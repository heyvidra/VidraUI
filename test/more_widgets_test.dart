import 'dart:async';
import 'dart:ui';

import 'package:flutter/services.dart';
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

Widget _wrapApp(Widget child) {
  return VidraApp.navigator(
    theme: VThemeData.light(),
    darkTheme: VThemeData.dark(),
    home: child,
  );
}

Widget _wrapWithOverlay(Widget child) {
  return _wrap(
    Overlay(
      initialEntries: [
        OverlayEntry(builder: (_) => child),
      ],
    ),
  );
}

void _noopIndex(int value) {}

void main() {
  group('VDivider', () {
    testWidgets('renders horizontal divider', (tester) async {
      await tester.pumpWidget(_wrap(const VDivider()));
      expect(find.byType(VDivider), findsOneWidget);
    });

    testWidgets('renders vertical divider', (tester) async {
      await tester.pumpWidget(_wrap(
        const SizedBox(
          height: 40,
          child: VDivider(axis: Axis.vertical),
        ),
      ));
      expect(find.byType(VDivider), findsOneWidget);
    });
  });

  group('VListTile', () {
    testWidgets('renders title', (tester) async {
      await tester.pumpWidget(_wrap(
        const VListTile(title: 'Settings'),
      ));
      expect(find.text('Settings'), findsOneWidget);
    });

    testWidgets('renders subtitle when provided', (tester) async {
      await tester.pumpWidget(_wrap(
        const VListTile(
          title: 'Wi-Fi',
          subtitle: 'Connected to Home',
        ),
      ));
      expect(find.text('Connected to Home'), findsOneWidget);
    });

    testWidgets('fires onTap', (tester) async {
      bool tapped = false;
      await tester.pumpWidget(_wrap(
        VListTile(
          title: 'Tap me',
          onTap: () => tapped = true,
        ),
      ));
      await tester.tap(find.text('Tap me'));
      expect(tapped, isTrue);
    });

    testWidgets('triggers hover background when hovered', (tester) async {
      final theme = VThemeData.light();
      await tester.pumpWidget(_wrap(
        VListTile(
          title: 'Hover me',
          onTap: () {},
        ),
      ));

      final initialBox =
          tester.widget<AnimatedContainer>(find.byType(AnimatedContainer));
      final initialDec = initialBox.decoration as BoxDecoration;
      expect(initialDec.color, theme.colors.surface.withValues(alpha: 0));

      final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
      await gesture.addPointer(
          location: tester.getCenter(find.text('Hover me')));
      await gesture.moveTo(tester.getCenter(find.text('Hover me')));
      addTearDown(gesture.removePointer);
      await tester.pumpAndSettle();

      final hoveredBox =
          tester.widget<AnimatedContainer>(find.byType(AnimatedContainer));
      final hoveredDec = hoveredBox.decoration as BoxDecoration;
      expect(hoveredDec.color, theme.colors.surfaceHover);
    });

    testWidgets('triggers press background when pressed', (tester) async {
      final theme = VThemeData.light();
      await tester.pumpWidget(_wrap(
        VListTile(
          title: 'Press me',
          onTap: () {},
        ),
      ));

      final gesture =
          await tester.startGesture(tester.getCenter(find.text('Press me')));
      await tester.pump();

      final pressedBox =
          tester.widget<AnimatedContainer>(find.byType(AnimatedContainer));
      final pressedDec = pressedBox.decoration as BoxDecoration;
      expect(pressedDec.color, theme.colors.surfaceHover);

      await gesture.up();
      await tester.pumpAndSettle();
    });
  });

  group('VAppBar', () {
    testWidgets('does not overflow when bottom is provided', (tester) async {
      await tester.pumpWidget(_wrap(
        const VAppBar(
          safeArea: false,
          title: Text('Title'),
          bottom: SizedBox(
            height: 1,
            child: Text('Bottom'),
          ),
        ),
      ));

      expect(tester.takeException(), isNull);
    });
  });

  group('VForm', () {
    testWidgets('renders children', (tester) async {
      final key = GlobalKey<VFormState>();
      await tester.pumpWidget(_wrap(
        VForm(
          key: key,
          children: const [
            VFormField(
              errors: [],
              child: Text('Field 1'),
            ),
          ],
        ),
      ));
      expect(find.text('Field 1'), findsOneWidget);
    });

    testWidgets('validate returns true with no errors', (tester) async {
      final key = GlobalKey<VFormState>();
      await tester.pumpWidget(_wrap(
        VForm(
          key: key,
          children: const [],
        ),
      ));
      expect(key.currentState!.validate(), isTrue);
    });

    testWidgets('validate returns false with errors', (tester) async {
      final key = GlobalKey<VFormState>();
      await tester.pumpWidget(_wrap(
        VForm(
          key: key,
          children: const [
            VFormField(
              errors: [VFormFieldError('Required')],
              child: Text('Field 1'),
            ),
          ],
        ),
      ));
      expect(key.currentState!.validate(), isFalse);
    });

    testWidgets('uses the default theme gap between fields', (tester) async {
      await tester.pumpWidget(_wrap(
        const VForm(
          children: [
            SizedBox(
              key: ValueKey('field-1'),
              height: 10,
              child: Text('Field 1'),
            ),
            SizedBox(
              key: ValueKey('field-2'),
              height: 10,
              child: Text('Field 2'),
            ),
          ],
        ),
      ));

      final field1Bottom =
          tester.getBottomLeft(find.byKey(const ValueKey('field-1'))).dy;
      final field2Top =
          tester.getTopLeft(find.byKey(const ValueKey('field-2'))).dy;

      expect(field2Top - field1Bottom, 12);
    });

    testWidgets('uses a custom gap between fields', (tester) async {
      await tester.pumpWidget(_wrap(
        const VForm(
          gap: 24,
          children: [
            SizedBox(
              key: ValueKey('field-1'),
              height: 10,
              child: Text('Field 1'),
            ),
            SizedBox(
              key: ValueKey('field-2'),
              height: 10,
              child: Text('Field 2'),
            ),
          ],
        ),
      ));

      final field1Bottom =
          tester.getBottomLeft(find.byKey(const ValueKey('field-1'))).dy;
      final field2Top =
          tester.getTopLeft(find.byKey(const ValueKey('field-2'))).dy;

      expect(field2Top - field1Bottom, 24);
    });

    testWidgets('keeps field errors in the form layout', (tester) async {
      await tester.pumpWidget(_wrap(
        const VForm(
          gap: 20,
          children: [
            VFormField(
              errors: [VFormFieldError('Required')],
              child: Text('Field 1'),
            ),
            VFormField(
              child: Text('Field 2'),
            ),
          ],
        ),
      ));

      expect(find.text('Required'), findsOneWidget);
      expect(tester.getTopLeft(find.text('Field 2')).dy,
          greaterThan(tester.getBottomLeft(find.text('Required')).dy));
    });
  });

  group('VTable', () {
    testWidgets('renders headers and data', (tester) async {
      await tester.pumpWidget(_wrap(
        const VTable(
          columns: [
            VTableColumn(header: 'Name'),
            VTableColumn(header: 'Age'),
          ],
          rows: [
            ['Alice', '30'],
            ['Bob', '25'],
          ],
        ),
      ));
      expect(find.text('Name'), findsOneWidget);
      expect(find.text('Alice'), findsOneWidget);
      expect(find.text('Bob'), findsOneWidget);
    });

    testWidgets('updates rows when external rows change', (tester) async {
      await tester.pumpWidget(_wrap(
        const VTable(
          columns: [VTableColumn(header: 'Name')],
          rows: [
            ['Alice'],
          ],
        ),
      ));
      expect(find.text('Alice'), findsOneWidget);
      expect(find.text('Carol'), findsNothing);

      await tester.pumpWidget(_wrap(
        const VTable(
          columns: [VTableColumn(header: 'Name')],
          rows: [
            ['Carol'],
          ],
        ),
      ));

      expect(find.text('Alice'), findsNothing);
      expect(find.text('Carol'), findsOneWidget);
    });

    testWidgets('constrains large table bodies', (tester) async {
      final rows = List.generate(50, (i) => ['Row $i']);

      await tester.pumpWidget(_wrap(
        VTable(
          columns: const [VTableColumn(header: 'Name')],
          rows: rows,
          rowHeight: 20,
          maxBodyHeight: 80,
        ),
      ));

      expect(find.text('Row 0'), findsOneWidget);
      expect(find.text('Row 49'), findsNothing);
    });

    testWidgets('sorts rows when tapping a header', (tester) async {
      await tester.pumpWidget(_wrap(
        const VTable(
          columns: [VTableColumn(header: 'Name')],
          rows: [
            ['Bob'],
            ['Alice'],
          ],
        ),
      ));

      await tester.tap(find.text('Name'));
      await tester.pump();

      expect(
        tester.getTopLeft(find.text('Alice')).dy,
        lessThan(tester.getTopLeft(find.text('Bob')).dy),
      );
    });

    testWidgets('sortable headers expose semantics and preserve sorted labels',
        (tester) async {
      final semantics = tester.ensureSemantics();

      await tester.pumpWidget(_wrap(
        const VTable(
          columns: [VTableColumn(header: 'Name')],
          rows: [
            ['Bob'],
            ['Alice'],
          ],
        ),
      ));

      final initialNode = tester.getSemantics(find.bySemanticsLabel('Name'));
      final initialData = initialNode.getSemanticsData();
      expect(initialData.hint, 'Sort ascending');
      expect(initialData.hasAction(SemanticsAction.tap), isTrue);
      expect(initialData.flagsCollection.isButton, isTrue);

      await tester.tap(find.text('Name'));
      await tester.pump();

      final ascendingNode =
          tester.getSemantics(find.bySemanticsLabel('Name, sorted ascending'));
      final ascendingData = ascendingNode.getSemanticsData();
      expect(ascendingData.hint, 'Sort descending');
      expect(ascendingData.hasAction(SemanticsAction.tap), isTrue);
      expect(ascendingData.flagsCollection.isButton, isTrue);
      expect(find.text('Name'), findsOneWidget);

      await tester.tap(find.text('Name'));
      await tester.pump();

      final descendingNode =
          tester.getSemantics(find.bySemanticsLabel('Name, sorted descending'));
      final descendingData = descendingNode.getSemanticsData();
      expect(descendingData.hint, 'Sort ascending');
      expect(descendingData.hasAction(SemanticsAction.tap), isTrue);
      expect(descendingData.flagsCollection.isButton, isTrue);

      semantics.dispose();
    });

    testWidgets('header is focusable and tap sorting does not regress',
        (tester) async {
      await tester.pumpWidget(_wrap(
        const VTable(
          columns: [VTableColumn(header: 'Name')],
          rows: [
            ['Bob'],
            ['Alice'],
          ],
        ),
      ));

      final headerFocusWidgets = tester.widgetList<Focus>(
        find.ancestor(
          of: find.text('Name'),
          matching: find.byType(Focus),
        ),
      );

      expect(
        headerFocusWidgets.any((focus) => focus.canRequestFocus),
        isTrue,
      );

      await tester.tap(find.text('Name'));
      await tester.pump();

      expect(
        tester.getTopLeft(find.text('Alice')).dy,
        lessThan(tester.getTopLeft(find.text('Bob')).dy),
      );
    });

    testWidgets('focused header sorts when Enter is pressed', (tester) async {
      await tester.pumpWidget(_wrap(
        const VTable(
          columns: [VTableColumn(header: 'Name')],
          rows: [
            ['Bob'],
            ['Alice'],
          ],
        ),
      ));

      await tester.tap(find.text('Name'));
      await tester.pump();
      expect(
        tester.getTopLeft(find.text('Alice')).dy,
        lessThan(tester.getTopLeft(find.text('Bob')).dy),
      );

      await tester.sendKeyEvent(LogicalKeyboardKey.enter);
      await tester.pump();

      expect(
        tester.getTopLeft(find.text('Bob')).dy,
        lessThan(tester.getTopLeft(find.text('Alice')).dy),
      );
    });

    testWidgets('focused header sorts when Space is pressed', (tester) async {
      await tester.pumpWidget(_wrap(
        const VTable(
          columns: [VTableColumn(header: 'Name')],
          rows: [
            ['Bob'],
            ['Alice'],
          ],
        ),
      ));

      await tester.tap(find.text('Name'));
      await tester.pump();
      expect(
        tester.getTopLeft(find.text('Alice')).dy,
        lessThan(tester.getTopLeft(find.text('Bob')).dy),
      );

      await tester.sendKeyEvent(LogicalKeyboardKey.space);
      await tester.pump();

      expect(
        tester.getTopLeft(find.text('Bob')).dy,
        lessThan(tester.getTopLeft(find.text('Alice')).dy),
      );
    });

    testWidgets('empty state exposes semantic text', (tester) async {
      final semantics = tester.ensureSemantics();

      await tester.pumpWidget(_wrap(
        const VTable(
          columns: [VTableColumn(header: 'Name')],
          rows: [],
        ),
      ));

      expect(find.text('No data'), findsOneWidget);
      expect(find.bySemanticsLabel('No data'), findsOneWidget);

      semantics.dispose();
    });

    testWidgets('uses table tokens for header, rows, and sort indicator',
        (tester) async {
      const headerColor = Color(0xFF101010);
      const rowColor = Color(0xFF202020);
      const alternateColor = Color(0xFF303030);
      const headerTextColor = Color(0xFF404040);
      const bodyTextColor = Color(0xFF505050);
      const sortColor = Color(0xFF606060);
      final base = VThemeData.light();
      final theme = base.copyWith(
        components: base.components.copyWith(
          table: base.components.table.copyWith(
            headerBackground: headerColor,
            rowBackground: rowColor,
            alternateRowBackground: alternateColor,
            headerForeground: headerTextColor,
            bodyForeground: bodyTextColor,
            sortIndicatorColor: sortColor,
            sortIndicatorActiveColor: sortColor,
            sortIndicatorSize: 18,
            sortIndicatorSpacing: 13,
            headerPaddingHorizontal: 21,
            cellPaddingHorizontal: 19,
          ),
        ),
      );

      await tester.pumpWidget(Directionality(
        textDirection: TextDirection.ltr,
        child: VTheme(
          data: theme,
          child: const VTable(
            sortColumnIndex: 0,
            columns: [VTableColumn(header: 'Name')],
            rows: [
              ['Alice'],
              ['Bob'],
            ],
          ),
        ),
      ));

      final headerContainer = tester
          .widgetList<Container>(
        find.ancestor(
          of: find.text('Name'),
          matching: find.byType(Container),
        ),
      )
          .firstWhere((container) {
        final decoration = container.decoration;
        return decoration is BoxDecoration && decoration.color == headerColor;
      });
      final firstRowContainer = tester
          .widgetList<Container>(
        find.ancestor(
          of: find.text('Alice'),
          matching: find.byType(Container),
        ),
      )
          .firstWhere((container) {
        final decoration = container.decoration;
        return decoration is BoxDecoration && decoration.color == rowColor;
      });
      final secondRowContainer = tester
          .widgetList<Container>(
        find.ancestor(
          of: find.text('Bob'),
          matching: find.byType(Container),
        ),
      )
          .firstWhere((container) {
        final decoration = container.decoration;
        return decoration is BoxDecoration &&
            decoration.color == alternateColor;
      });

      expect(headerContainer, isNotNull);
      expect(firstRowContainer, isNotNull);
      expect(secondRowContainer, isNotNull);
      expect(
        tester
            .widget<VText>(
              find.ancestor(
                of: find.text('Name'),
                matching: find.byType(VText),
              ),
            )
            .color,
        headerTextColor,
      );
      expect(
        tester
            .widget<VText>(
              find.ancestor(
                of: find.text('Alice'),
                matching: find.byType(VText),
              ),
            )
            .color,
        bodyTextColor,
      );
      expect(tester.widget<Text>(find.text('▲')).style?.color, sortColor);
      expect(tester.widget<Text>(find.text('▲')).style?.fontSize, 18);
    });

    testWidgets('uses table tokens for header hover and focus visuals',
        (tester) async {
      const headerColor = Color(0xFF101010);
      const hoverColor = Color(0xFF202020);
      const focusColor = Color(0xFF303030);
      const activeSortColor = Color(0xFF404040);
      final base = VThemeData.light();
      final theme = base.copyWith(
        components: base.components.copyWith(
          table: base.components.table.copyWith(
            headerBackground: headerColor,
            headerHoverBackground: hoverColor,
            headerFocusOutlineColor: focusColor,
            headerFocusOutlineWidth: 3,
            sortIndicatorActiveColor: activeSortColor,
          ),
        ),
      );

      await tester.pumpWidget(Directionality(
        textDirection: TextDirection.ltr,
        child: VPlatformScope(
          behavior: VPlatformBehavior.desktop(isApple: false),
          child: VTheme(
            data: theme,
            child: const VTable(
              sortColumnIndex: 0,
              columns: [VTableColumn(header: 'Name')],
              rows: [
                ['Alice'],
              ],
            ),
          ),
        ),
      ));

      final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
      await gesture.addPointer(location: tester.getCenter(find.text('Name')));
      await gesture.moveTo(tester.getCenter(find.text('Name')));
      addTearDown(gesture.removePointer);
      await tester.pump();

      final hoveredHeader = tester
          .widgetList<Container>(
        find.ancestor(
          of: find.text('Name'),
          matching: find.byType(Container),
        ),
      )
          .firstWhere((container) {
        final decoration = container.decoration;
        return decoration is BoxDecoration && decoration.color == hoverColor;
      });
      expect(hoveredHeader, isNotNull);

      await tester.tap(find.text('Name'));
      await tester.pump();

      final focusedHeader = tester
          .widgetList<Container>(
        find.ancestor(
          of: find.text('Name'),
          matching: find.byType(Container),
        ),
      )
          .firstWhere((container) {
        final decoration = container.decoration;
        final border = decoration is BoxDecoration ? decoration.border : null;
        return border is Border &&
            border.top.color == focusColor &&
            border.top.width == 3;
      });
      expect(focusedHeader, isNotNull);
      expect(tester.widget<Text>(find.text('▼')).style?.color, activeSortColor);
    });

    testWidgets('uses table tokens for empty state', (tester) async {
      const emptyColor = Color(0xFF778899);
      final base = VThemeData.light();
      final theme = base.copyWith(
        components: base.components.copyWith(
          table: base.components.table.copyWith(
            emptyForeground: emptyColor,
            emptyTextSize: 17,
            emptyPaddingVertical: 30,
          ),
        ),
      );

      await tester.pumpWidget(Directionality(
        textDirection: TextDirection.ltr,
        child: VTheme(
          data: theme,
          child: const VTable(
            columns: [VTableColumn(header: 'Name')],
            rows: [],
          ),
        ),
      ));

      final empty = tester.widget<Text>(find.text('No data'));
      expect(empty.style?.color, emptyColor);
      expect(empty.style?.fontSize, 17);
    });
  });

  group('VTabs', () {
    testWidgets('handles tab count changes', (tester) async {
      await tester.pumpWidget(_wrap(
        const VTabBar(
          tabs: ['One', 'Two'],
          selectedIndex: 0,
          onChanged: _noopIndex,
        ),
      ));

      await tester.pumpWidget(_wrap(
        const VTabBar(
          tabs: ['One', 'Two', 'Three'],
          selectedIndex: 0,
          onChanged: _noopIndex,
        ),
      ));

      expect(tester.takeException(), isNull);
      expect(find.text('Three'), findsOneWidget);
    });

    testWidgets('renders VTabItem and custom widget tabs', (tester) async {
      await tester.pumpWidget(_wrap(
        const VTabBar(
          tabs: [
            VTabItem(label: 'Home', icon: Text('🏠')),
            Text('Custom Widget Tab'),
          ],
          selectedIndex: 0,
          onChanged: _noopIndex,
        ),
      ));

      expect(find.text('🏠'), findsOneWidget);
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Custom Widget Tab'), findsOneWidget);
    });
  });

  group('VSkeletonBox', () {
    testWidgets('renders skeleton box', (tester) async {
      await tester.pumpWidget(_wrap(
        const VSkeletonBox(width: 200, height: 16),
      ));
      expect(find.byType(VSkeletonBox), findsOneWidget);
    });
  });

  group('VSwipeActions', () {
    testWidgets('opens end actions after swipe left', (tester) async {
      VSwipeActionSide? openSide;

      await tester.pumpWidget(_wrap(
        Center(
          child: SizedBox(
            width: 240,
            child: VSwipeActions(
              onOpenChanged: (side) => openSide = side,
              endAction: const Center(child: Text('Delete')),
              child: const SizedBox(
                height: 48,
                child: Text('Swipe row'),
              ),
            ),
          ),
        ),
      ));

      await tester.drag(find.text('Swipe row'), const Offset(-120, 0));
      await tester.pumpAndSettle();

      expect(openSide, VSwipeActionSide.end);
    });

    testWidgets('action can be tapped after swipe', (tester) async {
      var deleted = false;

      await tester.pumpWidget(_wrap(
        Center(
          child: SizedBox(
            width: 240,
            child: VSwipeActions(
              endAction: GestureDetector(
                onTap: () => deleted = true,
                child: const Center(child: Text('Delete')),
              ),
              child: const SizedBox(
                height: 48,
                child: Text('Swipe row'),
              ),
            ),
          ),
        ),
      ));

      await tester.drag(find.text('Swipe row'), const Offset(-120, 0));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Delete'), warnIfMissed: false);

      expect(deleted, isTrue);
    });

    testWidgets('action tap closes the revealed row', (tester) async {
      VSwipeActionSide? openSide;

      await tester.pumpWidget(_wrap(
        Center(
          child: SizedBox(
            width: 240,
            child: VSwipeActions(
              onOpenChanged: (side) => openSide = side,
              endAction: GestureDetector(
                onTap: () {},
                child: const Center(child: Text('Delete')),
              ),
              child: const SizedBox(
                height: 48,
                child: Text('Swipe row'),
              ),
            ),
          ),
        ),
      ));

      await tester.drag(find.text('Swipe row'), const Offset(-120, 0));
      await tester.pumpAndSettle();
      expect(openSide, VSwipeActionSide.end);

      await tester.tap(find.text('Delete'), warnIfMissed: false);
      await tester.pumpAndSettle();

      expect(openSide, isNull);
    });

    testWidgets('outside tap closes the revealed row', (tester) async {
      VSwipeActionSide? openSide;

      await tester.pumpWidget(_wrapApp(
        Column(
          children: [
            SizedBox(
              width: 240,
              child: VSwipeActions(
                onOpenChanged: (side) => openSide = side,
                endAction: const Center(child: Text('Delete')),
                child: const SizedBox(
                  height: 48,
                  child: Text('Swipe row'),
                ),
              ),
            ),
            const SizedBox(
              height: 48,
              child: Text('Outside'),
            ),
          ],
        ),
      ));

      await tester.drag(find.text('Swipe row'), const Offset(-120, 0));
      await tester.pumpAndSettle();
      expect(openSide, VSwipeActionSide.end);

      await tester.tap(find.text('Outside'));
      await tester.pumpAndSettle();

      expect(openSide, isNull);
    });
  });

  group('VSelect', () {
    testWidgets('renders placeholder when no value', (tester) async {
      await tester.pumpWidget(_wrap(
        const VSelect<String>(
          options: [VSelectOption(value: 'a', label: 'Option A')],
          placeholder: 'Pick one',
        ),
      ));
      expect(find.text('Pick one'), findsOneWidget);
    });

    testWidgets('renders selected label', (tester) async {
      await tester.pumpWidget(_wrap(
        const VSelect<String>(
          options: [VSelectOption(value: 'a', label: 'Option A')],
          value: 'a',
        ),
      ));
      expect(find.text('Option A'), findsOneWidget);
    });

    testWidgets('renders with placeholder', (tester) async {
      await tester.pumpWidget(_wrap(
        const VSelect<String>(
          options: [
            VSelectOption(value: 'a', label: 'Option A'),
            VSelectOption(value: 'b', label: 'Option B'),
          ],
          placeholder: 'Pick',
        ),
      ));
      expect(find.text('Pick'), findsOneWidget);
    });

    testWidgets('uses a bounded lazy menu for large option lists',
        (tester) async {
      final options = List.generate(
        100,
        (i) => VSelectOption(value: i, label: 'Option $i'),
      );

      await tester.pumpWidget(_wrapWithOverlay(
        Center(
          child: SizedBox(
            width: 240,
            child: VSelect<int>(
              options: options,
              maxMenuHeight: 96,
              placeholder: 'Pick',
            ),
          ),
        ),
      ));

      await tester.tap(find.byType(VSelect<int>));
      await tester.pump();

      expect(find.byType(ListView), findsOneWidget);
      expect(find.text('Option 0'), findsOneWidget);
      expect(find.text('Option 99'), findsNothing);
    });

    testWidgets('uses select component tokens for trigger and menu sizing',
        (tester) async {
      final base = VThemeData.light();
      final theme = base.copyWith(
        components: base.components.copyWith(
          select: base.components.select.copyWith(
            triggerHeight: 64,
            triggerPaddingVertical: 0,
            itemHeight: 60,
          ),
        ),
      );

      await tester.pumpWidget(Directionality(
        textDirection: TextDirection.ltr,
        child: VTheme(
          data: theme,
          child: Overlay(
            initialEntries: [
              OverlayEntry(
                builder: (_) => const Center(
                  child: SizedBox(
                    width: 240,
                    child: VSelect<int>(
                      options: [
                        VSelectOption(value: 1, label: 'One'),
                        VSelectOption(value: 2, label: 'Two'),
                      ],
                      placeholder: 'Pick',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ));

      expect(tester.getSize(find.byType(AnimatedContainer).first).height, 64);

      await tester.tap(find.byType(VSelect<int>));
      await tester.pump();

      expect(tester.getSize(find.byType(ListView)).height, 120);
    });

    testWidgets(
        'selected and highlighted option preserves contrast-safe blue background',
        (tester) async {
      await tester.pumpWidget(_wrapWithOverlay(
        const Center(
          child: SizedBox(
            width: 240,
            child: VSelect<String>.multiple(
              options: [
                VSelectOption(value: 'a', label: 'Option A'),
                VSelectOption(value: 'b', label: 'Option B'),
              ],
              values: {'a'},
            ),
          ),
        ),
      ));

      await tester.tap(find.byType(VSelect<String>));
      await tester.pumpAndSettle();

      final decoratedBoxes = find.descendant(
        of: find.byType(ListView),
        matching: find.byType(DecoratedBox),
      );

      final firstOptionFinder = find.descendant(
        of: find.byType(ListView),
        matching: find.text('Option A'),
      );
      final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
      await gesture.addPointer(location: Offset.zero);
      addTearDown(gesture.removePointer);
      await tester.pump();
      await gesture.moveTo(tester.getCenter(firstOptionFinder));
      await tester.pumpAndSettle();

      final firstOptionDecoratedBox = tester.widget<DecoratedBox>(
        decoratedBoxes.first,
      );
      final decoration = firstOptionDecoratedBox.decoration as BoxDecoration;

      final theme = VThemeData.light();
      final expectedColor = theme.components.select.menuSelectedBackground
          .withValues(alpha: 0.85);
      expect(decoration.color, equals(expectedColor));
    });

    testWidgets(
        'does not pre-focus first option on mobile platforms when opened',
        (tester) async {
      // Use an explicit mobile scope — the test _wrap injects desktop scope,
      // so we override it here to exercise the mobile code path.
      await tester.pumpWidget(Directionality(
        textDirection: TextDirection.ltr,
        child: VPlatformScope(
          behavior: VPlatformBehavior.mobile(isApple: false),
          child: VTheme(
            data: VThemeData.light(),
            child: Overlay(
              initialEntries: [
                OverlayEntry(
                  builder: (_) => const Center(
                    child: SizedBox(
                      width: 240,
                      child: VSelect<String>(
                        options: [
                          VSelectOption(value: 'a', label: 'Option A'),
                          VSelectOption(value: 'b', label: 'Option B'),
                        ],
                        placeholder: 'Pick',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ));

      await tester.tap(find.byType(VSelect<String>));
      await tester.pumpAndSettle();

      final decoratedBoxes = find.descendant(
        of: find.byType(ListView),
        matching: find.byType(DecoratedBox),
      );

      final firstOptionDecoratedBox = tester.widget<DecoratedBox>(
        decoratedBoxes.first,
      );
      final decoration = firstOptionDecoratedBox.decoration as BoxDecoration;
      expect(decoration.color, isNull);
    });

    testWidgets('VSelectOption leading widget renders in menu', (tester) async {
      await tester.pumpWidget(_wrapWithOverlay(
        const Center(
          child: SizedBox(
            width: 240,
            child: VSelect<String>(
              options: [
                VSelectOption(
                  value: 'a',
                  label: 'Option A',
                  leading: Text('★'),
                ),
              ],
            ),
          ),
        ),
      ));

      await tester.tap(find.byType(VSelect<String>));
      await tester.pumpAndSettle();

      expect(find.text('★'), findsOneWidget);
    });

    testWidgets('searchable: true filters options by query', (tester) async {
      await tester.pumpWidget(_wrapWithOverlay(
        const Center(
          child: SizedBox(
            width: 240,
            child: VSelect<String>(
              searchable: true,
              options: [
                VSelectOption(value: 'apple', label: 'Apple'),
                VSelectOption(value: 'banana', label: 'Banana'),
              ],
            ),
          ),
        ),
      ));

      await tester.tap(find.byType(VSelect<String>));
      await tester.pumpAndSettle();

      // Check both are visible initially
      expect(find.text('Apple'), findsOneWidget);
      expect(find.text('Banana'), findsOneWidget);

      // Type "ap" into search field
      await tester.enterText(find.byType(VTextField), 'ap');
      await tester.pumpAndSettle();

      // Only "Apple" should be visible
      expect(find.text('Apple'), findsOneWidget);
      expect(find.text('Banana'), findsNothing);
    });

    testWidgets('custom icon is rendered on trigger', (tester) async {
      await tester.pumpWidget(_wrap(
        const VSelect<String>(
          options: [VSelectOption(value: 'a', label: 'Option A')],
          icon: Text('▼▼'),
        ),
      ));
      expect(find.text('▼▼'), findsOneWidget);
    });
  });

  group('VCarousel', () {
    testWidgets('handles empty and dynamic children', (tester) async {
      await tester.pumpWidget(_wrap(
        const VCarousel(children: []),
      ));
      expect(tester.takeException(), isNull);

      await tester.pumpWidget(_wrap(
        const VCarousel(
          children: [
            Text('First'),
            Text('Second'),
          ],
        ),
      ));

      expect(tester.takeException(), isNull);
      expect(find.text('First'), findsOneWidget);
    });
  });

  group('staggered animation widgets', () {
    testWidgets('VAnimatedList handles child list changes', (tester) async {
      await tester.pumpWidget(_wrap(
        const VAnimatedList(
          children: [
            Text('One'),
          ],
        ),
      ));
      await tester.pump(const Duration(milliseconds: 70));
      expect(find.text('One'), findsOneWidget);

      await tester.pumpWidget(_wrap(
        const VAnimatedList(
          children: [
            Text('One'),
            Text('Two'),
          ],
        ),
      ));
      await tester.pump(const Duration(milliseconds: 70));

      expect(tester.takeException(), isNull);
      expect(find.text('Two'), findsOneWidget);
    });

    testWidgets('VAnimatedList supports horizontal direction', (tester) async {
      await tester.pumpWidget(_wrap(
        const SizedBox(
          height: 80,
          child: VAnimatedList(
            scrollDirection: Axis.horizontal,
            gap: 8,
            children: [
              SizedBox(width: 80, child: Text('One')),
              SizedBox(width: 80, child: Text('Two')),
            ],
          ),
        ),
      ));

      final scrollView = tester.widget<SingleChildScrollView>(
        find.byType(SingleChildScrollView),
      );
      expect(scrollView.scrollDirection, Axis.horizontal);

      await tester.pump(const Duration(milliseconds: 140));

      expect(tester.takeException(), isNull);
      expect(find.text('One'), findsOneWidget);
      expect(find.text('Two'), findsOneWidget);
    });

    testWidgets('VScrollableList.builder lazily builds visible rows',
        (tester) async {
      final built = <int>{};
      await tester.pumpWidget(_wrap(
        SizedBox(
          height: 160,
          child: VScrollableList.builder(
            itemCount: 1000,
            itemBuilder: (context, index) {
              built.add(index);
              return SizedBox(
                height: 40,
                child: Text('Row $index'),
              );
            },
          ),
        ),
      ));

      expect(find.text('Row 0'), findsOneWidget);
      expect(built.length, lessThan(1000));
    });

    testWidgets('VScrollableList.animatedBuilder reads theme after initState',
        (tester) async {
      await tester.pumpWidget(_wrap(
        SizedBox(
          height: 160,
          child: VScrollableList.animatedBuilder(
            itemCount: 3,
            itemBuilder: (context, index) => SizedBox(
              height: 40,
              child: Text('Animated row $index'),
            ),
          ),
        ),
      ));
      await tester.pump();

      expect(find.text('Animated row 0'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('VScrollableList shows threshold button and scrolls to top',
        (tester) async {
      final scrollController = ScrollController();
      await tester.pumpWidget(_wrap(
        SizedBox(
          height: 160,
          child: VScrollableList.builder(
            controller: scrollController,
            itemCount: 30,
            showScrollToTopAfter: 40,
            itemBuilder: (context, index) => SizedBox(
              height: 40,
              child: Text('Row $index'),
            ),
          ),
        ),
      ));

      scrollController.jumpTo(240);
      await tester.pump();
      expect(find.bySemanticsLabel('Scroll to top'), findsOneWidget);

      await tester.tap(find.bySemanticsLabel('Scroll to top'));
      await tester.pumpAndSettle();
      expect(scrollController.offset, 0);
    });

    testWidgets('VScrollableList triggers pull refresh with custom builder',
        (tester) async {
      var refreshed = false;
      await tester.pumpWidget(_wrap(
        SizedBox(
          height: 160,
          child: VScrollableList.builder(
            itemCount: 3,
            onRefresh: () async {
              refreshed = true;
            },
            refreshTriggerDistance: 40,
            refreshBuilder: (context, pulled, trigger, refreshing) {
              return Text(refreshing ? 'Refreshing custom' : 'Pull custom');
            },
            itemBuilder: (context, index) => SizedBox(
              height: 40,
              child: Text('Row $index'),
            ),
          ),
        ),
      ));

      await tester.drag(find.byType(VScrollableList), const Offset(0, 120));
      await tester.pump();
      await tester.pumpAndSettle();

      expect(refreshed, isTrue);
      expect(tester.takeException(), isNull);
    });

    testWidgets('VScrollableList triggers load more once while loading',
        (tester) async {
      final completer = Completer<void>();
      var calls = 0;
      await tester.pumpWidget(_wrap(
        SizedBox(
          height: 160,
          child: VScrollableList.builder(
            itemCount: 30,
            loadMoreThreshold: 80,
            onLoadMore: () {
              calls++;
              return completer.future;
            },
            itemBuilder: (context, index) => SizedBox(
              height: 40,
              child: Text('Row $index'),
            ),
          ),
        ),
      ));

      await tester.drag(find.byType(VScrollableList), const Offset(0, -1000));
      await tester.pump();
      await tester.drag(find.byType(VScrollableList), const Offset(0, -1000));
      await tester.pump();

      expect(calls, 1);
      completer.complete();
      await tester.pumpAndSettle();
    });

    testWidgets('VScrollableList defers load more outside parent build',
        (tester) async {
      await tester.pumpWidget(_wrap(
        const SizedBox(
          height: 160,
          child: _LoadMoreDuringBuildHarness(),
        ),
      ));
      await tester.drag(find.byType(VScrollableList), const Offset(0, -1000));
      await tester.pumpAndSettle();

      expect(find.text('Calls 1'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('VStagger handles child list changes', (tester) async {
      await tester.pumpWidget(_wrap(
        const VStagger(
          delay: Duration(milliseconds: 1),
          children: [
            Text('One'),
          ],
        ),
      ));
      await tester.pump(const Duration(milliseconds: 2));
      expect(find.text('One'), findsOneWidget);

      await tester.pumpWidget(_wrap(
        const VStagger(
          delay: Duration(milliseconds: 1),
          children: [
            Text('One'),
            Text('Two'),
          ],
        ),
      ));
      await tester.pump(const Duration(milliseconds: 2));

      expect(tester.takeException(), isNull);
      expect(find.text('Two'), findsOneWidget);
    });
  });

  group('VSlider', () {
    testWidgets('renders horizontal slider', (tester) async {
      await tester.pumpWidget(_wrap(
        VSlider(value: 0.5, onChanged: (v) {}),
      ));
      expect(find.byType(VSlider), findsOneWidget);
    });

    testWidgets('renders vertical slider', (tester) async {
      await tester.pumpWidget(_wrap(
        Center(
          child: SizedBox(
            height: 200,
            child: VSlider(value: 0.5, onChanged: (v) {}, axis: Axis.vertical),
          ),
        ),
      ));
      expect(find.byType(VSlider), findsOneWidget);
    });

    testWidgets('calls onChanged when tapped', (tester) async {
      double? result;
      await tester.pumpWidget(_wrap(
        Center(
          child: SizedBox(
            width: 300,
            child: VSlider(
              value: 0.0,
              onChanged: (v) => result = v,
            ),
          ),
        ),
      ));
      final slider = find.byType(VSlider);
      await tester.tapAt(tester.getCenter(slider));
      expect(result, isNotNull);
    });

    testWidgets('uses slider tokens for background and active track colors',
        (tester) async {
      const trackBgColor = Color(0xFFFF00FF);
      const activeTrackColor = Color(0xFFFFEE00);
      final base = VThemeData.light();
      final theme = base.copyWith(
        components: base.components.copyWith(
          slider: base.components.slider.copyWith(
            trackBackground: WidgetStateProperty.all(trackBgColor),
            trackActive: WidgetStateProperty.all(activeTrackColor),
          ),
        ),
      );

      await tester.pumpWidget(Directionality(
        textDirection: TextDirection.ltr,
        child: VTheme(
          data: theme,
          child: Center(
            child: SizedBox(
              width: 200,
              child: VSlider(
                value: 0.5,
                onChanged: (v) {},
              ),
            ),
          ),
        ),
      ));

      final decoratedBoxes = tester.widgetList<DecoratedBox>(
        find.descendant(
          of: find.byType(VSlider),
          matching: find.byType(DecoratedBox),
        ),
      );

      final bgDecoration = decoratedBoxes.first.decoration as BoxDecoration;
      final activeDecoration =
          decoratedBoxes.elementAt(1).decoration as BoxDecoration;

      expect(bgDecoration.color, trackBgColor);
      expect(activeDecoration.color, activeTrackColor);
    });
  });
}

class _LoadMoreDuringBuildHarness extends StatefulWidget {
  const _LoadMoreDuringBuildHarness();

  @override
  State<_LoadMoreDuringBuildHarness> createState() =>
      _LoadMoreDuringBuildHarnessState();
}

class _LoadMoreDuringBuildHarnessState
    extends State<_LoadMoreDuringBuildHarness> {
  int _calls = 0;

  Future<void> _loadMore() async {
    setState(() => _calls++);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Calls $_calls'),
        Expanded(
          child: VScrollableList.builder(
            itemCount: 30,
            loadMoreThreshold: 100,
            onLoadMore: _calls == 0 ? _loadMore : null,
            itemBuilder: (context, index) => const SizedBox(
              height: 40,
              child: Text('Row'),
            ),
          ),
        ),
      ],
    );
  }
}
