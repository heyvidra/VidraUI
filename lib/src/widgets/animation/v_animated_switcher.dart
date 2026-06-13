import 'package:flutter/widgets.dart';

import '../../foundation/motion.dart';
import '../../theme/v_motion_scope.dart';

// ---------------------------------------------------------------------------
// Enums & typedefs
// ---------------------------------------------------------------------------

/// Pre-built content transition types for [VAnimatedSwitcher].
enum VContentTransition { fade, slide, scaleFade }

/// Builds an animated transition wrapper around [child].
typedef VTransitionBuilder = Widget Function(
  BuildContext context,
  Widget child,
  Animation<double> animation,
);

// ---------------------------------------------------------------------------
// Controller
// ---------------------------------------------------------------------------

/// Drives [VAnimatedSwitcher] and automatically tracks direction.
class VAnimatedSwitcherController extends ChangeNotifier {
  VAnimatedSwitcherController({int initialIndex = 0, int count = 0})
    : _index = initialIndex.clamp(0, count > 0 ? count - 1 : 0),
      _count = count,
      _previousIndex = initialIndex.clamp(0, count > 0 ? count - 1 : 0);

  int _index;
  int _count;
  int _previousIndex;

  /// Current child index.
  int get index => _index;

  /// Previous index (set automatically on every change).
  int get previousIndex => _previousIndex;

  /// Total number of children.
  int get count => _count;

  /// Whether the last change was forward.
  bool get isForward => _index > _previousIndex;

  /// Whether the last change was backward.
  bool get isBackward => _index < _previousIndex;

  /// Jump to [i] (clamped).  Notifies listeners.
  void jumpTo(int i) {
    final clamped = i.clamp(0, _count > 0 ? _count - 1 : 0);
    if (clamped == _index) return;
    _previousIndex = _index;
    _index = clamped;
    notifyListeners();
  }

  /// Move to the next child (wraps around).
  void next() => jumpTo((_index + 1) % _count);

  /// Move to the previous child (wraps around).
  void previous() => jumpTo((_index - 1 + _count) % _count);

  /// Update total count (e.g. after loading more children).
  /// Clamps [index] if needed.
  void updateCount(int newCount) {
    _count = newCount;
    if (_index >= _count && _count > 0) {
      _index = _count - 1;
    }
    notifyListeners();
  }
}

// ---------------------------------------------------------------------------
// VAnimatedSwitcher
// ---------------------------------------------------------------------------

/// Switches between multiple children with animated enter / exit transitions.
///
/// ```dart
/// final _ctrl = VAnimatedSwitcherController(count: 3);
///
/// VAnimatedSwitcher(
///   controller: _ctrl,
///   transition: VContentTransition.slide,
///   children: [PageA(), PageB(), PageC()],
/// )
///
/// _ctrl.next(); // slide left
/// _ctrl.previous(); // slide right
/// ```
class VAnimatedSwitcher extends StatefulWidget {
  const VAnimatedSwitcher({
    super.key,
    required this.controller,
    required this.children,
    this.transition,
    this.motion,
    this.enterTransition,
    this.exitTransition,
  });

  /// Controller that selects the active child and tracks direction.
  final VAnimatedSwitcherController controller;

  /// All children in order.
  final List<Widget> children;

  /// Pre-built transition.  Ignored if custom builders are provided.
  final VContentTransition? transition;

  /// Motion spec.  Defaults to [VMotionScope.of].normal.
  final VMotionSpec? motion;

  /// Custom enter transition builder.
  final VTransitionBuilder? enterTransition;

  /// Custom exit transition builder.
  final VTransitionBuilder? exitTransition;

  @override
  State<VAnimatedSwitcher> createState() => _VAnimatedSwitcherState();
}

