import 'package:flutter/widgets.dart';

import '../../foundation/semantic_tokens.dart';
import 'component_token_utils.dart';

/// Component-level tokens for divider separators.
@immutable
class VDividerTokens {
  factory VDividerTokens.fromColors(VColors colors) {
    return VDividerTokens(
      color: colors.border,
      thickness: 1.0,
      dotRadius: 1.5,
      dotStep: 5.0,
    );
  }

  const VDividerTokens({
    required this.color,
    required this.thickness,
    required this.dotRadius,
    required this.dotStep,
  });

  final Color color;
  final double thickness;
  final double dotRadius;
  final double dotStep;

  static VDividerTokens lerp(VDividerTokens a, VDividerTokens b, double t) {
    return VDividerTokens(
      color: lerpComponentTokenColor(a.color, b.color, t),
      thickness: lerpComponentTokenDouble(a.thickness, b.thickness, t),
      dotRadius: lerpComponentTokenDouble(a.dotRadius, b.dotRadius, t),
      dotStep: lerpComponentTokenDouble(a.dotStep, b.dotStep, t),
    );
  }

  VDividerTokens copyWith({
    Color? color,
    double? thickness,
    double? dotRadius,
    double? dotStep,
  }) {
    return VDividerTokens(
      color: color ?? this.color,
      thickness: thickness ?? this.thickness,
      dotRadius: dotRadius ?? this.dotRadius,
      dotStep: dotStep ?? this.dotStep,
    );
  }
}
