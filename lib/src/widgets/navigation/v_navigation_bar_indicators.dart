part of 'v_navigation_bar.dart';

class _PillIndicator extends StatelessWidget {
  const _PillIndicator({
    required this.left,
    required this.topOffset,
    required this.width,
    required this.height,
    required this.color,
    required this.radius,
    required this.duration,
    required this.curve,
  });

  final double left;
  final double topOffset;
  final double width;
  final double height;
  final Color color;
  final double radius;
  final Duration duration;
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: duration,
      curve: curve,
      left: left,
      top: topOffset,
      width: width,
      height: height,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}

class _DotIndicator extends StatelessWidget {
  const _DotIndicator({
    required this.left,
    required this.barHeight,
    required this.dotSize,
    required this.color,
    required this.duration,
    required this.curve,
    required this.showLabels,
  });

  final double left;
  final double barHeight;
  final double dotSize;
  final Color color;
  final Duration duration;
  final Curve curve;
  final bool showLabels;

  @override
  Widget build(BuildContext context) {
    final dotTop = barHeight - dotSize - (showLabels ? 6 : 8);
    return AnimatedPositioned(
      duration: duration,
      curve: curve,
      left: left,
      top: dotTop,
      width: dotSize,
      height: dotSize,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

class _TopLineIndicator extends StatelessWidget {
  const _TopLineIndicator({
    required this.left,
    required this.width,
    required this.lineHeight,
    required this.color,
    required this.duration,
    required this.curve,
  });

  final double left;
  final double width;
  final double lineHeight;
  final Color color;
  final Duration duration;
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: duration,
      curve: curve,
      left: left,
      top: 0,
      width: width,
      height: lineHeight,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(lineHeight / 2),
          ),
        ),
      ),
    );
  }
}
