import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../app/v_overlay_presenter.dart';
import '../../foundation/background.dart';
import '../../foundation/motion.dart';
import '../../foundation/overlay.dart';
import '../../theme/v_appearance_scope.dart';
import '../../theme/v_component_themes.g.dart';
import '../../theme/v_motion_scope.dart';
import '../../theme/v_overlay_animation.dart';
import '../../theme/v_theme.dart';
import '../../theme/v_theme_data.dart';

/// An [InheritedWidget] that provides a [close] callback to dialog contents.
class VDialogScope<T> extends InheritedWidget {
  const VDialogScope({
    super.key,
    required this.close,
    required super.child,
  });

  final void Function(T? result) close;

  static void Function(T? result) of<T>(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<VDialogScope<T>>();
    if (scope == null) {
      throw StateError(
        'No VDialogScope<$T> found in the given BuildContext. '
        'Ensure that the context used is a descendant of a VDialog widget.',
      );
    }
    return scope.close;
  }

  @override
  bool updateShouldNotify(VDialogScope<T> oldWidget) =>
      !identical(close, oldWidget.close);
}

/// The visual surface for a dialog.
///
/// Wraps the dialog content in a themed container with route-level semantics,
/// a [FocusTraversalGroup] to trap Tab navigation, and an initial focus scope.
class VDialogSurface extends StatelessWidget {
  const VDialogSurface({
    super.key,
    required this.child,
    this.semanticLabel,
    this.width,
    this.maxHeight,
    this.surfaceBackground,
  });

  final Widget child;
  final String? semanticLabel;
  final double? width;

  /// Maximum dialog height. If content exceeds this, it scrolls.
  final double? maxHeight;

  /// One-off background override for the dialog surface.
  ///
  /// This only affects the panel surface, not the modal barrier.
  final VBackground? surfaceBackground;

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);
    final tokens = VDialogTheme.of(context) ?? theme.components.dialog;
    final appearance = VAppearanceScope.of(context);
    final effectiveWidth = width ?? tokens.defaultWidth;
    final effectiveMaxHeight = maxHeight ?? tokens.defaultMaxHeight;
    final baseBg = tokens.surface;
    final baseRadius = theme.radii.lg;
    final resolvedBg = appearance?.background(baseBg, const {}) ?? baseBg;
    final surfaceColor = surfaceBackground?.color ?? resolvedBg;
    final decorationGradient = surfaceBackground?.gradient;
    final resolvedRadius = appearance?.radius(baseRadius) ?? baseRadius;
    final baseShadows = [theme.shadows.dialog];
    final resolvedShadows = appearance?.shadows(baseShadows) ?? baseShadows;

    return Semantics(
      scopesRoute: true,
      namesRoute: true,
      explicitChildNodes: true,
      label: semanticLabel,
      child: FocusTraversalGroup(
        policy: ReadingOrderTraversalPolicy(),
        child: FocusScope(
          autofocus: true,
          child: Container(
            width: effectiveWidth,
            constraints: BoxConstraints(
              maxWidth: theme.sizes.dialogMaxWidth,
              maxHeight: effectiveMaxHeight,
            ),
            margin: EdgeInsets.symmetric(horizontal: theme.spacing.xl),
            decoration: BoxDecoration(
              color: decorationGradient == null ? surfaceColor : null,
              gradient: decorationGradient,
              borderRadius: BorderRadius.circular(resolvedRadius),
              boxShadow: resolvedShadows,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(resolvedRadius),
              child: SingleChildScrollView(
                padding: EdgeInsets.all(theme.spacing.xl),
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Displays a dialog overlay using [VOverlay].
///
/// Does not use Material's dialog APIs. Returns a [Future] that completes
/// when the dialog is dismissed.
///
/// Focus is trapped inside the dialog while open and restored to the
/// previously focused element on close.
class VDialog {
  /// Shows a dialog and returns a [Future] that completes when closed.
  static Future<T?> show<T>(
    BuildContext context, {
    required Widget Function(BuildContext context) builder,
    bool barrierDismissible = true,
  }) {
    T? resultToComplete;
    final completer = Completer<T?>();
    final host = VOverlay.of(context);
    final sourceTheme = resolveOverlayTheme(
      context,
      VDialogTheme.of,
      (c, t) => c.copyWith(dialog: t),
    );
    final sourceMotion = VMotionScope.maybeOf(context);
    late VOverlayHandle handle;

    final previousFocus = saveOverlayFocus();

    void complete(T? result) {
      if (!completer.isCompleted) {
        resultToComplete = result;
      }
    }

    void remove() {
      handle.remove();
      restoreOverlayFocus(previousFocus);
      if (!completer.isCompleted) {
        completer.complete(resultToComplete);
      }
    }

    handle = host.show(
      (overlayContext, handle) {
        return _VDialogPresenter<T>(
          barrierDismissible: barrierDismissible,
          builder: builder,
          theme: sourceTheme,
          motion: sourceMotion,
          onCloseRequested: complete,
          onDismissed: remove,
        );
      },
      maintainState: true,
    );

    return completer.future;
  }
}

class _VDialogPresenter<T> extends StatefulWidget {
  const _VDialogPresenter({
    required this.barrierDismissible,
    required this.builder,
    required this.theme,
    required this.motion,
    required this.onCloseRequested,
    required this.onDismissed,
  });

  final bool barrierDismissible;
  final Widget Function(BuildContext) builder;
  final VThemeData theme;
  final VMotion? motion;
  final ValueChanged<T?> onCloseRequested;
  final VoidCallback onDismissed;

  @override
  State<_VDialogPresenter<T>> createState() => _VDialogPresenterState<T>();
}

class _VDialogPresenterState<T> extends State<_VDialogPresenter<T>>
    with VOverlayAnimationState {
  void _close(T? result) {
    if (isOverlayClosing) return;
    widget.onCloseRequested(result);
    reverseOverlay();
  }

  @override
  void dispose() {
    // If we're being disposed without a normal close (e.g. host torn down),
    // immediately complete with null and trigger the dismissal callback.
    if (!isOverlayClosing) {
      widget.onCloseRequested(null);
      widget.onDismissed();
    }
    disposeOverlayAnimation();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final motion = widget.motion ?? widget.theme.motion;
    final spec = motion.overlay;

    return VOverlayAnimation(
      motionSpec: spec,
      onReverseComplete: widget.onDismissed,
      builder: (animationContext, controller) {
        final animation =
            setupOverlayAnimation(controller, spec, animationContext);

        Widget result = VTheme(
          data: widget.theme,
          child: Stack(
            children: [
              Positioned.fill(
                child: GestureDetector(
                  onTap: widget.barrierDismissible ? () => _close(null) : null,
                  child: FadeTransition(
                    opacity: animation,
                    child: ColoredBox(
                      color: widget.theme.components.dialog.barrierColor,
                    ),
                  ),
                ),
              ),
              Center(
                child: VDialogScope<T>(
                  close: _close,
                  child: CallbackShortcuts(
                    bindings: <ShortcutActivator, VoidCallback>{
                      const SingleActivator(LogicalKeyboardKey.escape): () =>
                          _close(null),
                    },
                    child: FadeTransition(
                      opacity: animation,
                      child: ScaleTransition(
                        scale: Tween<double>(begin: 0.95, end: 1.0).animate(animation),
                        child: Builder(
                          builder: (descendantContext) {
                            return widget.builder(descendantContext);
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );

        return VMotionScope(
          motion: motion,
          child: result,
        );
      },
    );
  }
}
