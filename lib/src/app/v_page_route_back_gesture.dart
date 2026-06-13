import 'package:flutter/widgets.dart';

// ---------------------------------------------------------------------------
// VBackGestureScope — InheritedWidget providing gesture context
// ---------------------------------------------------------------------------

/// Provides back-gesture configuration to descendants.
///
/// Inserted by [VPageRoute.transitionsBuilder]. [VBackGestureDetector]
/// reads this scope to drive the route's animation controller and trigger
/// pop on confirmed swipe-to-back.
class VBackGestureScope extends InheritedWidget {
  const VBackGestureScope({
    super.key,
    required this.controller,
    required this.onCommitPop,
    required this.isGestureEnabled,
    required super.child,
  });

  /// The route's animation controller, used to drive the transition
  /// during swipe-to-back. Null if the route is not a [VPageRoute].
  final AnimationController? controller;

  /// Called when the user commits the back gesture (drag > threshold).
  final VoidCallback onCommitPop;

  /// Whether the back gesture should be active for this route.
  /// False disables the gesture detector entirely.
  final bool isGestureEnabled;

  /// Returns the nearest [VBackGestureScope] above this context.
  static VBackGestureScope? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<VBackGestureScope>();
  }

  /// Returns the nearest [VBackGestureScope] above this context.
  static VBackGestureScope of(BuildContext context) {
    final scope = maybeOf(context);
    assert(scope != null, 'No VBackGestureScope found in context');
    return scope!;
  }

  @override
  bool updateShouldNotify(VBackGestureScope oldWidget) =>
      controller != oldWidget.controller ||
      isGestureEnabled != oldWidget.isGestureEnabled;
}

// ---------------------------------------------------------------------------
// VBackGestureDetector — edge-swipe-to-back
// ---------------------------------------------------------------------------

/// Swipe-to-back gesture detector for horizontal edge swipes.
///
/// Drives the route's animation controller directly via [VBackGestureScope],
/// only calling [NavigatorState.pop] at the end if the user committed the
/// gesture.
class VBackGestureDetector extends StatefulWidget {
  const VBackGestureDetector({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<VBackGestureDetector> createState() => _VBackGestureDetectorState();
}

class _VBackGestureDetectorState extends State<VBackGestureDetector> {
  double _startDx = 0.0;
  bool _isDragging = false;
  double _currentFraction = 0.0;

  NavigatorState get _navigator => Navigator.of(context);

  void _handleDragStart(DragStartDetails details) {
    final scope = VBackGestureScope.maybeOf(context);
    if (scope == null || !scope.isGestureEnabled) return;
    final x = details.globalPosition.dx;
    if (x <= 20.0) {
      _startDx = x;
      _isDragging = true;
      _currentFraction = 0.0;
      _navigator.didStartUserGesture();
    }
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    if (!_isDragging) return;
    final scope = VBackGestureScope.maybeOf(context);
    if (scope == null) return;
    final width = MediaQuery.sizeOf(context).width;
    if (width <= 0) return;
    final dragDistance = details.globalPosition.dx - _startDx;
    _currentFraction = (dragDistance / width).clamp(0.0, 1.0);
    final ctrl = scope.controller;
    if (ctrl != null) {
      ctrl.value = 1.0 - _currentFraction;
    }
  }

  void _handleDragEnd(DragEndDetails details) {
    if (!_isDragging) return;
    _isDragging = false;
    final scope = VBackGestureScope.maybeOf(context);
    if (scope == null) return;

    final velocityX = details.velocity.pixelsPerSecond.dx;
    final shouldPop = _currentFraction > 0.35 || velocityX > 200.0;

    if (shouldPop) {
      _commitPop(scope);
    } else {
      _restoreRoute(scope);
    }
  }

  void _commitPop(VBackGestureScope scope) {
    final controller = scope.controller;
    if (controller == null) {
      _navigator.didStopUserGesture();
      _navigator.pop();
      return;
    }
    final totalMs = controller.duration?.inMilliseconds ?? 300;
    final duration = Duration(
      milliseconds: (controller.value * totalMs).round(),
    );
    controller
        .animateBack(0.0, duration: duration, curve: Curves.easeOutCubic)
        .whenCompleteOrCancel(() {
      _navigator.didStopUserGesture();
      if (controller.isDismissed) {
        _navigator.pop();
      }
    });
  }

  void _restoreRoute(VBackGestureScope scope) {
    _navigator.didStopUserGesture();
    final controller = scope.controller;
    if (controller == null) return;
    final totalMs = controller.duration?.inMilliseconds ?? 300;
    final duration = Duration(
      milliseconds: ((1.0 - controller.value) * totalMs).round(),
    );
    controller.animateTo(1.0, duration: duration, curve: Curves.easeOutCubic);
  }

  void _handleDragCancel() {
    if (!_isDragging) return;
    _isDragging = false;
    final scope = VBackGestureScope.maybeOf(context);
    if (scope == null) return;
    _navigator.didStopUserGesture();
    scope.controller?.animateTo(1.0, curve: Curves.easeOutCubic);
  }

  @override
  Widget build(BuildContext context) {
    final scope = VBackGestureScope.maybeOf(context);
    if (scope == null || !scope.isGestureEnabled) {
      return widget.child;
    }

    return GestureDetector(
      onHorizontalDragStart: _handleDragStart,
      onHorizontalDragUpdate: _handleDragUpdate,
      onHorizontalDragEnd: _handleDragEnd,
      onHorizontalDragCancel: _handleDragCancel,
      behavior: HitTestBehavior.translucent,
      child: widget.child,
    );
  }
}
