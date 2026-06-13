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
  group('VAnimatedText', () {
    // -----------------------------------------------------------------------
    // Reveal
    // -----------------------------------------------------------------------
    testWidgets('reveal effect shows text with opacity animation',
        (tester) async {
      await tester.pumpWidget(_wrap(
        const VAnimatedText(
          'Hello Reveal',
          effect: VTextAnimationEffect.reveal,
        ),
      ));

      await tester.pump();
      expect(find.text('Hello Reveal'), findsOneWidget);
    });

    // -----------------------------------------------------------------------
    // Typewriter
    // -----------------------------------------------------------------------
    testWidgets('typewriter effect prints text incrementally', (tester) async {
      var completed = false;
      await tester.pumpWidget(_wrap(
        VAnimatedText(
          'Type Me',
          effect: VTextAnimationEffect.typewriter,
          speed: const Duration(milliseconds: 10),
          showCursor: true,
          cursorChar: '_',
          onComplete: () => completed = true,
        ),
      ));

      // Initially nothing (or first char) printed.
      await tester.pump();
      expect(find.textContaining('Type Me'), findsNothing);
      expect(completed, isFalse);

      // Advance time to finish.
      await tester.pump(const Duration(milliseconds: 200));
      expect(find.textContaining('Type Me'), findsOneWidget);
      expect(completed, isTrue);
    });

    testWidgets('typewriter shows cursor', (tester) async {
      await tester.pumpWidget(_wrap(
        const VAnimatedText(
          'Hi',
          effect: VTextAnimationEffect.typewriter,
          speed: Duration(milliseconds: 1),
          showCursor: true,
          cursorChar: '|',
        ),
      ));

      await tester.pump(const Duration(milliseconds: 100));
      // Cursor should be present in the text span.
      expect(find.textContaining('|'), findsOneWidget);
    });

    // -----------------------------------------------------------------------
    // Fade
    // -----------------------------------------------------------------------
    testWidgets('fade effect shows text', (tester) async {
      await tester.pumpWidget(_wrap(
        const VAnimatedText(
          'Fade In',
          effect: VTextAnimationEffect.fade,
        ),
      ));

      await tester.pump();
      expect(find.text('Fade In'), findsOneWidget);
    });

    // -----------------------------------------------------------------------
    // Scale
    // -----------------------------------------------------------------------
    testWidgets('scale effect shows text', (tester) async {
      await tester.pumpWidget(_wrap(
        const VAnimatedText(
          'Scale Up',
          effect: VTextAnimationEffect.scale,
        ),
      ));

      await tester.pump();
      expect(find.text('Scale Up'), findsOneWidget);
    });

    // -----------------------------------------------------------------------
    // Bounce
    // -----------------------------------------------------------------------
    testWidgets('bounce effect shows text', (tester) async {
      await tester.pumpWidget(_wrap(
        const VAnimatedText(
          'Bounce',
          effect: VTextAnimationEffect.bounce,
        ),
      ));

      await tester.pump();
      expect(find.text('Bounce'), findsOneWidget);
    });

    // -----------------------------------------------------------------------
    // Wavy
    // -----------------------------------------------------------------------
    testWidgets('wavy effect shows text', (tester) async {
      await tester.pumpWidget(_wrap(
        const VAnimatedText(
          'Wave',
          effect: VTextAnimationEffect.wavy,
        ),
      ));

      await tester.pump();
      // Wavy renders individual character widgets; the text should be present.
      expect(find.text('W'), findsOneWidget);
      expect(find.text('a'), findsOneWidget);
    });

    // -----------------------------------------------------------------------
    // Scramble
    // -----------------------------------------------------------------------
    testWidgets('scramble effect converges to target text', (tester) async {
      await tester.pumpWidget(_wrap(
        const VAnimatedText(
          'ABC',
          effect: VTextAnimationEffect.scramble,
        ),
      ));

      // Let the animation run to completion.
      await tester.pumpAndSettle();

      // After completion, should display the target text exactly.
      expect(find.text('ABC'), findsOneWidget);
    });

    // -----------------------------------------------------------------------
    // Flicker
    // -----------------------------------------------------------------------
    testWidgets('flicker effect shows text', (tester) async {
      await tester.pumpWidget(_wrap(
        const VAnimatedText(
          'Flicker',
          effect: VTextAnimationEffect.flicker,
        ),
      ));

      await tester.pump();
      expect(find.text('Flicker'), findsOneWidget);
    });

    // -----------------------------------------------------------------------
    // Accessibility — disable animations
    // -----------------------------------------------------------------------
    testWidgets('shows static text when animations are disabled',
        (tester) async {
      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(disableAnimations: true),
          child: _wrap(
            const VAnimatedText(
              'Static',
              effect: VTextAnimationEffect.typewriter,
            ),
          ),
        ),
      );

      await tester.pump();
      // Should immediately show the full text without animation.
      expect(find.text('Static'), findsOneWidget);
    });
  });
}
