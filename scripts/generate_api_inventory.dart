import 'dart:io';

void main() {
  final root = Directory.current;
  final exportedFiles = _resolveExports(root);
  final symbols = <_Symbol>[];

  for (final entry in exportedFiles.entries) {
    final text = entry.key.readAsStringSync();
    final library = entry.key.path.replaceFirst('${root.path}/', '');
    symbols.addAll(
      _parseSymbols(text, library).where((s) => entry.value.allows(s.name)),
    );
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

/// Resolves the public export graph, honoring `show`/`hide` clauses with the
/// same union-across-paths semantics Dart uses for re-exports: a symbol is
/// public if at least one export edge reaching its file permits it.
Map<File, _ExportFilter> _resolveExports(Directory root) {
  final visited = <String>{};
  final filters = <String, _ExportFilter>{};
  final fileByPath = <String, File>{};
  final edge = RegExp(r"export\s+'([^']+)'(?:\s+(show|hide)\s+([^;]+))?;");

  void visit(File file) {
    final canonical = file.absolute.path;
    if (!visited.add(canonical)) return;

    final text = file.readAsStringSync();
    for (final match in edge.allMatches(text)) {
      // Normalize so a file reached via different relative paths (e.g.
      // 'app/../foundation/x.dart') resolves to one canonical key — otherwise
      // it gets parsed twice and emits duplicate map keys.
      final child = File(
        File('${file.parent.path}/${match.group(1)!}')
            .absolute
            .uri
            .normalizePath()
            .toFilePath(),
      );
      if (!child.existsSync() || !child.path.endsWith('.dart')) continue;
      final names = match.group(3) == null
          ? const <String>{}
          : match
              .group(3)!
              .split(',')
              .map((s) => s.trim())
              .where((s) => s.isNotEmpty)
              .toSet();
      final filter = _ExportFilter(
        show: match.group(2) == 'show' ? names : null,
        hide: match.group(2) == 'hide' ? names : null,
      );
      final key = child.path;
      fileByPath[key] = child;
      filters[key] =
          filters.containsKey(key) ? filters[key]!.merge(filter) : filter;
      visit(child);
    }
  }

  visit(File('${root.path}/lib/vidraui.dart'));
  return {for (final e in filters.entries) fileByPath[e.key]!: e.value};
}

/// Per-file gate of which top-level symbols a set of export edges exposes.
class _ExportFilter {
  const _ExportFilter({this.show, this.hide});

  final Set<String>? show;
  final Set<String>? hide;

  bool get _allowsAll => show == null && hide == null;

  bool allows(String name) {
    if (_allowsAll) return true;
    if (show != null) return show!.contains(name);
    return !hide!.contains(name);
  }

  /// Union semantics: the result allows a symbol if either edge does.
  _ExportFilter merge(_ExportFilter other) {
    if (_allowsAll || other._allowsAll) return const _ExportFilter();
    if (show != null && other.show != null) {
      return _ExportFilter(show: {...show!, ...other.show!});
    }
    if (hide != null && other.hide != null) {
      return _ExportFilter(hide: hide!.intersection(other.hide!));
    }
    // One show, one hide: allowed unless hidden AND not explicitly shown.
    final shown = show ?? other.show!;
    final hidden = hide ?? other.hide!;
    return _ExportFilter(hide: hidden.difference(shown));
  }
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
    .replaceAll(r'$', r'\$')
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
