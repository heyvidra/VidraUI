part of 'v_teaching_tip.dart';

class _VTeachingTipArrowPainter extends CustomPainter {
  _VTeachingTipArrowPainter({
    required this.color,
    required this.borderColor,
    required this.direction,
  });

  final Color color;
  final Color borderColor;
  final VTeachingTipArrowDirection direction;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = borderColor
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    final path = Path();
    switch (direction) {
      case VTeachingTipArrowDirection.up:
        path.moveTo(size.width / 2, 0);
        path.lineTo(size.width, size.height);
        path.lineTo(0, size.height);
        break;
      case VTeachingTipArrowDirection.down:
        path.moveTo(size.width / 2, size.height);
        path.lineTo(size.width, 0);
        path.lineTo(0, 0);
        break;
      case VTeachingTipArrowDirection.left:
        path.moveTo(0, size.height / 2);
        path.lineTo(size.width, size.height);
        path.lineTo(size.width, 0);
        break;
      case VTeachingTipArrowDirection.right:
        path.moveTo(size.width, size.height / 2);
        path.lineTo(0, size.height);
        path.lineTo(0, 0);
        break;
    }
    path.close();

    canvas.drawPath(path, paint);

    final borderPath = Path();
    switch (direction) {
      case VTeachingTipArrowDirection.up:
        borderPath.moveTo(0, size.height);
        borderPath.lineTo(size.width / 2, 0);
        borderPath.lineTo(size.width, size.height);
        break;
      case VTeachingTipArrowDirection.down:
        borderPath.moveTo(0, 0);
        borderPath.lineTo(size.width / 2, size.height);
        borderPath.lineTo(size.width, 0);
        break;
      case VTeachingTipArrowDirection.left:
        borderPath.moveTo(size.width, 0);
        borderPath.lineTo(0, size.height / 2);
        borderPath.lineTo(size.width, size.height);
        break;
      case VTeachingTipArrowDirection.right:
        borderPath.moveTo(0, 0);
        borderPath.lineTo(size.width, size.height / 2);
        borderPath.lineTo(0, size.height);
        break;
    }
    canvas.drawPath(borderPath, borderPaint);
  }

  @override
  bool shouldRepaint(covariant _VTeachingTipArrowPainter oldDelegate) {
    return color != oldDelegate.color ||
        borderColor != oldDelegate.borderColor ||
        direction != oldDelegate.direction;
  }
}

class _VCloseIconPainter extends CustomPainter {
  const _VCloseIconPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawLine(Offset.zero, Offset(size.width, size.height), paint);
    canvas.drawLine(Offset(0, size.height), Offset(size.width, 0), paint);
  }

  @override
  bool shouldRepaint(covariant _VCloseIconPainter oldDelegate) {
    return color != oldDelegate.color;
  }
}
