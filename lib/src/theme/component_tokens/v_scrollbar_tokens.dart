import 'package:flutter/widgets.dart';

import '../../foundation/semantic_tokens.dart';
import 'component_token_utils.dart';

/// Component-level tokens for scrollbars.
@immutable
class VScrollbarTokens {
  factory VScrollbarTokens.fromColors(VColors colors) {
    return VScrollbarTokens(
      thumbColor: colors.textMuted.withValues(alpha: 0.35),
      thumbColorHover: colors.textMuted.withValues(alpha: 0.6),
      trackColor: const Color(0x00000000),
      radius: 4.0,
      thickness: 6.0,
      thicknessHover: 8.0,
      minThumbLength: 18.0,
    );
  }

  const VScrollbarTokens({
    this.thumbColor = const Color(0x599E9E9E),
    this.thumbColorHover = const Color(0x999E9E9E),
    this.trackColor = const Color(0x00000000),
    this.radius = 4.0,
    this.thickness = 6.0,
    this.thicknessHover = 8.0,
    this.minThumbLength = 18.0,
  });

  final Color thumbColor;
  final Color thumbColorHover;
  final Color trackColor;
  final double radius;
  final double thickness;
  final double thicknessHover;

  /// Minimum length of the scrollbar thumb in logical pixels.
  final double minThumbLength;

  static VScrollbarTokens lerp(
      VScrollbarTokens a, VScrollbarTokens b, double t) {
    return VScrollbarTokens(
      thumbColor: lerpComponentTokenColor(a.thumbColor, b.thumbColor, t),
      thumbColorHover:
          lerpComponentTokenColor(a.thumbColorHover, b.thumbColorHover, t),
      trackColor: lerpComponentTokenColor(a.trackColor, b.trackColor, t),
      radius: lerpComponentTokenDouble(a.radius, b.radius, t),
      thickness: lerpComponentTokenDouble(a.thickness, b.thickness, t),
      thicknessHover:
          lerpComponentTokenDouble(a.thicknessHover, b.thicknessHover, t),
      minThumbLength:
          lerpComponentTokenDouble(a.minThumbLength, b.minThumbLength, t),
    );
  }

  VScrollbarTokens copyWith({
    Color? thumbColor,
    Color? thumbColorHover,
    Color? trackColor,
    double? radius,
    double? thickness,
    double? thicknessHover,
    double? minThumbLength,
  }) {
    return VScrollbarTokens(
      thumbColor: thumbColor ?? this.thumbColor,
      thumbColorHover: thumbColorHover ?? this.thumbColorHover,
      trackColor: trackColor ?? this.trackColor,
      radius: radius ?? this.radius,
      thickness: thickness ?? this.thickness,
      thicknessHover: thicknessHover ?? this.thicknessHover,
      minThumbLength: minThumbLength ?? this.minThumbLength,
    );
  }
}
