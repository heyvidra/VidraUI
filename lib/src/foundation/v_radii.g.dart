// GENERATED CODE — DO NOT EDIT.
//
// Regenerate with:
//   dart run scripts/generate_foundation_tokens.dart
//
// Registry: scripts/foundation_token_registry.dart

// coverage:ignore-file

part of 'radii.dart';

VRadii _$VRadiiLerp(
  VRadii a,
  VRadii b,
  double t,
) {
  return VRadii(
    xs: a.xs + (b.xs - a.xs) * t,
    sm: a.sm + (b.sm - a.sm) * t,
    md: a.md + (b.md - a.md) * t,
    lg: a.lg + (b.lg - a.lg) * t,
    xl: a.xl + (b.xl - a.xl) * t,
    full: a.full + (b.full - a.full) * t,
  );
}

VRadii _$VRadiiCopyWith(
  VRadii self, {
  double? xs,
  double? sm,
  double? md,
  double? lg,
  double? xl,
  double? full,
}) {
  return VRadii(
    xs: xs ?? self.xs,
    sm: sm ?? self.sm,
    md: md ?? self.md,
    lg: lg ?? self.lg,
    xl: xl ?? self.xl,
    full: full ?? self.full,
  );
}

bool _$VRadiiEq(VRadii a, Object other) {
  if (identical(a, other)) return true;
  return other is VRadii
    && a.xs == other.xs
    && a.sm == other.sm
    && a.md == other.md
    && a.lg == other.lg
    && a.xl == other.xl
    && a.full == other.full
    ;
}

int _$VRadiiHash(VRadii self) => Object.hash(
  self.xs,
  self.sm,
  self.md,
  self.lg,
  self.xl,
  self.full,
);

void _$VRadiiFillProperties(
  VRadii self,
  DiagnosticPropertiesBuilder properties,
) {
  properties.add(DoubleProperty('xs', self.xs));
  properties.add(DoubleProperty('sm', self.sm));
  properties.add(DoubleProperty('md', self.md));
  properties.add(DoubleProperty('lg', self.lg));
  properties.add(DoubleProperty('xl', self.xl));
  properties.add(DoubleProperty('full', self.full));
}

