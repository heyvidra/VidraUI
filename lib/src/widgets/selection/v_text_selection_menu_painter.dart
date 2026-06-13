part of 'v_text_selection_menu.dart';

class _VTextSelectionMenuBubblePainter extends CustomPainter {
  _VTextSelectionMenuBubblePainter({
    required this.color,
    required this.borderColor,
    required this.arrowX,
    required this.arrowOnTop,
    required this.radius,
    required this.isDesktop,
    required this.shadow,
  });

  final Color color;
  final Color borderColor;
  final double arrowX;
  final bool arrowOnTop;
  final double radius;
  final bool isDesktop;
  final BoxShadow shadow;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final path = Path();
    final w = size.width;
    final h = size.height;
    const arrowHeight = 6.0;
    const arrowBase = 12.0;

    if (isDesktop) {
      final rect = RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, w, h),
        Radius.circular(radius),
      );
      path.addRRect(rect);
    } else {
      final r = radius;
      if (arrowOnTop) {
        path.moveTo(r, arrowHeight);
        path.lineTo(arrowX - arrowBase / 2, arrowHeight);
        path.lineTo(arrowX, 0.0);
        path.lineTo(arrowX + arrowBase / 2, arrowHeight);
        path.lineTo(w - r, arrowHeight);

        path.arcToPoint(
          Offset(w, arrowHeight + r),
          radius: Radius.circular(r),
          clockwise: true,
        );
        path.lineTo(w, h - r);
        path.arcToPoint(
          Offset(w - r, h),
          radius: Radius.circular(r),
          clockwise: true,
        );
        path.lineTo(r, h);
        path.arcToPoint(
          Offset(0, h - r),
          radius: Radius.circular(r),
          clockwise: true,
        );
        path.lineTo(0, arrowHeight + r);
        path.arcToPoint(
          Offset(r, arrowHeight),
          radius: Radius.circular(r),
          clockwise: true,
        );
      } else {
        path.moveTo(r, 0.0);
        path.lineTo(w - r, 0.0);
        path.arcToPoint(
          Offset(w, r),
          radius: Radius.circular(r),
          clockwise: true,
        );
        path.lineTo(w, h - arrowHeight - r);
        path.arcToPoint(
          Offset(w - r, h - arrowHeight),
          radius: Radius.circular(r),
          clockwise: true,
        );

        path.lineTo(arrowX + arrowBase / 2, h - arrowHeight);
        path.lineTo(arrowX, h);
        path.lineTo(arrowX - arrowBase / 2, h - arrowHeight);
        path.lineTo(r, h - arrowHeight);

        path.arcToPoint(
          Offset(0, h - arrowHeight - r),
          radius: Radius.circular(r),
          clockwise: true,
        );
        path.lineTo(0, r);
        path.arcToPoint(
          Offset(r, 0.0),
          radius: Radius.circular(r),
          clockwise: true,
        );
      }
      path.close();
    }

    canvas.drawShadow(
      path,
      shadow.color.withValues(alpha: 0.15),
      6.0,
      false,
    );

    canvas.drawPath(path, paint);
    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(_VTextSelectionMenuBubblePainter oldDelegate) {
    return color != oldDelegate.color ||
        borderColor != oldDelegate.borderColor ||
        arrowX != oldDelegate.arrowX ||
        arrowOnTop != oldDelegate.arrowOnTop ||
        radius != oldDelegate.radius ||
        isDesktop != oldDelegate.isDesktop ||
        shadow != oldDelegate.shadow;
  }
}
