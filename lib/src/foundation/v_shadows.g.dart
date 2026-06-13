// GENERATED CODE — DO NOT EDIT.
//
// Regenerate with:
//   dart run scripts/generate_foundation_tokens.dart
//
// Registry: scripts/foundation_token_registry.dart

// coverage:ignore-file

part of 'shadows.dart';

VShadows _$VShadowsLerp(
  VShadows a,
  VShadows b,
  double t,
) {
  return VShadows(
    level1: BoxShadow.lerp(a.level1, b.level1, t)!,
    level2: BoxShadow.lerp(a.level2, b.level2, t)!,
    level3: BoxShadow.lerp(a.level3, b.level3, t)!,
    level4: BoxShadow.lerp(a.level4, b.level4, t)!,
  );
}

bool _$VShadowsEq(VShadows a, Object other) {
  if (identical(a, other)) return true;
  return other is VShadows
    && a.level1 == other.level1
    && a.level2 == other.level2
    && a.level3 == other.level3
    && a.level4 == other.level4
    ;
}

int _$VShadowsHash(VShadows self) => Object.hash(
  self.level1,
  self.level2,
  self.level3,
  self.level4,
);

void _$VShadowsFillProperties(
  VShadows self,
  DiagnosticPropertiesBuilder properties,
) {
  properties.add(DiagnosticsProperty<BoxShadow>('level1', self.level1));
  properties.add(DiagnosticsProperty<BoxShadow>('level2', self.level2));
  properties.add(DiagnosticsProperty<BoxShadow>('level3', self.level3));
  properties.add(DiagnosticsProperty<BoxShadow>('level4', self.level4));
}

