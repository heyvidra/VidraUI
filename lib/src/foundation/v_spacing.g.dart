// GENERATED CODE — DO NOT EDIT.
//
// Regenerate with:
//   dart run scripts/generate_foundation_tokens.dart
//
// Registry: scripts/foundation_token_registry.dart

// coverage:ignore-file

part of 'spacing.dart';

VSpacing _$VSpacingLerp(
  VSpacing a,
  VSpacing b,
  double t,
) {
  return VSpacing(
    xs: a.xs + (b.xs - a.xs) * t,
    sm: a.sm + (b.sm - a.sm) * t,
    md: a.md + (b.md - a.md) * t,
    lg: a.lg + (b.lg - a.lg) * t,
    xl: a.xl + (b.xl - a.xl) * t,
    x2l: a.x2l + (b.x2l - a.x2l) * t,
    x3l: a.x3l + (b.x3l - a.x3l) * t,
    gap: a.gap + (b.gap - a.gap) * t,
    iconGap: a.iconGap + (b.iconGap - a.iconGap) * t,
  );
}

VSpacing _$VSpacingCopyWith(
  VSpacing self, {
  double? xs,
  double? sm,
  double? md,
  double? lg,
  double? xl,
  double? x2l,
  double? x3l,
  double? gap,
  double? iconGap,
}) {
  return VSpacing(
    xs: xs ?? self.xs,
    sm: sm ?? self.sm,
    md: md ?? self.md,
    lg: lg ?? self.lg,
    xl: xl ?? self.xl,
    x2l: x2l ?? self.x2l,
    x3l: x3l ?? self.x3l,
    gap: gap ?? self.gap,
    iconGap: iconGap ?? self.iconGap,
  );
}

bool _$VSpacingEq(VSpacing a, Object other) {
  if (identical(a, other)) return true;
  return other is VSpacing
    && a.xs == other.xs
    && a.sm == other.sm
    && a.md == other.md
    && a.lg == other.lg
    && a.xl == other.xl
    && a.x2l == other.x2l
    && a.x3l == other.x3l
    && a.gap == other.gap
    && a.iconGap == other.iconGap
    ;
}

int _$VSpacingHash(VSpacing self) => Object.hash(
  self.xs,
  self.sm,
  self.md,
  self.lg,
  self.xl,
  self.x2l,
  self.x3l,
  self.gap,
  self.iconGap,
);

void _$VSpacingFillProperties(
  VSpacing self,
  DiagnosticPropertiesBuilder properties,
) {
  properties.add(DoubleProperty('xs', self.xs));
  properties.add(DoubleProperty('sm', self.sm));
  properties.add(DoubleProperty('md', self.md));
  properties.add(DoubleProperty('lg', self.lg));
  properties.add(DoubleProperty('xl', self.xl));
  properties.add(DoubleProperty('x2l', self.x2l));
  properties.add(DoubleProperty('x3l', self.x3l));
  properties.add(DoubleProperty('gap', self.gap));
  properties.add(DoubleProperty('iconGap', self.iconGap));
}

