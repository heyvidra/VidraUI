import 'dart:io';

typedef _Step = ({
  String label,
  String executable,
  List<String> arguments,
  String? workingDirectory
});

Future<void> main() async {
  final steps = <_Step>[
    (
      label: 'flutter analyze',
      executable: 'flutter',
      arguments: ['analyze'],
      workingDirectory: null,
    ),
    (
      label: 'flutter test',
      executable: 'flutter',
      arguments: ['test'],
      workingDirectory: null,
    ),
    (
      label: 'example flutter analyze',
      executable: 'flutter',
      arguments: ['analyze'],
      workingDirectory: 'example',
    ),
    (
      label: 'docs coverage',
      executable: Platform.resolvedExecutable,
      arguments: ['run', 'scripts/check_docs_coverage.dart'],
      workingDirectory: null,
    ),
    (
      label: 'API inventory diff',
      executable: Platform.resolvedExecutable,
      arguments: ['run', 'scripts/check_api_inventory.dart'],
      workingDirectory: null,
    ),
  ];

  for (final step in steps) {
    stdout.writeln('\n==> ${step.label}');
    final result = await Process.start(
      step.executable,
      step.arguments,
      workingDirectory: step.workingDirectory,
      mode: ProcessStartMode.inheritStdio,
    );
    final exitCode = await result.exitCode;
    if (exitCode != 0) {
      stderr.writeln('\nStep failed: ${step.label} (exit $exitCode)');
      exit(exitCode);
    }
  }

  stdout.writeln('\nAll verification steps passed.');
}
