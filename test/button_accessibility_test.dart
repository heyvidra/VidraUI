import 'dart:ui' show Tristate;

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vidraui/vidraui.dart';

void main() {
  group('VButton accessibility (A11y)', () {
    testWidgets('enabled button has correct semantics', (tester) async {
      await tester.pumpWidget(
        VidraApp.navigator(
          home: VButton(
            onPressed: () {},
            semanticLabel: 'Submit form',
            child: const VText('Submit'),
          ),
        ),
      );

      final semantics = tester.getSemantics(find.byType(VButton));
      
      expect(semantics.flagsCollection.isButton, isTrue);
      expect(semantics.flagsCollection.isEnabled, Tristate.isTrue);
      // Label includes child text, so we just check it contains our semantic label
      expect(semantics.label, contains('Submit form'));
      expect(semantics.hint, isEmpty); // No hint for enabled button
    });

    testWidgets('disabled button has "disabled" hint', (tester) async {
      await tester.pumpWidget(
        VidraApp.navigator(
          home: const VButton(
            onPressed: null, // Disabled
            semanticLabel: 'Submit form',
            child: VText('Submit'),
          ),
        ),
      );

      final semantics = tester.getSemantics(find.byType(VButton));
      
      expect(semantics.flagsCollection.isButton, isTrue);
      expect(semantics.flagsCollection.isEnabled, Tristate.isFalse);
      expect(semantics.label, contains('Submit form'));
      expect(semantics.hint, 'Button is disabled');
    });

    testWidgets('loading button has "loading" hint and live region',
        (tester) async {
      await tester.pumpWidget(
        VidraApp.navigator(
          home: VButton(
            onPressed: () {},
            loading: true,
            semanticLabel: 'Submit form',
            child: const VText('Submit'),
          ),
        ),
      );

      final semantics = tester.getSemantics(find.byType(VButton));
      
      expect(semantics.flagsCollection.isButton, isTrue);
      expect(semantics.flagsCollection.isEnabled, Tristate.isFalse);
      expect(semantics.label, contains('Submit form'));
      expect(semantics.hint, 'Loading, please wait');
      expect(semantics.flagsCollection.isLiveRegion, isTrue);
    });

    testWidgets('loading button with custom loading label', (tester) async {
      await tester.pumpWidget(
        VidraApp.navigator(
          home: VButton(
            onPressed: () {},
            loading: true,
            loadingSemanticLabel: 'Submitting your form',
            semanticLabel: 'Submit form',
            child: const VText('Submit'),
          ),
        ),
      );

      final semantics = tester.getSemantics(find.byType(VButton));
      
      expect(semantics.hint, 'Submitting your form');
      expect(semantics.flagsCollection.isLiveRegion, isTrue);
    });

    testWidgets('button without semanticLabel still has correct flags',
        (tester) async {
      await tester.pumpWidget(
        VidraApp.navigator(
          home: const VButton(
            onPressed: null,
            child: VText('Click me'),
          ),
        ),
      );

      final semantics = tester.getSemantics(find.byType(VButton));
      
      expect(semantics.flagsCollection.isButton, isTrue);
      expect(semantics.flagsCollection.isEnabled, Tristate.isFalse);
      expect(semantics.hint, 'Button is disabled');
    });

    testWidgets('loading button transitions announce state change',
        (tester) async {
      bool isLoading = false;
      
      await tester.pumpWidget(
        VidraApp.navigator(
          home: StatefulBuilder(
            builder: (context, setState) {
              return VButton(
                onPressed: () {
                  setState(() => isLoading = true);
                },
                loading: isLoading,
                semanticLabel: 'Submit',
                child: const VText('Submit'),
              );
            },
          ),
        ),
      );

      // Initial state: enabled
      var semantics = tester.getSemantics(find.byType(VButton));
      expect(semantics.flagsCollection.isEnabled, Tristate.isTrue);
      expect(semantics.flagsCollection.isLiveRegion, isFalse);
      expect(semantics.hint, isEmpty);

      // Tap to trigger loading
      await tester.tap(find.byType(VButton));
      await tester.pump();

      // Loading state: disabled + live region
      semantics = tester.getSemantics(find.byType(VButton));
      expect(semantics.flagsCollection.isEnabled, Tristate.isFalse);
      expect(semantics.flagsCollection.isLiveRegion, isTrue);
      expect(semantics.hint, 'Loading, please wait');
    });

    testWidgets('disabled button without onPressed has correct semantics',
        (tester) async {
      await tester.pumpWidget(
        VidraApp.navigator(
          home: const VButton(
            // onPressed explicitly null
            onPressed: null,
            loading: false,
            semanticLabel: 'Unavailable action',
            child: VText('Disabled'),
          ),
        ),
      );

      final semantics = tester.getSemantics(find.byType(VButton));
      
      expect(semantics.flagsCollection.isButton, isTrue);
      expect(semantics.flagsCollection.isEnabled, Tristate.isFalse);
      expect(semantics.hint, 'Button is disabled');
      expect(semantics.flagsCollection.isLiveRegion, isFalse);
    });

    testWidgets('multiple button variants all have correct semantics',
        (tester) async {
      await tester.pumpWidget(
        VidraApp.navigator(
          home: Column(
            children: [
              VButton(
                key: const Key('primary'),
                onPressed: () {},
                variant: VButtonVariant.primary,
                semanticLabel: 'Primary button',
                child: const VText('Primary'),
              ),
              VButton(
                key: const Key('secondary'),
                onPressed: () {},
                variant: VButtonVariant.secondary,
                semanticLabel: 'Secondary button',
                child: const VText('Secondary'),
              ),
              VButton(
                key: const Key('danger'),
                onPressed: () {},
                variant: VButtonVariant.danger,
                semanticLabel: 'Danger button',
                child: const VText('Delete'),
              ),
            ],
          ),
        ),
      );

      // All buttons should have button semantics and be enabled
      for (final key in ['primary', 'secondary', 'danger']) {
        final semantics = tester.getSemantics(find.byKey(Key(key)));
        expect(semantics.flagsCollection.isButton, isTrue, reason: '$key button should be a button');
        expect(semantics.flagsCollection.isEnabled, Tristate.isTrue, reason: '$key button should be enabled');
      }
    });
  });
}
