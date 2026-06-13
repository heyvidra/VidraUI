import 'dart:io';

Future<void> main() async {
  final inventoryFile = File('example/lib/docs/api_inventory.g.dart');
  if (!inventoryFile.existsSync()) {
    stderr.writeln('Missing ${inventoryFile.path}. Run:');
    stderr.writeln('  dart run scripts/generate_api_inventory.dart');
    exitCode = 1;
    return;
  }

  final before = inventoryFile.readAsStringSync();
  final result = await Process.run(
    Platform.resolvedExecutable,
    ['run', 'scripts/generate_api_inventory.dart'],
    runInShell: false,
  );

  if (result.exitCode != 0) {
    stderr.write(result.stderr);
    stdout.write(result.stdout);
    exitCode = result.exitCode;
    return;
  }

  final after = inventoryFile.readAsStringSync();
  if (before == after) {
    stdout.writeln('API inventory is up to date.');
    return;
  }

  inventoryFile.writeAsStringSync(before);
  final beforeSymbols = _parseSymbols(before);
  final afterSymbols = _parseSymbols(after);
  final beforeNames = beforeSymbols.keys.toSet();
  final afterNames = afterSymbols.keys.toSet();
  final added = afterNames.difference(beforeNames).toList()..sort();
  final removed = beforeNames.difference(afterNames).toList()..sort();
  final changedKinds = beforeNames
      .intersection(afterNames)
      .where((name) => beforeSymbols[name] != afterSymbols[name])
      .toList()
    ..sort();

  stderr.writeln('API inventory is out of date.');
  if (added.isNotEmpty) {
    stderr.writeln('Added symbols: ${added.join(', ')}');
  }
  if (removed.isNotEmpty) {
    stderr.writeln('Removed symbols: ${removed.join(', ')}');
  }
  if (changedKinds.isNotEmpty) {
    stderr.writeln('Changed symbol kinds: ${changedKinds.join(', ')}');
  }
  stderr.writeln('Run and commit the result when this API change is intended:');
  stderr.writeln('  dart run scripts/generate_api_inventory.dart');
  exitCode = 1;
}

Map<String, String> _parseSymbols(String source) {
  final symbols = <String, String>{};
  final pattern = RegExp(
    r"^  '([A-Za-z][A-Za-z0-9_]*)': VDocApiSymbol\([\s\S]*?^    kind: '([a-z]+)',",
    multiLine: true,
  );
  for (final match in pattern.allMatches(source)) {
    symbols[match.group(1)!] = match.group(2)!;
  }
  return symbols;
}
