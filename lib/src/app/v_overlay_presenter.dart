import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../foundation/motion.dart';
import '../foundation/overlay.dart';
import '../theme/v_motion_scope.dart';
import '../theme/v_overlay_animation.dart';
import '../theme/v_theme.dart';
import '../theme/v_theme_data.dart';

// ---------------------------------------------------------------------------
// Configuration
// ---------------------------------------------------------------------------

/// What kind of barrier sits behind the overlay content.
enum VOverlayBarrierMode {
  /// No barrier — content floats above existing UI.
  none,

  /// Semi-transparent colored backdrop behind the content.
  modal,

  /// Blurred backdrop (like iOS context menu lift).
  blurred,
}

/// Configuration for an overlay presentation lifecycle.
///
/// All fields default to the simplest case: no animation, no barrier,
/// no focus management, no auto-dismiss.
@immutable
class VOverlayPresenterConfig {
  const VOverlayPresenterConfig({
    this.motionSpec,
    this.barrierMode = VOverlayBarrierMode.none,
    this.barrierColor,
    this.barrierDismissible = true,
    this.saveAndRestoreFocus = false,
    this.autoDismissAfter,
    this.dismissOnEscape = false,
    this.maintainState = false,
  });

  /// The motion spec driving entry/exit animation.
  ///
  /// When null, the presenter renders content immediately with no animation.
  final VMotionSpec? motionSpec;

  /// What kind of barrier sits behind the overlay content.
  final VOverlayBarrierMode barrierMode;

  /// Color of the modal barrier. Defaults to the theme's scrim color.
  /// Ignored when [barrierMode] is [VOverlayBarrierMode.none].
  final Color? barrierColor;

  /// Whether tapping the barrier dismisses the overlay.
  final bool barrierDismissible;

  /// Whether to save focus before opening and restore it after closing.
  final bool saveAndRestoreFocus;

  /// Auto-dismiss the overlay after this duration.
  final Duration? autoDismissAfter;

  /// Whether pressing Escape dismisses the overlay.
  final bool dismissOnEscape;

  /// Passed through to [VOverlayController.show].
  final bool maintainState;
}

// ---------------------------------------------------------------------------
// Presentation handle
// ---------------------------------------------------------------------------

/// Handle for an active overlay presentation.
///
/// Call [dismiss] to begin the exit animation and clean up.
/// Await [closed] to be notified when dismissal completes.
class VOverlayPresentation {
  final Completer<void> _completer = Completer<void>();

  /// Completes when the overlay has been fully removed.
  Future<void> get closed => _completer.future;

  /// Dismisses the overlay — triggers exit animation, then cleanup.
  ///
  /// Idempotent; multiple calls are safe.
  void dismiss() {
    _onDismiss?.call();
  }

  /// Set by the presenter widget. Called when the user or auto-dismiss
  /// requests dismissal.
  VoidCallback? _onDismiss;

  /// Called by the presenter widget when the overlay is fully removed.
  void _complete() {
    if (!_completer.isCompleted) {
      _completer.complete();
    }
  }
}

// ---------------------------------------------------------------------------
// Presenter
// ---------------------------------------------------------------------------

/// Manages the full lifecycle of an overlay presentation:
/// insert → animate in → (auto-dismiss) → animate out → cleanup.
///
/// Callers provide [content] (the widget to display) and [config].
/// Returns a [VOverlayPresentation] handle.
///
/// The [content] builder receives a `close` callback it can call to
/// programmatically dismiss the overlay.
class VOverlayPresenter {
  /// Shows overlay content and returns a presentation handle.
  ///
  /// [context] must be a descendant of [VOverlayHost] and [VTheme].
  static VOverlayPresentation show({
    required BuildContext context,
    required Widget Function(VoidCallback close) content,
    VOverlayPresenterConfig config = const VOverlayPresenterConfig(),
  }) {
    final host = VOverlay.of(context);
    final theme = VTheme.of(context);
    final motion = VMotionScope.maybeOf(context);
    final presentation = VOverlayPresentation();

    final previousFocus =
        config.saveAndRestoreFocus ? saveOverlayFocus() : null;

    late VOverlayHandle handle;

    void remove() {
      handle.remove();
      restoreOverlayFocus(previousFocus);
      presentation._complete();
    }

    // The presenter widget calls this when the exit animation finishes.
    // We declare it here so it can close over [remove] and [presentation].
    presentation._onDismiss = () {
      // The presenter widget handles the animation + cleanup.
      handle.markNeedsBuild();
    };

    handle = host.show(
      (overlayContext, overlayHandle) {
        return _VOverlayPresenterWidget(
          config: config,
          content: content,
          theme: theme,
          motion: motion,
          onRemove: remove,
        );
      },
      maintainState: config.maintainState,
    );

    return presentation;
  }
}

