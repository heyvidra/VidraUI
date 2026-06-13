import 'dart:io';

void main() {
  final catalog = File('example/lib/docs/catalog.dart').readAsStringSync();
  final inventory =
      File('example/lib/docs/api_inventory.g.dart').readAsStringSync();
  final snippets = File('example/lib/docs/snippets.g.dart').readAsStringSync();

  final documentedSymbols = RegExp(r"'([A-Za-z][A-Za-z0-9_]*)'")
      .allMatches(catalog)
      .map((match) => match.group(1)!)
      .toSet();
  final inventorySymbols =
      RegExp(r"^  '([A-Za-z][A-Za-z0-9_]*)':", multiLine: true)
          .allMatches(inventory)
          .map((match) => match.group(1)!)
          .toSet();

  final missingSymbols = inventorySymbols.difference(documentedSymbols).toList()
    ..sort();
  final snippetIds = RegExp(r"snippetIds: \[([\s\S]*?)\],")
      .allMatches(catalog)
      .expand((match) => RegExp(r"'([a-z0-9-]+)'")
          .allMatches(match.group(1)!)
          .map((id) => id.group(1)!))
      .toSet();
  final extractedSnippetIds = RegExp(r"^  '([a-z0-9-]+)':", multiLine: true)
      .allMatches(snippets)
      .map((match) => match.group(1)!)
      .toSet();
  final missingSnippets = snippetIds.difference(extractedSnippetIds).toList()
    ..sort();

  if (missingSymbols.isNotEmpty || missingSnippets.isNotEmpty) {
    if (missingSymbols.isNotEmpty) {
      stderr.writeln('Missing API docs entries: ${missingSymbols.join(', ')}');
    }
    if (missingSnippets.isNotEmpty) {
      stderr.writeln('Missing snippets: ${missingSnippets.join(', ')}');
    }
    exitCode = 1;
    return;
  }

  stdout.writeln(
    'Docs coverage OK: ${inventorySymbols.length} symbols, '
    '${snippetIds.length} snippets.',
  );
}
