import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vidraui/vidraui.dart';

Widget _wrap(Widget child) {
  return MediaQuery(
    data: const MediaQueryData(),
    child: VTheme(
      data: VThemeData.light(),
      child: VOverlayHost(
        textDirection: TextDirection.ltr,
        child: Center(
          child: SizedBox(
            width: 320,
            child: child,
          ),
        ),
      ),
    ),
  );
}

Offset _textOffsetToPosition(WidgetTester tester, int offset) {
  final state = tester.state<EditableTextState>(find.byType(EditableText));
  final caret = state.renderEditable.getLocalRectForCaret(
    TextPosition(offset: offset),
  );
  return state.renderEditable.localToGlobal(caret.centerLeft);
}

void main() {
  group('VTextField', () {
    testWidgets('supports mouse drag selection', (tester) async {
      final controller = TextEditingController(text: 'Selectable text');
      addTearDown(controller.dispose);

      await tester.pumpWidget(_wrap(VTextField(controller: controller)));

      final start = _textOffsetToPosition(tester, 0);
      await tester.tapAt(start, kind: PointerDeviceKind.mouse);
      await tester.pump();

      final gesture = await tester.startGesture(
        start,
        kind: PointerDeviceKind.mouse,
      );
      addTearDown(gesture.removePointer);
      await tester.pump();
      await gesture.moveTo(_textOffsetToPosition(tester, 10));
      await tester.pump();
      await gesture.up();
      await tester.pumpAndSettle();

      expect(controller.selection.isCollapsed, isFalse);
    });

    testWidgets('shows context menu on secondary click', (tester) async {
      final controller = TextEditingController(text: 'Selectable text');
      addTearDown(controller.dispose);

      await tester.pumpWidget(_wrap(VTextField(controller: controller)));

      await tester.tapAt(
        _textOffsetToPosition(tester, 4),
        buttons: kSecondaryMouseButton,
        kind: PointerDeviceKind.mouse,
      );
      await tester.pump();

      expect(find.text('Select All'), findsOneWidget);
    });

    test('VTextSelectionMenuLayoutDelegate clamps horizontal boundaries', () {
      final delegate = VTextSelectionMenuLayoutDelegate(
        primaryAnchor: const Offset(450.0, 100.0),
        secondaryAnchor: const Offset(450.0, 120.0),
        margin: 8.0,
        isDesktop: false,
        radius: 22.0,
        onPositionChanged: (pos) {},
      );

      // Parent size is 500x500
      // Child size is 200x50
      // Ideal x before clamping is 450 - 200 / 2 = 350.
      // Maximum allowed x is 500 - 200 - 8 = 292.
      // The delegate must clamp the x coordinate to 292.0.
      final offset = delegate.getPositionForChild(
        const Size(500.0, 500.0),
        const Size(200.0, 50.0),
      );

      expect(offset.dx, 292.0);
      expect(offset.dy, 42.0); // 100.0 - 50.0 - 8.0
    });

    testWidgets('uses correct local theme (e.g. dark) for context menu', (tester) async {
      final controller = TextEditingController(text: 'Selectable text');
      addTearDown(controller.dispose);

      final darkTheme = VThemeData.dark();

      await tester.pumpWidget(MediaQuery(
        data: const MediaQueryData(),
        child: VTheme(
          data: VThemeData.light(),
          child: VOverlayHost(
            textDirection: TextDirection.ltr,
            child: VTheme(
              data: darkTheme,
              child: Center(
                child: SizedBox(
                  width: 320,
                  child: VTextField(controller: controller),
                ),
              ),
            ),
          ),
        ),
      ));

      await tester.tapAt(
        _textOffsetToPosition(tester, 4),
        buttons: kSecondaryMouseButton,
        kind: PointerDeviceKind.mouse,
      );
      await tester.pumpAndSettle();

      final menuFinder = find.byType(VTextSelectionMenu);
      expect(menuFinder, findsOneWidget);

      final menuWidget = tester.widget<VTextSelectionMenu>(menuFinder);
      expect(menuWidget.theme, equals(darkTheme));
    });
  });
}
