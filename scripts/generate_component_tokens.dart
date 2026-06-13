import 'dart:io';

import 'token_registry.dart';

void main() {
  final out = StringBuffer()
    ..writeln('// GENERATED CODE — DO NOT EDIT.')
    ..writeln('//')
    ..writeln('// Regenerate with:')
    ..writeln('//   dart run scripts/generate_component_tokens.dart')
    ..writeln('//')
    ..writeln('// Registry: scripts/token_registry.dart')
    ..writeln()
    ..writeln('// coverage:ignore-file')
    ..writeln()
    ..writeln("part of 'v_component_tokens.dart';")
    ..writeln();

  // ---------------------------------------------------------------------------
  // fromColors
  // ---------------------------------------------------------------------------
  out
    ..writeln('VComponentTokens _\$fromColors(VColors colors) {')
    ..writeln('  return VComponentTokens(');
  for (final entry in tokenRegistry) {
    out.writeln('    ${entry.name}: ${entry.type}.fromColors(colors),');
  }
  out
    ..writeln('  );')
    ..writeln('}')
    ..writeln();

  // ---------------------------------------------------------------------------
  // lerp
  // ---------------------------------------------------------------------------
  out
    ..writeln(
      'VComponentTokens _\$lerp(VComponentTokens a, VComponentTokens b, double t) {',
    )
    ..writeln('  return VComponentTokens(');
  for (final entry in tokenRegistry) {
    out.writeln(
      '    ${entry.name}: ${entry.type}.lerp(a.${entry.name}, b.${entry.name}, t),',
    );
  }
  out
    ..writeln('  );')
    ..writeln('}')
    ..writeln();

  // ---------------------------------------------------------------------------
  // copyWith
  // ---------------------------------------------------------------------------
  out.writeln('VComponentTokens _\$copyWith(');
  out.writeln('  VComponentTokens self, {');
  for (final entry in tokenRegistry) {
    out.writeln('  ${entry.type}? ${entry.name},');
  }
  out.writeln('}) {');
  out.writeln('  return VComponentTokens(');
  for (final entry in tokenRegistry) {
    out.writeln('    ${entry.name}: ${entry.name} ?? self.${entry.name},');
  }
  out
    ..writeln('  );')
    ..writeln('}');

  File('lib/src/theme/component_tokens/v_component_tokens.g.dart')
      .writeAsStringSync(out.toString());
  stdout.writeln('Generated v_component_tokens.g.dart (${tokenRegistry.length} tokens).');
}
