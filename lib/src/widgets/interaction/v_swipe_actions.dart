import 'dart:async';

import 'package:flutter/widgets.dart';

import '../../theme/v_theme.dart';

/// Which side actions are revealed on.
enum VSwipeActionSide { start, end }

/// How the swipe container behaves after release.
enum VSwipeActionBehavior {
  /// Snaps open when dragged past threshold.
  reveal,

  /// Always snaps closed on release.
  transient,
}

/// A container that reveals action widgets when swiped horizontally.
///
/// In LTR: swipe right → start actions; swipe left → end actions.
/// In RTL: the mapping is reversed to respect text direction.
class VSwipeActions extends StatefulWidget {
  const VSwipeActions({
    super.key,
    required this.child,
    this.startAction,
    this.endAction,
    this.startActions,
    this.endActions,
    this.behavior = VSwipeActionBehavior.reveal,
    this.enabled = true,
    this.threshold = 0.35,
    this.autoClose = true,
    this.closeOnTap = true,
    this.onOpenChanged,
    this.semanticLabel,
  }) : assert(threshold >= 0.0 && threshold <= 1.0);

  final Widget child;
  final Widget? startAction;
  final Widget? endAction;
  final List<Widget>? startActions;
  final List<Widget>? endActions;
  final VSwipeActionBehavior behavior;
  final bool enabled;
  final double threshold;
  final bool autoClose;
  final bool closeOnTap;
  final ValueChanged<VSwipeActionSide?>? onOpenChanged;
  final String? semanticLabel;

  @override
  State<VSwipeActions> createState() => _VSwipeActionsState();
}

