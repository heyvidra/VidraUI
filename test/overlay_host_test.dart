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
  group('VOverlayHost', () {
    testWidgets('inserts and removes overlay entries', (tester) async {
      late VOverlayController host;

      await tester.pumpWidget(_wrap(
        VOverlayHost(
          textDirection: TextDirection.ltr,
          child: Builder(
            builder: (context) {
              host = VOverlay.of(context);
              return const SizedBox.shrink();
            },
          ),
        ),
      ));

      final handle = host.show((_, __) => const Placeholder());
      await tester.pump();
      expect(handle.mounted, isTrue);

      handle.remove();
      await tester.pump();
      expect(handle.mounted, isFalse);
    });

    testWidgets('inserted entry renders widget', (tester) async {
      late VOverlayController host;

      await tester.pumpWidget(_wrap(
        VOverlayHost(
          textDirection: TextDirection.ltr,
          child: Builder(
            builder: (context) {
              host = VOverlay.of(context);
              return const SizedBox.shrink();
            },
          ),
        ),
      ));

      host.show((_, __) {
        return const Positioned(
          left: 0,
          top: 0,
          child: Text('OverlayContent'),
        );
      });
      await tester.pump();
      expect(find.text('OverlayContent'), findsOneWidget);
    });

    testWidgets('provides overlay controller scope to descendants',
        (tester) async {
      VOverlayController? controller;

      await tester.pumpWidget(_wrap(
        VOverlayHost(
          textDirection: TextDirection.ltr,
          child: Builder(
            builder: (context) {
              controller = VOverlay.maybeOf(context);
              return const SizedBox.shrink();
            },
          ),
        ),
      ));

      expect(controller, isNotNull);
    });

    testWidgets('dispose cleans up remaining entries', (tester) async {
      late VOverlayController host;
      VOverlayHandle? handle;

      await tester.pumpWidget(_wrap(
        VOverlayHost(
          textDirection: TextDirection.ltr,
          child: Builder(
            builder: (context) {
              host = VOverlay.of(context);
              return const SizedBox.shrink();
            },
          ),
        ),
      ));

      handle = host.show((_, __) => const Placeholder());
      await tester.pump();
      expect(handle.mounted, isTrue);

      // Pump a new widget that removes the host
      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump();
      expect(handle.mounted, isFalse);
    });

    testWidgets('VPopover falls back to Flutter Overlay without VOverlayHost',
        (tester) async {
      await tester.pumpWidget(_wrap(
        Overlay(
          initialEntries: [
            OverlayEntry(
              builder: (context) {
                return Center(
                  child: VPopover(
                    triggerBuilder: (context, controller, isOpen) {
                      return VButton(
                        onPressed: controller.toggle,
                        child: const Text('Open popover'),
                      );
                    },
                    contentBuilder: (context, controller) {
                      return const SizedBox(
                        width: 120,
                        height: 48,
                        child: Text('Raw overlay content'),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ));

      await tester.tap(find.text('Open popover'));
      await tester.pump();

      expect(find.text('Raw overlay content'), findsOneWidget);
    });
  });

  group('VToast', () {
    testWidgets('VToast.show renders message and default icon', (tester) async {
      await tester.pumpWidget(_wrap(
        VOverlayHost(
          textDirection: TextDirection.ltr,
          child: Builder(
            builder: (context) {
              return VButton(
                onPressed: () {
                  VToast.show(context, message: 'Test Toast Message');
                },
                child: const Text('Trigger'),
              );
            },
          ),
        ),
      ));

      await tester.tap(find.text('Trigger'));
      await tester.pump(); // Start overlay show
      await tester
          .pump(const Duration(milliseconds: 100)); // Finish entry animation

      expect(find.text('Test Toast Message'), findsOneWidget);
      expect(find.byType(CustomPaint),
          findsWidgets); // Custom vector info icon is custom drawn
    });

    testWidgets('VToast.show renders custom icon', (tester) async {
      await tester.pumpWidget(_wrap(
        VOverlayHost(
          textDirection: TextDirection.ltr,
          child: Builder(
            builder: (context) {
              return VButton(
                onPressed: () {
                  VToast.show(
                    context,
                    message: 'Test Custom Icon',
                    icon: const Text('🔥'),
                  );
                },
                child: const Text('Trigger'),
              );
            },
          ),
        ),
      ));

      await tester.tap(find.text('Trigger'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text('Test Custom Icon'), findsOneWidget);
      expect(find.text('🔥'), findsOneWidget); // Custom icon widget
      expect(find.text('ℹ'), findsNothing);
    });

    testWidgets('VToast.show renders action and lets it dismiss',
        (tester) async {
      var actionCount = 0;

      await tester.pumpWidget(_wrap(
        VOverlayHost(
          textDirection: TextDirection.ltr,
          child: Builder(
            builder: (context) {
              return VButton(
                onPressed: () {
                  VToast.show(
                    context,
                    message: 'Action Toast',
                    action: (context, dismiss) {
                      return VButton(
                        onPressed: () {
                          actionCount++;
                          dismiss();
                        },
                        child: const Text('Undo'),
                      );
                    },
                  );
                },
                child: const Text('Trigger'),
              );
            },
          ),
        ),
      ));

      await tester.tap(find.text('Trigger'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text('Action Toast'), findsOneWidget);
      expect(find.text('Undo'), findsOneWidget);

      await tester.tap(find.text('Action Toast'));
      await tester.pumpAndSettle();
      expect(find.text('Action Toast'), findsOneWidget);

      await tester.tap(find.text('Undo'));
      await tester.pumpAndSettle();

      expect(actionCount, 1);
      expect(find.text('Action Toast'), findsNothing);
    });

    testWidgets('VToast supports swipe-to-dismiss', (tester) async {
      await tester.pumpWidget(_wrap(
        VOverlayHost(
          textDirection: TextDirection.ltr,
          child: Builder(
            builder: (context) {
              return VButton(
                onPressed: () {
                  VToast.show(context, message: 'Swipeable Toast');
                },
                child: const Text('Trigger'),
              );
            },
          ),
        ),
      ));

      await tester.tap(find.text('Trigger'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text('Swipeable Toast'), findsOneWidget);

      // Perform swipe gesture to the right
      await tester.drag(find.text('Swipeable Toast'), const Offset(500, 0));
      await tester.pumpAndSettle();

      expect(find.text('Swipeable Toast'), findsNothing);
    });
  });
}
