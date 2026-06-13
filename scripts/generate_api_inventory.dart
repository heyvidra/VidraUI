import 'dart:io';

void main() {
  final root = Directory.current;
  final exportedFiles = _resolveExports(root);
  final symbols = <_Symbol>[];

  for (final file in exportedFiles) {
    final text = file.readAsStringSync();
    final library = file.path.replaceFirst('${root.path}/', '');
    symbols.addAll(_parseSymbols(text, library));
  }

  symbols.sort((a, b) => a.name.compareTo(b.name));
  final output = StringBuffer()
    ..writeln("import 'docs.dart';")
    ..writeln()
    ..writeln('const vApiInventory = <String, VDocApiSymbol>{');

  for (final symbol in symbols) {
    output
      ..writeln("  '${_escape(symbol.name)}': VDocApiSymbol(")
      ..writeln("    name: '${_escape(symbol.name)}',")
      ..writeln("    kind: '${_escape(symbol.kind)}',")
      ..writeln("    library: '${_escape(symbol.library)}',")
      ..writeln('    members: [');
    for (final member in symbol.members) {
      output
        ..writeln('      VDocApiMember(')
        ..writeln("        name: '${_escape(member.name)}',")
        ..writeln("        kind: '${_escape(member.kind)}',")
        ..writeln("        signature: '${_escape(member.signature)}',")
        ..writeln('      ),');
    }
    output
      ..writeln('    ],')
      ..writeln('  ),');
  }

  output.writeln('};');
  File('example/lib/docs/api_inventory.g.dart').writeAsStringSync(
    output.toString(),
  );
}

Set<File> _resolveExports(Directory root) {
  final seen = <String>{};
  final files = <File>{};

  void visit(File file) {
    final canonical = file.absolute.path;
    if (!seen.add(canonical)) return;

    final text = file.readAsStringSync();
    for (final match in RegExp(r"export\s+'([^']+)';").allMatches(text)) {
      final target = match.group(1)!;
      final child = File('${file.parent.path}/$target').absolute;
      if (!child.existsSync()) continue;
      if (child.path.endsWith('.dart')) {
        files.add(child);
        visit(child);
      }
    }
  }

  visit(File('${root.path}/lib/vidraui.dart'));
  return files;
}

List<_Symbol> _parseSymbols(String text, String library) {
  final parseText = _stripComments(text);
  final symbols = <_Symbol>[];
  final decl = RegExp(
    r'(?:(?:abstract|base|final|sealed|interface)\s+)*(class|enum|typedef)\s+([A-Za-z]\w*)',
  );

  for (final match in decl.allMatches(parseText)) {
    final kind = match.group(1)!;
    final name = match.group(2)!;
    if (name.startsWith('_')) continue;
    if (name == 'VInteractive') continue;

    if (kind == 'typedef') {
      symbols.add(
        _Symbol(
          name: name,
          kind: kind,
          library: library,
          members: [
            _Member(
              name: name,
              kind: 'typedef',
              signature: _lineAt(parseText, match.start),
            ),
          ],
        ),
      );
      continue;
    }

    final bodyStart = parseText.indexOf('{', match.end);
    if (bodyStart < 0) continue;
    final bodyEnd = _matchingBrace(parseText, bodyStart);
    if (bodyEnd < 0) continue;
    final body = parseText.substring(bodyStart + 1, bodyEnd);
    final members = kind == 'enum'
        ? _parseEnumMembers(body)
        : _parseClassMembers(body, name);
    symbols.add(
      _Symbol(
        name: name,
        kind: kind,
        library: library,
        members: members,
      ),
    );
  }

  return symbols;
}

String _stripComments(String text) {
  final withoutBlocks = text.replaceAll(RegExp(r'/\*[\s\S]*?\*/'), '');
  return withoutBlocks
      .split('\n')
      .where((line) => !line.trimLeft().startsWith('//'))
      .join('\n');
}

List<_Member> _parseEnumMembers(String body) {
  final valuesText = body.split(';').first;
  return valuesText
      .split(',')
      .map((value) => value.trim())
      .where((value) => value.isNotEmpty && !value.startsWith('_'))
      .map((value) {
    final name = value.split(RegExp(r'\s|\(')).first;
    return _Member(name: name, kind: 'value', signature: value);
  }).toList();
}

