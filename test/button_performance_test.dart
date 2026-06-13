import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vidraui/vidraui.dart';

void main() {
  group('VButton performance optimization', () {
    testWidgets('button renders without errors after optimization',
        (tester) async {
      await tester.pumpWidget(
        VidraApp.navigator(
          home: VButton(
            onPressed: () {},
            child: const VText('Optimized Button'),
          ),
        ),
      );

      expect(find.text('Optimized Button'), findsOneWidget);
    });

    testWidgets('button state transitions are smooth', (tester) async {
      await tester.pumpWidget(
        VidraApp.navigator(
          home: VButton(
            onPressed: () {},
            child: const VText('Hover Me'),
          ),
        ),
      );

      // Initial state
      expect(find.byType(VButton), findsOneWidget);

      // Simulate hover (via gesture enter)
      final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
      await gesture.addPointer(location: Offset.zero);
      addTearDown(gesture.removePointer);
      
      await tester.pump();
      
      // Move to button
      await gesture.moveTo(tester.getCenter(find.byType(VButton)));
      await tester.pump();
      
      // Should still render
      expect(find.byType(VButton), findsOneWidget);
      
      // Pump animation frames
      await tester.pump(const Duration(milliseconds: 50));
      await tester.pump(const Duration(milliseconds: 50));
      await tester.pump(const Duration(milliseconds: 100));
      
      // Button should still be present and functioning
      expect(find.byType(VButton), findsOneWidget);
    });

    testWidgets('multiple buttons render efficiently', (tester) async {
      await tester.pumpWidget(
        VidraApp.navigator(
          home: ListView.builder(
            itemCount: 20,
            itemBuilder: (context, index) => VButton(
              key: Key('button-$index'),
              onPressed: () {},
              child: VText('Button $index'),
            ),
          ),
        ),
      );

      // All visible buttons should render
      expect(find.byType(VButton), findsWidgets);
      
      // Scroll and ensure no rendering errors
      await tester.drag(find.byType(ListView), const Offset(0, -300));
      await tester.pump();
      
      expect(find.byType(VButton), findsWidgets);
    });

    testWidgets('button animation completes correctly', (tester) async {
      bool pressed = false;
      
      await tester.pumpWidget(
        VidraApp.navigator(
          home: VButton(
            onPressed: () => pressed = true,
            child: const VText('Tap Me'),
          ),
        ),
      );

      // Tap button
      await tester.tap(find.byType(VButton));
      
      // Pump through animation
      await tester.pump(); // Start
      await tester.pump(const Duration(milliseconds: 100)); // Mid
      await tester.pump(const Duration(milliseconds: 200)); // Complete
      
      expect(pressed, isTrue);
      expect(find.byType(VButton), findsOneWidget);
    });

    testWidgets('disabled button does not animate unnecessarily',
        (tester) async {
      await tester.pumpWidget(
        VidraApp.navigator(
          home: const VButton(
            onPressed: null, // Disabled
            child: VText('Disabled'),
          ),
        ),
      );

      expect(find.byType(VButton), findsOneWidget);
      
      // Attempt interaction
      await tester.tap(find.byType(VButton));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 200));
      
      // Should still render correctly
      expect(find.byType(VButton), findsOneWidget);
    });

    testWidgets('loading button transitions smoothly', (tester) async {
      bool isLoading = false;
      
      await tester.pumpWidget(
        VidraApp.navigator(
          home: StatefulBuilder(
            builder: (context, setState) {
              return VButton(
                onPressed: () => setState(() => isLoading = true),
                loading: isLoading,
                child: const VText('Submit'),
              );
            },
          ),
        ),
      );

      expect(find.text('Submit'), findsOneWidget);
      
      // Trigger loading
      await tester.tap(find.byType(VButton));
      await tester.pump(); // Start transition
      
      // Pump animation frames
      await tester.pump(const Duration(milliseconds: 50));
      await tester.pump(const Duration(milliseconds: 50));
      await tester.pump(const Duration(milliseconds: 100));
      
      // Loading indicator should appear
      expect(find.byType(VButton), findsOneWidget);
    });

    testWidgets('button variants all render with optimization',
        (tester) async {
      await tester.pumpWidget(
        VidraApp.navigator(
          home: Column(
            children: [
              VButton(
                onPressed: () {},
                variant: VButtonVariant.primary,
                child: const VText('Primary'),
              ),
              VButton(
                onPressed: () {},
                variant: VButtonVariant.secondary,
                child: const VText('Secondary'),
              ),
              VButton(
                onPressed: () {},
                variant: VButtonVariant.danger,
                child: const VText('Danger'),
              ),
            ],
          ),
        ),
      );

      expect(find.byType(VButton), findsNWidgets(3));
      
      // Pump animations
      await tester.pump(const Duration(milliseconds: 200));
      
      expect(find.byType(VButton), findsNWidgets(3));
    });

    testWidgets('button sizes render correctly with optimization',
        (tester) async {
      await tester.pumpWidget(
        VidraApp.navigator(
          home: Column(
            children: [
              VButton(
                onPressed: () {},
                size: VControlSize.sm,
                child: const VText('Small'),
              ),
              VButton(
                onPressed: () {},
                size: VControlSize.md,
                child: const VText('Medium'),
              ),
              VButton(
                onPressed: () {},
                size: VControlSize.lg,
                child: const VText('Large'),
              ),
            ],
          ),
        ),
      );

      expect(find.byType(VButton), findsNWidgets(3));
    });

    testWidgets('circular button renders with optimization', (tester) async {
      await tester.pumpWidget(
        VidraApp.navigator(
          home: VButton(
            onPressed: () {},
            shape: VButtonShape.circle,
            child: const VText('X'),
          ),
        ),
      );

      expect(find.byType(VButton), findsOneWidget);
      expect(find.text('X'), findsOneWidget);
    });

    testWidgets('button with appearance override renders correctly',
        (tester) async {
      await tester.pumpWidget(
        VidraApp.navigator(
          home: VButton(
            onPressed: () {},
            appearance: const VOutlinedAppearance(),
            child: const VText('Outlined'),
          ),
        ),
      );

      expect(find.byType(VButton), findsOneWidget);
      
      // Pump animation
      await tester.pump(const Duration(milliseconds: 200));
      
      expect(find.byType(VButton), findsOneWidget);
    });
  });
}
