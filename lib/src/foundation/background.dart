import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';

/// A local background override for page, container, and overlay surfaces.
///
/// Use [VBackground] for one-off color or gradient exceptions. Prefer theme,
/// component tokens, and appearances for reusable styling.
@immutable
class VBackground {
  const VBackground._({
    this.color,
    this.gradient,
  }) : assert(
          (color == null) != (gradient == null),
          'Provide exactly one background type.',
        );

  /// Creates a solid color background.
  const VBackground.color(Color color) : this._(color: color);

  /// Creates a gradient background.
  const VBackground.gradient(Gradient gradient) : this._(gradient: gradient);

  /// The solid background color, when this is a color background.
  final Color? color;

  /// The gradient background, when this is a gradient background.
  final Gradient? gradient;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is VBackground &&
        other.color == color &&
        other.gradient == gradient;
  }

  @override
  int get hashCode => Object.hash(color, gradient);

  @override
  String toString() => 'VBackground(${color ?? gradient})';
}
