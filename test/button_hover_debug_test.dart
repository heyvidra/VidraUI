import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vidraui/vidraui.dart';

/// Debug test to check if hover states are being detected at all.
void main() {
  testWidgets('debug hover state detection', (tester) async {
    final theme = VThemeData.light();
    var builderCallCount = 0;
    Set<WidgetState>? lastStates;

    await tester.pumpWidget(
      VPlatformScope(
        behavior: VPlatformBehavior.desktop(isApple: true),
        child: VidraApp.navigator(
          theme: theme,
          home: VButton(
            shape: VButtonShape.none,
            variant: VButtonVariant.primary,
            onPressed: () {},
            child: Builder(
              builder: (context) {
                // Try to capture the states being passed to the button builder
                builderCallCount++;
                print('Builder call #$builderCallCount');
                return const VText('Debug Button');
              },
            ),
          ),
        ),
      ),
    );

    await tester.pump();
    print('Initial pump complete, builder called $builderCallCount times');

    // Find button and hover
    final buttonFinder = find.byType(VButton);
    final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
    await gesture.addPointer(location: Offset.zero);
    
    print('Moving mouse to button center...');
    await gesture.moveTo(tester.getCenter(buttonFinder));
    await tester.pump();
    
    print('After hover move, builder called $builderCallCount times');

    // Check if there are any MouseRegion widgets in the tree
    final mouseRegionFinder = find.byType(MouseRegion);
    final mouseRegionCount = tester.widgetList<MouseRegion>(mouseRegionFinder).length;
    print('Found $mouseRegionCount MouseRegion widgets');

    // Let's also check the platform behavior
    final platformBehavior = VPlatformBehavior.desktop(isApple: true);
    print('Desktop behavior hasHoverCapability: ${platformBehavior.hasHoverCapability}');

    await gesture.removePointer();
  });
}