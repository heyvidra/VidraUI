import os
import re

def main():
    with open('example/lib/main.dart.bak', 'r') as f:
        lines = f.readlines()

    os.makedirs('example/lib/src/shell', exist_ok=True)
    os.makedirs('example/lib/src/docs_viewer', exist_ok=True)
    os.makedirs('example/lib/src/demos', exist_ok=True)

    classes = {}
    current_class = None
    brace_count = 0
    class_lines = []
    
    snippets = {}
    current_snippet = None

    other_lines = []

    # Extract snippets first
    i = 0
    while i < len(lines):
        line = lines[i]
        if line.startswith('// docs-snippet:start'):
            current_snippet = line.strip().split()[-1]
            snippets[current_snippet] = [line]
        elif current_snippet:
            snippets[current_snippet].append(line)
            if line.startswith('// docs-snippet:end'):
                current_snippet = None
        else:
            # We don't add snippet lines to other_lines yet
            pass
        i += 1

    # Extract classes and other top-level things (excluding snippets)
    i = 0
    while i < len(lines):
        line = lines[i]
        
        if line.startswith('// docs-snippet:start'):
            while i < len(lines) and not lines[i].startswith('// docs-snippet:end'):
                i += 1
            i += 1
            continue

        if current_class is None:
            m = re.match(r'^(?:abstract\s+)?class\s+([_A-Za-z0-9]+)', line)
            m_enum = re.match(r'^enum\s+([_A-Za-z0-9]+)', line)
            
            if m or m_enum:
                name = m.group(1) if m else m_enum.group(1)
                
                start_idx = i
                while start_idx > 0:
                    prev = lines[start_idx-1].strip()
                    if prev.startswith('///') or prev.startswith('//') or prev.startswith('@'):
                        start_idx -= 1
                    else:
                        break
                
                popped = len(other_lines) - start_idx
                if popped > 0:
                    class_lines = other_lines[-popped:]
                    other_lines = other_lines[:-popped]
                else:
                    class_lines = []
                
                current_class = name
                class_lines.append(line)
                brace_count += line.count('{') - line.count('}')
            else:
                other_lines.append(line)
        else:
            class_lines.append(line)
            brace_count += line.count('{') - line.count('}')
            if brace_count == 0:
                classes[current_class] = class_lines
                current_class = None
                class_lines = []
        i += 1
        
    print(f"Extracted {len(classes)} classes")

    shell_classes = [
        '_DemoCategory', '_DemoCategoryDocs', '_SidebarSection',
        'DemoShell', '_DemoShellState', '_WideLayout', '_NarrowLayout',
        '_Header', '_SidebarNav', '_SidebarNavSection', '_SidebarNavItem',
        '_DemoContent'
    ]
    
    docs_classes = [
        '_DocsPage', '_MaturityOverview', '_MaturityRow', '_DocsHero',
        '_DocsSection', '_CodeBlock', '_CodeBlockState', '_ApiTable',
        '_ApiMemberRow'
    ]

    demo_classes = [k for k in classes.keys() if 'Demo' in k and k not in shell_classes]
    
    def to_snake_case(name):
        s1 = re.sub('(.)([A-Z][a-z]+)', r'\1_\2', name.strip('_'))
        return re.sub('([a-z0-9])([A-Z])', r'\1_\2', s1).lower()

    def get_snippets_for_file(fname):
        matched = []
        base = fname.replace('_demo.dart', '').replace('.dart', '')
        # Map snippet prefix to file base name
        for k in list(snippets.keys()):
            if k.startswith(base) or base.startswith(k.split('-')[0]):
                matched.extend(snippets[k])
                matched.append('\n')
                del snippets[k]
        return matched

    generated_files = []

    def write_file(path, class_names):
        generated_files.append(path.replace('example/lib/', ''))
        with open(path, 'w') as f:
            f.write("part of '../../main.dart';\n\n")
            
            for c in class_names:
                if c in classes:
                    f.writelines(classes[c])
                    f.write("\n")
                    
                    state_class = f"{c}State"
                    if state_class in classes and state_class not in class_names:
                        f.writelines(classes[state_class])
                        f.write("\n")
                        
            # append matched snippets
            snips = get_snippets_for_file(os.path.basename(path))
            if snips:
                f.write("\n")
                f.writelines(snips)
                        
    write_file('example/lib/src/shell/demo_category.dart', ['_DemoCategory', '_DemoCategoryDocs', '_SidebarSection'])
    write_file('example/lib/src/shell/demo_shell.dart', ['DemoShell', '_DemoShellState', '_WideLayout', '_NarrowLayout', '_Header'])
    write_file('example/lib/src/shell/sidebar.dart', ['_SidebarNav', '_SidebarNavSection', '_SidebarNavItem'])
    write_file('example/lib/src/shell/demo_content.dart', ['_DemoContent'])
    
    write_file('example/lib/src/docs_viewer/docs_page.dart', ['_DocsPage', '_MaturityOverview', '_MaturityRow', '_DocsHero', '_DocsSection'])
    write_file('example/lib/src/docs_viewer/code_block.dart', ['_CodeBlock'])
    write_file('example/lib/src/docs_viewer/api_table.dart', ['_ApiTable', '_ApiMemberRow'])

    demo_base_names = list(set([k.replace('State', '') for k in demo_classes]))
    for demo in demo_base_names:
        fname = to_snake_case(demo) + '.dart'
        if demo in ['_TransitionPreviewNavigator', '_PreviewPage']:
            continue
            
        cls_list = [demo]
        if demo == '_PageTransitionsDemo':
            cls_list.extend(['_TransitionPreviewNavigator', '_PreviewPage'])
        elif demo == '_MiscDemo':
            cls_list.append('IconsType')
        elif demo == '_ResizableDemo':
            cls_list.append('_ResizableCanvas')
            
        write_file(f'example/lib/src/demos/{fname}', cls_list)
        
    if snippets:
        generated_files.append('src/demos/misc_snippets.dart')
        with open('example/lib/src/demos/misc_snippets.dart', 'w') as f:
            f.write("part of '../../main.dart';\n\n")
            for k, lines in snippets.items():
                f.writelines(lines)
                f.write("\n")
        
    while other_lines and (other_lines[-1].strip() == '' or other_lines[-1].startswith('//')):
        other_lines.pop()

    part_statements = "\n".join([f"part '{f}';" for f in generated_files])
    
    with open('example/lib/main.dart', 'w') as f:
        insert_idx = 0
        for i, line in enumerate(other_lines):
            if line.startswith('import '):
                insert_idx = i + 1
        
        for i in range(insert_idx):
            f.write(other_lines[i])
            
        f.write("\n")
        f.write(part_statements + "\n\n")
        
        for i in range(insert_idx, len(other_lines)):
            line = other_lines[i]
            if line.startswith('// ---------------------------------------------------------------------------') or line.startswith('// Docs snippets'):
                continue
            f.write(line)

if __name__ == '__main__':
    main()
