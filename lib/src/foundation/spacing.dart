import 'package:flutter/foundation.dart';

part 'v_spacing.g.dart';

/// Named spacing values used throughout the design system.
///
/// Widgets should read spacing from [VSpacing] rather than hard-coding
/// [EdgeInsets] or [SizedBox] dimensions.
@immutable
class VSpacing with Diagnosticable {
  factory VSpacing.defaults() {
    return const VSpacing(
      xs: 4,
      sm: 8,
      md: 12,
      lg: 16,
      xl: 24,
      x2l: 32,
      x3l: 48,
      gap: 8,
      iconGap: 4,
    );
  }
  const VSpacing({
    required this.xs,
    required this.sm,
    required this.md,
    required this.lg,
    required this.xl,
    required this.x2l,
    required this.x3l,
    this.gap = 8,
    this.iconGap = 4,
  });

  final double xs;
  final double sm;
  final double md;
  final double lg;
  final double xl;
  final double x2l;
  final double x3l;
  final double gap;
  final double iconGap;

  static VSpacing lerp(VSpacing a, VSpacing b, double t) =>
      _$VSpacingLerp(a, b, t);

  VSpacing copyWith({
    double? xs,
    double? sm,
    double? md,
    double? lg,
    double? xl,
    double? x2l,
    double? x3l,
    double? gap,
    double? iconGap,
  }) =>
      _$VSpacingCopyWith(this,
          xs: xs,
          sm: sm,
          md: md,
          lg: lg,
          xl: xl,
          x2l: x2l,
          x3l: x3l,
          gap: gap,
          iconGap: iconGap,
      );

  @override
  bool operator ==(Object other) => _$VSpacingEq(this, other);

  @override
  int get hashCode => _$VSpacingHash(this);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    _$VSpacingFillProperties(this, properties);
  }
}
