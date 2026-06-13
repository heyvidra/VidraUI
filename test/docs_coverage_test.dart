import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('docs coverage', () {
    final catalog = File('example/lib/docs/catalog.dart').readAsStringSync();
    final inventory =
        File('example/lib/docs/api_inventory.g.dart').readAsStringSync();
    final snippets =
        File('example/lib/docs/snippets.g.dart').readAsStringSync();

    test('every exported public API symbol is assigned to a docs page', () {
      final documentedSymbols = RegExp(r"'([A-Za-z][A-Za-z0-9_]*)'")
          .allMatches(catalog)
          .map((match) => match.group(1)!)
          .toSet();
      final inventorySymbols =
          RegExp(r"^  '([A-Za-z][A-Za-z0-9_]*)':", multiLine: true)
              .allMatches(inventory)
              .map((match) => match.group(1)!)
              .toSet();

      expect(
        inventorySymbols.difference(documentedSymbols),
        isEmpty,
        reason: 'Public exported symbols need a catalog docs page.',
      );
    });

    test('every catalog page has extracted non-empty snippets', () {
      final referencedSnippetIds = RegExp(r'snippetIds: \[([\s\S]*?)\],')
          .allMatches(catalog)
          .expand(
            (match) => RegExp(r"'([a-z0-9-]+)'")
                .allMatches(match.group(1)!)
                .map((id) => id.group(1)!),
          )
          .toSet();
      final extracted = <String, String>{
        for (final match in RegExp(
          r"  '([a-z0-9-]+)': VDocCodeSnippet\([\s\S]*?source: r'''([\s\S]*?)'''",
        ).allMatches(snippets))
          match.group(1)!: match.group(2)!.trim(),
      };

      expect(
        referencedSnippetIds.difference(extracted.keys.toSet()),
        isEmpty,
        reason: 'Every referenced snippet id must be extracted.',
      );
      for (final id in referencedSnippetIds) {
        expect(extracted[id], isNotEmpty, reason: id);
      }
    });

    test('every catalog page has a reachable demo category', () {
      final main = File('example/lib/main.dart').readAsStringSync();
      final slugs = RegExp(r"slug: '([^']+)'")
          .allMatches(catalog)
          .map((match) => match.group(1)!)
          .toSet();

      for (final slug in slugs) {
        expect(main, contains("=> '$slug'"), reason: slug);
      }
    });
  });
}
