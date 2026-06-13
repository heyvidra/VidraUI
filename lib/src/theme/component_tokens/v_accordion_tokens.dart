import 'package:flutter/widgets.dart';

import '../../foundation/radii.dart';
import '../../foundation/semantic_tokens.dart';
import '../../foundation/spacing.dart';
import '../../foundation/state.dart';
import 'component_token_utils.dart';

/// Component-level tokens for accordions.
@immutable
class VAccordionTokens {
  factory VAccordionTokens.fromColors(VColors colors) {
    return VAccordionTokens(
      headerBackground: VStateProperty.resolveWith(
        normal: colors.surface,
        hovered: colors.surfaceHover,
        pressed: colors.surfaceElevated,
        disabled: colors.surface,
      ),
      headerForeground: VStateProperty.resolveWith(
        normal: colors.text,
        disabled: colors.textDisabled,
      ),
      headerBorder: VStateProperty.resolveWith(
        normal: colors.border,
        disabled: colors.border,
      ),
      bodyBackground: colors.surface,
      focusRing: colors.focusRing,
      radius: 8.0,
      headerPadding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      bodyPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    );
  }

  /// Create accordion tokens from theme data using foundation tokens.
  factory VAccordionTokens.fromTheme({
    required VColors colors,
    required VSpacing spacing,
    required VRadii radii,
  }) {
    return VAccordionTokens(
      headerBackground: VStateProperty.resolveWith(
        normal: colors.surface,
        hovered: colors.surfaceHover,
        pressed: colors.surfaceElevated,
        disabled: colors.surface,
      ),
      headerForeground: VStateProperty.resolveWith(
        normal: colors.text,
        disabled: colors.textDisabled,
      ),
      headerBorder: VStateProperty.resolveWith(
        normal: colors.border,
        disabled: colors.border,
      ),
      bodyBackground: colors.surface,
      focusRing: colors.focusRing,
      radius: radii.md,
      headerPadding: EdgeInsets.symmetric(
        horizontal: spacing.lg,   // 16.0
        vertical: spacing.md,     // 12.0
      ),
      bodyPadding: EdgeInsets.symmetric(
        horizontal: spacing.lg,   // 16.0
        vertical: spacing.md,     // 12.0
      ),
    );
  }

  const VAccordionTokens({
    required this.headerBackground,
    required this.headerForeground,
    required this.headerBorder,
    required this.bodyBackground,
    required this.focusRing,
    required this.radius,
    required this.headerPadding,
    required this.bodyPadding,
  });

  final WidgetStateProperty<Color> headerBackground;
  final WidgetStateProperty<Color> headerForeground;
  final WidgetStateProperty<Color> headerBorder;
  final Color bodyBackground;
  final Color focusRing;
  final double radius;
  final EdgeInsetsGeometry headerPadding;
  final EdgeInsetsGeometry bodyPadding;

  static VAccordionTokens lerp(
    VAccordionTokens a,
    VAccordionTokens b,
    double t,
  ) {
    return VAccordionTokens(
      headerBackground: lerpComponentTokenStateColor(
        a.headerBackground,
        b.headerBackground,
        t,
      ),
      headerForeground: lerpComponentTokenStateColor(
        a.headerForeground,
        b.headerForeground,
        t,
      ),
      headerBorder:
          lerpComponentTokenStateColor(a.headerBorder, b.headerBorder, t),
      bodyBackground:
          lerpComponentTokenColor(a.bodyBackground, b.bodyBackground, t),
      focusRing: lerpComponentTokenColor(a.focusRing, b.focusRing, t),
      radius: lerpComponentTokenDouble(a.radius, b.radius, t),
      headerPadding: t < 0.5 ? a.headerPadding : b.headerPadding,
      bodyPadding: t < 0.5 ? a.bodyPadding : b.bodyPadding,
    );
  }

  VAccordionTokens copyWith({
    WidgetStateProperty<Color>? headerBackground,
    WidgetStateProperty<Color>? headerForeground,
    WidgetStateProperty<Color>? headerBorder,
    Color? bodyBackground,
    Color? focusRing,
    double? radius,
    EdgeInsetsGeometry? headerPadding,
    EdgeInsetsGeometry? bodyPadding,
  }) {
    return VAccordionTokens(
      headerBackground: headerBackground ?? this.headerBackground,
      headerForeground: headerForeground ?? this.headerForeground,
      headerBorder: headerBorder ?? this.headerBorder,
      bodyBackground: bodyBackground ?? this.bodyBackground,
      focusRing: focusRing ?? this.focusRing,
      radius: radius ?? this.radius,
      headerPadding: headerPadding ?? this.headerPadding,
      bodyPadding: bodyPadding ?? this.bodyPadding,
    );
  }
}
