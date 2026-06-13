import 'package:flutter/widgets.dart';

import '../../foundation/semantic_tokens.dart';
import '../../foundation/state.dart';
import 'component_token_utils.dart';

/// Component-level tokens for segmented controls.
@immutable
class VSegmentedControlTokens {
  factory VSegmentedControlTokens.fromColors(VColors colors) {
    return VSegmentedControlTokens(
      background: VStateProperty.resolveWith(
        normal: colors.surfaceElevated,
        disabled: colors.surface,
      ),
      border: VStateProperty.resolveWith(
        normal: colors.border,
        disabled: colors.border,
      ),
      indicatorBackground: VStateProperty.resolveWith(
        normal: colors.surface,
        disabled: colors.surfaceElevated,
      ),
      indicatorShadow: const [
        BoxShadow(
          color: Color(0x12000000),
          blurRadius: 4.0,
          offset: Offset(0.0, 1.5),
        ),
      ],
      foreground: VStateProperty.resolveWith(
        normal: colors.textMuted,
        selected: colors.text,
        disabled: colors.textDisabled,
      ),
      focusRing: colors.focusRing,
      radius: 8.0,
      indicatorRadius: 6.0,
      heightSm: 28.0,
      heightMd: 36.0,
      heightLg: 44.0,
      paddingHorizontalSm: 2.0,
      paddingHorizontalMd: 3.0,
      paddingHorizontalLg: 4.0,
    );
  }

  const VSegmentedControlTokens({
    required this.background,
    required this.border,
    required this.indicatorBackground,
    required this.indicatorShadow,
    required this.foreground,
    required this.focusRing,
    required this.radius,
    required this.indicatorRadius,
    required this.heightSm,
    required this.heightMd,
    required this.heightLg,
    required this.paddingHorizontalSm,
    required this.paddingHorizontalMd,
    required this.paddingHorizontalLg,
  });

  final WidgetStateProperty<Color> background;
  final WidgetStateProperty<Color> border;
  final WidgetStateProperty<Color> indicatorBackground;
  final List<BoxShadow> indicatorShadow;
  final WidgetStateProperty<Color> foreground;
  final Color focusRing;
  final double radius;
  final double indicatorRadius;
  final double heightSm;
  final double heightMd;
  final double heightLg;
  final double paddingHorizontalSm;
  final double paddingHorizontalMd;
  final double paddingHorizontalLg;

  static VSegmentedControlTokens lerp(
    VSegmentedControlTokens a,
    VSegmentedControlTokens b,
    double t,
  ) {
    return VSegmentedControlTokens(
      background: lerpComponentTokenStateColor(a.background, b.background, t),
      border: lerpComponentTokenStateColor(a.border, b.border, t),
      indicatorBackground: lerpComponentTokenStateColor(
        a.indicatorBackground,
        b.indicatorBackground,
        t,
      ),
      indicatorShadow: t < 0.5 ? a.indicatorShadow : b.indicatorShadow,
      foreground: lerpComponentTokenStateColor(a.foreground, b.foreground, t),
      focusRing: lerpComponentTokenColor(a.focusRing, b.focusRing, t),
      radius: lerpComponentTokenDouble(a.radius, b.radius, t),
      indicatorRadius:
          lerpComponentTokenDouble(a.indicatorRadius, b.indicatorRadius, t),
      heightSm: lerpComponentTokenDouble(a.heightSm, b.heightSm, t),
      heightMd: lerpComponentTokenDouble(a.heightMd, b.heightMd, t),
      heightLg: lerpComponentTokenDouble(a.heightLg, b.heightLg, t),
      paddingHorizontalSm: lerpComponentTokenDouble(
          a.paddingHorizontalSm, b.paddingHorizontalSm, t),
      paddingHorizontalMd: lerpComponentTokenDouble(
          a.paddingHorizontalMd, b.paddingHorizontalMd, t),
      paddingHorizontalLg: lerpComponentTokenDouble(
          a.paddingHorizontalLg, b.paddingHorizontalLg, t),
    );
  }

  VSegmentedControlTokens copyWith({
    WidgetStateProperty<Color>? background,
    WidgetStateProperty<Color>? border,
    WidgetStateProperty<Color>? indicatorBackground,
    List<BoxShadow>? indicatorShadow,
    WidgetStateProperty<Color>? foreground,
    Color? focusRing,
    double? radius,
    double? indicatorRadius,
    double? heightSm,
    double? heightMd,
    double? heightLg,
    double? paddingHorizontalSm,
    double? paddingHorizontalMd,
    double? paddingHorizontalLg,
  }) {
    return VSegmentedControlTokens(
      background: background ?? this.background,
      border: border ?? this.border,
      indicatorBackground: indicatorBackground ?? this.indicatorBackground,
      indicatorShadow: indicatorShadow ?? this.indicatorShadow,
      foreground: foreground ?? this.foreground,
      focusRing: focusRing ?? this.focusRing,
      radius: radius ?? this.radius,
      indicatorRadius: indicatorRadius ?? this.indicatorRadius,
      heightSm: heightSm ?? this.heightSm,
      heightMd: heightMd ?? this.heightMd,
      heightLg: heightLg ?? this.heightLg,
      paddingHorizontalSm: paddingHorizontalSm ?? this.paddingHorizontalSm,
      paddingHorizontalMd: paddingHorizontalMd ?? this.paddingHorizontalMd,
      paddingHorizontalLg: paddingHorizontalLg ?? this.paddingHorizontalLg,
    );
  }
}
