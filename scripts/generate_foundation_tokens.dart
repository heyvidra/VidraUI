import 'dart:io';

import 'foundation_token_registry.dart';

void main() {
  for (final entry in foundationTokenRegistry) {
    _generate(entry);
  }
  stdout.writeln('Generated ${foundationTokenRegistry.length} foundation '
      'token part files.');
}

void _generate(ClassEntry entry) {
  final out = StringBuffer()
    ..writeln('// GENERATED CODE — DO NOT EDIT.')
    ..writeln('//')
    ..writeln('// Regenerate with:')
    ..writeln('//   dart run scripts/generate_foundation_tokens.dart')
    ..writeln('//')
    ..writeln('// Registry: scripts/foundation_token_registry.dart')
    ..writeln()
    ..writeln('// coverage:ignore-file')
    ..writeln()
    ..writeln("part of '${entry.file.split('/').last}';")
    ..writeln();

  _emitLerp(out, entry);
  if (entry.generateCopyWith) {
    _emitCopyWith(out, entry);
  }
  _emitEq(out, entry);
  _emitHashCode(out, entry);
  if (entry.generateDiagnostics) {
    _emitDiagnostics(out, entry);
  }

  File(entry.gFile).writeAsStringSync(out.toString());
  stdout.writeln('  ${entry.gFile} (${entry.fields.length} fields)');
}

String _lerpExpr(String name, String strategy) {
  return switch (strategy) {
    'double' => 'a.$name + (b.$name - a.$name) * t',
    'Color' => 'Color.lerp(a.$name, b.$name, t)!',
    'TextStyle' => 'TextStyle.lerp(a.$name, b.$name, t)!',
    'BoxShadow' => 'BoxShadow.lerp(a.$name, b.$name, t)!',
    _ => throw ArgumentError('Unknown lerp strategy: $strategy'),
  };
}

String _fnName(String className, String suffix) => '_\$$className$suffix';

void _emitLerp(StringBuffer out, ClassEntry entry) {
  final fn = _fnName(entry.className, 'Lerp');
  out.writeln('${entry.className} $fn(');
  out.writeln('  ${entry.className} a,');
  out.writeln('  ${entry.className} b,');
  out.writeln('  double t,');
  out.writeln(') {');
  out.writeln('  return ${entry.className}(');
  for (final f in entry.fields) {
    out.writeln('    ${f.name}: ${_lerpExpr(f.name, entry.lerpStrategy)},');
  }
  out
    ..writeln('  );')
    ..writeln('}')
    ..writeln();
}

void _emitCopyWith(StringBuffer out, ClassEntry entry) {
  final fn = _fnName(entry.className, 'CopyWith');
  out.writeln('${entry.className} $fn(');
  out.writeln('  ${entry.className} self, {');
  for (final f in entry.fields) {
    out.writeln('  ${_fieldType(entry, f.name)}? ${f.name},');
  }
  out.writeln('}) {');
  out.writeln('  return ${entry.className}(');
  for (final f in entry.fields) {
    out.writeln('    ${f.name}: ${f.name} ?? self.${f.name},');
  }
  out
    ..writeln('  );')
    ..writeln('}')
    ..writeln();
}

void _emitEq(StringBuffer out, ClassEntry entry) {
  final fn = _fnName(entry.className, 'Eq');
  final eqFields =
      entry.hashCodeFields ?? entry.fields.map((f) => f.name).toList();
  out.writeln('bool $fn(${entry.className} a, Object other) {');
  out.writeln('  if (identical(a, other)) return true;');
  out.writeln('  return other is ${entry.className}');
  for (final name in eqFields) {
    out.writeln('    && a.$name == other.$name');
  }
  out
    ..writeln('    ;')
    ..writeln('}')
    ..writeln();
}

void _emitHashCode(StringBuffer out, ClassEntry entry) {
  final fn = _fnName(entry.className, 'Hash');
  final hashFields =
      entry.hashCodeFields ?? entry.fields.map((f) => f.name).toList();
  if (entry.hashCodeStyle == 'hashAll') {
    out.writeln('int $fn(${entry.className} self) => Object.hashAll([');
    for (final name in hashFields) {
      out.writeln('  self.$name,');
    }
    out.writeln(']);');
  } else {
    out.writeln('int $fn(${entry.className} self) => Object.hash(');
    for (final name in hashFields) {
      out.writeln('  self.$name,');
    }
    out.writeln(');');
  }
  out.writeln();
}

/// Infer the field type from the class's lerp strategy.
String _fieldType(ClassEntry entry, String name) {
  return switch (entry.lerpStrategy) {
    'double' => 'double',
    'Color' => 'Color',
    'TextStyle' => 'TextStyle',
    'BoxShadow' => 'BoxShadow',
    _ => 'Object',
  };
}

/// Maps a lerp strategy to the appropriate DiagnosticsProperty constructor.
String _diagExpr(String name, String strategy) {
  return switch (strategy) {
    'double' => "DoubleProperty('$name', self.$name)",
    'Color' => "DiagnosticsProperty<Color>('$name', self.$name)",
    'TextStyle' => "DiagnosticsProperty<TextStyle>('$name', self.$name)",
    'BoxShadow' => "DiagnosticsProperty<BoxShadow>('$name', self.$name)",
    _ => "DiagnosticsProperty<Object>('$name', self.$name)",
  };
}

void _emitDiagnostics(StringBuffer out, ClassEntry entry) {
  final fn = '_\$${entry.className}FillProperties';
  out.writeln('void $fn(');
  out.writeln('  ${entry.className} self,');
  out.writeln('  DiagnosticPropertiesBuilder properties,');
  out.writeln(') {');
  for (final f in entry.fields) {
    out.writeln('  properties.add(${_diagExpr(f.name, entry.lerpStrategy)});');
  }
  out
    ..writeln('}')
    ..writeln();
}
