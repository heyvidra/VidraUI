import 'package:flutter/widgets.dart';

/// Paints evenly spaced dots along an arbitrary [Path], or along a rounded
/// rectangle derived from the [size] passed to [paint].
///
/// Works for straight lines, rounded rectangles, circles, and any
/// other closed or open path.  Dots are drawn as filled circles whose
/// centres lie on the path.
///
/// Internal — not exported from the widget barrel.
class DottedPathPainter extends CustomPainter {
  /// Paints dots along a pre-built [path].
  const DottedPathPainter({
    this.path,
    this.borderRadius,
    required this.color,
    this.dotRadius = 1.5,
    this.step = 5.0,
  }) : assert(path != null || borderRadius != null);

  /// Pre-built path.  Use for arbitrary shapes.
  final Path? path;

  /// Rounded-rect radius.  When non-null, the painter builds the path from
  /// [size] using [borderRadius].  Ignored when [path] is provided.
  final BorderRadius? borderRadius;

  final Color color;
  final double dotRadius;
  final double step;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final effectivePath = path ?? _roundedRectPath(size, borderRadius!);
    final metrics = effectivePath.computeMetrics();
    for (final metric in metrics) {
      var distance = dotRadius;
      while (distance < metric.length - dotRadius) {
        final tangent = metric.getTangentForOffset(distance);
        if (tangent != null) {
          canvas.drawCircle(tangent.position, dotRadius, paint);
        }
        distance += step;
      }
    }
  }

  Path _roundedRectPath(Size size, BorderRadius radius) {
    final rect = Offset.zero & size;
    return Path()..addRRect(radius.toRRect(rect));
  }

  @override
  bool shouldRepaint(DottedPathPainter oldDelegate) =>
      path != oldDelegate.path ||
      borderRadius != oldDelegate.borderRadius ||
      color != oldDelegate.color ||
      dotRadius != oldDelegate.dotRadius ||
      step != oldDelegate.step;
}
