import 'dart:async';

import 'package:flutter/widgets.dart';

import '../../foundation/motion.dart';
import 'v_animated.dart';

/// An animated list that fades and slides items in as they appear.
class VAnimatedList extends StatefulWidget {
  const VAnimatedList({
    super.key,
    required this.children,
    this.gap = 0,
    this.motion,
    this.padding,
    this.controller,
    this.scrollDirection = Axis.vertical,
  });

  final List<Widget> children;
  final double gap;
  final VMotion? motion;
  final EdgeInsetsGeometry? padding;
  final ScrollController? controller;
  final Axis scrollDirection;

  @override
  State<VAnimatedList> createState() => _VAnimatedListState();
}

class _VAnimatedListState extends State<VAnimatedList> {
  Timer? _revealTimer;
  int _visibleCount = 0;

  @override
  void initState() {
    super.initState();
    _scheduleRevealNext();
  }

  @override
  void didUpdateWidget(VAnimatedList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.children.length != oldWidget.children.length) {
      _visibleCount = _visibleCount.clamp(0, widget.children.length);
      _scheduleRevealNext();
    }
  }

  void _scheduleRevealNext() {
    _revealTimer?.cancel();
    if (_visibleCount >= widget.children.length) return;
    _revealTimer = Timer(const Duration(milliseconds: 60), () {
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
    final motion = widget.motion ?? VMotion.defaults();

    return SingleChildScrollView(
      controller: widget.controller,
      scrollDirection: widget.scrollDirection,
      padding: widget.padding,
      child: _buildFlex(motion),
    );
  }

  Widget _buildFlex(VMotion motion) {
    final visibleCount = _visibleCount.clamp(0, widget.children.length);
    final children = List.generate(visibleCount, (i) {
      final delay = motion.control.duration * i;
      Widget item = widget.children[i];
      if (widget.gap > 0 && i > 0) {
        item = Padding(
          padding: widget.scrollDirection == Axis.vertical
              ? EdgeInsets.only(top: widget.gap)
              : EdgeInsets.only(left: widget.gap),
          child: item,
        );
      }
      return _AnimatedListItem(
        key: ValueKey(i),
        delay: delay,
        curve: motion.normal.curve,
        duration: motion.normal.duration,
        scrollDirection: widget.scrollDirection,
        child: item,
      );
    });

    if (widget.scrollDirection == Axis.horizontal) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: children,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }
}

class _AnimatedListItem extends StatefulWidget {
  const _AnimatedListItem({
    super.key,
    required this.child,
    required this.delay,
    required this.curve,
    required this.duration,
    required this.scrollDirection,
  });

  final Widget child;
  final Duration delay;
  final Curve curve;
  final Duration duration;
  final Axis scrollDirection;

  @override
  State<_AnimatedListItem> createState() => _AnimatedListItemState();
}

class _AnimatedListItemState extends State<_AnimatedListItem>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final CurvedAnimation _curved;
  late final Animation<double> _opacity;
  late final Animation<Offset> _slide;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _curved = CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    );
    _opacity = _curved;
    _slide = Tween<Offset>(
      begin: widget.scrollDirection == Axis.vertical
          ? const Offset(0, 0.08)
          : const Offset(0.08, 0),
      end: Offset.zero,
    ).animate(_curved);

    _timer = Timer(widget.delay, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _curved.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VSlideFadeTransition(
      opacity: _opacity,
      position: _slide,
      visible: true,
      child: widget.child,
    );
  }
}
