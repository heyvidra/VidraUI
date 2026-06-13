import 'dart:io';

/// Generates all foundation token part files and checks they match
/// the committed versions.
void main() {
  // Run the generator
  final result = Process.runSync(
    'dart',
    ['run', 'scripts/generate_foundation_tokens.dart'],
  );
  if (result.exitCode != 0) {
    stderr.write(result.stderr);
    exit(1);
  }

  // Check each g.dart file is unchanged (already committed)
  final diff = Process.runSync(
    'git',
    ['diff', '--exit-code', '--', 'lib/src/foundation/v_*.g.dart'],
  );
  if (diff.exitCode != 0) {
    stderr.writeln(
      'ERROR: foundation token .g.dart files are stale.\n'
      'Run: dart run scripts/generate_foundation_tokens.dart\n'
      'Then commit the updated files.',
    );
    exit(1);
  }

  stdout.writeln('OK: all foundation token .g.dart files are up to date.');
}
