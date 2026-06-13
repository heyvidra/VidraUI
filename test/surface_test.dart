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

BoxDecoration _surfaceDecoration(WidgetTester tester) {
  return tester
      .widgetList<Container>(find.byType(Container))
      .map((container) => container.decoration)
      .whereType<BoxDecoration>()
      .first;
}

void main() {
  group('VSurface', () {
    testWidgets('uses color background override', (tester) async {
      const color = Color(0xFF123456);

      await tester.pumpWidget(_wrap(
        const VSurface(
          background: VBackground.color(color),
          child: SizedBox(width: 24, height: 24),
        ),
      ));

      expect(_surfaceDecoration(tester).color, color);
      expect(_surfaceDecoration(tester).gradient, isNull);
    });

    testWidgets('uses gradient background override', (tester) async {
      const gradient = LinearGradient(
        colors: [Color(0xFF111111), Color(0xFF222222)],
      );

      await tester.pumpWidget(_wrap(
        const VSurface(
          background: VBackground.gradient(gradient),
          child: SizedBox(width: 24, height: 24),
        ),
      ));

      expect(_surfaceDecoration(tester).gradient, gradient);
      expect(_surfaceDecoration(tester).color, isNull);
    });

    testWidgets('background override wins over appearance and tokens',
        (tester) async {
      const override = Color(0xFFABCDEF);
      const tokenColor = Color(0xFF111111);
      const appearanceColor = Color(0xFF222222);

      await tester.pumpWidget(_wrap(
        VAppearanceScope(
          appearance: const _SurfaceTestAppearance(appearanceColor),
          child: VSurfaceTheme(
            data: VSurfaceTokens.fromColors(VColors.light()).copyWith(
              baseBackground: tokenColor,
            ),
            child: const VSurface(
              background: VBackground.color(override),
              child: SizedBox(width: 24, height: 24),
            ),
          ),
        ),
      ));

      expect(_surfaceDecoration(tester).color, override);
      expect(_surfaceDecoration(tester).gradient, isNull);
      expect(
        tester.widgetList<DecoratedBox>(find.byType(DecoratedBox)).where(
              (box) =>
                  box.decoration is BoxDecoration &&
                  (box.decoration as BoxDecoration).gradient != null,
            ),
        isEmpty,
      );
    });

    testWidgets('uses default token background when no override is provided',
        (tester) async {
      final theme = VThemeData.light();

      await tester.pumpWidget(_wrap(
        const VSurface(
          variant: VSurfaceVariant.card,
          child: SizedBox(width: 24, height: 24),
        ),
      ));

      expect(
        _surfaceDecoration(tester).color,
        theme.components.surface.cardBackground,
      );
    });

    testWidgets('uses elevation color and shadow', (tester) async {
      final theme = VThemeData.light();
      const elevation = VElevation.level2;

      await tester.pumpWidget(_wrap(
        const VSurface(
          elevation: elevation,
          child: SizedBox(width: 24, height: 24),
        ),
      ));

      final decoration = _surfaceDecoration(tester);
      expect(decoration.color, theme.surfaceColor(elevation));
      expect(decoration.boxShadow, [theme.shadow(elevation)]);
    });
  });
}

class _SurfaceTestAppearance extends VAppearance {
  const _SurfaceTestAppearance(this.color);

  final Color color;

  @override
  Color background(Color base, Set<WidgetState> states) => color;

  @override
  Gradient? gradient(Color base, Set<WidgetState> states) {
    return const LinearGradient(
      colors: [Color(0xFF333333), Color(0xFF444444)],
    );
  }
}
