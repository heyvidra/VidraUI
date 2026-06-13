import 'package:flutter/widgets.dart';

import '../../foundation/semantic_tokens.dart';
import 'component_token_utils.dart';

/// Component-level tokens for steps indicators.
@immutable
class VStepsTokens {
  factory VStepsTokens.fromColors(VColors colors) {
    return VStepsTokens(
      activeColor: colors.actionPrimary,
      inactiveColor: colors.border,
      activeText: colors.actionPrimaryText,
      inactiveText: colors.border,
      surface: colors.surface,
      indicatorSize: 24.0,
      lineHeight: 2.0,
      lineMargin: 8.0,
    );
  }

  const VStepsTokens({
    required this.activeColor,
    required this.inactiveColor,
    required this.activeText,
    required this.inactiveText,
    required this.surface,
    required this.indicatorSize,
    required this.lineHeight,
    required this.lineMargin,
  });

  final Color activeColor;
  final Color inactiveColor;
  final Color activeText;
  final Color inactiveText;
  final Color surface;
  final double indicatorSize;
  final double lineHeight;
  final double lineMargin;

  static VStepsTokens lerp(VStepsTokens a, VStepsTokens b, double t) {
    return VStepsTokens(
      activeColor: lerpComponentTokenColor(a.activeColor, b.activeColor, t),
      inactiveColor: lerpComponentTokenColor(a.inactiveColor, b.inactiveColor, t),
      activeText: lerpComponentTokenColor(a.activeText, b.activeText, t),
      inactiveText: lerpComponentTokenColor(a.inactiveText, b.inactiveText, t),
      surface: lerpComponentTokenColor(a.surface, b.surface, t),
      indicatorSize: lerpComponentTokenDouble(a.indicatorSize, b.indicatorSize, t),
      lineHeight: lerpComponentTokenDouble(a.lineHeight, b.lineHeight, t),
      lineMargin: lerpComponentTokenDouble(a.lineMargin, b.lineMargin, t),
    );
  }

  VStepsTokens copyWith({
    Color? activeColor,
    Color? inactiveColor,
    Color? activeText,
    Color? inactiveText,
    Color? surface,
    double? indicatorSize,
    double? lineHeight,
    double? lineMargin,
  }) {
    return VStepsTokens(
      activeColor: activeColor ?? this.activeColor,
      inactiveColor: inactiveColor ?? this.inactiveColor,
      activeText: activeText ?? this.activeText,
      inactiveText: inactiveText ?? this.inactiveText,
      surface: surface ?? this.surface,
      indicatorSize: indicatorSize ?? this.indicatorSize,
      lineHeight: lineHeight ?? this.lineHeight,
      lineMargin: lineMargin ?? this.lineMargin,
    );
  }
}
