import 'package:flutter/widgets.dart';

import '../../foundation/motion.dart';
import '../../theme/v_motion_scope.dart';

/// Animated container that resolves timing from VidraUI motion tokens.
class VAnimatedBox extends StatelessWidget {
  const VAnimatedBox({
    super.key,
    this.motion,
    this.decoration,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.constraints,
    this.alignment,
    this.clipBehavior = Clip.none,
    this.child,
  });

  /// Motion spec used for the transition. Defaults to `motion.control`.
  final VMotionSpec? motion;
  final Decoration? decoration;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;
  final BoxConstraints? constraints;
  final AlignmentGeometry? alignment;
  final Clip clipBehavior;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final spec = motion ?? VMotionScope.of(context).control;

    return AnimatedContainer(
      duration: VMotionResolver.duration(context, spec),
      curve: VMotionResolver.curve(context, spec),
      decoration: decoration,
      padding: padding,
      margin: margin,
      width: width,
      height: height,
      constraints: constraints,
      alignment: alignment,
      clipBehavior: clipBehavior,
      child: child,
    );
  }
}

// ---------------------------------------------------------------------------
// Shared animated-presence base class
// ---------------------------------------------------------------------------

/// Shared state for widgets that animate a child in/out of the tree.
///
/// The three public widgets — [VAnimatedVisibility], [VAnimatedScaleFade],
/// and [VAnimatedSlideFade] — all share the same controller lifecycle,
/// animation configuration, and visibility management. Only their [build]
/// transition trees differ.
abstract class _VAnimatedPresenceState<T extends StatefulWidget>
    extends State<T> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late CurvedAnimation _animation;
  bool _includeChild = false;

  // -----------------------------------------------------------------------
  // Subclass contract
  // -----------------------------------------------------------------------

  /// Whether the child is currently visible.
  bool get _visible;

  /// Whether the child should be kept in the tree while hidden.
  bool get _maintainState;

  /// Optional motion override from the widget.
  VMotionSpec? get _motionOverride;

  /// Default motion spec for this transition type.
  VMotionSpec _defaultSpec(VMotion m);

  /// Reads the visible flag from a widget of type [T].
  bool _readVisible(T widget);

  // -----------------------------------------------------------------------
  // Lifecycle
  // -----------------------------------------------------------------------

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      value: _visible ? 1 : 0,
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _includeChild = _visible || _maintainState;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _configureAnimation();
  }

  @override
  void didUpdateWidget(covariant T oldWidget) {
    super.didUpdateWidget(oldWidget);
    _configureAnimation();
    if (_visible != _readVisible(oldWidget)) {
      _setVisible(_visible);
    } else if (_maintainState && !_includeChild) {
      setState(() => _includeChild = true);
    } else if (!_visible && !_maintainState && _includeChild) {
      setState(() => _includeChild = false);
    }
  }

  @override
  void dispose() {
    _animation.dispose();
    _controller.dispose();
    super.dispose();
  }

  // -----------------------------------------------------------------------
  // Animation helpers
  // -----------------------------------------------------------------------

  void _configureAnimation() {
    final spec = _motionOverride ?? _defaultSpec(VMotionScope.of(context));
    _controller.duration = VMotionResolver.duration(context, spec);
    _controller.reverseDuration =
        VMotionResolver.reverseDuration(context, spec);
    _animation.dispose();
    _animation = CurvedAnimation(
      parent: _controller,
      curve: VMotionResolver.curve(context, spec),
      reverseCurve: VMotionResolver.reverseCurve(context, spec),
    );
  }

  void _setVisible(bool visible) {
    if (visible) {
      setState(() => _includeChild = true);
      _controller.forward();
    } else {
      _controller.reverse().whenComplete(() {
        if (mounted && !_maintainState) {
          setState(() => _includeChild = false);
        }
      });
    }
  }
}

// ---------------------------------------------------------------------------
// VAnimatedVisibility
// ---------------------------------------------------------------------------

/// Fades a child in and out using VidraUI motion tokens.
class VAnimatedVisibility extends StatefulWidget {
  const VAnimatedVisibility({
    super.key,
    required this.visible,
    required this.child,
    this.motion,
    this.maintainState = false,
  });

  final bool visible;
  final Widget child;

  /// Motion spec used for the transition. Defaults to `motion.fast`.
  final VMotionSpec? motion;

  /// Whether to keep the child in the tree while hidden.
  final bool maintainState;

  @override
  State<VAnimatedVisibility> createState() => _VAnimatedVisibilityState();
}

