import 'package:flutter/widgets.dart';

import '../../theme/v_theme.dart';

/// An animated chevron arrow that rotates 180° when [isOpen] is true.
///
/// Typically used as a dropdown indicator in select menus and expandable
/// sections.
class VChevronIcon extends StatelessWidget {
  const VChevronIcon({
    super.key,
    required this.isOpen,
    required this.color,
    this.size = 16,
  });

  /// Whether the chevron points downward (open state).
  final bool isOpen;

  /// Colour of the chevron stroke.
  final Color color;

  /// Width and height of the icon bounding box.
  final double size;

  @override
  Widget build(BuildContext context) {
    final motion = VTheme.of(context).motion;
    return AnimatedRotation(
      turns: isOpen ? 0.5 : 0.0,
      duration: motion.control.duration,
      curve: motion.control.curve,
      child: CustomPaint(
        size: Size(size, size),
        painter: _VChevronPainter(color: color),
      ),
    );
  }
}

class _VChevronPainter extends CustomPainter {
  const _VChevronPainter({required this.color});
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final path = Path()
      ..moveTo(size.width * 0.2, size.height * 0.35)
      ..lineTo(size.width * 0.5, size.height * 0.65)
      ..lineTo(size.width * 0.8, size.height * 0.35);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _VChevronPainter oldDelegate) =>
      oldDelegate.color != color;
}
