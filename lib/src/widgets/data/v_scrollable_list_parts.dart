part of 'v_scrollable_list.dart';

class _LazyAnimatedListItem extends StatefulWidget {
  const _LazyAnimatedListItem({
    super.key,
    required this.child,
    required this.animate,
  });

  final Widget child;
  final bool animate;

  @override
  State<_LazyAnimatedListItem> createState() => _LazyAnimatedListItemState();
}

class _LazyAnimatedListItemState extends State<_LazyAnimatedListItem>
    with TickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double> _opacity = const AlwaysStoppedAnimation<double>(1);
  Animation<Offset> _slide = const AlwaysStoppedAnimation<Offset>(Offset.zero);
  bool _configured = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!widget.animate || _configured) return;

    final motion = VTheme.of(context).motion;
    final duration =
        motion.reducedMotion ? Duration.zero : motion.normal.duration;
    final curve = motion.reducedMotion ? Curves.linear : motion.normal.curve;

    _controller = AnimationController(
      vsync: this,
      duration: duration,
    );

    _opacity = CurvedAnimation(parent: _controller!, curve: curve);
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.06),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller!, curve: curve));

    _controller!.forward();
    _configured = true;
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.animate) {
      return widget.child;
    }
    return FadeTransition(
      opacity: _opacity,
      child: SlideTransition(
        position: _slide,
        child: widget.child,
      ),
    );
  }
}

class _DefaultRefreshIndicator extends StatelessWidget {
  const _DefaultRefreshIndicator({
    required this.pulledExtent,
    required this.triggerDistance,
    required this.refreshing,
  });

  final double pulledExtent;
  final double triggerDistance;
  final bool refreshing;

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);
    final armed = pulledExtent >= triggerDistance;
    final label = refreshing
        ? 'Refreshing'
        : armed
            ? 'Release to refresh'
            : 'Pull to refresh';
    return Center(
      child: Semantics(
        liveRegion: refreshing,
        label: label,
        child: VFlex.horizontal(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const VSpinner(size: 16),
            SizedBox(width: theme.spacing.sm),
            VText(label, variant: VTextVariant.caption),
          ],
        ),
      ),
    );
  }
}



class _DefaultScrollButton extends StatelessWidget {
  const _DefaultScrollButton({
    required this.semanticLabel,
    required this.direction,
    required this.onPressed,
  });

  final String semanticLabel;
  final AxisDirection direction;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return VButton(
      onPressed: onPressed,
      shape: VButtonShape.circle,
      size: VControlSize.sm,
      semanticLabel: semanticLabel,
      child: SizedBox.square(
        dimension: 16,
        child: _ArrowGlyph(direction: direction),
      ),
    );
  }
}

class _ArrowGlyph extends StatelessWidget {
  const _ArrowGlyph({required this.direction});

  final AxisDirection direction;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _ArrowGlyphPainter(
        color: VTheme.of(context).colors.text,
        direction: direction,
      ),
    );
  }
}

class _ArrowGlyphPainter extends CustomPainter {
  const _ArrowGlyphPainter({
    required this.color,
    required this.direction,
  });

  final Color color;
  final AxisDirection direction;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    final path = Path();
    final top = size.height * 0.28;
    final mid = size.height * 0.5;
    final bottom = size.height * 0.72;
    final left = size.width * 0.28;
    final center = size.width * 0.5;
    final right = size.width * 0.72;

    if (direction == AxisDirection.up) {
      path
        ..moveTo(left, mid)
        ..lineTo(center, top)
        ..lineTo(right, mid)
        ..moveTo(center, top)
        ..lineTo(center, bottom);
    } else {
      path
        ..moveTo(left, mid)
        ..lineTo(center, bottom)
        ..lineTo(right, mid)
        ..moveTo(center, top)
        ..lineTo(center, bottom);
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_ArrowGlyphPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.direction != direction;
  }
}


