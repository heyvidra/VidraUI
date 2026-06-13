import 'dart:ui';
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

Widget _buildNavigator(VMotion motion) {
  return Navigator(
    onGenerateRoute: (settings) {
      if (settings.name == '/') {
        return VPageRoute<void>(
          settings: settings,
          motion: motion,
          builder: (context) => SizedBox.expand(
            child: DecoratedBox(
              decoration: const BoxDecoration(color: Color(0xFFFFFFFF)),
              child: Center(
                child: VButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/next');
                  },
                  child: const Text('Go'),
                ),
              ),
            ),
          ),
        );
      }
      return VPageRoute<void>(
        settings: settings,
        motion: motion,
        builder: (context) => const SizedBox.expand(
          child: DecoratedBox(
            decoration: BoxDecoration(color: Color(0xFFFFFFFF)),
            child: Center(
              child: Text('TargetPage'),
            ),
          ),
        ),
      );
    },
  );
}


void main() {
  group('VPageRoute Transitions', () {
    testWidgets('renders slideFade transition', (tester) async {
      final motion = VMotion.defaults().copyWith(pageTransition: VPageTransition.slideFade);
      await tester.pumpWidget(_wrap(_buildNavigator(motion)));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Go'));
      await tester.pump();
      await tester.pumpAndSettle();

      expect(find.text('TargetPage'), findsOneWidget);
    });

    testWidgets('renders iosDepthSlide transition', (tester) async {
      final motion = VMotion.defaults().copyWith(pageTransition: VPageTransition.iosDepthSlide);
      await tester.pumpWidget(_wrap(_buildNavigator(motion)));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Go'));
      await tester.pump();
      await tester.pumpAndSettle();

      expect(find.text('TargetPage'), findsOneWidget);
    });

    testWidgets('renders sharedAxisX transition', (tester) async {
      final motion = VMotion.defaults().copyWith(pageTransition: VPageTransition.sharedAxisX);
      await tester.pumpWidget(_wrap(_buildNavigator(motion)));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Go'));
      await tester.pump();
      await tester.pumpAndSettle();

      expect(find.text('TargetPage'), findsOneWidget);
    });

    testWidgets('renders perspective3D transition', (tester) async {
      final motion = VMotion.defaults().copyWith(pageTransition: VPageTransition.perspective3D);
      await tester.pumpWidget(_wrap(_buildNavigator(motion)));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Go'));
      await tester.pump();
      await tester.pumpAndSettle();

      expect(find.text('TargetPage'), findsOneWidget);
    });

    testWidgets('renders adaptive transition', (tester) async {
      final motion = VMotion.defaults().copyWith(pageTransition: VPageTransition.adaptive);
      await tester.pumpWidget(_wrap(_buildNavigator(motion)));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Go'));
      await tester.pump();
      await tester.pumpAndSettle();

      expect(find.text('TargetPage'), findsOneWidget);
    });

    testWidgets('VBackGestureDetector pop gesture works on left edge drag', (tester) async {
      final motion = VMotion.defaults().copyWith(pageTransition: VPageTransition.iosDepthSlide);
      late VPageRoute<void> route;

      await tester.pumpWidget(_wrap(
        Navigator(
          onGenerateRoute: (settings) {
            if (settings.name == '/') {
              return VPageRoute<void>(
                settings: settings,
                motion: motion,
                builder: (context) => SizedBox.expand(
                  child: DecoratedBox(
                    decoration: const BoxDecoration(color: Color(0xFFFFFFFF)),
                    child: Center(
                      child: VButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed('/next');
                        },
                        child: const Text('Go'),
                      ),
                    ),
                  ),
                ),
              );
            }
            route = VPageRoute<void>(
              settings: settings,
              motion: motion,
              builder: (context) => const SizedBox.expand(
                child: DecoratedBox(
                  decoration: BoxDecoration(color: Color(0xFFFFFFFF)),
                  child: Center(
                    child: Text('TargetPage'),
                  ),
                ),
              ),
            );
            return route;
          },
        ),
      ));
      await tester.pumpAndSettle();

      // Push target page
      await tester.tap(find.text('Go'));
      await tester.pump();
      await tester.pumpAndSettle();

      expect(find.byType(VBackGestureDetector), findsOneWidget);

      // Perform a drag gesture using TestPointer
      final TestPointer testPointer = TestPointer(1, PointerDeviceKind.touch);
      
      // Pointer down at left edge
      tester.binding.handlePointerEvent(testPointer.down(const Offset(5, 100)));
      await tester.pump();

      // Move to dx = 15 to start drag
      tester.binding.handlePointerEvent(testPointer.move(const Offset(15, 100)));
      await tester.pump();

      // Move to dx = 405 (dragged 400px, fraction = 0.5)
      tester.binding.handlePointerEvent(testPointer.move(const Offset(405, 100)));
      await tester.pump();

      // Verify that controller value was driven manually by drag
      expect(route.animation!.value, 0.5);

      // Pointer up
      tester.binding.handlePointerEvent(testPointer.up());
      await tester.pumpAndSettle();

      // Verify that controller animated to 0.0 (pop successful)
      expect(route.animation!.value, 0.0);
    });

    testWidgets('VBackGestureDetector drag cancellation does not pop', (tester) async {
      final motion = VMotion.defaults().copyWith(pageTransition: VPageTransition.iosDepthSlide);
      late VPageRoute<void> route;

      await tester.pumpWidget(_wrap(
        Navigator(
          onGenerateRoute: (settings) {
            if (settings.name == '/') {
              return VPageRoute<void>(
                settings: settings,
                motion: motion,
                builder: (context) => SizedBox.expand(
                  child: DecoratedBox(
                    decoration: const BoxDecoration(color: Color(0xFFFFFFFF)),
                    child: Center(
                      child: VButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed('/next');
                        },
                        child: const Text('Go'),
                      ),
                    ),
                  ),
                ),
              );
            }
            route = VPageRoute<void>(
              settings: settings,
              motion: motion,
              builder: (context) => const SizedBox.expand(
                child: DecoratedBox(
                  decoration: BoxDecoration(color: Color(0xFFFFFFFF)),
                  child: Center(
                    child: Text('TargetPage'),
                  ),
                ),
              ),
            );
            return route;
          },
        ),
      ));
      await tester.pumpAndSettle();

      // Push target page
      await tester.tap(find.text('Go'));
      await tester.pump();
      await tester.pumpAndSettle();

      // Perform a drag gesture using TestPointer
      final TestPointer testPointer = TestPointer(1, PointerDeviceKind.touch);
      
      // Pointer down at left edge
      tester.binding.handlePointerEvent(testPointer.down(const Offset(5, 100)));
      await tester.pump();

      // Move to dx = 15 to start drag
      tester.binding.handlePointerEvent(testPointer.move(const Offset(15, 100)));
      await tester.pump();

      // Move to dx = 25 (dragged 20px, fraction = 0.025)
      tester.binding.handlePointerEvent(testPointer.move(const Offset(25, 100)));
      await tester.pump();

      // Verify that controller value was driven manually
      expect(route.animation!.value, closeTo(0.975, 0.001));

      // Pointer up
      tester.binding.handlePointerEvent(testPointer.up());
      await tester.pumpAndSettle();

      // Verify that controller animated back to 1.0 (pop cancelled)
      expect(route.animation!.value, 1.0);
    });
  });
}
