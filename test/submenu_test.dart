import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vidraui/vidraui.dart';

Widget _wrap(Widget child) {
  return VPlatformScope(
    behavior: VPlatformBehavior.desktop(isApple: false),
    child: Directionality(
      textDirection: TextDirection.ltr,
      child: VTheme(
        data: VThemeData.light(),
        child: VOverlayHost(
          textDirection: TextDirection.ltr,
          child: Center(child: child),
        ),
      ),
    ),
  );
}

void main() {
  group('Cascading Submenu', () {
    testWidgets('hover/tap opens submenu and leaf tap closes all recursively', (tester) async {
      var activatedLeaf = false;

      final menu = VMenuAnchor<String>(
        items: [
          const VMenuItem(value: 'flat', label: 'Flat Item'),
          VMenuItem(
            label: 'Parent Submenu',
            children: [
              VMenuItem(
                value: 'leaf',
                label: 'Leaf Action',
                onPressed: () => activatedLeaf = true,
              ),
            ],
          ),
        ],
        builder: (context, controller, isOpen) {
          return VButton(
            onPressed: controller.toggle,
            child: const VText('Open Root'),
          );
        },
      );

      await tester.pumpWidget(_wrap(menu));

      // Open Root Menu
      await tester.tap(find.text('Open Root'));
      await tester.pump();
      expect(find.text('Flat Item'), findsOneWidget);
      expect(find.text('Parent Submenu'), findsOneWidget);

      // Tap on Parent Submenu to open it (since hover debouncing is 150ms, taping is instant)
      await tester.tap(find.text('Parent Submenu'));
      await tester.pumpAndSettle();

      // Leaf Action should be visible in the submenu
      expect(find.text('Leaf Action'), findsOneWidget);

      // Tap Leaf Action
      await tester.tap(find.text('Leaf Action'));
      await tester.pumpAndSettle();

      // Leaf Action's onPressed should be triggered
      expect(activatedLeaf, isTrue);

      // All menus should be closed recursively
      expect(find.text('Flat Item'), findsNothing);
      expect(find.text('Leaf Action'), findsNothing);
    });

    testWidgets('ArrowRight opens submenu and ArrowLeft closes it', (tester) async {
      final menu = VMenuAnchor<String>(
        items: [
          const VMenuItem(value: 'flat', label: 'Flat Item'),
          const VMenuItem(
            label: 'Parent Submenu',
            children: [
              VMenuItem(value: 'leaf', label: 'Leaf Action'),
            ],
          ),
        ],
        builder: (context, controller, isOpen) {
          return VButton(
            onPressed: controller.toggle,
            child: const VText('Open Root'),
          );
        },
      );

      await tester.pumpWidget(_wrap(menu));

      // Open Root Menu
      await tester.tap(find.text('Open Root'));
      await tester.pump();

      // Arrow down to highlight "Parent Submenu"
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowDown); // highlights Parent Submenu
      await tester.pump();

      // Press ArrowRight to open submenu
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowRight);
      await tester.pumpAndSettle();

      // Submenu should be open and "Leaf Action" visible
      expect(find.text('Leaf Action'), findsOneWidget);

      // Press ArrowLeft to close submenu and return focus to parent
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowLeft);
      await tester.pumpAndSettle();

      // Submenu should be closed, but parent should remain open
      expect(find.text('Leaf Action'), findsNothing);
      expect(find.text('Flat Item'), findsOneWidget);
    });

    testWidgets('submenu opens horizontally on the side instead of underneath', (tester) async {
      final menu = VMenuAnchor<String>(
        items: [
          const VMenuItem(
            label: 'Parent Submenu',
            children: [
              VMenuItem(
                value: 'leaf',
                label: 'Leaf Action',
              ),
            ],
          ),
        ],
        builder: (context, controller, isOpen) {
          return VButton(
            onPressed: controller.toggle,
            child: const VText('Open Root'),
          );
        },
      );

      await tester.pumpWidget(_wrap(menu));

      // Open Root Menu
      await tester.tap(find.text('Open Root'));
      await tester.pump();

      // Tap on Parent Submenu to open it
      await tester.tap(find.text('Parent Submenu'));
      await tester.pumpAndSettle();

      // Find the trigger position and size
      final triggerFinder = find.text('Parent Submenu');
      final triggerBox = tester.renderObject(triggerFinder) as RenderBox;
      final triggerOffset = triggerBox.localToGlobal(Offset.zero);

      // Find the leaf action position
      final leafFinder = find.text('Leaf Action');
      final leafBox = tester.renderObject(leafFinder) as RenderBox;
      final leafOffset = leafBox.localToGlobal(Offset.zero);

      // Submenu should be on the right side of the parent menu item,
      // which means the horizontal start position of Leaf Action is to the right
      // of the Parent Submenu trigger start position.
      expect(leafOffset.dx, greaterThanOrEqualTo(triggerOffset.dx + triggerBox.size.width));
    });

    testWidgets('hovering another item closes open submenu', (tester) async {
      final menu = VMenuAnchor<String>(
        items: [
          const VMenuItem(value: 'flat', label: 'Flat Item'),
          const VMenuItem(
            label: 'Parent Submenu',
            children: [
              VMenuItem(value: 'leaf', label: 'Leaf Action'),
            ],
          ),
        ],
        builder: (context, controller, isOpen) {
          return VButton(
            onPressed: controller.toggle,
            child: const VText('Open Root'),
          );
        },
      );

      await tester.pumpWidget(_wrap(menu));

      // Open Root Menu
      await tester.tap(find.text('Open Root'));
      await tester.pumpAndSettle();

      // Create a mouse pointer
      final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
      await gesture.addPointer(location: Offset.zero);
      await tester.pump();

      // Hover over 'Parent Submenu'
      await gesture.moveTo(tester.getCenter(find.text('Parent Submenu')));
      // Wait for the hover delay (150ms) to open the submenu
      await tester.pumpAndSettle(const Duration(milliseconds: 200));
      expect(find.text('Leaf Action'), findsOneWidget);

      // Now move mouse to hover 'Flat Item'
      await gesture.moveTo(tester.getCenter(find.text('Flat Item')));
      await tester.pumpAndSettle();

      // The submenu should be closed automatically
      expect(find.text('Leaf Action'), findsNothing);
      await gesture.removePointer();
    });
  });
}
