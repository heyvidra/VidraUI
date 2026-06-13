import 'package:flutter/foundation.dart';

part 'v_breakpoint_values.g.dart';

/// Screen size breakpoint identifiers.
enum VBreakpoint { xs, sm, md, lg, xl, xxl }

/// Theme-configurable breakpoint thresholds.
///
/// Each field is the minimum width (in logical pixels) for that breakpoint.
/// Resolve a screen width to a [VBreakpoint] with [resolve].
@immutable
class VBreakpointValues with Diagnosticable {
  const VBreakpointValues({
    this.sm = 600,
    this.md = 840,
    this.lg = 1200,
    this.xl = 1440,
    this.xxl = 1920,
  })  : assert(sm > 0),
        assert(md > sm),
        assert(lg > md),
        assert(xl > lg),
        assert(xxl > xl);

  final double sm;
  final double md;
  final double lg;
  final double xl;
  final double xxl;

  /// Returns the [VBreakpoint] for a given screen [width].
  VBreakpoint resolve(double width) {
    if (width >= xxl) return VBreakpoint.xxl;
    if (width >= xl) return VBreakpoint.xl;
    if (width >= lg) return VBreakpoint.lg;
    if (width >= md) return VBreakpoint.md;
    if (width >= sm) return VBreakpoint.sm;
    return VBreakpoint.xs;
  }

  VBreakpointValues copyWith({
    double? sm,
    double? md,
    double? lg,
    double? xl,
    double? xxl,
  }) =>
      _$VBreakpointValuesCopyWith(this,
          sm: sm,
          md: md,
          lg: lg,
          xl: xl,
          xxl: xxl,
      );

  static VBreakpointValues lerp(
    VBreakpointValues a,
    VBreakpointValues b,
    double t,
  ) =>
      _$VBreakpointValuesLerp(a, b, t);

  @override
  bool operator ==(Object other) => _$VBreakpointValuesEq(this, other);

  @override
  int get hashCode => _$VBreakpointValuesHash(this);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    _$VBreakpointValuesFillProperties(this, properties);
  }
}
