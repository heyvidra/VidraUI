import 'package:flutter/widgets.dart';

import '../../foundation/semantic_tokens.dart';
import '../../foundation/state.dart';
import 'component_token_utils.dart';

/// Component-level tokens for chips.
@immutable
class VChipTokens {
  factory VChipTokens.fromColors(VColors colors) {
    return VChipTokens(
      background: VStateProperty.resolveWith(
        normal: colors.surfaceElevated,
        hovered: colors.surfaceHover,
        pressed: colors.surfaceHover,
        selected: colors.actionPrimary,
        disabled: colors.surfaceElevated,
      ),
      foreground: VStateProperty.resolveWith(
        normal: colors.text,
        selected: colors.actionPrimaryText,
        disabled: colors.textDisabled,
      ),
      border: VStateProperty.resolveWith(
        normal: colors.border,
        hovered: colors.borderStrong,
        focused: colors.focusRing,
        selected: colors.actionPrimary,
        disabled: colors.border,
      ),
      focusRing: colors.focusRing,
      heightSm: 28,
      heightMd: 32,
      heightLg: 40,
      paddingHorizontalSm: 8,
      paddingHorizontalMd: 12,
      paddingHorizontalLg: 16,
      gap: 6,
      radius: 999,
      iconSizeSm: 14,
      iconSizeMd: 16,
      iconSizeLg: 18,
    );
  }

  const VChipTokens({
    required this.background,
    required this.foreground,
    required this.border,
    required this.focusRing,
    required this.heightSm,
    required this.heightMd,
    required this.heightLg,
    required this.paddingHorizontalSm,
    required this.paddingHorizontalMd,
    required this.paddingHorizontalLg,
    required this.gap,
    required this.radius,
    required this.iconSizeSm,
    required this.iconSizeMd,
    required this.iconSizeLg,
  });

  final WidgetStateProperty<Color> background;
  final WidgetStateProperty<Color> foreground;
  final WidgetStateProperty<Color> border;
  final Color focusRing;
  final double heightSm;
  final double heightMd;
  final double heightLg;
  final double paddingHorizontalSm;
  final double paddingHorizontalMd;
  final double paddingHorizontalLg;
  final double gap;
  final double radius;
  final double iconSizeSm;
  final double iconSizeMd;
  final double iconSizeLg;

  static VChipTokens lerp(VChipTokens a, VChipTokens b, double t) {
    return VChipTokens(
      background: lerpComponentTokenStateColor(a.background, b.background, t),
      foreground: lerpComponentTokenStateColor(a.foreground, b.foreground, t),
      border: lerpComponentTokenStateColor(a.border, b.border, t),
      focusRing: lerpComponentTokenColor(a.focusRing, b.focusRing, t),
      heightSm: lerpComponentTokenDouble(a.heightSm, b.heightSm, t),
      heightMd: lerpComponentTokenDouble(a.heightMd, b.heightMd, t),
      heightLg: lerpComponentTokenDouble(a.heightLg, b.heightLg, t),
      paddingHorizontalSm: lerpComponentTokenDouble(
          a.paddingHorizontalSm, b.paddingHorizontalSm, t),
      paddingHorizontalMd: lerpComponentTokenDouble(
          a.paddingHorizontalMd, b.paddingHorizontalMd, t),
      paddingHorizontalLg: lerpComponentTokenDouble(
          a.paddingHorizontalLg, b.paddingHorizontalLg, t),
      gap: lerpComponentTokenDouble(a.gap, b.gap, t),
      radius: lerpComponentTokenDouble(a.radius, b.radius, t),
      iconSizeSm: lerpComponentTokenDouble(a.iconSizeSm, b.iconSizeSm, t),
      iconSizeMd: lerpComponentTokenDouble(a.iconSizeMd, b.iconSizeMd, t),
      iconSizeLg: lerpComponentTokenDouble(a.iconSizeLg, b.iconSizeLg, t),
    );
  }

  VChipTokens copyWith({
    WidgetStateProperty<Color>? background,
    WidgetStateProperty<Color>? foreground,
    WidgetStateProperty<Color>? border,
    Color? focusRing,
    double? heightSm,
    double? heightMd,
    double? heightLg,
    double? paddingHorizontalSm,
    double? paddingHorizontalMd,
    double? paddingHorizontalLg,
    double? gap,
    double? radius,
    double? iconSizeSm,
    double? iconSizeMd,
    double? iconSizeLg,
  }) {
    return VChipTokens(
      background: background ?? this.background,
      foreground: foreground ?? this.foreground,
      border: border ?? this.border,
      focusRing: focusRing ?? this.focusRing,
      heightSm: heightSm ?? this.heightSm,
      heightMd: heightMd ?? this.heightMd,
      heightLg: heightLg ?? this.heightLg,
      paddingHorizontalSm: paddingHorizontalSm ?? this.paddingHorizontalSm,
      paddingHorizontalMd: paddingHorizontalMd ?? this.paddingHorizontalMd,
      paddingHorizontalLg: paddingHorizontalLg ?? this.paddingHorizontalLg,
      gap: gap ?? this.gap,
      radius: radius ?? this.radius,
      iconSizeSm: iconSizeSm ?? this.iconSizeSm,
      iconSizeMd: iconSizeMd ?? this.iconSizeMd,
      iconSizeLg: iconSizeLg ?? this.iconSizeLg,
    );
  }
}
