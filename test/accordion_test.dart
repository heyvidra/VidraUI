import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vidraui/vidraui.dart';

Widget _wrap(Widget child) {
  return Directionality(
    textDirection: TextDirection.ltr,
    child: VTheme(
      data: VThemeData.light().copyWith(
        motion: const VMotion(reducedMotion: true),
      ),
      child: child,
    ),
  );
}

void main() {
  group('VCollapsible', () {
    testWidgets('toggles expand and collapse states on tap', (tester) async {
      bool? isExpanded;

      await tester.pumpWidget(_wrap(
        VCollapsible(
          header: const Text('Header'),
          onChanged: (v) => isExpanded = v,
          child: const Text('Content'),
        ),
      ));

      expect(isExpanded, isNull);

      await tester.tap(find.text('Header'));
      await tester.pumpAndSettle();

      expect(isExpanded, isTrue);

      await tester.tap(find.text('Header'));
      await tester.pumpAndSettle();

      expect(isExpanded, isFalse);
    });
  });

  group('VAccordion', () {
    testWidgets('exclusive single mode collapses other open items', (tester) async {
      await tester.pumpWidget(_wrap(
        const VAccordion(
          multiple: false,
          initialIndex: 0,
          items: [
            VAccordionItem(
              header: Text('H1'),
              child: Text('C1'),
            ),
            VAccordionItem(
              header: Text('H2'),
              child: Text('C2'),
            ),
          ],
        ),
      ));

      // Initially H1 is open (initialIndex: 0)
      final c1Finder = find.text('C1', skipOffstage: false);
      final c2Finder = find.text('C2', skipOffstage: false);

      expect(tester.getRect(c1Finder).height, greaterThan(0));
      expect(tester.getRect(c2Finder).height, equals(0));

      // Tap H2 to open it
      await tester.tap(find.text('H2'));
      await tester.pumpAndSettle();

      // Now H2 is open, H1 collapses
      expect(tester.getRect(c1Finder).height, equals(0));
      expect(tester.getRect(c2Finder).height, greaterThan(0));
    });

    testWidgets('multi mode allows multiple expanded items', (tester) async {
      await tester.pumpWidget(_wrap(
        const VAccordion(
          multiple: true,
          items: [
            VAccordionItem(
              header: Text('H1'),
              initiallyExpanded: true,
              child: Text('C1'),
            ),
            VAccordionItem(
              header: Text('H2'),
              initiallyExpanded: true,
              child: Text('C2'),
            ),
          ],
        ),
      ));

      final c1Finder = find.text('C1', skipOffstage: false);
      final c2Finder = find.text('C2', skipOffstage: false);

      // Both should be open initially
      expect(tester.getRect(c1Finder).height, greaterThan(0));
      expect(tester.getRect(c2Finder).height, greaterThan(0));
    });
  });
}
