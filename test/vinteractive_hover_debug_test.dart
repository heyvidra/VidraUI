import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vidraui/src/widgets/interaction/v_interactive.dart';
import 'package:vidraui/vidraui.dart';

/// Debug test to check VInteractive hover state directly.
void main() {
  testWidgets('VInteractive hover state debug', (tester) async {
    Set<WidgetState>? capturedStates;
    var builderCallCount = 0;

    await tester.pumpWidget(
      VPlatformScope(
        behavior: VPlatformBehavior.desktop(isApple: true),
        child: VidraApp.navigator(
          theme: VThemeData.light(),
          home: Builder(
            builder: (context) {
              // Access VInteractive directly
              return SizedBox(
                width: 100,
                height: 50,
                child: Stack(
                  children: [
                    // Custom VInteractive usage to debug states
                    Positioned.fill(
                      child: Container(
                        color: const Color(
                            0x11000000), // Semi-transparent for visibility
                        child: VInteractive(
                          enabled: true,
                          onTap: () => print('Tapped!'),
                          builder: (context, states) {
                            builderCallCount++;
                            capturedStates = states;
                            print(
                                'VInteractive builder call #$builderCallCount, states: $states');

                            return Container(
                              color: states.contains(WidgetState.hovered)
                                  ? const Color(
                                      0xFF00FF00) // Green when hovered
                                  : const Color(
                                      0xFFFF0000), // Red when not hovered
                              child: const Center(
                                  child: VText('Interactive Area')),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );

    await tester.pump();
    print('=== Initial state ===');
    print('Builder called $builderCallCount times');
    print('Initial states: $capturedStates');
    expect(capturedStates?.contains(WidgetState.hovered), isFalse);

    // Create hover gesture
    final interactiveFinder = find.byType(VInteractive);
    expect(interactiveFinder, findsOneWidget);

    print('=== Starting hover ===');
    final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
    await gesture.addPointer(location: Offset.zero);

    // Move to center of interactive area
    await gesture.moveTo(tester.getCenter(interactiveFinder));
    await tester.pump();

    print('=== After hover move ===');
    print('Builder called $builderCallCount times');
    print('States after hover: $capturedStates');

    // Check if hover state is now active
    expect(capturedStates?.contains(WidgetState.hovered), isTrue,
        reason: 'Hover state should be active after mouse move');

    // Move away
    print('=== Moving away ===');
    await gesture.moveTo(const Offset(-100, -100));
    await tester.pump();

    print('=== After move away ===');
    print('Builder called $builderCallCount times');
    print('States after move away: $capturedStates');
    expect(capturedStates?.contains(WidgetState.hovered), isFalse,
        reason: 'Hover state should be inactive after mouse move away');

    await gesture.removePointer();
  });
}
