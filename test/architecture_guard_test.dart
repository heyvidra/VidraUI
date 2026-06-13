import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('architecture guards', () {
    final libFiles = Directory('lib')
        .listSync(recursive: true)
        .whereType<File>()
        .where((file) => file.path.endsWith('.dart'))
        .toList();

    test('lib does not import Material or Cupertino component libraries', () {
      for (final file in libFiles) {
        final source = file.readAsStringSync();
        expect(
          source,
          isNot(contains("import 'package:flutter/material.dart';")),
          reason: file.path,
        );
        expect(
          source,
          isNot(contains("import 'package:flutter/cupertino.dart';")),
          reason: file.path,
        );
      }
    });

    test('lib does not use forbidden Flutter component APIs', () {
      final forbidden = RegExp(
        r'\b(MaterialApp|CupertinoApp|Scaffold|AppBar|TextField|'
        r'ElevatedButton|TextButton|OutlinedButton|IconButton|InkWell|'
        r'ThemeData|showDialog|ScaffoldMessenger|SnackBar|BottomSheet|'
        r'CupertinoPageRoute|CupertinoButton|CupertinoTextField)\b',
      );

      for (final file in libFiles) {
        final source = file.readAsStringSync();
        expect(
          forbidden.firstMatch(source),
          isNull,
          reason: file.path,
        );
      }
    });

    test('core does not ship named trend appearance presets', () {
      final forbidden = RegExp(
        r'\b(VGlassAppearance|VNeumorphicAppearance|'
        r'VGlassmorphismAppearance|VNeumorphismAppearance)\b',
      );

      for (final file in libFiles) {
        final source = file.readAsStringSync();
        expect(
          forbidden.firstMatch(source),
          isNull,
          reason: file.path,
        );
      }
    });

    test('foundation, theme, and app layers do not import widgets layer', () {
      final guardedFiles = libFiles.where((file) {
        final path = file.path;
        return path.startsWith('lib/src/foundation/') ||
            path.startsWith('lib/src/theme/') ||
            path.startsWith('lib/src/app/');
      });

      final violations = <String>[];
      for (final file in guardedFiles) {
        final source = file.readAsStringSync();
        if (source.contains("import '../widgets/") ||
            source.contains("import 'package:vidraui/src/widgets/")) {
          violations.add(file.path);
        }
      }

      expect(
        violations,
        isEmpty,
        reason:
            'Lower layers must not import widgets. Keep dependency direction '
            'widgets -> app/theme/foundation, app -> theme/foundation, '
            'theme -> foundation.',
      );
    });

    test('widgets barrel does not export internal implementation helpers', () {
      final source = File('lib/src/widgets/widgets.dart').readAsStringSync();
      final forbiddenExports = <String>[
        "export 'interaction/v_interactive.dart'",
        "export 'overlays/v_overlay_utils.dart'",
        "export 'navigation/v_list_navigator.dart'",
        "export 'forms/v_control_row.dart'",
        // Old paths (pre-reorganization) for backwards compatibility check
        "export 'v_interactive.dart'",
        "export 'v_overlay_utils.dart'",
        "export 'v_list_navigator.dart'",
        "export 'v_control_row.dart'",
      ];

      final violations = forbiddenExports
          .where((exportLine) => source.contains(exportLine))
          .toList();

      expect(
        violations,
        isEmpty,
        reason: 'Internal widget primitives must not be exported publicly.',
      );

      expect(
        source,
        contains(
          "export 'overlays/v_anchored_overlay.dart' show VAnchoredOverlayPlacement;",
        ),
        reason:
            'Only the public placement enum should be exported from anchored '
            'overlay helpers; geometry and resolver types are internal.',
      );
    });

    test('exported type symbols use the V prefix', () {
      const allowlist = <String, String>{
        'VidraApp': 'Established app shell API from the original package.',
      };
      const guardedKinds = {'class', 'enum', 'typedef', 'extension', 'mixin'};
      final inventory =
          File('example/lib/docs/api_inventory.g.dart').readAsStringSync();
      final symbolPattern = RegExp(
        r"^  '([A-Za-z][A-Za-z0-9_]*)': VDocApiSymbol\([\s\S]*?^    kind: '([a-z]+)',",
        multiLine: true,
      );

      final violations = <String>[];
      for (final match in symbolPattern.allMatches(inventory)) {
        final name = match.group(1)!;
        final kind = match.group(2)!;
        if (!guardedKinds.contains(kind)) continue;
        if (name.startsWith('V')) continue;
        if (allowlist.containsKey(name)) continue;
        violations.add('$name ($kind)');
      }

      expect(
        violations,
        isEmpty,
        reason:
            'Exported public class/enum/typedef/extension/mixin symbols must '
            'use the V prefix unless explicitly allowlisted.',
      );
    });
  });
}
