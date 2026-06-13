part of 'v_toast.dart';

class _VToastIcon extends StatelessWidget {
  const _VToastIcon({
    required this.variant,
    required this.color,
    required this.size,
  });

  final VToastVariant variant;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _VToastIconPainter(variant: variant, color: color),
    );
  }
}

class _VToastIconPainter extends CustomPainter {
  const _VToastIconPainter({
    required this.variant,
    required this.color,
  });

  final VToastVariant variant;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    switch (variant) {
      case VToastVariant.info:
        paint.strokeWidth = 1.5;
        canvas.drawCircle(
          Offset(size.width / 2, size.height / 2),
          size.width / 2 - 1,
          paint,
        );
        final paintDot = Paint()
          ..color = color
          ..style = PaintingStyle.fill;
        canvas.drawCircle(
          Offset(size.width / 2, size.height * 0.32),
          1.2,
          paintDot,
        );
        canvas.drawLine(
          Offset(size.width / 2, size.height * 0.46),
          Offset(size.width / 2, size.height * 0.72),
          paint,
        );
        break;

      case VToastVariant.success:
        paint.strokeWidth = 2.0;
        canvas.drawCircle(
          Offset(size.width / 2, size.height / 2),
          size.width / 2 - 1,
          paint,
        );
        final checkPath = Path()
          ..moveTo(size.width * 0.32, size.height * 0.5)
          ..lineTo(size.width * 0.46, size.height * 0.64)
          ..lineTo(size.width * 0.68, size.height * 0.36);
        canvas.drawPath(checkPath, paint);
        break;

      case VToastVariant.warning:
        paint.strokeWidth = 1.5;
        final path = Path()
          ..moveTo(size.width / 2, size.height * 0.12)
          ..lineTo(size.width * 0.88, size.height * 0.84)
          ..lineTo(size.width * 0.12, size.height * 0.84)
          ..close();
        canvas.drawPath(path, paint);
        canvas.drawLine(
          Offset(size.width / 2, size.height * 0.38),
          Offset(size.width / 2, size.height * 0.62),
          paint,
        );
        final paintDot = Paint()
          ..color = color
          ..style = PaintingStyle.fill;
        canvas.drawCircle(
          Offset(size.width / 2, size.height * 0.74),
          1.2,
          paintDot,
        );
        break;

      case VToastVariant.error:
        paint.strokeWidth = 1.5;
        canvas.drawCircle(
          Offset(size.width / 2, size.height / 2),
          size.width / 2 - 1,
          paint,
        );
        paint.strokeWidth = 2.0;
        canvas.drawLine(
          Offset(size.width * 0.33, size.height * 0.33),
          Offset(size.width * 0.67, size.height * 0.67),
          paint,
        );
        canvas.drawLine(
          Offset(size.width * 0.33, size.height * 0.67),
          Offset(size.width * 0.67, size.height * 0.33),
          paint,
        );
        break;
    }
  }

  @override
  bool shouldRepaint(_VToastIconPainter oldDelegate) =>
      variant != oldDelegate.variant || color != oldDelegate.color;
}
