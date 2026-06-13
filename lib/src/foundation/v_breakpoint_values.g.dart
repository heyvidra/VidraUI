// GENERATED CODE — DO NOT EDIT.
//
// Regenerate with:
//   dart run scripts/generate_foundation_tokens.dart
//
// Registry: scripts/foundation_token_registry.dart

// coverage:ignore-file

part of 'responsive.dart';

VBreakpointValues _$VBreakpointValuesLerp(
  VBreakpointValues a,
  VBreakpointValues b,
  double t,
) {
  return VBreakpointValues(
    sm: a.sm + (b.sm - a.sm) * t,
    md: a.md + (b.md - a.md) * t,
    lg: a.lg + (b.lg - a.lg) * t,
    xl: a.xl + (b.xl - a.xl) * t,
    xxl: a.xxl + (b.xxl - a.xxl) * t,
  );
}

VBreakpointValues _$VBreakpointValuesCopyWith(
  VBreakpointValues self, {
  double? sm,
  double? md,
  double? lg,
  double? xl,
  double? xxl,
}) {
  return VBreakpointValues(
    sm: sm ?? self.sm,
    md: md ?? self.md,
    lg: lg ?? self.lg,
    xl: xl ?? self.xl,
    xxl: xxl ?? self.xxl,
  );
}

bool _$VBreakpointValuesEq(VBreakpointValues a, Object other) {
  if (identical(a, other)) return true;
  return other is VBreakpointValues
    && a.sm == other.sm
    && a.md == other.md
    && a.lg == other.lg
    && a.xl == other.xl
    && a.xxl == other.xxl
    ;
}

int _$VBreakpointValuesHash(VBreakpointValues self) => Object.hash(
  self.sm,
  self.md,
  self.lg,
  self.xl,
  self.xxl,
);

void _$VBreakpointValuesFillProperties(
  VBreakpointValues self,
  DiagnosticPropertiesBuilder properties,
) {
  properties.add(DoubleProperty('sm', self.sm));
  properties.add(DoubleProperty('md', self.md));
  properties.add(DoubleProperty('lg', self.lg));
  properties.add(DoubleProperty('xl', self.xl));
  properties.add(DoubleProperty('xxl', self.xxl));
}

