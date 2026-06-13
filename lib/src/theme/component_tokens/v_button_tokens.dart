import 'package:flutter/widgets.dart';

import '../../foundation/radii.dart';
import '../../foundation/semantic_tokens.dart';
import '../../foundation/sizes.dart';
import '../../foundation/state.dart';
import 'component_token_utils.dart';

/// Component-level tokens for buttons.
///
/// All color fields use [WidgetStateProperty] so each state
/// (normal, hovered, pressed, focused, disabled) resolves to
/// the appropriate color.
@immutable
class VButtonTokens {
  factory VButtonTokens.fromColors(VColors colors) =>
      VButtonTokens.fromTheme(colors, VSizes.defaults(), VRadii.defaults());

  /// Create button tokens from theme data using foundation tokens.
  factory VButtonTokens.fromTheme(
    VColors colors,
    VSizes sizes,
    VRadii radii,
  ) {
    return VButtonTokens(
      primaryBackground: VStateProperty.resolveWith(
        normal: colors.actionPrimary,
        hovered: colors.actionPrimaryHover,
        pressed: colors.actionPrimaryPressed,
        disabled: colors.surfaceElevated,
      ),
      primaryForeground: VStateProperty.resolveWith(
        normal: colors.actionPrimaryText,
        disabled: colors.textDisabled,
      ),
      primaryBorder: VStateProperty.resolveWith(
        normal: colors.actionPrimary,
        hovered: colors.actionPrimaryHover,
        pressed: colors.actionPrimaryPressed,
        disabled: colors.surfaceElevated,
      ),
      secondaryBackground: VStateProperty.resolveWith(
        normal: colors.surface,
        hovered: colors.surfaceHover,
        pressed: colors.surfaceElevated,
        disabled: colors.surfaceElevated,
      ),
      secondaryForeground: VStateProperty.resolveWith(
        normal: colors.text,
        disabled: colors.textDisabled,
      ),
      secondaryBorder: VStateProperty.resolveWith(
        normal: colors.border,
        hovered: colors.borderStrong,
        focused: colors.focusRing,
        disabled: colors.border,
      ),
      dangerBackground: VStateProperty.resolveWith(
        normal: colors.danger,
        hovered: colors.dangerHover,
        pressed: colors.dangerHover,
        disabled: colors.surfaceElevated,
      ),
      dangerForeground: VStateProperty.resolveWith(
        normal: colors.actionPrimaryText,
        disabled: colors.textDisabled,
      ),
      dangerBorder: VStateProperty.resolveWith(
        normal: colors.danger,
        hovered: colors.dangerHover,
        pressed: colors.dangerHover,
        disabled: colors.surfaceElevated,
      ),
      focusRing: colors.focusRing,
      // Use foundation tokens instead of hardcoded values
      heightSm: sizes.controlSm,
      heightMd: sizes.controlMd,
      heightLg: sizes.controlLg,
      paddingHorizontalSm: sizes.buttonPaddingHorizontalSm,
      paddingHorizontalMd: sizes.buttonPaddingHorizontalMd,
      paddingHorizontalLg: sizes.buttonPaddingHorizontalLg,
      paddingVerticalSm: sizes.buttonPaddingVerticalSm,
      paddingVerticalMd: sizes.buttonPaddingVerticalMd,
      paddingVerticalLg: sizes.buttonPaddingVerticalLg,
      iconSizeSm: sizes.iconSm,
      iconSizeMd: sizes.iconMd,
      iconSizeLg: sizes.iconLg,
      radius: radii.md,
    );
  }

  const VButtonTokens({
    required this.primaryBackground,
    required this.primaryForeground,
    required this.primaryBorder,
    required this.secondaryBackground,
    required this.secondaryForeground,
    required this.secondaryBorder,
    required this.dangerBackground,
    required this.dangerForeground,
    required this.dangerBorder,
    required this.focusRing,
    required this.heightSm,
    required this.heightMd,
    required this.heightLg,
    required this.paddingHorizontalSm,
    required this.paddingHorizontalMd,
    required this.paddingHorizontalLg,
    required this.paddingVerticalSm,
    required this.paddingVerticalMd,
    required this.paddingVerticalLg,
    required this.iconSizeSm,
    required this.iconSizeMd,
    required this.iconSizeLg,
    required this.radius,
  });

  final WidgetStateProperty<Color> primaryBackground;
  final WidgetStateProperty<Color> primaryForeground;
  final WidgetStateProperty<Color> primaryBorder;

  final WidgetStateProperty<Color> secondaryBackground;
  final WidgetStateProperty<Color> secondaryForeground;
  final WidgetStateProperty<Color> secondaryBorder;

  final WidgetStateProperty<Color> dangerBackground;
  final WidgetStateProperty<Color> dangerForeground;
  final WidgetStateProperty<Color> dangerBorder;
  final Color focusRing;
  final double heightSm;
  final double heightMd;
  final double heightLg;
  final double paddingHorizontalSm;
  final double paddingHorizontalMd;
  final double paddingHorizontalLg;
  final double paddingVerticalSm;
  final double paddingVerticalMd;
  final double paddingVerticalLg;
  final double iconSizeSm;
  final double iconSizeMd;
  final double iconSizeLg;
  final double radius;

