import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vidraui/vidraui.dart';

void main() {
  group('VColors', () {
    test('light factory returns non-null for all fields', () {
      final c = VColors.light();
      expect(c.background, isA<Color>());
      expect(c.surface, isA<Color>());
      expect(c.text, isA<Color>());
      expect(c.actionPrimary, isA<Color>());
      expect(c.danger, isA<Color>());
      expect(c.focusRing, isA<Color>());
    });

    test('dark factory returns non-null for all fields', () {
      final c = VColors.dark();
      expect(c.background, isA<Color>());
      expect(c.surface, isA<Color>());
      expect(c.text, isA<Color>());
      expect(c.actionPrimary, isA<Color>());
    });

    test('lerp at t=0 returns first color', () {
      final a = VColors.light();
      final b = VColors.dark();
      final result = VColors.lerp(a, b, 0.0);
      expect(result.background, a.background);
      expect(result.text, a.text);
    });

    test('lerp at t=1 returns second color', () {
      final a = VColors.light();
      final b = VColors.dark();
      final result = VColors.lerp(a, b, 1.0);
      expect(result.background, b.background);
      expect(result.text, b.text);
    });

    test('copyWith preserves unspecified fields', () {
      final original = VColors.light();
      final modified = original.copyWith(
        actionPrimary: const Color(0xFF7C3AED),
      );
      expect(modified.actionPrimary, const Color(0xFF7C3AED));
      // Other fields unchanged
      expect(modified.background, original.background);
      expect(modified.surface, original.surface);
      expect(modified.text, original.text);
    });

    test('equality', () {
      final a = VColors.light();
      final b = VColors.light();
      expect(a, equals(b));
      expect(a.hashCode, equals(b.hashCode));
    });
  });

  group('VThemeData', () {
    test('light factory produces valid theme', () {
      final theme = VThemeData.light();
      expect(theme.colors, isA<VColors>());
      expect(theme.typography, isA<VTypography>());
      expect(theme.spacing, isA<VSpacing>());
      expect(theme.radii, isA<VRadii>());
      expect(theme.shadows, isA<VShadows>());
      expect(theme.motion, isA<VMotion>());
      expect(theme.components, isA<VComponentTokens>());
    });

    test('dark factory produces valid theme', () {
      final theme = VThemeData.dark();
      expect(theme.colors, isA<VColors>());
    });

    test('copyWith preserves unspecified fields', () {
      final original = VThemeData.light();
      final modified = original.copyWith(
        spacing: VSpacing.defaults().copyWith(md: 99),
      );
      expect(modified.spacing.md, 99);
      expect(modified.colors, original.colors);
      expect(modified.typography, original.typography);
      expect(modified.radii, original.radii);
    });

    test('applyOverrides transforms token groups', () {
      final original = VThemeData.light();
      final modified = original.applyOverrides(
        colors: (colors) => colors.copyWith(
          actionPrimary: const Color(0xFF16A34A),
        ),
        spacing: (spacing) => spacing.copyWith(md: 99),
      );

      expect(modified.colors.actionPrimary, const Color(0xFF16A34A));
      expect(modified.spacing.md, 99);
      expect(modified.typography, original.typography);
      expect(modified.radii, original.radii);
    });

    test('applyOverrides regenerates component tokens after color overrides',
        () {
      final modified = VThemeData.light().applyOverrides(
        colors: (colors) => colors.copyWith(
          actionPrimary: const Color(0xFF16A34A),
          actionPrimaryHover: const Color(0xFF15803D),
          actionPrimaryPressed: const Color(0xFF166534),
        ),
      );

      expect(
        modified.components.button.primaryBackground.resolve(<WidgetState>{}),
        const Color(0xFF16A34A),
      );
      expect(
        modified.components.button.primaryBackground
            .resolve({WidgetState.hovered}),
        const Color(0xFF15803D),
      );
    });

    test('applyOverrides component override wins after color regeneration', () {
      final modified = VThemeData.light().applyOverrides(
        colors: (colors) => colors.copyWith(
          actionPrimary: const Color(0xFF16A34A),
        ),
        components: (theme, components) => components.copyWith(
          button: components.button.copyWith(
            primaryBackground: VStateProperty.states(
              normal: const Color(0xFF7C3AED),
            ),
          ),
        ),
      );

      expect(
        modified.components.button.primaryBackground.resolve(<WidgetState>{}),
        const Color(0xFF7C3AED),
      );
    });

    test('lerp at t=0 returns first theme', () {
      final a = VThemeData.light();
      final b = VThemeData.dark();
      final result = VThemeData.lerp(a, b, 0.0);
      expect(result.colors.background, a.colors.background);
    });

    test('lerp at t=1 returns second theme', () {
      final a = VThemeData.light();
      final b = VThemeData.dark();
      final result = VThemeData.lerp(a, b, 1.0);
      expect(result.colors.background, b.colors.background);
    });
  });

  group('VTheme', () {
    testWidgets('override transforms colors for descendants', (tester) async {
      VThemeData? captured;

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: VTheme(
            data: VThemeData.light(),
            child: VTheme.override(
              colors: (colors) => colors.copyWith(
                actionPrimary: const Color(0xFF16A34A),
              ),
              child: Builder(
                builder: (context) {
                  captured = VTheme.of(context);
                  return const SizedBox();
                },
              ),
            ),
          ),
        ),
      );

      expect(captured!.colors.actionPrimary, const Color(0xFF16A34A));
    });

    testWidgets('color overrides regenerate component tokens', (tester) async {
      VThemeData? captured;

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: VTheme(
            data: VThemeData.light(),
            child: VTheme.override(
              colors: (colors) => colors.copyWith(
                actionPrimary: const Color(0xFF16A34A),
                actionPrimaryHover: const Color(0xFF15803D),
                actionPrimaryPressed: const Color(0xFF166534),
              ),
              child: Builder(
                builder: (context) {
                  captured = VTheme.of(context);
                  return const SizedBox();
                },
              ),
            ),
          ),
        ),
      );

      expect(
        captured!.components.button.primaryBackground.resolve(<WidgetState>{}),
        const Color(0xFF16A34A),
      );
      expect(
        captured!.components.button.primaryBackground
            .resolve({WidgetState.hovered}),
        const Color(0xFF15803D),
      );
    });

    testWidgets('explicit component override wins after color regeneration',
        (tester) async {
      VThemeData? captured;

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: VTheme(
            data: VThemeData.light(),
            child: VTheme.override(
              colors: (colors) => colors.copyWith(
                actionPrimary: const Color(0xFF16A34A),
              ),
              components: (theme, components) => components.copyWith(
                button: components.button.copyWith(
                  primaryBackground: VStateProperty.states(
                    normal: const Color(0xFF7C3AED),
                  ),
                ),
              ),
              child: Builder(
                builder: (context) {
                  captured = VTheme.of(context);
                  return const SizedBox();
                },
              ),
            ),
          ),
        ),
      );

      expect(
        captured!.components.button.primaryBackground.resolve(<WidgetState>{}),
        const Color(0xFF7C3AED),
      );
    });

    testWidgets('nested overrides compose from the nearest parent theme',
        (tester) async {
      VThemeData? captured;

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: VTheme(
            data: VThemeData.light(),
            child: VTheme.override(
              colors: (colors) => colors.copyWith(
                actionPrimary: const Color(0xFF16A34A),
              ),
              child: VTheme.override(
                spacing: (spacing) => spacing.copyWith(md: 42),
                child: Builder(
                  builder: (context) {
                    captured = VTheme.of(context);
                    return const SizedBox();
                  },
                ),
              ),
            ),
          ),
        ),
      );

      expect(captured!.colors.actionPrimary, const Color(0xFF16A34A));
      expect(captured!.spacing.md, 42);
    });
  });

  group('scoped component theme overrides', () {
    testWidgets('VTokenTheme resolves by token type and composes overrides',
        (tester) async {
      VButtonTokens? button;
      VInputTokens? input;

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: VTheme(
            data: VThemeData.light(),
            child: VTokenTheme<VButtonTokens>(
              data: VThemeData.light().components.button.copyWith(
                    focusRing: const Color(0xFF111111),
                  ),
              child: VTokenTheme.override<VButtonTokens>(
                data: (theme, tokens) => tokens.copyWith(
                  primaryForeground: VStateProperty.states(
                    normal: theme.colors.success,
                  ),
                ),
                fallback: (theme) => theme.components.button,
                child: VTokenTheme.override<VInputTokens>(
                  data: (theme, tokens) => tokens.copyWith(
                    focusRing: theme.colors.success,
                  ),
                  fallback: (theme) => theme.components.input,
                  child: Builder(
                    builder: (context) {
                      button = VTokenTheme.maybeOf<VButtonTokens>(context);
                      input = VTokenTheme.maybeOf<VInputTokens>(context);
                      return const SizedBox();
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      );

      expect(button!.focusRing, const Color(0xFF111111));
      expect(
        button!.primaryForeground.resolve(<WidgetState>{}),
        VThemeData.light().colors.success,
      );
      expect(input!.focusRing, VThemeData.light().colors.success);
    });

    testWidgets('component theme override helpers transform nearest tokens',
        (tester) async {
      final captured = <String, Object?>{};

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: VTheme(
            data: VThemeData.light(),
            child: VSurfaceTheme.override(
              data: (theme, tokens) => tokens.copyWith(
                cardBackground: theme.colors.successSurface,
              ),
              child: VChipTheme.override(
                data: (theme, tokens) => tokens.copyWith(
                  focusRing: theme.colors.success,
                ),
                child: VCheckboxTheme.override(
                  data: (theme, tokens) => tokens.copyWith(
                    focusRing: theme.colors.success,
                  ),
                  child: VRadioTheme.override(
                    data: (theme, tokens) => tokens.copyWith(
                      focusRing: theme.colors.success,
                    ),
                    child: VSwitchTheme.override(
                      data: (theme, tokens) => tokens.copyWith(
                        focusRing: theme.colors.success,
                      ),
                      child: VInputTheme.override(
                        data: (theme, tokens) => tokens.copyWith(
                          focusRing: theme.colors.success,
                        ),
                        child: Builder(
                          builder: (context) {
                            captured['surface'] =
                                VSurfaceTheme.of(context)?.cardBackground;
                            captured['chip'] =
                                VChipTheme.of(context)?.focusRing;
                            captured['checkbox'] =
                                VCheckboxTheme.of(context)?.focusRing;
                            captured['radio'] =
                                VRadioTheme.of(context)?.focusRing;
                            captured['switch'] =
                                VSwitchTheme.of(context)?.focusRing;
                            captured['input'] =
                                VInputTheme.of(context)?.focusRing;
                            return const SizedBox();
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );

      final colors = VThemeData.light().colors;
      expect(captured['surface'], colors.successSurface);
      expect(captured['chip'], colors.success);
      expect(captured['checkbox'], colors.success);
      expect(captured['radio'], colors.success);
      expect(captured['switch'], colors.success);
      expect(captured['input'], colors.success);
    });

    testWidgets('additional component wrappers expose scoped tokens',
        (tester) async {
      final captured = <String, Object?>{};

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: VTheme(
            data: VThemeData.light(),
            child: VAppBarTheme.override(
              data: (theme, tokens) => tokens.copyWith(
                background: theme.colors.successSurface,
              ),
              child: VSelectTheme.override(
                data: (theme, tokens) => tokens.copyWith(
                  focusRing: theme.colors.success,
                ),
                child: VTableTheme.override(
                  data: (theme, tokens) => tokens.copyWith(
                    headerFocusOutlineColor: theme.colors.success,
                  ),
                  child: VDatePickerTheme.override(
                    data: (theme, tokens) => tokens.copyWith(
                      focusOutline: theme.colors.success,
                    ),
                    child: VTimePickerTheme.override(
                      data: (theme, tokens) => tokens.copyWith(
                        selectedForeground: theme.colors.success,
                      ),
                      child: VDialogTheme.override(
                        data: (theme, tokens) => tokens.copyWith(
                          surface: theme.colors.successSurface,
                        ),
                        child: VToastTheme.override(
                          data: (theme, tokens) => tokens.copyWith(
                            successForeground: theme.colors.success,
                          ),
                          child: Builder(
                            builder: (context) {
                              captured['appBar'] =
                                  VAppBarTheme.of(context)?.background;
                              captured['select'] =
                                  VSelectTheme.of(context)?.focusRing;
                              captured['table'] = VTableTheme.of(context)
                                  ?.headerFocusOutlineColor;
                              captured['date'] =
                                  VDatePickerTheme.of(context)?.focusOutline;
                              captured['time'] = VTimePickerTheme.of(context)
                                  ?.selectedForeground;
                              captured['dialog'] =
                                  VDialogTheme.of(context)?.surface;
                              captured['toast'] =
                                  VToastTheme.of(context)?.successForeground;
                              return const SizedBox();
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );

      final colors = VThemeData.light().colors;
      expect(captured['appBar'], colors.successSurface);
      expect(captured['select'], colors.success);
      expect(captured['table'], colors.success);
      expect(captured['date'], colors.success);
      expect(captured['time'], colors.success);
      expect(captured['dialog'], colors.successSurface);
      expect(captured['toast'], colors.success);
    });
  });

  group('VSpacing', () {
    test('defaults produce expected values', () {
      final s = VSpacing.defaults();
      expect(s.xs, 4);
      expect(s.sm, 8);
      expect(s.md, 12);
      expect(s.lg, 16);
      expect(s.xl, 24);
    });

    test('copyWith overrides only specified', () {
      final s = VSpacing.defaults().copyWith(md: 100);
      expect(s.md, 100);
      expect(s.xs, 4); // unchanged
    });
  });

  group('VRadii', () {
    test('defaults produce expected values', () {
      final r = VRadii.defaults();
      expect(r.sm, 4);
      expect(r.md, 8);
      expect(r.lg, 12);
      expect(r.full, 9999);
    });
  });

  group('VComponentTokens', () {
    test('fromColors produces all sub-tokens', () {
      final colors = VColors.light();
      final components = VComponentTokens.fromColors(colors);
      expect(components.button, isA<VButtonTokens>());
      expect(components.checkbox, isA<VCheckboxTokens>());
      expect(components.switch_, isA<VSwitchTokens>());
      expect(components.surface, isA<VSurfaceTokens>());
      expect(components.dialog, isA<VDialogTokens>());
      expect(components.input, isA<VInputTokens>());
    });

    test('lerp delegates to sub-token interpolation', () {
      final a = VComponentTokens.fromColors(VColors.light());
      final b = VComponentTokens.fromColors(VColors.dark());
      final result = VComponentTokens.lerp(a, b, 0.25);

      expect(
        result.surface.baseBackground,
        Color.lerp(a.surface.baseBackground, b.surface.baseBackground, 0.25),
      );
      expect(
        result.input.borderFocused,
        Color.lerp(a.input.borderFocused, b.input.borderFocused, 0.25),
      );
      expect(
        result.dialog.surface,
        Color.lerp(a.dialog.surface, b.dialog.surface, 0.25),
      );
    });

    test('lerp interpolates stateful component token colors', () {
      final a = VComponentTokens.fromColors(VColors.light());
      final b = VComponentTokens.fromColors(VColors.dark());
      final result = VComponentTokens.lerp(a, b, 0.25);
      final states = <WidgetState>{WidgetState.hovered};

      expect(
        result.button.primaryBackground.resolve(states),
        Color.lerp(
          a.button.primaryBackground.resolve(states),
          b.button.primaryBackground.resolve(states),
          0.25,
        ),
      );
      expect(
        result.checkbox.uncheckedBorder.resolve(states),
        Color.lerp(
          a.checkbox.uncheckedBorder.resolve(states),
          b.checkbox.uncheckedBorder.resolve(states),
          0.25,
        ),
      );
      expect(
        result.switch_.trackBackground.resolve(states),
        Color.lerp(
          a.switch_.trackBackground.resolve(states),
          b.switch_.trackBackground.resolve(states),
          0.25,
        ),
      );
    });

    test('teaching tip tokens copy and interpolate layout values', () {
      const a = VTeachingTipTokens(
        gap: 10,
        surfaceWidth: 280,
        margin: 8,
        closeButtonSize: 20,
        titleSubtitleGap: 6,
        contentActionGap: 14,
        actionButtonGap: 6,
      );
      const b = VTeachingTipTokens(
        gap: 18,
        surfaceWidth: 360,
        margin: 16,
        closeButtonSize: 28,
        titleSubtitleGap: 10,
        contentActionGap: 22,
        actionButtonGap: 10,
      );

      final copied = a.copyWith(surfaceWidth: 320);
      final interpolated = VTeachingTipTokens.lerp(a, b, 0.5);

      expect(copied.surfaceWidth, 320);
      expect(copied.gap, a.gap);
      expect(interpolated.gap, 14);
      expect(interpolated.surfaceWidth, 320);
      expect(interpolated.margin, 12);
      expect(interpolated.closeButtonSize, 24);
      expect(interpolated.titleSubtitleGap, 8);
      expect(interpolated.contentActionGap, 18);
      expect(interpolated.actionButtonGap, 8);
    });

    test('menu tokens copy and interpolate overlay layout values', () {
      final a = VComponentTokens.fromColors(VColors.light()).menu;
      final b = a.copyWith(
        width: 260,
        maxHeight: 500,
        backdropOpacity: 0.6,
        liftScaleDelta: 0.08,
        menuScaleBegin: 0.8,
        modernPressedOverlayOpacity: 0.5,
      );

      final copied = a.copyWith(width: 240);
      final interpolated = VMenuTokens.lerp(a, b, 0.5);

      expect(copied.width, 240);
      expect(copied.maxHeight, a.maxHeight);
      expect(interpolated.width, 240);
      expect(interpolated.maxHeight, 450);
      expect(interpolated.backdropOpacity, 0.525);
      expect(interpolated.liftScaleDelta, 0.06);
      expect(interpolated.menuScaleBegin, closeTo(0.85, 0.0001));
      expect(interpolated.modernPressedOverlayOpacity, 0.625);
    });
  });

  group('VMotion', () {
    test('VMotionSpec.copyWith preserves unspecified fields', () {
      const spec = VMotionSpec(
        duration: Duration(milliseconds: 120),
        curve: Curves.easeOut,
        reverseDuration: Duration(milliseconds: 80),
        reverseCurve: Curves.easeIn,
      );

      final updated = spec.copyWith(
        duration: const Duration(milliseconds: 200),
      );

      expect(updated.duration, const Duration(milliseconds: 200));
      expect(updated.curve, spec.curve);
      expect(updated.reverseDuration, spec.reverseDuration);
      expect(updated.reverseCurve, spec.reverseCurve);
    });

    test('VMotionSpec.lerp interpolates durations and hard-cuts curves', () {
      const a = VMotionSpec(
        duration: Duration(milliseconds: 100),
        curve: Curves.easeOut,
        reverseDuration: Duration(milliseconds: 50),
        reverseCurve: Curves.easeIn,
      );
      const b = VMotionSpec(
        duration: Duration(milliseconds: 300),
        curve: Curves.linear,
        reverseDuration: Duration(milliseconds: 150),
        reverseCurve: Curves.easeInOut,
      );

      final early = VMotionSpec.lerp(a, b, 0.25);
      final late = VMotionSpec.lerp(a, b, 0.75);

      expect(early.duration, const Duration(milliseconds: 150));
      expect(early.reverseDuration, const Duration(milliseconds: 75));
      expect(early.curve, Curves.easeOut);
      expect(late.duration, const Duration(milliseconds: 250));
      expect(late.reverseDuration, const Duration(milliseconds: 125));
      expect(late.curve, Curves.linear);
      expect(late.reverseCurve, Curves.easeInOut);
    });

    test('VMotion.lerp includes named specs and reduced motion', () {
      final a = VMotion.defaults();
      final b = VMotion.defaults().copyWith(
        overlay: const VMotionSpec(
          duration: Duration(milliseconds: 620),
          curve: Curves.linear,
        ),
        reducedMotion: true,
      );

      final early = VMotion.lerp(a, b, 0.25);
      final late = VMotion.lerp(a, b, 0.75);

      expect(early.overlay.duration, const Duration(milliseconds: 320));
      expect(early.reducedMotion, isFalse);
      expect(late.overlay.duration, const Duration(milliseconds: 520));
      expect(late.reducedMotion, isTrue);
    });

    testWidgets('VMotionResolver uses theme motion by default', (tester) async {
      final themeMotion = VMotion.defaults().copyWith(
        overlay: const VMotionSpec(
          duration: Duration(milliseconds: 444),
          curve: Curves.easeOut,
        ),
      );
      Duration? resolved;

      await tester.pumpWidget(Directionality(
        textDirection: TextDirection.ltr,
        child: VTheme(
          data: VThemeData.light().copyWith(motion: themeMotion),
          child: Builder(
            builder: (context) {
              resolved = VMotionResolver.duration(
                context,
                VMotionScope.of(context).overlay,
              );
              return const SizedBox.shrink();
            },
          ),
        ),
      ));

      expect(resolved, const Duration(milliseconds: 444));
    });

    testWidgets('VMotionScope overrides theme motion and reduced motion',
        (tester) async {
      final scopedMotion = VMotion.defaults().copyWith(
        reducedMotion: true,
        overlay: const VMotionSpec(
          duration: Duration(milliseconds: 444),
          curve: Curves.easeOut,
        ),
      );
      Duration? resolvedDuration;
      Curve? resolvedCurve;

      await tester.pumpWidget(Directionality(
        textDirection: TextDirection.ltr,
        child: VTheme(
          data: VThemeData.light(),
          child: VMotionScope(
            motion: scopedMotion,
            child: Builder(
              builder: (context) {
                final spec = VMotionScope.of(context).overlay;
                resolvedDuration = VMotionResolver.duration(context, spec);
                resolvedCurve = VMotionResolver.curve(context, spec);
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      ));

      expect(resolvedDuration, Duration.zero);
      expect(resolvedCurve, Curves.linear);
    });
  });
}
