import 'package:flutter/widgets.dart';

import '../../foundation/semantic_tokens.dart';
import '../../foundation/state.dart';
import 'component_token_utils.dart';

/// Component-level tokens for bottom navigation bars.
@immutable
class VNavigationBarTokens {
  factory VNavigationBarTokens.fromColors(VColors colors) {
    return VNavigationBarTokens(
      background: colors.surface,
      border: colors.border,
      shadow: const [
        BoxShadow(
          color: Color(0x1A000000),
          blurRadius: 8.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
      foreground: VStateProperty.resolveWith(
        normal: colors.textMuted,
        selected: colors.actionPrimary,
        hovered: colors.text,
        focused: colors.text,
        disabled: colors.textDisabled,
      ),
      indicatorBackground: VStateProperty.resolveWith(
        normal: colors.actionPrimary.withValues(alpha: 0.12),
        disabled: colors.surfaceElevated,
      ),
      focusRing: colors.focusRing,
      height: 64.0,
      iconSize: 24.0,
      iconLabelSpacing: 4.0,
      horizontalPadding: 0.0,
      indicatorRadius: 16.0,
      indicatorHorizontalInset: 4.0,
      borderRadius: 0.0,
      horizontalMargin: 0.0,
      bottomMargin: 0.0,
      indicatorDotSize: 5.0,
      indicatorTopLineHeight: 4.0,
      iconsOnlyHeight: 52.0,
      labelsOnlyHeight: 48.0,
      centerFabSize: 56.0,
      centerFabBackground: colors.actionPrimary,
      centerFabForeground: colors.actionPrimaryText,
      centerFabElevation: 6.0,
      notchMargin: 6.0,
    );
  }

  const VNavigationBarTokens({
    required this.background,
    required this.border,
    this.shadow = const [],
    required this.foreground,
    required this.indicatorBackground,
    required this.focusRing,
    required this.height,
    required this.iconSize,
    required this.iconLabelSpacing,
    required this.horizontalPadding,
    required this.indicatorRadius,
    required this.indicatorHorizontalInset,
    this.borderRadius = 0.0,
    this.horizontalMargin = 0.0,
    this.bottomMargin = 0.0,
    this.indicatorDotSize = 4.0,
    this.indicatorTopLineHeight = 3.0,
    this.iconsOnlyHeight = 56.0,
    this.labelsOnlyHeight = 48.0,
    this.centerFabSize = 56.0,
    this.centerFabBackground = const Color(0xFF3B82F6),
    this.centerFabForeground = const Color(0xFFFEFBFF),
    this.centerFabElevation = 6.0,
    this.notchMargin = 6.0,
  });

  final Color background;
  final Color border;
  final List<BoxShadow> shadow;
  final WidgetStateProperty<Color> foreground;
  final WidgetStateProperty<Color> indicatorBackground;
  final Color focusRing;
  final double height;
  final double iconSize;
  final double iconLabelSpacing;
  final double horizontalPadding;
  final double indicatorRadius;
  final double indicatorHorizontalInset;

  // Shape
  final double borderRadius;
  final double horizontalMargin;
  final double bottomMargin;

  // Indicator
  final double indicatorDotSize;
  final double indicatorTopLineHeight;

  // Content modes
  final double iconsOnlyHeight;
  final double labelsOnlyHeight;

  // Center FAB
  final double centerFabSize;
  final Color centerFabBackground;
  final Color centerFabForeground;
  final double centerFabElevation;
  final double notchMargin;

  static VNavigationBarTokens lerp(
    VNavigationBarTokens a,
    VNavigationBarTokens b,
    double t,
  ) {
    return VNavigationBarTokens(
      background: lerpComponentTokenColor(a.background, b.background, t),
      border: lerpComponentTokenColor(a.border, b.border, t),
      shadow: t < 0.5 ? a.shadow : b.shadow,
      foreground: lerpComponentTokenStateColor(a.foreground, b.foreground, t),
      indicatorBackground: lerpComponentTokenStateColor(
        a.indicatorBackground,
        b.indicatorBackground,
        t,
      ),
      focusRing: lerpComponentTokenColor(a.focusRing, b.focusRing, t),
      height: lerpComponentTokenDouble(a.height, b.height, t),
      iconSize: lerpComponentTokenDouble(a.iconSize, b.iconSize, t),
      iconLabelSpacing:
          lerpComponentTokenDouble(a.iconLabelSpacing, b.iconLabelSpacing, t),
      horizontalPadding:
          lerpComponentTokenDouble(a.horizontalPadding, b.horizontalPadding, t),
      indicatorRadius:
          lerpComponentTokenDouble(a.indicatorRadius, b.indicatorRadius, t),
      indicatorHorizontalInset: lerpComponentTokenDouble(
        a.indicatorHorizontalInset,
        b.indicatorHorizontalInset,
        t,
      ),
      borderRadius: lerpComponentTokenDouble(a.borderRadius, b.borderRadius, t),
      horizontalMargin:
          lerpComponentTokenDouble(a.horizontalMargin, b.horizontalMargin, t),
      bottomMargin: lerpComponentTokenDouble(a.bottomMargin, b.bottomMargin, t),
      indicatorDotSize:
          lerpComponentTokenDouble(a.indicatorDotSize, b.indicatorDotSize, t),
      indicatorTopLineHeight: lerpComponentTokenDouble(
        a.indicatorTopLineHeight,
        b.indicatorTopLineHeight,
        t,
      ),
      iconsOnlyHeight:
          lerpComponentTokenDouble(a.iconsOnlyHeight, b.iconsOnlyHeight, t),
      labelsOnlyHeight:
          lerpComponentTokenDouble(a.labelsOnlyHeight, b.labelsOnlyHeight, t),
      centerFabSize:
          lerpComponentTokenDouble(a.centerFabSize, b.centerFabSize, t),
      centerFabBackground: lerpComponentTokenColor(
        a.centerFabBackground,
        b.centerFabBackground,
        t,
      ),
      centerFabForeground: lerpComponentTokenColor(
        a.centerFabForeground,
        b.centerFabForeground,
        t,
      ),
      centerFabElevation: lerpComponentTokenDouble(
        a.centerFabElevation,
        b.centerFabElevation,
        t,
      ),
      notchMargin: lerpComponentTokenDouble(a.notchMargin, b.notchMargin, t),
    );
  }

  VNavigationBarTokens copyWith({
    Color? background,
    Color? border,
    List<BoxShadow>? shadow,
    WidgetStateProperty<Color>? foreground,
    WidgetStateProperty<Color>? indicatorBackground,
    Color? focusRing,
    double? height,
    double? iconSize,
    double? iconLabelSpacing,
    double? horizontalPadding,
    double? indicatorRadius,
    double? indicatorHorizontalInset,
    double? borderRadius,
    double? horizontalMargin,
    double? bottomMargin,
    double? indicatorDotSize,
    double? indicatorTopLineHeight,
    double? iconsOnlyHeight,
    double? labelsOnlyHeight,
    double? centerFabSize,
    Color? centerFabBackground,
    Color? centerFabForeground,
    double? centerFabElevation,
    double? notchMargin,
  }) {
    return VNavigationBarTokens(
      background: background ?? this.background,
      border: border ?? this.border,
      shadow: shadow ?? this.shadow,
      foreground: foreground ?? this.foreground,
      indicatorBackground: indicatorBackground ?? this.indicatorBackground,
      focusRing: focusRing ?? this.focusRing,
      height: height ?? this.height,
      iconSize: iconSize ?? this.iconSize,
      iconLabelSpacing: iconLabelSpacing ?? this.iconLabelSpacing,
      horizontalPadding: horizontalPadding ?? this.horizontalPadding,
      indicatorRadius: indicatorRadius ?? this.indicatorRadius,
      indicatorHorizontalInset:
          indicatorHorizontalInset ?? this.indicatorHorizontalInset,
      borderRadius: borderRadius ?? this.borderRadius,
      horizontalMargin: horizontalMargin ?? this.horizontalMargin,
      bottomMargin: bottomMargin ?? this.bottomMargin,
      indicatorDotSize: indicatorDotSize ?? this.indicatorDotSize,
      indicatorTopLineHeight:
          indicatorTopLineHeight ?? this.indicatorTopLineHeight,
      iconsOnlyHeight: iconsOnlyHeight ?? this.iconsOnlyHeight,
      labelsOnlyHeight: labelsOnlyHeight ?? this.labelsOnlyHeight,
      centerFabSize: centerFabSize ?? this.centerFabSize,
      centerFabBackground: centerFabBackground ?? this.centerFabBackground,
      centerFabForeground: centerFabForeground ?? this.centerFabForeground,
      centerFabElevation: centerFabElevation ?? this.centerFabElevation,
      notchMargin: notchMargin ?? this.notchMargin,
    );
  }
}
