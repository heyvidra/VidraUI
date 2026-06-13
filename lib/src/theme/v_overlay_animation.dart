import 'package:flutter/widgets.dart';

import '../foundation/motion.dart';
import 'v_motion_scope.dart';

// ---------------------------------------------------------------------------
// Mixin: VOverlayAnimationState
// ---------------------------------------------------------------------------

/// Mixin for [State] classes that use [VOverlayAnimation] and need to
/// capture the controller + manage a [CurvedAnimation] lifecycle.
///
/// Encapsulates the common pattern:
/// - capture [AnimationController] from [VOverlayAnimation.builder]
/// - create/recreate a [CurvedAnimation] from a [VMotionSpec]
/// - idempotent closing guard that reverses the controller
/// - dispose of the [CurvedAnimation] in [State.dispose]
///
/// Usage:
/// ```dart
/// class _MyState extends State<MyWidget> with VOverlayAnimationState {
///   @override
///   Widget build(BuildContext context) {
///     return VOverlayAnimation(
///       motionSpec: spec,
///       onReverseComplete: onDismissed,
///       builder: (ctx, controller) {
///         final curved = setupOverlayAnimation(controller, spec, ctx);
///         // ... use curved ...
///       },
///     );
///   }
///
///   @override
///   void dispose() {
///     disposeOverlayAnimation();
///     super.dispose();
///   }
/// }
/// ```
mixin VOverlayAnimationState<S extends StatefulWidget> on State<S> {
  AnimationController? _overlayController;
  CurvedAnimation? _overlayCurvedAnimation;
  VMotionSpec? _overlayCurvedSpec;
  bool _overlayClosing = false;

  /// Whether the overlay is currently reversing.
  bool get isOverlayClosing => _overlayClosing;

  /// The captured [AnimationController], or null if not yet configured
  /// or no animation spec was provided.
  AnimationController? get overlayController => _overlayController;

  /// Captures [controller] from [VOverlayAnimation.builder] and creates or
  /// reuses a [CurvedAnimation] from [spec].
  ///
  /// Must be called inside the [VOverlayAnimation.builder] callback.
  /// The [CurvedAnimation] is only recreated when [spec] or [controller]
  /// changes — not on every build — to avoid dispose-during-build errors.
  CurvedAnimation setupOverlayAnimation(
    AnimationController controller,
    VMotionSpec spec,
    BuildContext animationContext,
  ) {
    final specChanged = spec != _overlayCurvedSpec;
    final controllerChanged = controller != _overlayController;
    _overlayController = controller;
    if (_overlayCurvedAnimation == null || specChanged || controllerChanged) {
      _overlayCurvedSpec = spec;
      final old = _overlayCurvedAnimation;
      _overlayCurvedAnimation = CurvedAnimation(
        parent: controller,
        curve: VMotionResolver.curve(animationContext, spec),
        reverseCurve: VMotionResolver.reverseCurve(animationContext, spec),
      );
      // Dispose old animation after creating new one to avoid null window.
      old?.dispose();
    }
    return _overlayCurvedAnimation!;
  }

  /// Begins the exit animation by reversing the captured controller.
  ///
  /// Idempotent — subsequent calls when already closing are ignored.
  void reverseOverlay() {
    if (_overlayClosing) return;
    _overlayClosing = true;
    _overlayController?.reverse();
  }

  /// Stores [controller] without creating a [CurvedAnimation].
  ///
  /// Use in overlays that need the close guard and controller reference
  /// but manage their own animation curves (e.g. barrier-only animations).
  void captureOverlayController(AnimationController controller) {
    _overlayController = controller;
  }

  /// Disposes the managed [CurvedAnimation].
  ///
  /// Call from [State.dispose] with `@mustCallSuper` semantics (though
  /// Dart mixins cannot enforce dispose ordering, so callers must call
  /// this explicitly).
  void disposeOverlayAnimation() {
    _overlayCurvedAnimation?.dispose();
  }
}

/// Owns an [AnimationController] configured from a [VMotionSpec] via
/// [VMotionResolver].
///
/// Calls [AnimationController.forward] on mount. The raw controller is
/// passed to [builder] so callers can create their own [CurvedAnimation]
/// children (or multiple curves from the same controller).
///
/// Callers trigger exit by calling [AnimationController.reverse] on the
/// controller passed to [builder]. When the reverse animation completes,
/// [onReverseComplete] is called.
///
/// Unlike the presenter, this widget does NOT include a closing guard —
/// callers that need one (e.g. VSheet with drag-to-dismiss) must implement
/// it themselves.
class VOverlayAnimation extends StatefulWidget {
  const VOverlayAnimation({
    super.key,
    required this.motionSpec,
    required this.builder,
    this.onReverseComplete,
  });

  /// The motion spec used to resolve duration, reverse duration, and curves
  /// via [VMotionResolver]. Respects reduced motion.
  final VMotionSpec motionSpec;

  /// Builds the animated content.
  ///
  /// [controller] is a pre-configured [AnimationController] that has already
  /// had [AnimationController.forward] called. The controller's
  /// [AnimationController.reverse] triggers the exit animation; when it
  /// completes, [onReverseComplete] is called.
  final Widget Function(
    BuildContext context,
    AnimationController controller,
  ) builder;

  /// Called when the reverse animation finishes.
  final VoidCallback? onReverseComplete;

  @override
  State<VOverlayAnimation> createState() => _VOverlayAnimationState();
}

class _VOverlayAnimationState extends State<VOverlayAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _controller.addStatusListener(_onStatusChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _controller.forward();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _configureAnimation();
  }

  @override
  void didUpdateWidget(VOverlayAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.motionSpec != oldWidget.motionSpec) {
      _configureAnimation();
    }
    if (widget.onReverseComplete != oldWidget.onReverseComplete) {
      _controller.removeStatusListener(_onStatusChanged);
      _controller.addStatusListener(_onStatusChanged);
    }
  }

  void _configureAnimation() {
    _controller.duration = VMotionResolver.duration(context, widget.motionSpec);
    _controller.reverseDuration =
        VMotionResolver.reverseDuration(context, widget.motionSpec);
  }

  void _onStatusChanged(AnimationStatus status) {
    if (status == AnimationStatus.dismissed) {
      widget.onReverseComplete?.call();
    }
  }

  @override
  void dispose() {
    _controller.removeStatusListener(_onStatusChanged);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _controller);
  }
}