  static VButtonTokens lerp(VButtonTokens a, VButtonTokens b, double t) {
    return VButtonTokens(
      primaryBackground: lerpComponentTokenStateColor(
          a.primaryBackground, b.primaryBackground, t),
      primaryForeground: lerpComponentTokenStateColor(
          a.primaryForeground, b.primaryForeground, t),
      primaryBorder:
          lerpComponentTokenStateColor(a.primaryBorder, b.primaryBorder, t),
      secondaryBackground: lerpComponentTokenStateColor(
          a.secondaryBackground, b.secondaryBackground, t),
      secondaryForeground: lerpComponentTokenStateColor(
          a.secondaryForeground, b.secondaryForeground, t),
      secondaryBorder:
          lerpComponentTokenStateColor(a.secondaryBorder, b.secondaryBorder, t),
      dangerBackground: lerpComponentTokenStateColor(
          a.dangerBackground, b.dangerBackground, t),
      dangerForeground: lerpComponentTokenStateColor(
          a.dangerForeground, b.dangerForeground, t),
      dangerBorder:
          lerpComponentTokenStateColor(a.dangerBorder, b.dangerBorder, t),
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
      paddingVerticalSm:
          lerpComponentTokenDouble(a.paddingVerticalSm, b.paddingVerticalSm, t),
      paddingVerticalMd:
          lerpComponentTokenDouble(a.paddingVerticalMd, b.paddingVerticalMd, t),
      paddingVerticalLg:
          lerpComponentTokenDouble(a.paddingVerticalLg, b.paddingVerticalLg, t),
      iconSizeSm: lerpComponentTokenDouble(a.iconSizeSm, b.iconSizeSm, t),
      iconSizeMd: lerpComponentTokenDouble(a.iconSizeMd, b.iconSizeMd, t),
      iconSizeLg: lerpComponentTokenDouble(a.iconSizeLg, b.iconSizeLg, t),
      radius: lerpComponentTokenDouble(a.radius, b.radius, t),
    );
  }

  VButtonTokens copyWith({
    WidgetStateProperty<Color>? primaryBackground,
    WidgetStateProperty<Color>? primaryForeground,
    WidgetStateProperty<Color>? primaryBorder,
    WidgetStateProperty<Color>? secondaryBackground,
    WidgetStateProperty<Color>? secondaryForeground,
    WidgetStateProperty<Color>? secondaryBorder,
    WidgetStateProperty<Color>? dangerBackground,
    WidgetStateProperty<Color>? dangerForeground,
    WidgetStateProperty<Color>? dangerBorder,
    Color? focusRing,
    double? heightSm,
    double? heightMd,
    double? heightLg,
    double? paddingHorizontalSm,
    double? paddingHorizontalMd,
    double? paddingHorizontalLg,
    double? paddingVerticalSm,
    double? paddingVerticalMd,
    double? paddingVerticalLg,
    double? iconSizeSm,
    double? iconSizeMd,
    double? iconSizeLg,
    double? radius,
  }) {
    return VButtonTokens(
      primaryBackground: primaryBackground ?? this.primaryBackground,
      primaryForeground: primaryForeground ?? this.primaryForeground,
      primaryBorder: primaryBorder ?? this.primaryBorder,
      secondaryBackground: secondaryBackground ?? this.secondaryBackground,
      secondaryForeground: secondaryForeground ?? this.secondaryForeground,
      secondaryBorder: secondaryBorder ?? this.secondaryBorder,
      dangerBackground: dangerBackground ?? this.dangerBackground,
      dangerForeground: dangerForeground ?? this.dangerForeground,
      dangerBorder: dangerBorder ?? this.dangerBorder,
      focusRing: focusRing ?? this.focusRing,
      heightSm: heightSm ?? this.heightSm,
      heightMd: heightMd ?? this.heightMd,
      heightLg: heightLg ?? this.heightLg,
      paddingHorizontalSm: paddingHorizontalSm ?? this.paddingHorizontalSm,
      paddingHorizontalMd: paddingHorizontalMd ?? this.paddingHorizontalMd,
      paddingHorizontalLg: paddingHorizontalLg ?? this.paddingHorizontalLg,
      paddingVerticalSm: paddingVerticalSm ?? this.paddingVerticalSm,
      paddingVerticalMd: paddingVerticalMd ?? this.paddingVerticalMd,
      paddingVerticalLg: paddingVerticalLg ?? this.paddingVerticalLg,
      iconSizeSm: iconSizeSm ?? this.iconSizeSm,
      iconSizeMd: iconSizeMd ?? this.iconSizeMd,
      iconSizeLg: iconSizeLg ?? this.iconSizeLg,
      radius: radius ?? this.radius,
    );
  }
}