// ---------------------------------------------------------------------------
// Overlay theme resolution
// ---------------------------------------------------------------------------
// ---------------------------------------------------------------------------
// Focus utilities
// ---------------------------------------------------------------------------

/// Saves the current focus node for later restoration after an overlay closes.
///
/// Call before showing an overlay; pass the result to [restoreFocus] in the
/// dismissal callback.
FocusNode? saveOverlayFocus() => FocusManager.instance.primaryFocus;

/// Restores focus to [previousFocus] if it still has a valid enclosing scope.
///
/// Safe to call with `null` — does nothing.
void restoreOverlayFocus(FocusNode? previousFocus) {
  if (previousFocus == null) return;
  final scope = previousFocus.enclosingScope;
  if (scope != null) {
    previousFocus.requestFocus();
  }
}

// ---------------------------------------------------------------------------
// Internal presenter widget
// ---------------------------------------------------------------------------

class _VOverlayPresenterWidget extends StatefulWidget {
  const _VOverlayPresenterWidget({
    required this.config,
    required this.content,
    required this.theme,
    required this.motion,
    required this.onRemove,
  });

  final VOverlayPresenterConfig config;
  final Widget Function(VoidCallback close) content;
  final VThemeData theme;
  final VMotion? motion;
  final VoidCallback onRemove;

  @override
  State<_VOverlayPresenterWidget> createState() =>
      _VOverlayPresenterWidgetState();
}

class _VOverlayPresenterWidgetState extends State<_VOverlayPresenterWidget>
    with VOverlayAnimationState {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    if (widget.config.autoDismissAfter != null) {
      _timer = Timer(widget.config.autoDismissAfter!, _requestDismiss);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _requestDismiss() {
    if (isOverlayClosing) return;
    _timer?.cancel();
    // When no animation controller exists (motionSpec == null), remove
    // immediately. Otherwise let the mixin reverse the animation.
    if (overlayController == null) {
      widget.onRemove();
      return;
    }
    reverseOverlay();
  }

  @override
  Widget build(BuildContext context) {
    if (isOverlayClosing && overlayController == null) {
      // Dismissed without animation — nothing to render.
      return const SizedBox.shrink();
    }

    Widget content = widget.content(_requestDismiss);

    // Wrap with ESC shortcut if configured.
    if (widget.config.dismissOnEscape) {
      content = CallbackShortcuts(
        bindings: <ShortcutActivator, VoidCallback>{
          const SingleActivator(LogicalKeyboardKey.escape): _requestDismiss,
        },
        child: content,
      );
    }

    // Wrap with theme.
    content = VTheme(data: widget.theme, child: content);

    // Wrap with motion scope if a local motion was captured.
    if (widget.motion != null) {
      content = VMotionScope(motion: widget.motion!, child: content);
    }

    // If no animation, render content directly with an optional static barrier.
    if (widget.config.motionSpec == null) {
      if (widget.config.barrierMode != VOverlayBarrierMode.none) {
        content = _buildBarrier(child: content, animated: false);
      }
      return content;
    }

    // Animated path — wrap in VOverlayAnimation.
    return VOverlayAnimation(
      motionSpec: widget.config.motionSpec!,
      onReverseComplete: widget.onRemove,
      builder: (animationContext, controller) {
        captureOverlayController(controller);

        Widget animatedContent = content;

        // Wrap with animated barrier if needed.
        if (widget.config.barrierMode != VOverlayBarrierMode.none) {
          animatedContent = _buildBarrier(
            child: animatedContent,
            animated: true,
            controller: controller,
          );
        }

        return animatedContent;
      },
    );
  }

  Widget _buildBarrier({
    required Widget child,
    required bool animated,
    AnimationController? controller,
  }) {
    final barrierColor = widget.config.barrierColor ??
        widget.theme.colors.scrim.withValues(alpha: 0.5);

    Widget barrier = Positioned.fill(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: widget.config.barrierDismissible ? _requestDismiss : null,
        child: ColoredBox(color: barrierColor),
      ),
    );

    if (animated && controller != null) {
      final fadeAnim = CurvedAnimation(
        parent: controller,
        curve: Curves.easeOut,
        reverseCurve: Curves.easeIn,
      );
      barrier = FadeTransition(opacity: fadeAnim, child: barrier);
    }

    return Stack(
      children: [
        barrier,
        child,
      ],
    );
  }
}
