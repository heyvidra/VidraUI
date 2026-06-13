import 'dart:async';

import 'package:flutter/widgets.dart';

import '../../foundation/motion.dart';
import '../../theme/v_motion_scope.dart';

/// Reveals children one by one with staggered delays.
///
/// Each child fades and slides in after a delay proportional to its index.
class VStagger extends StatefulWidget {
  const VStagger({
    super.key,
    required this.children,
    this.motion,
    this.delay = const Duration(milliseconds: 60),
    this.beginOffset = const Offset(0, 0.08),
    this.initialCount = 0,
  });

  final List<Widget> children;
  final VMotionSpec? motion;
  final Duration delay;
  final Offset beginOffset;
  final int initialCount;

  @override
  State<VStagger> createState() => _VStaggerState();
}

class _VStaggerState extends State<VStagger> {
  Timer? _revealTimer;
  int _visibleCount = 0;

  @override
  void initState() {
    super.initState();
    _visibleCount = widget.initialCount.clamp(0, widget.children.length);
    if (_visibleCount < widget.children.length) {
      WidgetsBinding.instance
          .addPostFrameCallback((_) => _scheduleRevealNext());
    }
  }

  @override
  void didUpdateWidget(VStagger oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.children.length != oldWidget.children.length ||
        widget.delay != oldWidget.delay) {
      _visibleCount = _visibleCount.clamp(0, widget.children.length);
      _scheduleRevealNext();
    }
  }

  void _scheduleRevealNext() {
    _revealTimer?.cancel();
    if (!mounted || _visibleCount >= widget.children.length) return;
    _revealTimer = Timer(widget.delay, () {
      if (!mounted) return;
      setState(() => _visibleCount++);
      _scheduleRevealNext();
    });
  }

  @override
  void dispose() {
    _revealTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final visibleCount = _visibleCount.clamp(0, widget.children.length);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: List.generate(visibleCount, (i) {
        return _StaggerItem(
          key: ValueKey(i),
          delay: widget.delay * i,
          motion: widget.motion,
          beginOffset: widget.beginOffset,
          child: widget.children[i],
        );
      }),
    );
  }
}

class _StaggerItem extends StatefulWidget {
  const _StaggerItem({
    super.key,
    required this.child,
    required this.delay,
    this.motion,
    this.beginOffset = const Offset(0, 0.08),
  });

  final Widget child;
  final Duration delay;
  final VMotionSpec? motion;
  final Offset beginOffset;

  @override
  State<_StaggerItem> createState() => _StaggerItemState();
}

class _StaggerItemState extends State<_StaggerItem>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl = AnimationController(vsync: this);
  late CurvedAnimation _opacity;
  late Animation<Offset> _slide;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(widget.delay, () {
      if (mounted) _ctrl.forward();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _configureAnimation();
  }

  void _configureAnimation() {
    final spec = widget.motion ?? VMotionScope.of(context).fast;
    _ctrl.duration = VMotionResolver.duration(context, spec);
    _opacity = CurvedAnimation(
      parent: _ctrl,
      curve: VMotionResolver.curve(context, spec),
    );
    _slide = Tween<Offset>(
      begin: widget.beginOffset,
      end: Offset.zero,
    ).animate(_opacity);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: SlideTransition(
        position: _slide,
        child: widget.child,
      ),
    );
  }
}