class _VSwipeActionsState extends State<VSwipeActions>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  double _offset = 0;
  double _animationStart = 0;
  double _animationEnd = 0;
  double _startExtent = 0;
  double _endExtent = 0;
  VSwipeActionSide? _openSide;

  List<Widget> get _startActions {
    final explicit = widget.startActions;
    if (explicit != null && explicit.isNotEmpty) return explicit;
    final single = widget.startAction;
    return single != null ? [single] : const [];
  }

  List<Widget> get _endActions {
    final explicit = widget.endActions;
    if (explicit != null && explicit.isNotEmpty) return explicit;
    final single = widget.endAction;
    return single != null ? [single] : const [];
  }

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
    );
    _ctrl.addListener(_onAnimate);
  }

  @override
  void dispose() {
    _ctrl.removeListener(_onAnimate);
    _ctrl.dispose();
    super.dispose();
  }

  void _onAnimate() {
    if (!mounted) return;
    setState(() {
      _offset =
          _animationStart + (_animationEnd - _animationStart) * _ctrl.value;
    });
  }

  void _snapTo(double target) {
    final theme = VTheme.of(context);
    _ctrl
      ..stop()
      ..duration = theme.motion.control.duration;
    _animationStart = _offset;
    _animationEnd = target;
    _ctrl.forward(from: 0);
  }

  void _snapOpen(VSwipeActionSide side) {
    final extent = side == VSwipeActionSide.start ? _startExtent : _endExtent;
    final dir = _directionFor(side);
    _snapTo(dir > 0 ? extent : -extent);
    if (_openSide != side) {
      _openSide = side;
      widget.onOpenChanged?.call(side);
    }
  }

  void _snapClosed() {
    _snapTo(0);
    if (_openSide != null) {
      _openSide = null;
      widget.onOpenChanged?.call(null);
    }
  }

  /// +1 means dragging this direction reveals start.
  int _directionFor(VSwipeActionSide side) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    return switch (side) {
      VSwipeActionSide.start => isRtl ? -1 : 1,
      VSwipeActionSide.end => isRtl ? 1 : -1,
    };
  }

  void _onHorizontalDragUpdate(DragUpdateDetails d) {
    if (!widget.enabled) return;
    _ctrl.stop();
    setState(() {
      _offset = (_offset + d.delta.dx).clamp(-_endExtent, _startExtent);
    });
  }

  void _onHorizontalDragEnd(DragEndDetails d) {
    if (!widget.enabled) return;
    final absOffset = _offset.abs();
    final velocity = d.velocity.pixelsPerSecond.dx;
    if (widget.behavior == VSwipeActionBehavior.transient) {
      _snapClosed();
      return;
    }
    // Check if past threshold for either side.
    if (_offset > 0 &&
        _startExtent > 0 &&
        (absOffset >= _startExtent * widget.threshold || velocity > 450)) {
      _snapOpen(VSwipeActionSide.start);
    } else if (_offset < 0 &&
        _endExtent > 0 &&
        (absOffset >= _endExtent * widget.threshold || velocity < -450)) {
      _snapOpen(VSwipeActionSide.end);
    } else {
      _snapClosed();
    }
  }

  void _onTap() {
    if (widget.closeOnTap && _openSide != null && widget.enabled) {
      _snapClosed();
    }
  }

  void _onActionPointerUp() {
    if (!widget.autoClose || !widget.enabled) return;
    unawaited(Future<void>.microtask(() {
      if (mounted) _snapClosed();
    }));
  }

  void _onTapOutside(PointerDownEvent event) {
    if (_openSide != null && widget.enabled) {
      _snapClosed();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);

    final startActions = _startActions;
    final endActions = _endActions;

    // Use a fixed action extent derived from sizes.
    final defaultExtent = theme.sizes.controlLg * 2.5;
    _startExtent = startActions.isNotEmpty ? defaultExtent : 0;
    _endExtent = endActions.isNotEmpty ? defaultExtent : 0;
    final clampedOffset = _offset.clamp(-_endExtent, _startExtent).toDouble();
    if (clampedOffset != _offset) {
      _offset = clampedOffset;
    }

    return TapRegion(
      onTapOutside: _onTapOutside,
      child: Semantics(
        label: widget.semanticLabel,
        child: GestureDetector(
          onTap: _onTap,
          child: Stack(
            clipBehavior: Clip.hardEdge,
            children: [
              // Behind — action backgrounds
              if (startActions.isNotEmpty)
                PositionedDirectional(
                  start: 0,
                  top: 0,
                  bottom: 0,
                  width: _startExtent,
                  child: _ActionRow(
                    actions: startActions,
                    side: VSwipeActionSide.start,
                    visible: _openSide == VSwipeActionSide.start ||
                        (_offset.abs() > 2),
                    onPointerUp: _onActionPointerUp,
                  ),
                ),
              if (endActions.isNotEmpty)
                PositionedDirectional(
                  end: 0,
                  top: 0,
                  bottom: 0,
                  width: _endExtent,
                  child: _ActionRow(
                    actions: endActions,
                    side: VSwipeActionSide.end,
                    visible: _openSide == VSwipeActionSide.end ||
                        (_offset.abs() > 2),
                    onPointerUp: _onActionPointerUp,
                  ),
                ),
              // Front — content
              Transform.translate(
                offset: Offset(_offset, 0),
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onHorizontalDragUpdate: _onHorizontalDragUpdate,
                  onHorizontalDragEnd: _onHorizontalDragEnd,
                  child: widget.child,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionRow extends StatelessWidget {
  const _ActionRow({
    required this.actions,
    required this.side,
    required this.visible,
    required this.onPointerUp,
  });

  final List<Widget> actions;
  final VSwipeActionSide side;
  final bool visible;
  final VoidCallback onPointerUp;

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);

    return ExcludeSemantics(
      excluding: !visible,
      child: IgnorePointer(
        ignoring: !visible,
        child: Listener(
          onPointerUp: (_) => onPointerUp(),
          child: AnimatedOpacity(
            duration: theme.motion.control.duration,
            opacity: visible ? 1.0 : 0.0,
            child: ClipRect(
              child: Row(
                children: actions.map((w) => Expanded(child: w)).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
