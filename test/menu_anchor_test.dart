import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vidraui/vidraui.dart';

Widget _wrap(Widget child) {
  return Directionality(
    textDirection: TextDirection.ltr,
    child: VTheme(
      data: VThemeData.light(),
      child: VOverlayHost(
        textDirection: TextDirection.ltr,
        child: Center(child: child),
      ),
    ),
  );
}

VMenuAnchor<String> _menu({
  VMenuController? controller,
  List<VMenuItem<String>>? items,
  VMenuSelectionMode selectionMode = VMenuSelectionMode.none,
  String? selectedValue,
  Set<String>? selectedValues,
  ValueChanged<String>? onSelected,
  ValueChanged<Set<String>>? onSelectionChanged,
  double maxMenuHeight = 280,
}) {
  return VMenuAnchor<String>(
    controller: controller,
    items: items ??
        [
          const VMenuItem(value: 'one', label: 'One'),
          const VMenuItem(value: 'two', label: 'Two'),
        ],
    selectionMode: selectionMode,
    selectedValue: selectedValue,
    selectedValues: selectedValues,
    maxMenuHeight: maxMenuHeight,
    onSelected: onSelected,
    onSelectionChanged: onSelectionChanged,
    builder: (context, controller, isOpen) {
      return VButton(
        onPressed: controller.toggle,
        child: const VText('Open menu'),
      );
    },
  );
}

void main() {
  group('VMenuAnchor', () {
    testWidgets('opens from trigger and closes on outside tap', (tester) async {
      await tester.pumpWidget(_wrap(_menu()));

      await tester.tap(find.text('Open menu'));
      await tester.pump();
      expect(find.text('One'), findsOneWidget);

      await tester.tapAt(Offset.zero);
      await tester.pump();
      expect(find.text('One'), findsNothing);
    });

    testWidgets('escape closes the menu', (tester) async {
      await tester.pumpWidget(_wrap(_menu()));

      await tester.tap(find.text('Open menu'));
      await tester.pump();
      await tester.sendKeyEvent(LogicalKeyboardKey.escape);
      await tester.pump();

      expect(find.text('One'), findsNothing);
    });

    testWidgets('arrow keys skip disabled items and separators',
        (tester) async {
      var activated = '';
      await tester.pumpWidget(_wrap(_menu(
        items: [
          const VMenuItem(value: 'one', label: 'One'),
          const VMenuItem(value: 'disabled', label: 'Disabled', enabled: false),
          const VMenuItem.separator(),
          VMenuItem(
            value: 'two',
            label: 'Two',
            onPressed: () => activated = 'two',
          ),
        ],
      )));

      await tester.tap(find.text('Open menu'));
      await tester.pump();
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowDown);
      await tester.sendKeyEvent(LogicalKeyboardKey.enter);
      await tester.pump();

      expect(activated, 'two');
    });

    testWidgets('enter activates highlighted action item', (tester) async {
      var count = 0;
      await tester.pumpWidget(_wrap(_menu(
        items: [
          VMenuItem(label: 'Increment', onPressed: () => count++),
        ],
      )));

      await tester.tap(find.text('Open menu'));
      await tester.pump();
      await tester.sendKeyEvent(LogicalKeyboardKey.enter);
      await tester.pump();

      expect(count, 1);
      expect(find.text('Increment'), findsNothing);
    });

    testWidgets('disabled item does not call callbacks', (tester) async {
      var count = 0;
      await tester.pumpWidget(_wrap(_menu(
        items: [
          VMenuItem(
            label: 'Disabled',
            enabled: false,
            onPressed: () => count++,
          ),
          const VMenuItem(label: 'Enabled'),
        ],
      )));

      await tester.tap(find.text('Open menu'));
      await tester.pump();

      await tester.tap(find.text('Disabled'));
      await tester.pump();
      expect(count, 0);
    });

    testWidgets('single selection calls onSelected and closes', (tester) async {
      String? selected;
      await tester.pumpWidget(_wrap(_menu(
        selectionMode: VMenuSelectionMode.single,
        onSelected: (value) => selected = value,
      )));

      await tester.tap(find.text('Open menu'));
      await tester.pump();
      await tester.tap(find.text('One'));
      await tester.pump();

      expect(selected, 'one');
      expect(find.text('One'), findsNothing);
    });

    testWidgets('multiple selection calls onSelectionChanged and stays open',
        (tester) async {
      Set<String> selected = {};
      await tester.pumpWidget(_wrap(StatefulBuilder(
        builder: (context, setState) {
          return _menu(
            selectionMode: VMenuSelectionMode.multiple,
            selectedValues: selected,
            onSelectionChanged: (value) => setState(() => selected = value),
          );
        },
      )));

      await tester.tap(find.text('Open menu'));
      await tester.pump();
      await tester.tap(find.text('One'));
      await tester.pump();

      expect(selected, {'one'});
      expect(find.text('One'), findsOneWidget);
    });

    testWidgets('controller opens, closes, and toggles menu', (tester) async {
      final controller = VMenuController();
      await tester.pumpWidget(_wrap(_menu(controller: controller)));

      controller.open();
      await tester.pump();
      expect(controller.isOpen, isTrue);
      expect(find.text('One'), findsOneWidget);

      controller.close();
      await tester.pump();
      expect(controller.isOpen, isFalse);

      controller.toggle();
      await tester.pump();
      expect(controller.isOpen, isTrue);
    });

    testWidgets('large menus build only visible rows', (tester) async {
      await tester.pumpWidget(_wrap(_menu(
        maxMenuHeight: 96,
        items: List.generate(
          200,
          (index) => VMenuItem(
            value: 'item-$index',
            label: 'Item $index',
          ),
        ),
      )));

      await tester.tap(find.text('Open menu'));
      await tester.pump();

      expect(find.text('Item 0'), findsOneWidget);
      expect(find.text('Item 199'), findsNothing);

      final listView = tester.widget<ListView>(find.byType(ListView));
      expect(listView.itemExtent, isNull);
      expect(tester.getSize(find.byType(ListView)).height, 96);
    });
  });
}
