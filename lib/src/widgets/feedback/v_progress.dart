import 'dart:math';

import 'package:flutter/widgets.dart';

import '../../theme/v_motion_scope.dart';
import '../../theme/v_theme.dart';

/// A linear progress bar.
///
/// Set [value] to null for indeterminate mode (animated bar).
class VProgressBar extends StatelessWidget {
  const VProgressBar({
    super.key,
    this.value,
    this.backgroundColor,
    this.foregroundColor,
    this.height = 6,
  });

  final double? value;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double height;

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);
    final bg = backgroundColor ?? theme.colors.border;
    final fg = foregroundColor ?? theme.colors.actionPrimary;

    if (value == null) {
      return Semantics(
        label: 'Loading',
        child: _IndeterminateBar(height: height, bg: bg, fg: fg),
      );
    }

    final clamped = (value!).clamp(0.0, 1.0);
    return Semantics(
      value: '${(clamped * 100).round()}%',
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(height / 2),
        ),
        child: SizedBox(
          height: height,
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: clamped,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: fg,
                borderRadius: BorderRadius.circular(height / 2),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _IndeterminateBar extends StatefulWidget {
  const _IndeterminateBar({
    required this.height,
    required this.bg,
    required this.fg,
  });

  final double height;
  final Color bg;
  final Color fg;

  @override
  State<_IndeterminateBar> createState() => _IndeterminateBarState();
}

class _IndeterminateBarState extends State<_IndeterminateBar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final spec = VMotionScope.of(context).slow;
    _controller.duration = VMotionResolver.duration(context, spec);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.height / 2),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: widget.bg,
        ),
        child: SizedBox(
          height: widget.height,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  final width = constraints.maxWidth;
                  final barWidth = width * 0.35;
                  final left =
                      -barWidth + (width + barWidth) * _controller.value;
                  return Stack(
                    children: [
                      Positioned(
                        left: left,
                        top: 0,
                        bottom: 0,
                        width: barWidth,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: widget.fg,
                            borderRadius:
                                BorderRadius.circular(widget.height / 2),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

/// A circular indeterminate spinner.
class VSpinner extends StatefulWidget {
  const VSpinner({
    super.key,
    this.size = 24,
    this.color,
    this.strokeWidth = 2.5,
  });

  final double size;
  final Color? color;
  final double strokeWidth;

  @override
  State<VSpinner> createState() => _VSpinnerState();
}

class _VSpinnerState extends State<VSpinner>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final spec = VMotionScope.of(context).slow;
    _controller.duration = VMotionResolver.duration(context, spec);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);
    final color = widget.color ?? theme.colors.actionPrimary;

    return Semantics(
      child: SizedBox(
        width: widget.size,
        height: widget.size,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return CustomPaint(
              painter: _SpinnerPainter(
                color: color,
                strokeWidth: widget.strokeWidth,
                progress: _controller.value,
              ),
            );
          },
        ),
      ),
    );
  }
}

class _SpinnerPainter extends CustomPainter {
  _SpinnerPainter({
    required this.color,
    required this.strokeWidth,
    required this.progress,
  });

  final Color color;
  final double strokeWidth;
  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final startAngle = progress * pi * 2;
    const sweepAngle = pi * 1.2;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(_SpinnerPainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.color != color;
}

/// A small animated loading indicator — three pulsing dots.
///
/// Originally lived in [VButton] internals; moved here so other widgets
/// can reuse it as a standalone progress primitive.
class VLoadingDots extends StatefulWidget {
  const VLoadingDots({super.key, required this.color});

  final Color color;
  static const _dotSize = 4.0;

  @override
  State<VLoadingDots> createState() => _VLoadingDotsState();
}

class _VLoadingDotsState extends State<VLoadingDots>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl = AnimationController(
    duration: const Duration(milliseconds: 900),
    vsync: this,
  )..repeat();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final spec = VMotionScope.of(context).slow;
    _ctrl.duration = VMotionResolver.duration(context, spec);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (context, _) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(3, (i) {
            final delay = i * 0.2;
            final t = ((_ctrl.value - delay) % 1.0).clamp(0.0, 1.0);
            final opacity = 0.3 + 0.7 * (1 - (t - 0.5).abs() * 2);

            return Container(
              width: VLoadingDots._dotSize,
              height: VLoadingDots._dotSize,
              margin: EdgeInsets.only(left: i > 0 ? 3 : 0),
              decoration: BoxDecoration(
                color: widget.color.withValues(alpha: opacity),
                shape: BoxShape.circle,
              ),
            );
          }),
        );
      },
    );
  }
}
