import 'dart:ui';

import 'package:flutter/foundation.dart';

/// Configuration for the [VIconTheme].
///
/// Provides default size, color, and opacity for [VIcon] widgets
/// in the subtree.
@immutable
class VIconThemeData {
  const VIconThemeData({
    this.size,
    this.color,
    this.opacity,
  });

  /// Default icon size. Falls back to 20.0 when not set.
  final double? size;

  /// Default icon color. Falls back to [VTheme.colors.text].
  final Color? color;

  /// Default opacity. Falls back to 1.0.
  final double? opacity;

  /// Hard-fallback size when no other source provides one.
  static const defaultSize = 20.0;

  /// Hard-fallback opacity.
  static const defaultOpacity = 1.0;

  /// Effective size, resolved against defaults.
  double get effectiveSize => size ?? defaultSize;

  /// Effective opacity, resolved against defaults.
  double get effectiveOpacity => opacity ?? defaultOpacity;

  VIconThemeData copyWith({
    double? size,
    Color? color,
    double? opacity,
  }) {
    return VIconThemeData(
      size: size ?? this.size,
      color: color ?? this.color,
      opacity: opacity ?? this.opacity,
    );
  }

  static VIconThemeData lerp(VIconThemeData a, VIconThemeData b, double t) {
    return VIconThemeData(
      size: t < 0.5 ? a.size : b.size,
      color: Color.lerp(a.color, b.color, t),
      opacity:
          a.effectiveOpacity + (b.effectiveOpacity - a.effectiveOpacity) * t,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is VIconThemeData &&
        other.size == size &&
        other.color == color &&
        other.opacity == opacity;
  }

  @override
  int get hashCode => Object.hash(size, color, opacity);
}
