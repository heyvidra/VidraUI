import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vidraui/vidraui.dart';

/// Integration test for VButton shape.none hover behavior on desktop platforms.
void main() {
  group('VButton shape.none hover integration (desktop)', () {
    testWidgets('primary variant changes color on hover with desktop behavior', (tester) async {
      final theme = VThemeData.light();
      
      await tester.pumpWidget(
        VPlatformScope(
          behavior: VPlatformBehavior.desktop(isApple: true),
          child: VidraApp.navigator(
            theme: theme,
            home: VButton(
              shape: VButtonShape.none,
              variant: VButtonVariant.primary,
              onPressed: () {},
              child: const VText('Hover Me'),
            ),
          ),
        ),
      );

      await tester.pump();
      
      // Helper to get the current text color
      Color getCurrentTextColor() {
        final textStyleWidgets = tester.widgetList<DefaultTextStyle>(find.byType(DefaultTextStyle)).toList();
        return textStyleWidgets
            .where((style) => style.style.color != null)
            .map((style) => style.style.color!)
            .firstWhere((color) => 
              color == theme.colors.actionPrimary || 
              color == theme.colors.actionPrimaryHover || 
              color == theme.colors.textDisabled);
      }
      
      // Initial state - should show normal action color
      expect(getCurrentTextColor(), equals(theme.colors.actionPrimary));
      
      // Create mouse gesture and hover
      final buttonFinder = find.byType(VButton);
      final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
      await gesture.addPointer(location: Offset.zero);
      
      // Move to button and trigger hover
      await gesture.moveTo(tester.getCenter(buttonFinder));
      await tester.pump();
      
      // Should now show hover color
      expect(getCurrentTextColor(), equals(theme.colors.actionPrimaryHover));
      
      // Move away to end hover
      await gesture.moveTo(const Offset(-100, -100));
      await tester.pump();
      
      // Should return to normal color
      expect(getCurrentTextColor(), equals(theme.colors.actionPrimary));
      
      await gesture.removePointer();
    });

    testWidgets('danger variant changes color on hover with desktop behavior', (tester) async {
      final theme = VThemeData.light();
      
      await tester.pumpWidget(
        VPlatformScope(
          behavior: VPlatformBehavior.desktop(isApple: true),
          child: VidraApp.navigator(
            theme: theme,
            home: VButton(
              shape: VButtonShape.none,
              variant: VButtonVariant.danger,
              onPressed: () {},
              child: const VText('Delete'),
            ),
          ),
        ),
      );

      await tester.pump();
      
      Color getCurrentTextColor() {
        final textStyleWidgets = tester.widgetList<DefaultTextStyle>(find.byType(DefaultTextStyle)).toList();
        return textStyleWidgets
            .where((style) => style.style.color != null)
            .map((style) => style.style.color!)
            .firstWhere((color) => 
              color == theme.colors.danger || 
              color == theme.colors.dangerHover || 
              color == theme.colors.textDisabled);
      }
      
      // Initial state
      expect(getCurrentTextColor(), equals(theme.colors.danger));
      
      // Hover
      final buttonFinder = find.byType(VButton);
      final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
      await gesture.addPointer(location: Offset.zero);
      await gesture.moveTo(tester.getCenter(buttonFinder));
      await tester.pump();
      
      // Should show danger hover color
      expect(getCurrentTextColor(), equals(theme.colors.dangerHover));
      
      await gesture.removePointer();
    });
    
    testWidgets('secondary variant does NOT change color on hover', (tester) async {
      final theme = VThemeData.light();
      
      await tester.pumpWidget(
        VPlatformScope(
          behavior: VPlatformBehavior.desktop(isApple: true),
          child: VidraApp.navigator(
            theme: theme,
            home: VButton(
              shape: VButtonShape.none,
              variant: VButtonVariant.secondary,
              onPressed: () {},
              child: const VText('Secondary'),
            ),
          ),
        ),
      );

      await tester.pump();
      
      Color getCurrentTextColor() {
        final textStyleWidgets = tester.widgetList<DefaultTextStyle>(find.byType(DefaultTextStyle)).toList();
        return textStyleWidgets
            .where((style) => style.style.color != null)
            .map((style) => style.style.color!)
            .firstWhere((color) => 
              color == theme.colors.text || 
              color == theme.colors.textDisabled);
      }
      
      // Initial state
      expect(getCurrentTextColor(), equals(theme.colors.text));
      
      // Hover
      final buttonFinder = find.byType(VButton);
      final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
      await gesture.addPointer(location: Offset.zero);
      await gesture.moveTo(tester.getCenter(buttonFinder));
      await tester.pump();
      
      // Should stay the same (no hover effect for secondary)
      expect(getCurrentTextColor(), equals(theme.colors.text));
      
      await gesture.removePointer();
    });
  });
}