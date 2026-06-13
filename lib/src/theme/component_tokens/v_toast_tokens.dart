import 'package:flutter/widgets.dart';

import '../../foundation/semantic_tokens.dart';
import 'component_token_utils.dart';

/// Component-level tokens for toast overlays.
@immutable
class VToastTokens {
  factory VToastTokens.fromColors(VColors colors) {
    return VToastTokens(
      infoBackground: colors.surfaceElevated,
      infoForeground: colors.text,
      successBackground: colors.successSurface,
      successForeground: colors.success,
      warningBackground: colors.warning.withValues(alpha: 0.12),
      warningForeground: colors.warning,
      errorBackground: colors.dangerSurface,
      errorForeground: colors.danger,
      borderColor: colors.border,
      borderWidth: 1.0,
      shadow: const BoxShadow(
        color: Color(0x1F000000),
        blurRadius: 20,
        spreadRadius: -4,
        offset: Offset(0, 8),
      ),
    );
  }

  const VToastTokens({
    this.infoBackground = const Color(0xFFF3F4F6),
    this.infoForeground = const Color(0xFF111827),
    this.successBackground = const Color(0xFFF0FDF4),
    this.successForeground = const Color(0xFF16A34A),
    this.warningBackground = const Color(0x1FD97706),
    this.warningForeground = const Color(0xFFD97706),
    this.errorBackground = const Color(0xFFFEF2F2),
    this.errorForeground = const Color(0xFFEF4444),
    this.borderColor = const Color(0xFFE5E7EB),
    this.shadow = const BoxShadow(
      color: Color(0x1F000000),
      blurRadius: 20,
      spreadRadius: -4,
      offset: Offset(0, 8),
    ),
    this.horizontalInset = 24,
    this.verticalInset = 24,
    this.slideOffsetY = 0.2,
    this.paddingHorizontal = 16,
    this.paddingVertical = 10,
    this.radius = 12,
    this.borderWidth = 1,
    this.iconSize = 20,
    this.textSize = 14,
    this.spacing = 8,
  });

  final Color infoBackground;
  final Color infoForeground;
  final Color successBackground;
  final Color successForeground;
  final Color warningBackground;
  final Color warningForeground;
  final Color errorBackground;
  final Color errorForeground;
  final Color borderColor;
  final BoxShadow? shadow;
  final double horizontalInset;
  final double verticalInset;
  final double slideOffsetY;
  final double paddingHorizontal;
  final double paddingVertical;
  final double radius;
  final double borderWidth;
  final double iconSize;
  final double textSize;
  final double spacing;

  static VToastTokens lerp(VToastTokens a, VToastTokens b, double t) {
    return VToastTokens(
      infoBackground:
          lerpComponentTokenColor(a.infoBackground, b.infoBackground, t),
      infoForeground:
          lerpComponentTokenColor(a.infoForeground, b.infoForeground, t),
      successBackground:
          lerpComponentTokenColor(a.successBackground, b.successBackground, t),
      successForeground:
          lerpComponentTokenColor(a.successForeground, b.successForeground, t),
      warningBackground:
          lerpComponentTokenColor(a.warningBackground, b.warningBackground, t),
      warningForeground:
          lerpComponentTokenColor(a.warningForeground, b.warningForeground, t),
      errorBackground:
          lerpComponentTokenColor(a.errorBackground, b.errorBackground, t),
      errorForeground:
          lerpComponentTokenColor(a.errorForeground, b.errorForeground, t),
      borderColor: lerpComponentTokenColor(a.borderColor, b.borderColor, t),
      shadow: BoxShadow.lerp(a.shadow, b.shadow, t),
      horizontalInset:
          lerpComponentTokenDouble(a.horizontalInset, b.horizontalInset, t),
      verticalInset:
          lerpComponentTokenDouble(a.verticalInset, b.verticalInset, t),
      slideOffsetY: lerpComponentTokenDouble(a.slideOffsetY, b.slideOffsetY, t),
      paddingHorizontal:
          lerpComponentTokenDouble(a.paddingHorizontal, b.paddingHorizontal, t),
      paddingVertical:
          lerpComponentTokenDouble(a.paddingVertical, b.paddingVertical, t),
      radius: lerpComponentTokenDouble(a.radius, b.radius, t),
      borderWidth: lerpComponentTokenDouble(a.borderWidth, b.borderWidth, t),
      iconSize: lerpComponentTokenDouble(a.iconSize, b.iconSize, t),
      textSize: lerpComponentTokenDouble(a.textSize, b.textSize, t),
      spacing: lerpComponentTokenDouble(a.spacing, b.spacing, t),
    );
  }

  VToastTokens copyWith({
    Color? infoBackground,
    Color? infoForeground,
    Color? successBackground,
    Color? successForeground,
    Color? warningBackground,
    Color? warningForeground,
    Color? errorBackground,
    Color? errorForeground,
    Color? borderColor,
    BoxShadow? shadow,
    double? horizontalInset,
    double? verticalInset,
    double? slideOffsetY,
    double? paddingHorizontal,
    double? paddingVertical,
    double? radius,
    double? borderWidth,
    double? iconSize,
    double? textSize,
    double? spacing,
  }) {
    return VToastTokens(
      infoBackground: infoBackground ?? this.infoBackground,
      infoForeground: infoForeground ?? this.infoForeground,
      successBackground: successBackground ?? this.successBackground,
      successForeground: successForeground ?? this.successForeground,
      warningBackground: warningBackground ?? this.warningBackground,
      warningForeground: warningForeground ?? this.warningForeground,
      errorBackground: errorBackground ?? this.errorBackground,
      errorForeground: errorForeground ?? this.errorForeground,
      borderColor: borderColor ?? this.borderColor,
      shadow: shadow ?? this.shadow,
      horizontalInset: horizontalInset ?? this.horizontalInset,
      verticalInset: verticalInset ?? this.verticalInset,
      slideOffsetY: slideOffsetY ?? this.slideOffsetY,
      paddingHorizontal: paddingHorizontal ?? this.paddingHorizontal,
      paddingVertical: paddingVertical ?? this.paddingVertical,
      radius: radius ?? this.radius,
      borderWidth: borderWidth ?? this.borderWidth,
      iconSize: iconSize ?? this.iconSize,
      textSize: textSize ?? this.textSize,
      spacing: spacing ?? this.spacing,
    );
  }
}