class _VAnimatedVisibilityState
    extends _VAnimatedPresenceState<VAnimatedVisibility> {
  @override
  bool get _visible => widget.visible;

  @override
  bool get _maintainState => widget.maintainState;

  @override
  VMotionSpec? get _motionOverride => widget.motion;

  @override
  VMotionSpec _defaultSpec(VMotion m) => m.fast;

  @override
  bool _readVisible(VAnimatedVisibility w) => w.visible;

  @override
  Widget build(BuildContext context) {
    if (!_includeChild) return const SizedBox.shrink();

    return IgnorePointer(
      ignoring: !widget.visible,
      child: FadeTransition(
        opacity: _animation,
        child: widget.child,
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// VAnimatedScaleFade
// ---------------------------------------------------------------------------

/// Combines fade and scale transitions using VidraUI motion tokens.
class VAnimatedScaleFade extends StatefulWidget {
  const VAnimatedScaleFade({
    super.key,
    required this.visible,
    required this.child,
    this.motion,
    this.alignment = Alignment.center,
    this.beginScale = 0.96,
    this.maintainState = false,
  });

  final bool visible;
  final Widget child;

  /// Motion spec used for the transition. Defaults to `motion.overlay`.
  final VMotionSpec? motion;
  final Alignment alignment;
  final double beginScale;
  final bool maintainState;

  @override
  State<VAnimatedScaleFade> createState() => _VAnimatedScaleFadeState();
}

class _VAnimatedScaleFadeState
    extends _VAnimatedPresenceState<VAnimatedScaleFade> {
  @override
  bool get _visible => widget.visible;

  @override
  bool get _maintainState => widget.maintainState;

  @override
  VMotionSpec? get _motionOverride => widget.motion;

  @override
  VMotionSpec _defaultSpec(VMotion m) => m.overlay;

  @override
  bool _readVisible(VAnimatedScaleFade w) => w.visible;

  @override
  Widget build(BuildContext context) {
    if (!_includeChild) return const SizedBox.shrink();

    final scale = Tween<double>(
      begin: widget.beginScale,
      end: 1,
    ).animate(_animation);

    return IgnorePointer(
      ignoring: !widget.visible,
      child: FadeTransition(
        opacity: _animation,
        child: ScaleTransition(
          scale: scale,
          alignment: widget.alignment,
          child: widget.child,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// VAnimatedSlideFade
// ---------------------------------------------------------------------------

/// Combines fade and slide transitions using VidraUI motion tokens.
class VAnimatedSlideFade extends StatefulWidget {
  const VAnimatedSlideFade({
    super.key,
    required this.visible,
    required this.child,
    this.motion,
    this.beginOffset = const Offset(0, 0.08),
    this.maintainState = false,
  });

  final bool visible;
  final Widget child;

  /// Motion spec used for the transition. Defaults to `motion.overlay`.
  final VMotionSpec? motion;
  final Offset beginOffset;
  final bool maintainState;

  @override
  State<VAnimatedSlideFade> createState() => _VAnimatedSlideFadeState();
}

class _VAnimatedSlideFadeState
    extends _VAnimatedPresenceState<VAnimatedSlideFade> {
  @override
  bool get _visible => widget.visible;

  @override
  bool get _maintainState => widget.maintainState;

  @override
  VMotionSpec? get _motionOverride => widget.motion;

  @override
  VMotionSpec _defaultSpec(VMotion m) => m.overlay;

  @override
  bool _readVisible(VAnimatedSlideFade w) => w.visible;

  @override
  Widget build(BuildContext context) {
    if (!_includeChild) return const SizedBox.shrink();

    final position = Tween<Offset>(
      begin: widget.beginOffset,
      end: Offset.zero,
    ).animate(_animation);

    return VSlideFadeTransition(
      opacity: _animation,
      position: position,
      visible: widget.visible,
      child: widget.child,
    );
  }
}

// ---------------------------------------------------------------------------
// Shared slide-fade transition primitive
// ---------------------------------------------------------------------------

/// Package-private slide-fade transition widget.
///
/// Used by [VAnimatedSlideFade] and VAnimatedList's [_AnimatedListItemState].
/// Combines [IgnorePointer], [FadeTransition], and [SlideTransition] into
/// a single reusable widget.
class VSlideFadeTransition extends StatelessWidget {
  const VSlideFadeTransition({
    super.key,
    required this.opacity,
    required this.position,
    required this.visible,
    required this.child,
  });

  final Animation<double> opacity;
  final Animation<Offset> position;
  final bool visible;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !visible,
      child: FadeTransition(
        opacity: opacity,
        child: SlideTransition(
          position: position,
          child: child,
        ),
      ),
    );
  }
}
