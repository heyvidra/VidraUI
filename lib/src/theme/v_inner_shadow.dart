import 'package:flutter/widgets.dart';

/// Paints inner shadows using the [BoxShadow] list.
///
/// Internal helper — not exported from widgets.dart.
class VInnerShadowPainter extends CustomPainter {
  const VInnerShadowPainter({
    required this.shadows,
    required this.borderRadius,
    this.clipBehavior = Clip.antiAlias,
  });

  final List<BoxShadow> shadows;
  final BorderRadiusGeometry borderRadius;
  final Clip clipBehavior;

  @override
  void paint(Canvas canvas, Size size) {
    if (shadows.isEmpty) return;
    final rect = Offset.zero & size;
    final rrect = borderRadius.resolve(TextDirection.ltr).toRRect(rect);

    for (final shadow in shadows) {
      // Use a mask filter to create the blur effect
      final paint = Paint()
        ..color = shadow.color
        ..maskFilter = shadow.blurRadius > 0 
            ? MaskFilter.blur(BlurStyle.normal, shadow.blurSigma)
            : null;

      // Save layer for compositing
      canvas.saveLayer(rect, Paint());
      
      // Clip to the border radius
      canvas.clipRRect(rrect, doAntiAlias: clipBehavior == Clip.antiAlias);
      
      // Draw the shadow offset shape
      // For inner shadow, we draw the inverse - a large rect with a hole
      final outerRect = rect.inflate(shadow.blurRadius * 2 + shadow.spreadRadius);
      final outerPath = Path()
        ..addRect(outerRect)
        ..addRRect(rrect.shift(shadow.offset))
        ..fillType = PathFillType.evenOdd;
      
      canvas.drawPath(outerPath, paint);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(VInnerShadowPainter old) =>
      shadows != old.shadows || 
      borderRadius != old.borderRadius ||
      clipBehavior != old.clipBehavior;
}
