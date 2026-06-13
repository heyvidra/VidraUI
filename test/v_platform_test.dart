import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vidraui/vidraui.dart';

void main() {
  group('VPlatformBehavior Resolution', () {
    test('resolves correct behavior by platform', () {
      final iOS = VPlatformBehavior.resolve(TargetPlatform.iOS);
      expect(iOS.isDesktop, isFalse);
      expect(iOS.isApple, isTrue);
      expect(iOS.selectionMenuItemHeight, 44.0);
      expect(iOS.selectionMenuRadius, 22.0);
      expect(iOS.shortcutModifier, '⌘');

      final macOS = VPlatformBehavior.resolve(TargetPlatform.macOS);
      expect(macOS.isDesktop, isTrue);
      expect(macOS.isApple, isTrue);
      expect(macOS.selectionMenuItemHeight, 36.0);
      expect(macOS.selectionMenuRadius, 8.0);
      expect(macOS.shortcutModifier, '⌘');

      final android = VPlatformBehavior.resolve(TargetPlatform.android);
      expect(android.isDesktop, isFalse);
      expect(android.isApple, isFalse);
      expect(android.selectionMenuItemHeight, 44.0);
      expect(android.selectionMenuRadius, 22.0);
      expect(android.shortcutModifier, 'Ctrl+');

      final windows = VPlatformBehavior.resolve(TargetPlatform.windows);
      expect(windows.isDesktop, isTrue);
      expect(windows.isApple, isFalse);
      expect(windows.selectionMenuItemHeight, 36.0);
      expect(windows.selectionMenuRadius, 8.0);
      expect(windows.shortcutModifier, 'Ctrl+');
    });

    test('factories create custom behaviors', () {
      final customMobile = VPlatformBehavior.mobile(isApple: false);
      expect(customMobile.isDesktop, isFalse);
      expect(customMobile.isApple, isFalse);
      expect(customMobile.shortcutModifier, 'Ctrl+');

      final customDesktop = VPlatformBehavior.desktop(isApple: true);
      expect(customDesktop.isDesktop, isTrue);
      expect(customDesktop.isApple, isTrue);
      expect(customDesktop.shortcutModifier, '⌘');
    });
  });

  group('VPlatformScope Widget Tests', () {
    testWidgets('looks up behavior correctly in context', (tester) async {
      late VPlatformBehavior resolvedBehavior;

      await tester.pumpWidget(
        VPlatformScope(
          behavior: VPlatformBehavior.desktop(isApple: true),
          child: Builder(
            builder: (context) {
              resolvedBehavior = VPlatformScope.of(context);
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(resolvedBehavior.isDesktop, isTrue);
      expect(resolvedBehavior.isApple, isTrue);
    });

    testWidgets('subtree overrides parent behavior', (tester) async {
      late VPlatformBehavior parentBehavior;
      late VPlatformBehavior childBehavior;

      await tester.pumpWidget(
        VPlatformScope(
          behavior: VPlatformBehavior.desktop(isApple: true),
          child: Builder(
            builder: (context1) {
              parentBehavior = VPlatformScope.of(context1);
              return VPlatformScope(
                behavior: VPlatformBehavior.mobile(isApple: false),
                child: Builder(
                  builder: (context2) {
                    childBehavior = VPlatformScope.of(context2);
                    return const SizedBox.shrink();
                  },
                ),
              );
            },
          ),
        ),
      );

      expect(parentBehavior.isDesktop, isTrue);
      expect(parentBehavior.isApple, isTrue);

      expect(childBehavior.isDesktop, isFalse);
      expect(childBehavior.isApple, isFalse);
    });

    testWidgets('falls back to defaultTargetPlatform resolution if no scope present', (tester) async {
      late VPlatformBehavior behavior;

      await tester.pumpWidget(
        Builder(
          builder: (context) {
            behavior = VPlatformScope.of(context);
            return const SizedBox.shrink();
          },
        ),
      );

      // defaultTargetPlatform in tester environment resolves by default to TargetPlatform.android
      expect(behavior.isDesktop, isFalse);
      expect(behavior.isApple, isFalse);
    });
  });
}