class _VAnimatedSwitcherState extends State<VAnimatedSwitcher>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  int _currentIndex = 0;
  Widget? _exitingChild;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.controller.index;
    _ctrl = AnimationController(vsync: this, value: 1.0);
    widget.controller.addListener(_onControllerChanged);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final spec = widget.motion ?? VMotionScope.of(context).normal;
    _ctrl.duration = VMotionResolver.duration(context, spec);
  }

  @override
  void didUpdateWidget(VAnimatedSwitcher oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller.removeListener(_onControllerChanged);
      widget.controller.addListener(_onControllerChanged);
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onControllerChanged);
    _ctrl.dispose();
    super.dispose();
  }

  void _onControllerChanged() {
    if (widget.controller.index == _currentIndex) return;
    final oldChild = _childAt(_currentIndex);
    _currentIndex = widget.controller.index;
    _exitingChild = oldChild;
    _ctrl.forward(from: 0).then((_) {
      if (mounted) setState(() => _exitingChild = null);
    });
    setState(() {});
  }

  Widget _childAt(int i) {
    if (i < 0 || i >= widget.children.length) return const SizedBox.shrink();
    return KeyedSubtree(key: ValueKey(i), child: widget.children[i]);
  }

  // ── build ─────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final hasExit = _exitingChild != null;
    final t = widget.transition ?? VContentTransition.fade;
    final enterBuilder = widget.enterTransition ?? _defaultEnter(t);
    final exitBuilder = widget.exitTransition ?? _defaultExit(t);

    final enterWidget = enterBuilder(
      context,
      _childAt(_currentIndex),
      _ctrl.view,
    );

    if (!hasExit) return enterWidget;

    return Stack(
      fit: StackFit.passthrough,
      children: [
        exitBuilder(context, _exitingChild!, ReverseAnimation(_ctrl.view)),
        enterWidget,
      ],
    );
  }

  // ── default transitions ───────────────────────────────────────

  VTransitionBuilder _defaultEnter(VContentTransition t) => switch (t) {
    VContentTransition.fade => _fadeEnter,
    VContentTransition.slide => _slideEnter,
    VContentTransition.scaleFade => _scaleFadeEnter,
  };

  VTransitionBuilder _defaultExit(VContentTransition t) => switch (t) {
    VContentTransition.fade => _fadeExit,
    VContentTransition.slide => _slideExit,
    VContentTransition.scaleFade => _scaleFadeExit,
  };

  static Widget _fadeEnter(BuildContext c, Widget w, Animation<double> a) =>
      FadeTransition(opacity: a, child: w);
  static Widget _fadeExit(BuildContext c, Widget w, Animation<double> a) =>
      FadeTransition(opacity: a, child: w);

  // slide — direction auto-inferred from controller
  Widget _slideEnter(BuildContext c, Widget w, Animation<double> a) {
    final isForward = widget.controller.isForward;
    final begin = Offset(isForward ? 1 : -1, 0);
    return SlideTransition(
      position: Tween<Offset>(begin: begin, end: Offset.zero).animate(a),
      child: w,
    );
  }

  Widget _slideExit(BuildContext c, Widget w, Animation<double> a) {
    final isForward = widget.controller.isForward;
    final end = Offset(isForward ? -1 : 1, 0);
    return SlideTransition(
      position: Tween<Offset>(begin: Offset.zero, end: end).animate(a),
      child: w,
    );
  }

  static Widget _scaleFadeEnter(BuildContext c, Widget w, Animation<double> a) {
    final scale = Tween<double>(begin: 0.95, end: 1.0).animate(
      CurvedAnimation(parent: a, curve: Curves.easeOutCubic),
    );
    return FadeTransition(opacity: a, child: ScaleTransition(scale: scale, child: w));
  }

  static Widget _scaleFadeExit(BuildContext c, Widget w, Animation<double> a) {
    final scale = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: a, curve: Curves.easeInCubic),
    );
    return FadeTransition(opacity: a, child: ScaleTransition(scale: scale, child: w));
  }
}
