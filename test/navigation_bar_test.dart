import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vidraui/vidraui.dart';

Widget _wrap(Widget child, {MediaQueryData? mediaQuery}) {
  final widget = Align(
    alignment: Alignment.bottomCenter,
    child: child,
  );
  return Directionality(
    textDirection: TextDirection.ltr,
    child: VTheme(
      data: VThemeData.light().copyWith(
        motion: const VMotion(reducedMotion: true),
      ),
      child: mediaQuery != null
          ? MediaQuery(data: mediaQuery, child: widget)
          : widget,
    ),
  );
}

void main() {
  final destinations = [
    const VNavigationDestination(
      icon: SizedBox(width: 24, height: 24, child: Text('H')),
      label: 'Home',
    ),
    const VNavigationDestination(
      icon: SizedBox(width: 24, height: 24, child: Text('S')),
      label: 'Search',
    ),
    const VNavigationDestination(
      icon: SizedBox(width: 24, height: 24, child: Text('P')),
      label: 'Profile',
    ),
  ];

  group('VNavigationBar Basic', () {
    testWidgets('renders destinations and responds to taps', (tester) async {
      int selectedIndex = 0;

      await tester.pumpWidget(_wrap(
        VNavigationBar(
          destinations: destinations,
          selectedIndex: selectedIndex,
          onChanged: (i) => selectedIndex = i,
        ),
      ));

      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Search'), findsOneWidget);
      expect(find.text('Profile'), findsOneWidget);

      await tester.tap(find.text('Search'));
      await tester.pumpAndSettle();

      expect(selectedIndex, equals(1));
    });

    testWidgets('does not select disabled destinations', (tester) async {
      int selectedIndex = 0;

      await tester.pumpWidget(_wrap(
        VNavigationBar(
          destinations: [
            const VNavigationDestination(
              icon: SizedBox(),
              label: 'Home',
            ),
            const VNavigationDestination(
              icon: SizedBox(),
              label: 'Search',
              enabled: false,
            ),
          ],
          selectedIndex: selectedIndex,
          onChanged: (i) => selectedIndex = i,
        ),
      ));

      await tester.tap(find.text('Search'));
      await tester.pumpAndSettle();

      expect(selectedIndex, equals(0));
    });
  });

  group('VNavigationBar Safe Area Padding (Heterogeneous Screen Shapes)', () {
    testWidgets('flat shape extends height and adds bottom padding for safe area', (tester) async {
      const customPadding = EdgeInsets.only(bottom: 34.0, left: 10.0, right: 10.0);
      const mediaQuery = MediaQueryData(padding: customPadding);

      await tester.pumpWidget(_wrap(
        VNavigationBar(
          shape: VNavigationBarShape.flat,
          destinations: destinations,
          selectedIndex: 0,
          onChanged: (_) {},
        ),
        mediaQuery: mediaQuery,
      ));

      final containerFinder = find.byType(Container).first;
      final Size containerSize = tester.getSize(containerFinder);
      
      // Default height is 64.0. With 34.0 bottom safe area, total height should be 98.0
      expect(containerSize.height, equals(98.0));

      final container = tester.widget<Container>(containerFinder);
      final BoxDecoration decoration = container.decoration as BoxDecoration;
      expect(decoration.border?.top, isNotNull);

      // Check interior padding (should include horizontal and bottom safe area)
      final padding = container.padding as EdgeInsets;
      expect(padding.bottom, equals(34.0));
      expect(padding.left, equals(10.0));
      expect(padding.right, equals(10.0));
    });

    testWidgets('floating and capsule shapes add safe area to outer margins instead of interior padding', (tester) async {
      const customPadding = EdgeInsets.only(bottom: 34.0, left: 10.0, right: 10.0);
      const mediaQuery = MediaQueryData(padding: customPadding);

      await tester.pumpWidget(_wrap(
        VNavigationBar(
          shape: VNavigationBarShape.floating,
          destinations: destinations,
          selectedIndex: 0,
          onChanged: (_) {},
        ),
        mediaQuery: mediaQuery,
      ));

      // Container size should be exactly barHeight (64.0) inside
      final containerFinder = find.byType(Container).first;
      final Size containerSize = tester.getSize(containerFinder);
      expect(containerSize.height, equals(64.0));

      final container = tester.widget<Container>(containerFinder);
      // Interior padding should not have safe area bottom (handled by outer margins)
      final padding = container.padding as EdgeInsets;
      expect(padding.bottom, equals(0.0));

      // Outer margin padding should include bottom safe area and default margin
      final paddingWidgetFinder = find.byType(Padding).first;
      final paddingWidget = tester.widget<Padding>(paddingWidgetFinder);
      final margin = paddingWidget.padding as EdgeInsets;
      
      // Default bottom margin is 8.0. With 34.0 bottom safe area, it should be 42.0
      expect(margin.bottom, equals(42.0));
      // Default horizontal margin is 16.0. With 10.0 safe area, it should be 26.0
      expect(margin.left, equals(26.0));
      expect(margin.right, equals(26.0));
    });
  });

  group('VNavigationBar Animations and Center FAB Notched Gap', () {
    testWidgets('supports animations properties', (tester) async {
      await tester.pumpWidget(_wrap(
        VNavigationBar(
          destinations: destinations,
          selectedIndex: 0,
          onChanged: (_) {},
          animation: VNavigationBarAnimation.shift,
        ),
      ));

      expect(find.byType(VNavigationBar), findsOneWidget);
    });

    testWidgets('splits destinations and builds gap when center FAB is active', (tester) async {
      const centerFab = VNavigationDestination(
        icon: SizedBox(width: 24, height: 24, child: Text('+')),
        label: 'Create',
      );

      // Create a 4 item list
      final fourDestinations = [
        ...destinations,
        const VNavigationDestination(
          icon: SizedBox(),
          label: 'Settings',
        ),
      ];

      await tester.pumpWidget(_wrap(
        VNavigationBar(
          destinations: fourDestinations,
          selectedIndex: 0,
          onChanged: (_) {},
          centerDestination: centerFab,
        ),
      ));

      // There should be a notch gap in the middle
      // Let's verify by checking if the center destination is rendered as a FAB
      expect(find.text('+'), findsOneWidget);

      // Let's check that the gap exists in the Row children.
      // The Row contains the left items, a SizedBox, and right items.
      final rowFinder = find.byType(Row).first;
      final row = tester.widget<Row>(rowFinder);

      // Expect left items + SizedBox (gap) + right items
      // For 4 destinations: left items (2) + gap (1) + right items (2) = 5 widgets
      expect(row.children.length, equals(5));

      // Check that the middle child is a SizedBox representing the gap
      expect(row.children[2], isA<SizedBox>());
      final gapSizedBox = row.children[2] as SizedBox;
      expect(gapSizedBox.width, isNotNull);
      expect(gapSizedBox.width! > 0.0, isTrue);
    });

    testWidgets('renders CustomPaint with _NotchPainter and ClipPath with _NotchClipper when center FAB is active', (tester) async {
      const centerFab = VNavigationDestination(
        icon: SizedBox(),
        label: 'Create',
      );

      await tester.pumpWidget(_wrap(
        VNavigationBar(
          destinations: destinations,
          selectedIndex: 0,
          onChanged: (_) {},
          centerDestination: centerFab,
        ),
      ));

      // Verify that a ClipPath with _NotchClipper is rendered
      final clipPathFinder = find.byType(ClipPath);
      expect(clipPathFinder, findsOneWidget);
      final clipPath = tester.widget<ClipPath>(clipPathFinder);
      expect(clipPath.clipper, isNotNull);
      
      // Verify that a CustomPaint with _NotchPainter is rendered
      final customPaintFinder = find.byType(CustomPaint);
      expect(customPaintFinder, findsAtLeastNWidgets(1));
      
      bool foundNotchPainter = false;
      for (final element in tester.allElements) {
        if (element.widget is CustomPaint) {
          final cp = element.widget as CustomPaint;
          if (cp.painter != null && cp.painter.runtimeType.toString() == '_NotchPainter') {
            foundNotchPainter = true;
            break;
          }
        }
      }
      expect(foundNotchPainter, isTrue);
    });
  });
}
