import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vidraui/vidraui.dart';

Widget _wrap(Widget child) {
  return Directionality(
    textDirection: TextDirection.ltr,
    child: VTheme(data: VThemeData.light(), child: child),
  );
}

void main() {
  group('VChip', () {
    testWidgets('renders label', (tester) async {
      await tester.pumpWidget(_wrap(
        const VChip(label: Text('Chip')),
      ));
      expect(find.text('Chip'), findsOneWidget);
    });

    testWidgets('onPressed fires when tapped', (tester) async {
      bool fired = false;
      await tester.pumpWidget(_wrap(
        VChip(label: const Text('Click'), onPressed: () => fired = true),
      ));
      await tester.tap(find.text('Click'));
      expect(fired, isTrue);
    });

    testWidgets('disabled (enabled: false) does not fire', (tester) async {
      bool fired = false;
      await tester.pumpWidget(_wrap(
        VChip(label: const Text('Disabled'), enabled: false, onPressed: () => fired = true),
      ));
      await tester.tap(find.text('Disabled'));
      expect(fired, isFalse);
    });

    testWidgets('onDeleted fires delete affordance', (tester) async {
      bool fired = false;
      await tester.pumpWidget(_wrap(
        VChip(label: const Text('Del'), onDeleted: () => fired = true),
      ));
      await tester.tap(find.byKey(const Key('v_chip_delete_button')));
      expect(fired, isTrue);
    });

    testWidgets('renders leading widget', (tester) async {
      await tester.pumpWidget(_wrap(
        const VChip(label: Text('With icon'), leading: Text('★')),
      ));
      expect(find.text('★'), findsOneWidget);
    });

    testWidgets('renders variants', (tester) async {
      await tester.pumpWidget(_wrap(
        const Row(children: [
          VChip(label: Text('Soft')),
          VChip(label: Text('Filled'), variant: VChipVariant.filled),
          VChip(label: Text('Outlined'), variant: VChipVariant.outlined),
        ]),
      ));
      expect(find.text('Soft'), findsOneWidget);
      expect(find.text('Filled'), findsOneWidget);
      expect(find.text('Outlined'), findsOneWidget);
    });
  });
}
