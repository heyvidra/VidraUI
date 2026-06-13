import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';

part 'v_shadows.g.dart';

/// VidraUI depth levels, determining surface tonal shifts and shadow intensity.
enum VElevation {
  /// Plane (Background level).
  level0,

  /// Base (Cards, Panels).
  level1,

  /// Float (Menus, Popovers).
  level2,

  /// Lift (Dialogs).
  level3,

  /// Top (Toasts, Overlays).
  level4,
}

/// Named box shadows for light and dark themes.
///
/// Hallmark Discipline: Shadows are restricted to state-driven overlays.
/// Light mode uses soft, machined depth. Dark mode uses “Ghost Edges”
/// to prioritize tonal layering over synthetic glow.
@immutable
class VShadows with Diagnosticable {
  factory VShadows.light([Color scrim = const Color(0xFF0A0B0D)]) {
    return VShadows(
      level1: BoxShadow(
        color: scrim.withValues(alpha: 0.07),
        blurRadius: 8,
        offset: const Offset(0, 2),
      ),
      level2: BoxShadow(
        color: scrim.withValues(alpha: 0.10),
        blurRadius: 12,
        offset: const Offset(0, 4),
      ),
      level3: BoxShadow(
        color: scrim.withValues(alpha: 0.16),
        blurRadius: 24,
        offset: const Offset(0, 8),
      ),
      level4: BoxShadow(
        color: scrim.withValues(alpha: 0.20),
        blurRadius: 32,
        offset: const Offset(0, 12),
      ),
    );
  }

  /// Dark mode shadows use “Ghost Edges” — tight, dark, 0-blur spreads
  /// that provide a machined boundary without emitting a halo.
  factory VShadows.dark([Color scrim = const Color(0xFF0A0B0D)]) {
    return VShadows(
      level1: BoxShadow(
        color: scrim.withValues(alpha: 0.4),
        blurRadius: 0,
        spreadRadius: 1,
        offset: const Offset(0, 1),
      ),
      level2: BoxShadow(
        color: scrim.withValues(alpha: 0.6),
        blurRadius: 0,
        spreadRadius: 1,
        offset: const Offset(0, 2),
      ),
      level3: BoxShadow(
        color: scrim.withValues(alpha: 0.8),
        blurRadius: 0,
        spreadRadius: 1,
        offset: const Offset(0, 4),
      ),
      level4: BoxShadow(
        color: scrim.withValues(alpha: 0.9),
        blurRadius: 0,
        spreadRadius: 1,
        offset: const Offset(0, 8),
      ),
    );
  }

  const VShadows({
    required this.level1,
    required this.level2,
    required this.level3,
    required this.level4,
  });

  final BoxShadow level1;
  final BoxShadow level2;
  final BoxShadow level3;
  final BoxShadow level4;

  /// Compatibility alias for [level1].
  BoxShadow get card => level1;

  /// Compatibility alias for [level3].
  BoxShadow get dialog => level3;

  /// Compatibility alias for [level2].
  BoxShadow get dropdown => level2;

  /// Compatibility alias for [level1].
  BoxShadow get panel => level1;

  /// Resolves the shadow for a given [elevation].
  BoxShadow? resolve(VElevation elevation) {
    return switch (elevation) {
      VElevation.level0 => null,
      VElevation.level1 => level1,
      VElevation.level2 => level2,
      VElevation.level3 => level3,
      VElevation.level4 => level4,
    };
  }

  static VShadows lerp(VShadows a, VShadows b, double t) =>
      _$VShadowsLerp(a, b, t);

  @override
  bool operator ==(Object other) => _$VShadowsEq(this, other);

  @override
  int get hashCode => _$VShadowsHash(this);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    _$VShadowsFillProperties(this, properties);
  }
}
