part of 'v_navigation_bar.dart';

class _NotchClipper extends CustomClipper<Path> {
  const _NotchClipper({
    required this.fabRadius,
    required this.notchMargin,
    this.borderRadius = 0,
  });

  final double fabRadius;
  final double notchMargin;
  final double borderRadius;

  @override
  Path getClip(Size size) {
    final effectiveRadius = fabRadius + notchMargin;
    final center = size.width / 2;
    final r = borderRadius;
    final path = Path();

    path.moveTo(r, 0);
    path.lineTo(center - effectiveRadius, 0);
    path.arcToPoint(
      Offset(center + effectiveRadius, 0),
      radius: Radius.circular(effectiveRadius),
      clockwise: false,
    );
    path.lineTo(size.width - r, 0);
    if (r > 0) {
      path.arcToPoint(
        Offset(size.width, r),
        radius: Radius.circular(r),
        clockwise: true,
      );
    }
    path.lineTo(size.width, size.height - r);
    if (r > 0) {
      path.arcToPoint(
        Offset(size.width - r, size.height),
        radius: Radius.circular(r),
        clockwise: true,
      );
    }
    path.lineTo(r, size.height);
    if (r > 0) {
      path.arcToPoint(
        Offset(0, size.height - r),
        radius: Radius.circular(r),
        clockwise: true,
      );
    }
    path.lineTo(0, r);
    if (r > 0) {
      path.arcToPoint(
        Offset(r, 0),
        radius: Radius.circular(r),
        clockwise: true,
      );
    }
    path.close();

    return path;
  }

  @override
  bool shouldReclip(_NotchClipper oldClipper) =>
      fabRadius != oldClipper.fabRadius ||
      notchMargin != oldClipper.notchMargin ||
      borderRadius != oldClipper.borderRadius;
}

class _NotchPainter extends CustomPainter {
  const _NotchPainter({
    required this.fabRadius,
    required this.notchMargin,
    required this.borderRadius,
    required this.backgroundColor,
    required this.borderColor,
    required this.borderWidth,
    this.shadows,
    required this.shape,
  });

  final double fabRadius;
  final double notchMargin;
  final double borderRadius;
  final Color backgroundColor;
  final Color borderColor;
  final double borderWidth;
  final List<BoxShadow>? shadows;
  final VNavigationBarShape shape;

  @override
  void paint(Canvas canvas, Size size) {
    final effectiveRadius = fabRadius + notchMargin;
    final center = size.width / 2;
    final r = borderRadius;
    final path = Path()
      ..moveTo(r, 0)
      ..lineTo(center - effectiveRadius, 0)
      ..arcToPoint(
        Offset(center + effectiveRadius, 0),
        radius: Radius.circular(effectiveRadius),
        clockwise: false,
      )
      ..lineTo(size.width - r, 0);

    if (r > 0) {
      path.arcToPoint(
        Offset(size.width, r),
        radius: Radius.circular(r),
        clockwise: true,
      );
    }
    path.lineTo(size.width, size.height - r);

    if (r > 0) {
      path.arcToPoint(
        Offset(size.width - r, size.height),
        radius: Radius.circular(r),
        clockwise: true,
      );
    }
    path.lineTo(r, size.height);

    if (r > 0) {
      path.arcToPoint(
        Offset(0, size.height - r),
        radius: Radius.circular(r),
        clockwise: true,
      );
    }
    path.lineTo(0, r);

    if (r > 0) {
      path.arcToPoint(
        Offset(r, 0),
        radius: Radius.circular(r),
        clockwise: true,
      );
    }
    path.close();

    if (shadows != null && shadows!.isNotEmpty) {
      for (final shadow in shadows!) {
        final shadowPaint = Paint()
          ..color = shadow.color
          ..maskFilter = MaskFilter.blur(
            BlurStyle.normal,
            shadow.blurRadius * 0.57735 + 0.5,
          );
        canvas.drawPath(path.shift(shadow.offset), shadowPaint);
      }
    }

    canvas.drawPath(
      path,
      Paint()
        ..color = backgroundColor
        ..style = PaintingStyle.fill,
    );

    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    if (shape == VNavigationBarShape.flat) {
      final borderPath = Path()
        ..moveTo(0, 0)
        ..lineTo(center - effectiveRadius, 0)
        ..arcToPoint(
          Offset(center + effectiveRadius, 0),
          radius: Radius.circular(effectiveRadius),
          clockwise: false,
        )
        ..lineTo(size.width, 0);
      canvas.drawPath(borderPath, borderPaint);
    } else {
      canvas.drawPath(path, borderPaint);
    }
  }

  @override
  bool shouldRepaint(_NotchPainter oldDelegate) {
    return fabRadius != oldDelegate.fabRadius ||
        notchMargin != oldDelegate.notchMargin ||
        borderRadius != oldDelegate.borderRadius ||
        backgroundColor != oldDelegate.backgroundColor ||
        borderColor != oldDelegate.borderColor ||
        borderWidth != oldDelegate.borderWidth ||
        shadows != oldDelegate.shadows ||
        shape != oldDelegate.shape;
  }
}
