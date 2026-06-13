import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vidraui/vidraui.dart';

Widget _wrap(Widget child) {
  return Directionality(
    textDirection: TextDirection.ltr,
    child: VPlatformScope(
      behavior: VPlatformBehavior.desktop(isApple: false),
      child: VTheme(
        data: VThemeData.light(),
        child: child,
      ),
    ),
  );
}

Future<Rect> _dragPositionedResizable(
  WidgetTester tester, {
  required Rect initialRect,
  required Offset start,
  required Offset delta,
  Set<VResizeHandle> enabledHandles = VResizeHandles.all,
  bool showHandles = true,
  VResizeBoundaryBehavior boundaryBehavior = VResizeBoundaryBehavior.fixed,
  VResizeHandleBuilder? handleBuilder,
}) async {
  var rect = initialRect;

  await tester.pumpWidget(_wrap(
    StatefulBuilder(
      builder: (context, setState) {
        return SizedBox(
          width: 400,
          height: 300,
          child: Stack(
            children: [
              VResizable.positioned(
                rect: rect,
                enabledHandles: enabledHandles,
                showHandles: showHandles,
                boundaryBehavior: boundaryBehavior,
                onRectChanged: (value) => setState(() => rect = value),
                handleBuilder: handleBuilder,
                child: const SizedBox.expand(),
              ),
            ],
          ),
        );
      },
    ),
  ));

  final gesture = await tester.startGesture(start);
  await gesture.moveBy(delta);
  await gesture.up();
  await tester.pump();

  return rect;
}

void main() {
  group('VResizable', () {
    testWidgets('right edge resizes from the visual rect edge', (tester) async {
      final rect = await _dragPositionedResizable(
        tester,
        initialRect: const Rect.fromLTWH(40, 40, 200, 150),
        start: const Offset(235, 115),
        delta: const Offset(40, 0),
        enabledHandles: VResizeHandles.rightBottom,
      );

      expect(rect.left, 40);
      expect(rect.top, 40);
      expect(rect.width, 240);
      expect(rect.height, 150);
    });

    testWidgets('all corner handles resize the matching corner',
        (tester) async {
      final cases = [
        (
          start: const Offset(105, 85),
          delta: const Offset(-20, -10),
          expected: const Rect.fromLTWH(80, 70, 180, 130),
        ),
        (
          start: const Offset(255, 85),
          delta: const Offset(20, -10),
          expected: const Rect.fromLTWH(100, 70, 180, 130),
        ),
        (
          start: const Offset(105, 195),
          delta: const Offset(-20, 10),
          expected: const Rect.fromLTWH(80, 80, 180, 130),
        ),
        (
          start: const Offset(255, 195),
          delta: const Offset(20, 10),
          expected: const Rect.fromLTWH(100, 80, 180, 130),
        ),
      ];

      for (final entry in cases) {
        final rect = await _dragPositionedResizable(
          tester,
          initialRect: const Rect.fromLTWH(100, 80, 160, 120),
          start: entry.start,
          delta: entry.delta,
        );

        expect(rect, entry.expected);
      }
    });

    testWidgets('empty enabledHandles disables resize', (tester) async {
      final rect = await _dragPositionedResizable(
        tester,
        initialRect: const Rect.fromLTWH(40, 40, 200, 150),
        start: const Offset(235, 115),
        delta: const Offset(40, 0),
        enabledHandles: const {},
      );

      expect(rect, const Rect.fromLTWH(40, 40, 200, 150));
    });

    testWidgets('rightBottom handles do not enable left edge resize',
        (tester) async {
      final rect = await _dragPositionedResizable(
        tester,
        initialRect: const Rect.fromLTWH(40, 40, 200, 150),
        start: const Offset(45, 115),
        delta: const Offset(-40, 0),
        enabledHandles: VResizeHandles.rightBottom,
      );

      expect(rect, const Rect.fromLTWH(40, 40, 200, 150));
    });

    testWidgets('hidden handles keep hit zones active', (tester) async {
      final rect = await _dragPositionedResizable(
        tester,
        initialRect: const Rect.fromLTWH(40, 40, 200, 150),
        start: const Offset(235, 115),
        delta: const Offset(40, 0),
        enabledHandles: VResizeHandles.rightBottom,
        showHandles: false,
      );

      expect(rect.width, 240);
    });

    testWidgets('fixed boundary stops left drag at the parent edge',
        (tester) async {
      final rect = await _dragPositionedResizable(
        tester,
        initialRect: const Rect.fromLTWH(40, 40, 100, 80),
        start: const Offset(45, 80),
        delta: const Offset(-240, 0),
      );

      expect(rect.left, 0);
      expect(rect.width, 140);
    });

    testWidgets('expandWithinBounds keeps the previous inward expansion',
        (tester) async {
      final rect = await _dragPositionedResizable(
        tester,
        initialRect: const Rect.fromLTWH(40, 40, 100, 80),
        start: const Offset(45, 80),
        delta: const Offset(-240, 0),
        boundaryBehavior: VResizeBoundaryBehavior.expandWithinBounds,
      );

      expect(rect.left, 0);
      expect(rect.width, 340);
    });

    testWidgets('handleBuilder replaces the visible handle', (tester) async {
      await _dragPositionedResizable(
        tester,
        initialRect: const Rect.fromLTWH(40, 40, 200, 150),
        start: const Offset(235, 115),
        delta: Offset.zero,
        enabledHandles: VResizeHandles.rightBottom,
        handleBuilder: (context, handle, active, defaultHandle) {
          return SizedBox(
            key: ValueKey('custom-$handle'),
            width: 12,
            height: 12,
          );
        },
      );

      expect(find.byKey(const ValueKey('custom-VResizeHandle.right')),
          findsOneWidget);
      expect(find.byKey(const ValueKey('custom-VResizeHandle.bottom')),
          findsOneWidget);
      expect(find.byKey(const ValueKey('custom-VResizeHandle.bottomRight')),
          findsOneWidget);
    });
  });
}
