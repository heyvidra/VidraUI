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
        child: child,
      ),
    ),
  );
}

void main() {
  group('VTeachingTip', () {
    testWidgets('renders child target but does not show tip initially',
        (tester) async {
      final controller = VPopoverController();

      await tester.pumpWidget(_wrap(
        Center(
          child: VTeachingTip(
            controller: controller,
            title: 'Tip Title',
            subtitle: 'Tip Subtitle',
            child: const SizedBox(
              width: 50,
              height: 50,
              child: Text('Target'),
            ),
          ),
        ),
      ));

      expect(find.text('Target'), findsOneWidget);
      expect(find.text('Tip Title'), findsNothing);
      expect(find.text('Tip Subtitle'), findsNothing);
    });

    testWidgets('shows tip when controller is opened, and closes when closed',
        (tester) async {
      final controller = VPopoverController();

      await tester.pumpWidget(_wrap(
        Center(
          child: VTeachingTip(
            controller: controller,
            title: 'Tip Title',
            subtitle: 'Tip Subtitle',
            child: const SizedBox(
              width: 50,
              height: 50,
              child: Text('Target'),
            ),
          ),
        ),
      ));

      controller.open();
      await tester.pump();
      await tester.pumpAndSettle();

      expect(find.text('Tip Title'), findsOneWidget);
      expect(find.text('Tip Subtitle'), findsOneWidget);

      controller.close();
      await tester.pumpAndSettle();

      expect(find.text('Tip Title'), findsNothing);
    });

    testWidgets('dismisses when close button is tapped', (tester) async {
      final controller = VPopoverController();
      var closeCallbackFired = false;

      await tester.pumpWidget(_wrap(
        Center(
          child: VTeachingTip(
            controller: controller,
            title: 'Tip Title',
            subtitle: 'Tip Subtitle',
            onClose: () {
              closeCallbackFired = true;
            },
            child: const SizedBox(
              width: 50,
              height: 50,
              child: Text('Target'),
            ),
          ),
        ),
      ));

      controller.open();
      await tester.pumpAndSettle();

      // Tap close button (the last GestureDetector inside the overlay is the close button)
      await tester.tap(find.byType(GestureDetector).last);
      await tester.pumpAndSettle();

      expect(controller.isOpen, isFalse);
      expect(closeCallbackFired, isTrue);
      expect(find.text('Tip Title'), findsNothing);
    });

    testWidgets('renders action buttons and triggers their callbacks',
        (tester) async {
      final controller = VPopoverController();
      var primaryPressed = false;
      var secondaryPressed = false;

      await tester.pumpWidget(_wrap(
        Center(
          child: VTeachingTip(
            controller: controller,
            title: 'Tip Title',
            subtitle: 'Tip Subtitle',
            primaryButton: VButton(
              onPressed: () {
                primaryPressed = true;
              },
              child: const VText('Next'),
            ),
            secondaryButton: VButton(
              variant: VButtonVariant.secondary,
              onPressed: () {
                secondaryPressed = true;
              },
              child: const VText('Skip'),
            ),
            child: const SizedBox(
              width: 50,
              height: 50,
              child: Text('Target'),
            ),
          ),
        ),
      ));

      controller.open();
      await tester.pumpAndSettle();

      expect(find.text('Next'), findsOneWidget);
      expect(find.text('Skip'), findsOneWidget);

      await tester.tap(find.text('Next'));
      await tester.pump();
      expect(primaryPressed, isTrue);

      await tester.tap(find.text('Skip'));
      await tester.pump();
      expect(secondaryPressed, isTrue);
    });

    testWidgets('auto placement flips tall rich tip above the target',
        (tester) async {
      final controller = VPopoverController();

      await tester.pumpWidget(_wrap(
        SizedBox(
          width: 500,
          height: 260,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: VTeachingTip(
                    controller: controller,
                    title: 'Rich Tip',
                    subtitle: 'A taller tip should flip when there is no room.',
                    placement: VAnchoredOverlayPlacement.auto,
                    illustration: Container(height: 120),
                    primaryButton: VButton(
                      onPressed: () {},
                      child: const VText('Done'),
                    ),
                    child: const SizedBox(
                      width: 80,
                      height: 40,
                      child: Text('Target'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ));

      controller.open();
      await tester.pumpAndSettle();

      final targetRect = tester.getRect(find.text('Target'));
      final tipTitleRect = tester.getRect(find.text('Rich Tip'));
      expect(tipTitleRect.bottom, lessThan(targetRect.top));
    });

    testWidgets('left placement near bottom keeps tip close to target center',
        (tester) async {
      final controller = VPopoverController();

      await tester.pumpWidget(_wrap(
        SizedBox(
          width: 500,
          height: 260,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: VTeachingTip(
                    controller: controller,
                    title: 'Left Tip',
                    subtitle: 'Opened pointing to the left.',
                    placement: VAnchoredOverlayPlacement.left,
                    showCloseButton: false,
                    child: const SizedBox(
                      width: 80,
                      height: 40,
                      child: Text('Target'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ));

      controller.open();
      await tester.pumpAndSettle();

      final targetRect = tester.getRect(find.text('Target'));
      final tipTitleRect = tester.getRect(find.text('Left Tip'));
      final centerDistance =
          (tipTitleRect.center.dy - targetRect.center.dy).abs();
      expect(centerDistance, lessThan(80));
    });

    testWidgets('action buttons keep stable horizontal position while opening',
        (tester) async {
      final controller = VPopoverController();

      await tester.pumpWidget(_wrap(
        Center(
          child: VTeachingTip(
            controller: controller,
            title: 'Step 1: Save Content',
            subtitle:
                'Store your meeting minutes locally or export them instantly.',
            placement: VAnchoredOverlayPlacement.up,
            primaryButton: VButton(
              onPressed: () {},
              child: const VText('Next Step'),
            ),
            secondaryButton: VButton(
              variant: VButtonVariant.secondary,
              onPressed: () {},
              child: const VText('Skip'),
            ),
            child: const SizedBox(
              width: 96,
              height: 72,
              child: Text('Target'),
            ),
          ),
        ),
      ));

      controller.open();
      await tester.pump();
      final firstLeft = tester.getTopLeft(find.text('Skip')).dx;
      await tester.pump(const Duration(milliseconds: 80));
      final midLeft = tester.getTopLeft(find.text('Skip')).dx;
      await tester.pumpAndSettle();
      final settledLeft = tester.getTopLeft(find.text('Skip')).dx;

      expect((midLeft - firstLeft).abs(), lessThan(0.5));
      expect((settledLeft - firstLeft).abs(), lessThan(0.5));
    });

    testWidgets('supports all transition styles without exceptions',
        (tester) async {
      for (final style in VTeachingTipTransitionStyle.values) {
        final controller = VPopoverController();

        await tester.pumpWidget(_wrap(
          Center(
            child: VTeachingTip(
              controller: controller,
              title: 'Tip $style',
              subtitle: 'Subtitle $style',
              transitionStyle: style,
              child: const SizedBox(
                width: 50,
                height: 50,
                child: Text('Target'),
              ),
            ),
          ),
        ));

        controller.open();
        await tester.pumpAndSettle();

        expect(find.text('Tip $style'), findsOneWidget);

        controller.close();
        await tester.pumpAndSettle();

        expect(find.text('Tip $style'), findsNothing);
      }
    });
  });
}
