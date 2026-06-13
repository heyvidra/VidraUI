import 'dart:io';

import 'component_theme_registry.dart';

void main() {
  final out = StringBuffer()
    ..writeln('// GENERATED CODE — DO NOT EDIT.')
    ..writeln('//')
    ..writeln('// Regenerate with:')
    ..writeln('//   dart run scripts/generate_component_themes.dart')
    ..writeln('//')
    ..writeln('// Registry: scripts/component_theme_registry.dart')
    ..writeln()
    ..writeln('// coverage:ignore-file')
    ..writeln()
    ..writeln("import 'package:flutter/widgets.dart';")
    ..writeln()
    ..writeln("import 'component_tokens.dart';")
    ..writeln("import 'v_theme.dart';")
    ..writeln("import 'v_token_theme.dart';")
    ..writeln();

  for (final entry in entries) {
    if (entry.extraTypedef != null) {
      out.writeln(entry.extraTypedef!);
      out.writeln();
    }

    out.writeln('/// Overrides [${entry.tokenType}] for its subtree.');
    out.writeln(
      'class ${entry.className} extends '
      'VComponentThemeWrapper<${entry.tokenType}> {',
    );
    out.writeln('  const ${entry.className}({');
    out.writeln('    super.key,');
    out.writeln('    required super.data,');
    out.writeln('    required super.child,');
    out.writeln('  });');
    out.writeln();
    out.writeln(
      '  static ${entry.tokenType}? of(BuildContext context) =>',
    );
    out.writeln(
      '    VComponentThemeWrapper.ofToken<${entry.tokenType}>(context);',
    );
    out.writeln();
    out.writeln('  static Widget override({');
    out.writeln('    Key? key,');
    out.writeln(
      '    required VScopedTokenOverride<${entry.tokenType}> data,',
    );
    out.writeln('    required Widget child,');
    out.writeln('  }) =>');
    out.writeln('    VTokenTheme.override<${entry.tokenType}>(');
    out.writeln('      key: key,');
    out.writeln('      data: data,');
    out.writeln(
      '      fallback: (theme) => theme.components.${entry.accessor},',
    );
    out.writeln('      child: child,');
    out.writeln('    );');
    out.writeln('}');
    out.writeln();
  }

  File('lib/src/theme/v_component_themes.g.dart')
      .writeAsStringSync(out.toString());
  stdout.writeln('Generated v_component_themes.g.dart '
      '(${entries.length} classes).');
}
