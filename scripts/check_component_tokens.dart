import 'dart:io';

/// CI guard: regenerates v_component_tokens.g.dart and checks that the
/// committed file is up to date with the token registry.
///
/// Exit 0 if the committed file matches freshly-generated output.
/// Exit 1 if stale — run `dart run scripts/generate_component_tokens.dart`.
Future<void> main() async {
  // 1. Run the generator
  final result = await Process.run(
    'dart',
    ['run', 'scripts/generate_component_tokens.dart'],
  );
  if (result.exitCode != 0) {
    stderr.writeln('ERROR: generator failed');
    stderr.write(result.stderr);
    exit(1);
  }

  // 2. Check whether the generated file changed vs what's committed
  final diff = await Process.run(
    'git',
    ['diff', '--exit-code', 'lib/src/theme/component_tokens/v_component_tokens.g.dart'],
  );
  if (diff.exitCode != 0) {
    stderr.writeln(
      'ERROR: v_component_tokens.g.dart is stale.\n'
      'Run: dart run scripts/generate_component_tokens.dart\n'
      'Then commit the updated file.',
    );
    exit(1);
  }

  stdout.writeln('OK: v_component_tokens.g.dart is up to date.');
}
