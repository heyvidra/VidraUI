import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vidraui/vidraui.dart';
// VLoadingDots is an internal primitive (not part of the public barrel).
import 'package:vidraui/src/widgets/feedback/v_progress.dart'
    show VLoadingDots;

void main() {
  testWidgets('VButton variants render correctly (like example)',
      (tester) async {
    await tester.pumpWidget(
      VidraApp.navigator(
        home: Padding(
          padding: const EdgeInsets.all(16),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: const [
              VButton(
                onPressed: _noop,
                child: VText('Primary'),
              ),
              VButton(
                onPressed: _noop,
                variant: VButtonVariant.secondary,
                child: VText('Secondary'),
              ),
              VButton(
                onPressed: _noop,
                variant: VButtonVariant.danger,
                child: VText('Danger'),
              ),
            ],
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // All three buttons should render
    expect(find.byType(VButton), findsNWidgets(3));
    expect(find.text('Primary'), findsOneWidget);
    expect(find.text('Secondary'), findsOneWidget);
    expect(find.text('Danger'), findsOneWidget);

    // Check each button has reasonable dimensions
    for (final buttonFinder in [
      find.widgetWithText(VButton, 'Primary'),
      find.widgetWithText(VButton, 'Secondary'),
      find.widgetWithText(VButton, 'Danger'),
    ]) {
      final box = tester.renderObject(buttonFinder) as RenderBox;
      expect(box.size.width, greaterThan(50),
          reason: 'Button should have width > 50');
      expect(box.size.height, greaterThan(20),
          reason: 'Button should have height > 20');
      print('  Button size: ${box.size}');
    }
  });

  testWidgets('VButton disabled state renders', (tester) async {
    await tester.pumpWidget(
      VidraApp.navigator(
        home: const VButton(
          onPressed: null,
          child: VText('Disabled'),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byType(VButton), findsOneWidget);
    expect(find.text('Disabled'), findsOneWidget);
  });

  testWidgets('VButton loading state renders', (tester) async {
    await tester.pumpWidget(
      VidraApp.navigator(
        home: const VButton(
          loading: true,
          onPressed: _noop,
          child: VText('Saving…'),
        ),
      ),
    );

    // Use pump() instead of pumpAndSettle() because loading animation is infinite
    await tester.pump();

    expect(find.byType(VButton), findsOneWidget);
    expect(find.byType(VLoadingDots), findsOneWidget);
  });

  testWidgets('VButton sizes render correctly', (tester) async {
    await tester.pumpWidget(
      VidraApp.navigator(
        home: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: const [
            VButton(
              size: VControlSize.sm,
              onPressed: _noop,
              child: VText('Small'),
            ),
            VButton(
              onPressed: _noop,
              child: VText('Medium'),
            ),
            VButton(
              size: VControlSize.lg,
              onPressed: _noop,
              child: VText('Large'),
            ),
          ],
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byType(VButton), findsNWidgets(3));

    final smallBox =
        tester.renderObject(find.widgetWithText(VButton, 'Small')) as RenderBox;
    final mediumBox = tester.renderObject(find.widgetWithText(VButton, 'Medium'))
        as RenderBox;
    final largeBox =
        tester.renderObject(find.widgetWithText(VButton, 'Large')) as RenderBox;

    // Height should increase: small < medium < large
    expect(smallBox.size.height, lessThan(mediumBox.size.height));
    expect(mediumBox.size.height, lessThan(largeBox.size.height));

    print('Small height: ${smallBox.size.height}');
    print('Medium height: ${mediumBox.size.height}');
    print('Large height: ${largeBox.size.height}');
  });

  testWidgets('VButton inside VSurface renders (example pattern)',
      (tester) async {
    await tester.pumpWidget(
      VidraApp.navigator(
        home: VSurface(
          variant: VSurfaceVariant.card,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: VFlex.vertical(
              gap: 12,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const VText('Variants', variant: VTextVariant.title),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: const [
                    VButton(
                      onPressed: _noop,
                      child: VText('Primary', variant: VTextVariant.label),
                    ),
                    VButton(
                      onPressed: _noop,
                      variant: VButtonVariant.secondary,
                      child: VText('Secondary', variant: VTextVariant.label),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byType(VButton), findsNWidgets(2));
    expect(find.text('Primary'), findsOneWidget);
    expect(find.text('Secondary'), findsOneWidget);
  });
}

void _noop() {}
