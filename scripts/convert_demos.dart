import 'dart:io';

/// Converts all `part of '../../main.dart'` demo files to independent
/// library files. Removes `part of`, adds shared imports, and makes
/// classes public (removes `_` prefix from class names).
void main() {
  final dir = Directory('example/lib/src/demos');
  final shell = Directory('example/lib/src/shell');
  final docs = Directory('example/lib/src/docs_viewer');

  for (final d in [dir, shell, docs]) {
    for (final file in d.listSync().whereType<File>()) {
      if (!file.path.endsWith('.dart')) continue;
      _convert(file);
    }
  }
}

final _demoImports = [
  "import 'demo_imports.dart';",
];
final _shellImports = [
  "import 'package:flutter/widgets.dart';",
  "import 'package:vidraui/vidraui.dart';",
];
final _docsViewerImports = [
  "import 'package:flutter/widgets.dart';",
  "import 'package:vidraui/vidraui.dart';",
  "import '../docs/docs.dart';",
];

final _classPattern = RegExp(r'^class _(\w+)');
final _constPattern = RegExp(r'const _(\w+)\(\)');
// ignore: unused_element — kept for future pattern-matching extensions
final _typePattern = RegExp(r'_\w+Demo\b');
final _extendsPattern = RegExp(r'_(\w+Demo)\b');

void _convert(File file) {
  var content = file.readAsStringSync();

  // Skip files without part of
  if (!content.contains("part of '../../main.dart';") &&
      !content.contains("part of '../main.dart';")) {
    return;
  }

  // Remove part of directive
  content = content.replaceFirst(
    RegExp(r"part of '[^']+';"),
    '',
  );

  // Add appropriate imports
  final imports = file.path.contains('/shell/')
      ? _shellImports
      : file.path.contains('/docs_viewer/')
          ? _docsViewerImports
          : _demoImports;

  content = '${imports.join('\n')}\n\n$content'.trimLeft();

  // Make demo class names public (remove leading _)
  content = content.replaceAllMapped(_classPattern, (m) {
    return 'class ${m.group(1)}';
  });
  content = content.replaceAllMapped(_constPattern, (m) {
    return 'const ${m.group(1)}()';
  });
  // Replace _FooDemo type references
  content = content.replaceAllMapped(_extendsPattern, (m) {
    return '${m.group(1)}';
  });

  file.writeAsStringSync(content);
  stdout.writeln('  ${file.path}');
}
