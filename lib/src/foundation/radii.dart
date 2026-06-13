import 'package:flutter/foundation.dart';

part 'v_radii.g.dart';

/// Named border radius values.
@immutable
class VRadii with Diagnosticable {
  factory VRadii.defaults() {
    return const VRadii(
      xs: 2,
      sm: 4,
      md: 8,
      lg: 12,
      xl: 16,
      full: 9999,
    );
  }
  const VRadii({
    required this.xs,
    required this.sm,
    required this.md,
    required this.lg,
    required this.xl,
    required this.full,
  });

  final double xs;
  final double sm;
  final double md;
  final double lg;
  final double xl;
  final double full;

  static VRadii lerp(VRadii a, VRadii b, double t) =>
      _$VRadiiLerp(a, b, t);

  VRadii copyWith({
    double? xs,
    double? sm,
    double? md,
    double? lg,
    double? xl,
    double? full,
  }) =>
      _$VRadiiCopyWith(this,
          xs: xs,
          sm: sm,
          md: md,
          lg: lg,
          xl: xl,
          full: full,
      );

  @override
  bool operator ==(Object other) => _$VRadiiEq(this, other);

  @override
  int get hashCode => _$VRadiiHash(this);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    _$VRadiiFillProperties(this, properties);
  }
}
