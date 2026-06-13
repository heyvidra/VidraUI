import 'package:flutter/widgets.dart';

import '../../foundation/semantic_tokens.dart';
import 'component_token_utils.dart';

/// Component-level tokens for date pickers.
@immutable
class VDatePickerTokens {
  factory VDatePickerTokens.fromColors(VColors colors) {
    return VDatePickerTokens(
      navigationForeground: colors.actionPrimary,
      weekdayForeground: colors.textMuted,
      dayForeground: colors.text,
      selectedBackground: colors.actionPrimary,
      selectedForeground: colors.actionPrimaryText,
      todayBorder: colors.actionPrimary,
      focusOutline: colors.actionPrimary,
      focusBackground: colors.surfaceHover,
      disabledForeground: colors.textDisabled,
    );
  }

  const VDatePickerTokens({
    this.navigationForeground = const Color(0xFF2563EB),
    this.weekdayForeground = const Color(0xFF6B7280),
    this.dayForeground = const Color(0xFF111827),
    this.selectedBackground = const Color(0xFF2563EB),
    this.selectedForeground = const Color(0xFFFEFBFF),
    this.todayBorder = const Color(0xFF2563EB),
    this.focusOutline = const Color(0xFF2563EB),
    this.focusBackground = const Color(0xFFEFF6FF),
    this.disabledForeground = const Color(0xFF9CA3AF),
    this.headerSpacing = 8,
    this.weekdaySpacing = 4,
    this.dayCellHeight = 36,
    this.dayCellRadius = 18,
    this.dayTextSize = 14,
    this.navigationIconSize = 16,
    this.todayBorderWidth = 1.5,
    this.focusOutlineWidth = 2,
  });

  final Color navigationForeground;
  final Color weekdayForeground;
  final Color dayForeground;
  final Color selectedBackground;
  final Color selectedForeground;
  final Color todayBorder;
  final Color focusOutline;
  final Color focusBackground;
  final Color disabledForeground;
  final double headerSpacing;
  final double weekdaySpacing;
  final double dayCellHeight;
  final double dayCellRadius;
  final double dayTextSize;
  final double navigationIconSize;
  final double todayBorderWidth;
  final double focusOutlineWidth;

  static VDatePickerTokens lerp(
    VDatePickerTokens a,
    VDatePickerTokens b,
    double t,
  ) {
    return VDatePickerTokens(
      navigationForeground: lerpComponentTokenColor(
          a.navigationForeground, b.navigationForeground, t),
      weekdayForeground:
          lerpComponentTokenColor(a.weekdayForeground, b.weekdayForeground, t),
      dayForeground:
          lerpComponentTokenColor(a.dayForeground, b.dayForeground, t),
      selectedBackground: lerpComponentTokenColor(
          a.selectedBackground, b.selectedBackground, t),
      selectedForeground: lerpComponentTokenColor(
          a.selectedForeground, b.selectedForeground, t),
      todayBorder: lerpComponentTokenColor(a.todayBorder, b.todayBorder, t),
      focusOutline: lerpComponentTokenColor(a.focusOutline, b.focusOutline, t),
      focusBackground:
          lerpComponentTokenColor(a.focusBackground, b.focusBackground, t),
      disabledForeground: lerpComponentTokenColor(
          a.disabledForeground, b.disabledForeground, t),
      headerSpacing:
          lerpComponentTokenDouble(a.headerSpacing, b.headerSpacing, t),
      weekdaySpacing:
          lerpComponentTokenDouble(a.weekdaySpacing, b.weekdaySpacing, t),
      dayCellHeight:
          lerpComponentTokenDouble(a.dayCellHeight, b.dayCellHeight, t),
      dayCellRadius:
          lerpComponentTokenDouble(a.dayCellRadius, b.dayCellRadius, t),
      dayTextSize: lerpComponentTokenDouble(a.dayTextSize, b.dayTextSize, t),
      navigationIconSize: lerpComponentTokenDouble(
          a.navigationIconSize, b.navigationIconSize, t),
      todayBorderWidth:
          lerpComponentTokenDouble(a.todayBorderWidth, b.todayBorderWidth, t),
      focusOutlineWidth:
          lerpComponentTokenDouble(a.focusOutlineWidth, b.focusOutlineWidth, t),
    );
  }

  VDatePickerTokens copyWith({
    Color? navigationForeground,
    Color? weekdayForeground,
    Color? dayForeground,
    Color? selectedBackground,
    Color? selectedForeground,
    Color? todayBorder,
    Color? focusOutline,
    Color? focusBackground,
    Color? disabledForeground,
    double? headerSpacing,
    double? weekdaySpacing,
    double? dayCellHeight,
    double? dayCellRadius,
    double? dayTextSize,
    double? navigationIconSize,
    double? todayBorderWidth,
    double? focusOutlineWidth,
  }) {
    return VDatePickerTokens(
      navigationForeground: navigationForeground ?? this.navigationForeground,
      weekdayForeground: weekdayForeground ?? this.weekdayForeground,
      dayForeground: dayForeground ?? this.dayForeground,
      selectedBackground: selectedBackground ?? this.selectedBackground,
      selectedForeground: selectedForeground ?? this.selectedForeground,
      todayBorder: todayBorder ?? this.todayBorder,
      focusOutline: focusOutline ?? this.focusOutline,
      focusBackground: focusBackground ?? this.focusBackground,
      disabledForeground: disabledForeground ?? this.disabledForeground,
      headerSpacing: headerSpacing ?? this.headerSpacing,
      weekdaySpacing: weekdaySpacing ?? this.weekdaySpacing,
      dayCellHeight: dayCellHeight ?? this.dayCellHeight,
      dayCellRadius: dayCellRadius ?? this.dayCellRadius,
      dayTextSize: dayTextSize ?? this.dayTextSize,
      navigationIconSize: navigationIconSize ?? this.navigationIconSize,
      todayBorderWidth: todayBorderWidth ?? this.todayBorderWidth,
      focusOutlineWidth: focusOutlineWidth ?? this.focusOutlineWidth,
    );
  }
}
