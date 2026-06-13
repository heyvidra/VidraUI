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
  group('VSegmentedControl', () {
    testWidgets('taps select option', (tester) async {
      String selectedValue = 'one';

      await tester.pumpWidget(_wrap(
        StatefulBuilder(
          builder: (context, setState) {
            return VSegmentedControl<String>(
              value: selectedValue,
              options: const [
                VSegmentedControlOption(value: 'one', label: 'One'),
                VSegmentedControlOption(value: 'two', label: 'Two'),
              ],
              onChanged: (v) => setState(() => selectedValue = v),
            );
          },
        ),
      ));

      expect(selectedValue, 'one');

      await tester.tap(find.text('Two'));
      await tester.pumpAndSettle();

      expect(selectedValue, 'two');
    });

    testWidgets('disabled options do not trigger onChanged', (tester) async {
      String selectedValue = 'one';

      await tester.pumpWidget(_wrap(
        StatefulBuilder(
          builder: (context, setState) {
            return VSegmentedControl<String>(
              value: selectedValue,
              options: const [
                VSegmentedControlOption(value: 'one', label: 'One'),
                VSegmentedControlOption(value: 'two', label: 'Two', enabled: false),
              ],
              onChanged: (v) => setState(() => selectedValue = v),
            );
          },
        ),
      ));

      await tester.tap(find.text('Two'));
      await tester.pumpAndSettle();

      expect(selectedValue, 'one');
    });

    testWidgets('arrow keys navigate and cycle options when focused', (tester) async {
      String selectedValue = 'one';

      await tester.pumpWidget(_wrap(
        StatefulBuilder(
          builder: (context, setState) {
            return VSegmentedControl<String>(
              value: selectedValue,
              options: const [
                VSegmentedControlOption(value: 'one', label: 'One'),
                VSegmentedControlOption(value: 'two', label: 'Two'),
                VSegmentedControlOption(value: 'three', label: 'Three'),
              ],
              onChanged: (v) => setState(() => selectedValue = v),
            );
          },
        ),
      ));

      // Tap to focus the control
      await tester.tap(find.text('One'));
      await tester.pumpAndSettle();

      // Send Arrow Right key
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowRight);
      await tester.pumpAndSettle();
      expect(selectedValue, 'two');

      // Send Arrow Left key
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowLeft);
      await tester.pumpAndSettle();
      expect(selectedValue, 'one');
    });
  });
}
