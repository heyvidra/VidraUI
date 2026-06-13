import 'dart:io';

void main() {
  final directory = Directory('example/lib');
  final snippets = <String, String>{};
  final pattern = RegExp(
    r'// docs-snippet:start ([a-z0-9-]+)\n([\s\S]*?)// docs-snippet:end \1',
  );

  for (final entity in directory.listSync(recursive: true)) {
    if (entity is File && entity.path.endsWith('.dart')) {
      final source = entity.readAsStringSync();
      for (final match in pattern.allMatches(source)) {
        final id = match.group(1)!;
        final body = _stripLineComments(_trimIndent(match.group(2)!.trimRight()));
        snippets[id] = body;
      }
    }
  }

  final output = StringBuffer()
    ..writeln("import 'docs.dart';")
    ..writeln()
    ..writeln('const vDocSnippets = <String, VDocCodeSnippet>{');

  final ids = snippets.keys.toList()..sort();
  for (final id in ids) {
    output
      ..writeln("  '$id': VDocCodeSnippet(")
      ..writeln("    id: '$id',")
      ..writeln("    source: r'''")
      ..writeln(snippets[id])
      ..writeln("''',")
      ..writeln('  ),');
  }

  output.writeln('};');
  File('example/lib/docs/snippets.g.dart').writeAsStringSync(
    output.toString(),
  );
}

String _trimIndent(String source) {
  final lines = source.split('\n');
  final indents = lines
      .where((line) => line.trim().isNotEmpty)
      .map((line) => line.length - line.trimLeft().length)
      .toList();
  final indent = indents.isEmpty ? 0 : indents.reduce((a, b) => a < b ? a : b);
  return lines
      .map((line) => line.length >= indent ? line.substring(indent) : line)
      .join('\n');
}

String _stripLineComments(String source) {
  return source
      .split('\n')
      .map((line) {
        final trimmedLeft = line.trimLeft();
        if (!trimmedLeft.startsWith('//')) return line;
        final indent = line.substring(0, line.length - trimmedLeft.length);
        final uncommented = trimmedLeft.substring(2);
        return '$indent${uncommented.startsWith(' ') ? uncommented.substring(1) : uncommented}';
      })
      .join('\n')
      .trim();
}
