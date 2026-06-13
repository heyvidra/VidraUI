import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vidraui/vidraui.dart';

void main() {
  testWidgets('VButton reads tokens correctly', (tester) async {
    late VButtonTokens capturedTokens;
    
    await tester.pumpWidget(
      VidraApp.navigator(
        home: Builder(
          builder: (context) {
            final theme = VTheme.of(context);
            capturedTokens = theme.components.button;
            
            return VButton(
              onPressed: () {},
              child: const VText('Test'),
            );
          },
        ),
      ),
    );

    // Verify tokens exist and have reasonable values
    expect(capturedTokens, isNotNull);
    expect(capturedTokens.heightMd, greaterThan(0));
    expect(capturedTokens.paddingHorizontalMd, greaterThan(0));
    expect(capturedTokens.radius, greaterThan(0));
    
    // Verify primary background resolves
    final normalState = <WidgetState>{};
    final primaryBg = capturedTokens.primaryBackground.resolve(normalState);
    expect((primaryBg.a * 255.0).round().clamp(0, 255), greaterThan(0));
    
    print('✅ Tokens captured successfully:');
    print('  heightMd: ${capturedTokens.heightMd}');
    print('  paddingHorizontalMd: ${capturedTokens.paddingHorizontalMd}');
    print('  radius: ${capturedTokens.radius}');
    print('  primaryBg: $primaryBg');
  });

  testWidgets('VButton renders with all visual properties', (tester) async {
    await tester.pumpWidget(
      VidraApp.navigator(
        home: VButton(
          onPressed: () {},
          variant: VButtonVariant.primary,
          child: const VText('Primary Button'),
        ),
      ),
    );

    // Button should render
    expect(find.byType(VButton), findsOneWidget);
    expect(find.text('Primary Button'), findsOneWidget);
    
    // Check that the button has a reasonable size
    final buttonBox = tester.renderObject(find.byType(VButton)) as RenderBox;
    expect(buttonBox.size.width, greaterThan(50));
    expect(buttonBox.size.height, greaterThan(20));
    
    print('✅ Button renders with size: ${buttonBox.size}');
  });

  testWidgets('VButton decoration renders correctly', (tester) async {
    await tester.pumpWidget(
      VidraApp.navigator(
        home: Center(
          child: VButton(
            onPressed: () {},
            child: const VText('Test Button'),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Find DecoratedBox (should be created by _AnimatedButtonDecoration)
    final decoratedBoxes = find.descendant(
      of: find.byType(VButton),
      matching: find.byType(DecoratedBox),
    );
    
    expect(decoratedBoxes, findsWidgets);
    print('✅ Found ${decoratedBoxes.evaluate().length} DecoratedBox widgets');
    
    // Check for ConstrainedBox
    final constrainedBoxes = find.descendant(
      of: find.byType(VButton),
      matching: find.byType(ConstrainedBox),
    );
    
    expect(constrainedBoxes, findsWidgets);
    print('✅ Found ${constrainedBoxes.evaluate().length} ConstrainedBox widgets');
  });
}