List<_Member> _parseClassMembers(String body, String className) {
  final members = <_Member>[];
  final lines = body.split('\n');
  var depth = 0;
  String? pendingDeclaration;
  final pendingAnnotations = <String>[];

  for (final rawLine in lines) {
    final line = rawLine.trim();
    if (line.startsWith('@')) {
      pendingAnnotations.add(line);
      continue;
    }

    final atTopLevel = depth == 0;
    var effectiveLine = line;
    if (pendingDeclaration != null && atTopLevel && line.isNotEmpty) {
      effectiveLine = '$pendingDeclaration $line';
      pendingDeclaration = null;
    }

    if (atTopLevel && line.isNotEmpty && !line.startsWith('//')) {
      if (effectiveLine.endsWith('=')) {
        pendingDeclaration = effectiveLine;
      } else {
        final member = _parseClassMemberLine(effectiveLine, className);
        if (member != null) members.add(member);
      }
    }

    depth += _charCount(rawLine, '{') - _charCount(rawLine, '}');
    if (line.isNotEmpty && !line.startsWith('@')) pendingAnnotations.clear();
  }

  final deduped = <String, _Member>{};
  for (final member in members) {
    deduped.putIfAbsent('${member.kind}:${member.name}', () => member);
  }
  final result = deduped.values.toList();
  result.sort((a, b) {
    final kindCompare = a.kind.compareTo(b.kind);
    return kindCompare == 0 ? a.name.compareTo(b.name) : kindCompare;
  });
  return result;
}

_Member? _parseClassMemberLine(String line, String className) {
  if (line.startsWith('_') || line.startsWith('super.')) return null;
  if (line.startsWith('const factory $className') ||
      line.startsWith('factory $className') ||
      line.startsWith('const $className') ||
      line.startsWith('$className(') ||
      line.startsWith('$className.')) {
    final name = line
        .replaceFirst('const factory ', '')
        .replaceFirst('factory ', '')
        .replaceFirst('const ', '')
        .split('(')
        .first
        .trim();
    if (name.contains('._')) return null;
    return _Member(name: name, kind: 'constructor', signature: line);
  }

  final fieldMatch = RegExp(
    r'^(?:static\s+)?(?:const\s+|final\s+|late\s+final\s+)?([A-Za-z_][\w<>?,\s.]*)\s+([A-Za-z]\w*)\s*(?:[=;({])',
  ).firstMatch(line);
  if (fieldMatch != null) {
    final name = fieldMatch.group(2)!;
    if (name.startsWith('_')) return null;
    final isMethod = line.contains('(');
    final kind = isMethod ? 'method' : 'field';
    return _Member(name: name, kind: kind, signature: line);
  }

  final getterMatch = RegExp(
    r'^(?:static\s+)?([A-Za-z_][\w<>?,\s.]*)\s+get\s+([A-Za-z]\w*)',
  ).firstMatch(line);
  if (getterMatch != null) {
    return _Member(
      name: getterMatch.group(2)!,
      kind: 'getter',
      signature: line,
    );
  }

  return null;
}

int _matchingBrace(String text, int openIndex) {
  var depth = 0;
  for (var i = openIndex; i < text.length; i++) {
    final char = text.codeUnitAt(i);
    if (char == 123) depth++;
    if (char == 125) depth--;
    if (depth == 0) return i;
  }
  return -1;
}

String _lineAt(String text, int index) {
  final start = text.lastIndexOf('\n', index) + 1;
  final end = text.indexOf('\n', index);
  return text.substring(start, end < 0 ? text.length : end).trim();
}

int _charCount(String text, String char) =>
    RegExp(RegExp.escape(char)).allMatches(text).length;

String _escape(String value) => value
    .replaceAll(r'\', r'\\')
    .replaceAll("'", r"\'")
    .replaceAll('\n', r'\n');

class _Symbol {
  const _Symbol({
    required this.name,
    required this.kind,
    required this.library,
    required this.members,
  });

  final String name;
  final String kind;
  final String library;
  final List<_Member> members;
}

class _Member {
  const _Member({
    required this.name,
    required this.kind,
    required this.signature,
  });

  final String name;
  final String kind;
  final String signature;
}
