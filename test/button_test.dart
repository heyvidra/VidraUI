import 'dart:ui' show Tristate;

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
  group('VButton', () {
    testWidgets('renders without error', (tester) async {
      await tester.pumpWidget(_wrap(
        VButton(
          onPressed: () {},
          child: const VText('Click'),
        ),
      ));
      expect(find.text('Click'), findsOneWidget);
    });

    testWidgets('fires onPressed on tap', (tester) async {
      int count = 0;
      await tester.pumpWidget(_wrap(
        VButton(
          onPressed: () => count++,
          child: const VText('Click'),
        ),
      ));
      await tester.tap(find.text('Click'));
      expect(count, 1);
    });

    testWidgets('disabled button does not fire on tap', (tester) async {
      int count = 0;
      await tester.pumpWidget(_wrap(
        const VButton(
          onPressed: null,
          child: VText('Disabled'),
        ),
      ));
      await tester.tap(find.text('Disabled'));
      expect(count, 0);
    });

    testWidgets('renders primary, secondary, danger variants', (tester) async {
      await tester.pumpWidget(_wrap(
        VFlex.horizontal(
          gap: 8,
          children: [
            VButton(
              onPressed: () {},
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
      ));
      expect(find.text('Primary'), findsOneWidget);
      expect(find.text('Secondary'), findsOneWidget);
      expect(find.text('Danger'), findsOneWidget);
    });

    testWidgets('supports small, medium, and large sizes', (tester) async {
      await tester.pumpWidget(_wrap(
        VFlex.horizontal(
          gap: 8,
          children: [
            VButton(
              key: const ValueKey('small'),
              size: VControlSize.sm,
              onPressed: () {},
              child: const VText('Small'),
            ),
            VButton(
              key: const ValueKey('medium'),
              onPressed: () {},
              child: const VText('Medium'),
            ),
            VButton(
              key: const ValueKey('large'),
              size: VControlSize.lg,
              onPressed: () {},
              child: const VText('Large'),
            ),
          ],
        ),
      ));

      final small = tester.getSize(find.byKey(const ValueKey('small')));
      final medium = tester.getSize(find.byKey(const ValueKey('medium')));
      final large = tester.getSize(find.byKey(const ValueKey('large')));

      expect(small.height, lessThan(medium.height));
      expect(medium.height, lessThan(large.height));
    });

    testWidgets('supports circular icon buttons', (tester) async {
      await tester.pumpWidget(_wrap(
        Center(
          child: VButton(
            shape: VButtonShape.circle,
            semanticLabel: 'Search',
            onPressed: () {},
            child: const Text('S'),
          ),
        ),
      ));

      // Find the actual button widget to check its size
      final buttonBox = tester.renderObject(find.byType(VButton)) as RenderBox;
      final size = buttonBox.size;

      expect(size.width, size.height);
    });

    testWidgets('has button semantics', (tester) async {
      await tester.pumpWidget(_wrap(
        VButton(
          onPressed: () {},
          child: const VText('Click'),
        ),
      ));
      final semantics = tester.getSemantics(find.byType(VButton));
      expect(semantics.flagsCollection.isButton, isTrue);
      expect(semantics.flagsCollection.isEnabled, Tristate.isTrue);
    });

    testWidgets('disabled button has disabled semantics', (tester) async {
      await tester.pumpWidget(_wrap(
        const VButton(
          onPressed: null,
          child: VText('Disabled'),
        ),
      ));
      final semantics = tester.getSemantics(find.byType(VButton));
      expect(semantics.flagsCollection.isEnabled, Tristate.isFalse);
    });

    testWidgets('VButtonTheme.override transforms nearest button tokens',
        (tester) async {
      VButtonTokens? captured;

      await tester.pumpWidget(_wrap(
        VButtonTheme.override(
          data: (theme, button) => button.copyWith(
            primaryBackground: VStateProperty.states(
              normal: theme.colors.success,
              hovered: theme.colors.successHover,
            ),
          ),
          child: Builder(
            builder: (context) {
              captured = VButtonTheme.of(context);
              return const SizedBox();
            },
          ),
        ),
      ));

      expect(
        captured!.primaryBackground.resolve(<WidgetState>{}),
        VThemeData.light().colors.success,
      );
      expect(
        captured!.primaryBackground.resolve({WidgetState.hovered}),
        VThemeData.light().colors.successHover,
      );
    });

    testWidgets('nested VButtonTheme.override composes from nearest override',
        (tester) async {
      VButtonTokens? captured;

      await tester.pumpWidget(_wrap(
        VButtonTheme.override(
          data: (theme, button) => button.copyWith(
            primaryBackground: VStateProperty.states(
              normal: theme.colors.success,
            ),
          ),
          child: VButtonTheme.override(
            data: (theme, button) => button.copyWith(
              primaryBorder: button.primaryBackground,
            ),
            child: Builder(
              builder: (context) {
                captured = VButtonTheme.of(context);
                return const SizedBox();
              },
            ),
          ),
        ),
      ));

      expect(
        captured!.primaryBorder.resolve(<WidgetState>{}),
        VThemeData.light().colors.success,
      );
    });
  });
}
