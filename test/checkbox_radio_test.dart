import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vidraui/vidraui.dart';

Widget _wrap(Widget child) {
  return Directionality(
    textDirection: TextDirection.ltr,
    child: VTheme(
      data: VThemeData.light(),
      child: child,
    ),
  );
}

void main() {
  group('VCheckbox', () {
    testWidgets('renders label', (tester) async {
      await tester.pumpWidget(_wrap(
        VCheckbox(
          checked: false,
          label: 'Accept',
          onChanged: (_) {},
        ),
      ));
      expect(find.text('Accept'), findsOneWidget);
    });

    testWidgets('fires onChanged on tap', (tester) async {
      bool? result;
      await tester.pumpWidget(_wrap(
        VCheckbox(
          checked: false,
          onChanged: (v) => result = v,
        ),
      ));
      await tester.tap(find.byType(VCheckbox));
      expect(result, isTrue);
    });

    testWidgets('disabled does not fire', (tester) async {
      bool? result;
      final focusNode = FocusNode();
      addTearDown(focusNode.dispose);

      await tester.pumpWidget(_wrap(
        VCheckbox(
          checked: false,
          enabled: false,
          focusNode: focusNode,
          onChanged: (v) => result = v,
        ),
      ));
      await tester.tap(find.byType(VCheckbox));
      focusNode.requestFocus();
      await tester.pump();
      await tester.sendKeyEvent(LogicalKeyboardKey.space);
      expect(result, isNull);
    });

    testWidgets('renders indeterminate state', (tester) async {
      await tester.pumpWidget(_wrap(
        VCheckbox(
          checked: null,
          onChanged: (_) {},
        ),
      ));
      expect(find.byType(CustomPaint), findsOneWidget);
    });

    testWidgets('cycles states when tristate is true', (tester) async {
      bool? state = false;

      await tester.pumpWidget(StatefulBuilder(
        builder: (context, setState) => _wrap(
          VCheckbox(
            checked: state,
            tristate: true,
            onChanged: (v) => setState(() => state = v),
          ),
        ),
      ));

      // Tap 1: false -> null
      await tester.tap(find.byType(VCheckbox));
      await tester.pump();
      expect(state, isNull);

      // Tap 2: null -> true
      await tester.tap(find.byType(VCheckbox));
      await tester.pump();
      expect(state, isTrue);

      // Tap 3: true -> false
      await tester.tap(find.byType(VCheckbox));
      await tester.pump();
      expect(state, isFalse);

      // Tap 4: false -> null
      await tester.tap(find.byType(VCheckbox));
      await tester.pump();
      expect(state, isNull);
    });
  });

  group('VRadio', () {
    testWidgets('renders label', (tester) async {
      await tester.pumpWidget(_wrap(
        const VRadio(selected: false, label: 'Option A'),
      ));
      expect(find.text('Option A'), findsOneWidget);
    });

    testWidgets('fires onSelected on tap', (tester) async {
      bool fired = false;
      await tester.pumpWidget(_wrap(
        VRadio(
          selected: false,
          onSelected: () => fired = true,
        ),
      ));
      await tester.tap(find.byType(VRadio));
      expect(fired, isTrue);
    });

    testWidgets('works with typed VRadioGroup', (tester) async {
      String? selected = 'a';

      await tester.pumpWidget(_wrap(
        StatefulBuilder(
          builder: (context, setState) {
            return VRadioGroup<String>(
              value: selected,
              onChanged: (value) => setState(() => selected = value),
              child: const Column(
                children: [
                  VRadio<String>(value: 'a', label: 'Option A'),
                  VRadio<String>(value: 'b', label: 'Option B'),
                ],
              ),
            );
          },
        ),
      ));

      await tester.tap(find.text('Option B'));
      expect(selected, 'b');
    });
  });

  group('VSwitch', () {
    testWidgets('fires onChanged on tap', (tester) async {
      bool? result;
      await tester.pumpWidget(_wrap(
        VSwitch(
          checked: false,
          onChanged: (v) => result = v,
        ),
      ));
      await tester.tap(find.byType(VSwitch));
      expect(result, isTrue);
    });

    testWidgets('disabled does not fire', (tester) async {
      bool? result;
      final focusNode = FocusNode();
      addTearDown(focusNode.dispose);

      await tester.pumpWidget(_wrap(
        VSwitch(
          checked: true,
          enabled: false,
          focusNode: focusNode,
          onChanged: (v) => result = v,
        ),
      ));
      await tester.tap(find.byType(VSwitch));
      focusNode.requestFocus();
      await tester.pump();
      await tester.sendKeyEvent(LogicalKeyboardKey.space);
      expect(result, isNull);
    });

    testWidgets('thumb stretches and squashes on press', (tester) async {
      await tester.pumpWidget(_wrap(
        VSwitch(
          checked: false,
          onChanged: (_) {},
        ),
      ));

      final thumbFinder = find.descendant(
        of: find.byType(VSwitch),
        matching: find.byType(DecoratedBox),
      ).last;
      
      final initialBox = tester.renderObject(thumbFinder) as RenderBox;
      final initialSize = initialBox.size;

      final gesture = await tester.startGesture(tester.getCenter(find.byType(VSwitch)));
      await tester.pump();
      // Advance time by 100ms to let the stretch animation progress
      await tester.pump(const Duration(milliseconds: 100));

      final pressedBox = tester.renderObject(thumbFinder) as RenderBox;
      final pressedSize = pressedBox.size;

      expect(pressedSize.width, greaterThan(initialSize.width));
      expect(pressedSize.height, lessThan(initialSize.height));

      await gesture.up();
      await tester.pumpAndSettle();
    });

    testWidgets('renders label', (tester) async {
      await tester.pumpWidget(_wrap(
        VSwitch(
          checked: false,
          label: 'Toggle Switch',
          onChanged: (_) {},
        ),
      ));
      expect(find.text('Toggle Switch'), findsOneWidget);
    });

    testWidgets('renders custom labelWidget', (tester) async {
      await tester.pumpWidget(_wrap(
        VSwitch(
          checked: false,
          labelWidget: const Text('Custom Label'),
          onChanged: (_) {},
        ),
      ));
      expect(find.text('Custom Label'), findsOneWidget);
    });
  });
}
