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
  group('VAvatar', () {
    testWidgets('shows initials from name', (tester) async {
      await tester.pumpWidget(_wrap(const VAvatar(name: 'John Doe')));
      expect(find.text('JD'), findsOneWidget);
    });

    testWidgets('single name shows first letter', (tester) async {
      await tester.pumpWidget(_wrap(const VAvatar(name: 'Admin')));
      expect(find.text('A'), findsOneWidget);
    });

    testWidgets('empty name shows fallback', (tester) async {
      await tester.pumpWidget(_wrap(const VAvatar(name: '')));
      expect(find.text('?'), findsOneWidget);
    });
  });

  group('VBadge', () {
    testWidgets('shows count', (tester) async {
      await tester.pumpWidget(_wrap(
        const VBadge(
          count: 5,
          child: Text('Inbox'),
        ),
      ));
      expect(find.text('5'), findsOneWidget);
    });

    testWidgets('shows 99+ for counts over 99', (tester) async {
      await tester.pumpWidget(_wrap(
        const VBadge(
          count: 150,
          child: Text('Inbox'),
        ),
      ));
      expect(find.text('99+'), findsOneWidget);
    });

    testWidgets('dot mode shows no text', (tester) async {
      await tester.pumpWidget(_wrap(
        const VBadge(
          showDot: true,
          child: Text('Inbox'),
        ),
      ));
      expect(find.text(''), findsNothing);
    });
  });

  group('VProgressBar', () {
    testWidgets('renders determinate bar', (tester) async {
      await tester.pumpWidget(_wrap(
        const VProgressBar(value: 0.5),
      ));
      expect(find.byType(VProgressBar), findsOneWidget);
    });

    testWidgets('renders indeterminate bar', (tester) async {
      await tester.pumpWidget(_wrap(
        const VProgressBar(value: null),
      ));
      expect(find.byType(VProgressBar), findsOneWidget);
    });
  });

  group('VSpinner', () {
    testWidgets('renders spinner', (tester) async {
      await tester.pumpWidget(_wrap(const VSpinner()));
      expect(find.byType(VSpinner), findsOneWidget);
    });
  });

  group('VSlider', () {
    testWidgets('renders horizontal slider', (tester) async {
      await tester.pumpWidget(_wrap(
        VSlider(
          value: 0.5,
          onChanged: (v) {},
        ),
      ));
      expect(find.byType(VSlider), findsOneWidget);
    });

    testWidgets('renders vertical slider', (tester) async {
      await tester.pumpWidget(_wrap(
        VSlider(
          value: 0.5,
          onChanged: (v) {},
          axis: Axis.vertical,
        ),
      ));
      expect(find.byType(VSlider), findsOneWidget);
    });

    testWidgets('snaps to step', (tester) async {
      double? result;
      await tester.pumpWidget(_wrap(
        VSlider(
          value: 0.0,
          min: 0,
          max: 100,
          step: 25,
          onChanged: (v) => result = v,
        ),
      ));

      // Tap near 30% should snap to 25
      final slider = tester.getSize(find.byType(VSlider));
      await tester.tapAt(
        tester.getTopLeft(find.byType(VSlider)) +
            Offset(slider.width * 0.28, slider.height / 2),
      );
      expect(result, 25.0);
    });

    testWidgets('VSlider updates valueNotifier and triggers onDragEnd', (tester) async {
      final notifier = ValueNotifier<double>(0.5);
      double? endValue;

      await tester.pumpWidget(_wrap(
        VSlider(
          value: 0.5,
          valueNotifier: notifier,
          onChanged: (val) {},
          onDragEnd: (val) => endValue = val,
        ),
      ));

      expect(notifier.value, 0.5);

      final slider = tester.getSize(find.byType(VSlider));
      // Tap near 80% width
      await tester.tapAt(
        tester.getTopLeft(find.byType(VSlider)) +
            Offset(slider.width * 0.8, slider.height / 2),
      );
      await tester.pump();

      expect(endValue, greaterThan(0.5));
      expect(notifier.value, endValue);
    });
  });

  group('date and time picker tokens', () {
    testWidgets('VDatePicker moves focus with arrow keys', (tester) async {
      DateTime? selected = DateTime(2026, 1, 15);

      await tester.pumpWidget(_wrap(
        StatefulBuilder(
          builder: (context, setState) {
            return VDatePicker(
              selected: selected,
              firstDate: DateTime(2026, 1),
              lastDate: DateTime(2026, 1, 31),
              onChanged: (date) => setState(() => selected = date),
            );
          },
        ),
      ));

      await tester.tap(find.text('15'));
      await tester.pump();

      await tester.sendKeyEvent(LogicalKeyboardKey.arrowRight);
      await tester.pump();
      await tester.sendKeyEvent(LogicalKeyboardKey.enter);
      await tester.pump();
      expect(selected, DateTime(2026, 1, 16));

      await tester.sendKeyEvent(LogicalKeyboardKey.arrowDown);
      await tester.pump();
      await tester.sendKeyEvent(LogicalKeyboardKey.enter);
      await tester.pump();
      expect(selected, DateTime(2026, 1, 23));

      await tester.sendKeyEvent(LogicalKeyboardKey.arrowLeft);
      await tester.pump();
      await tester.sendKeyEvent(LogicalKeyboardKey.enter);
      await tester.pump();
      expect(selected, DateTime(2026, 1, 22));

      await tester.sendKeyEvent(LogicalKeyboardKey.arrowUp);
      await tester.pump();
      await tester.sendKeyEvent(LogicalKeyboardKey.enter);
      await tester.pump();
      expect(selected, DateTime(2026, 1, 15));
    });

    testWidgets('VDatePicker selects focused date with Enter and Space',
        (tester) async {
      DateTime? selected = DateTime(2026, 1, 15);

      await tester.pumpWidget(_wrap(
        StatefulBuilder(
          builder: (context, setState) {
            return VDatePicker(
              selected: selected,
              firstDate: DateTime(2026, 1),
              lastDate: DateTime(2026, 1, 31),
              onChanged: (date) => setState(() => selected = date),
            );
          },
        ),
      ));

      await tester.tap(find.text('15'));
      await tester.pump();
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowRight);
      await tester.pump();
      await tester.sendKeyEvent(LogicalKeyboardKey.enter);
      await tester.pump();
      expect(selected, DateTime(2026, 1, 16));

      await tester.sendKeyEvent(LogicalKeyboardKey.arrowRight);
      await tester.pump();
      await tester.sendKeyEvent(LogicalKeyboardKey.space);
      await tester.pump();
      expect(selected, DateTime(2026, 1, 17));
    });

    testWidgets('VDatePicker does not select disabled out-of-range dates',
        (tester) async {
      DateTime? selected = DateTime(2026, 1, 10);

      await tester.pumpWidget(_wrap(
        StatefulBuilder(
          builder: (context, setState) {
            return VDatePicker(
              selected: selected,
              firstDate: DateTime(2026, 1, 10),
              lastDate: DateTime(2026, 1, 20),
              onChanged: (date) => setState(() => selected = date),
            );
          },
        ),
      ));

      await tester.tap(find.text('9'));
      await tester.pump();
      expect(selected, DateTime(2026, 1, 10));

      await tester.tap(find.text('10'));
      await tester.pump();
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowLeft);
      await tester.pump();
      await tester.sendKeyEvent(LogicalKeyboardKey.space);
      await tester.pump();
      expect(selected, DateTime(2026, 1, 10));
    });

    testWidgets('VDatePicker exposes date and navigation semantics',
        (tester) async {
      final semantics = tester.ensureSemantics();

      await tester.pumpWidget(_wrap(
        VDatePicker(
          selected: DateTime(2026, 1, 15),
          firstDate: DateTime(2026, 1, 10),
          lastDate: DateTime(2026, 1, 20),
        ),
      ));

      expect(find.bySemanticsLabel('Previous month'), findsOneWidget);
      expect(find.bySemanticsLabel('Next month'), findsOneWidget);
      expect(find.bySemanticsLabel('Jan 15, 2026, selected'), findsOneWidget);
      expect(find.bySemanticsLabel('Jan 9, 2026, disabled'), findsOneWidget);

      semantics.dispose();
    });

    testWidgets('VDatePicker uses date picker component tokens',
        (tester) async {
      const selectedColor = Color(0xFF123456);
      final base = VThemeData.light();
      final theme = base.copyWith(
        components: base.components.copyWith(
          datePicker: base.components.datePicker.copyWith(
            selectedBackground: selectedColor,
            dayCellHeight: 44,
            dayCellRadius: 11,
          ),
        ),
      );

      await tester.pumpWidget(Directionality(
        textDirection: TextDirection.ltr,
        child: VTheme(
          data: theme,
          child: VDatePicker(
            selected: DateTime(2026, 5, 15),
          ),
        ),
      ));

      final selectedCell = find.ancestor(
        of: find.text('15'),
        matching: find.byWidgetPredicate((widget) {
          return widget is Container &&
              widget.decoration is BoxDecoration &&
              (widget.decoration! as BoxDecoration).color == selectedColor;
        }),
      );
      final selectedContainer = tester.widget<Container>(selectedCell);
      final decoration = selectedContainer.decoration! as BoxDecoration;

      expect(tester.getSize(selectedCell).height, 44);
      expect(decoration.color, selectedColor);
      expect(decoration.borderRadius, BorderRadius.circular(11));
    });

    testWidgets('VDatePicker uses dedicated focus component tokens',
        (tester) async {
      const focusColor = Color(0xFFABCDEF);
      const focusBackground = Color(0xFFEEDDCC);
      final base = VThemeData.light();
      final theme = base.copyWith(
        components: base.components.copyWith(
          datePicker: base.components.datePicker.copyWith(
            focusOutline: focusColor,
            focusOutlineWidth: 3,
            focusBackground: focusBackground,
          ),
        ),
      );

      await tester.pumpWidget(Directionality(
        textDirection: TextDirection.ltr,
        child: VTheme(
          data: theme,
          child: VDatePicker(
            selected: DateTime(2026, 5, 15),
            firstDate: DateTime(2026, 5, 1),
            lastDate: DateTime(2026, 5, 31),
          ),
        ),
      ));

      await tester.tap(find.text('14'));
      await tester.pump();

      final focusedCell = find.ancestor(
        of: find.text('14'),
        matching: find.byWidgetPredicate((widget) {
          if (widget is! Container || widget.decoration is! BoxDecoration) {
            return false;
          }
          final decoration = widget.decoration! as BoxDecoration;
          final border = decoration.border;
          return decoration.color == focusBackground &&
              border is Border &&
              border.top.color == focusColor &&
              border.top.width == 3;
        }),
      );

      expect(focusedCell, findsOneWidget);

      final selectedCell = tester.widget<Container>(
        find.ancestor(
          of: find.text('15'),
          matching: find.byWidgetPredicate((widget) {
            return widget is Container &&
                widget.decoration is BoxDecoration &&
                (widget.decoration! as BoxDecoration).color ==
                    theme.components.datePicker.selectedBackground;
          }),
        ),
      );
      expect((selectedCell.decoration! as BoxDecoration).border, isNull);
    });

    testWidgets('VTimePicker uses time picker component tokens',
        (tester) async {
      const selectedColor = Color(0xFF654321);
      final base = VThemeData.light();
      final theme = base.copyWith(
        components: base.components.copyWith(
          timePicker: base.components.timePicker.copyWith(
            columnWidth: 80,
            wheelHeight: 220,
            itemHeight: 52,
            diameterRatio: 3,
            selectedForeground: selectedColor,
          ),
        ),
      );

      await tester.pumpWidget(Directionality(
        textDirection: TextDirection.ltr,
        child: VTheme(
          data: theme,
          child: const VTimePicker(
            selected: VTimeOfDay(hour: 12, minute: 0),
          ),
        ),
      ));

      final wheel = tester.widget<ListWheelScrollView>(
        find.byType(ListWheelScrollView).first,
      );

      expect(wheel.itemExtent, 52);
      expect(wheel.diameterRatio, 3);
      expect(
        tester.getSize(find.byType(ListWheelScrollView).first),
        const Size(80, 220),
      );
      expect(
        tester
            .widget<VText>(
              find.ancestor(
                of: find.text('12'),
                matching: find.byType(VText),
              ),
            )
            .color,
        selectedColor,
      );
    });

    testWidgets('VTimePicker exposes hour and minute item semantics',
        (tester) async {
      final semantics = tester.ensureSemantics();

      await tester.pumpWidget(_wrap(
        const VTimePicker(
          selected: VTimeOfDay(hour: 12, minute: 0),
        ),
      ));

      expect(find.bySemanticsLabel('Hour 12, selected'), findsOneWidget);
      expect(find.bySemanticsLabel('Minute 00, selected'), findsOneWidget);
      expect(find.bySemanticsLabel('Hour 13'), findsOneWidget);

      semantics.dispose();
    });

    testWidgets('VTimePicker selects focused items with Enter and Space',
        (tester) async {
      var selected = const VTimeOfDay(hour: 12, minute: 0);
      var calls = 0;

      await tester.pumpWidget(_wrap(
        StatefulBuilder(
          builder: (context, setState) {
            return VTimePicker(
              selected: selected,
              onChanged: (time) {
                calls += 1;
                setState(() => selected = time);
              },
            );
          },
        ),
      ));

      await tester.tap(find.text('13').first);
      await tester.pump();
      expect(selected.hour, 13);

      await tester.sendKeyEvent(LogicalKeyboardKey.enter);
      await tester.pump();
      expect(selected.hour, 13);

      await tester.tap(find.text('05').first);
      await tester.pump();
      expect(selected.minute, 5);

      await tester.sendKeyEvent(LogicalKeyboardKey.space);
      await tester.pump();
      expect(selected.minute, 5);
      expect(calls, greaterThanOrEqualTo(4));
    });
  });

  group('VImageSource', () {
    testWidgets('uses cacheKey as the network image cache identity',
        (tester) async {
      late ImageProvider<Object> first;
      late ImageProvider<Object> second;

      await tester.pumpWidget(_wrap(Builder(
        builder: (context) {
          first = const VNetworkImageSource(
            'https://example.com/one.png',
            cacheKey: 'avatar:1',
          ).resolve(context);
          second = const VNetworkImageSource(
            'https://example.com/two.png',
            cacheKey: 'avatar:1',
          ).resolve(context);
          return const SizedBox.shrink();
        },
      )));

      final firstKey = await first.obtainKey(ImageConfiguration.empty);
      final secondKey = await second.obtainKey(ImageConfiguration.empty);

      expect(firstKey, secondKey);
    });

    testWidgets('cache false creates one-shot cache identities',
        (tester) async {
      late ImageProvider<Object> first;
      late ImageProvider<Object> second;

      await tester.pumpWidget(_wrap(Builder(
        builder: (context) {
          const source = VNetworkImageSource(
            'https://example.com/avatar.png',
            cache: false,
          );
          first = source.resolve(context);
          second = source.resolve(context);
          return const SizedBox.shrink();
        },
      )));

      final firstKey = await first.obtainKey(ImageConfiguration.empty);
      final secondKey = await second.obtainKey(ImageConfiguration.empty);

      expect(firstKey, isNot(secondKey));
    });
  });
}
