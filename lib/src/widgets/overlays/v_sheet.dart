import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../app/v_overlay_presenter.dart';
import '../../foundation/background.dart';
import '../../foundation/motion.dart';
import '../../foundation/overlay.dart';
import '../../theme/v_motion_scope.dart';
import '../../theme/v_overlay_animation.dart';
import '../../theme/v_theme.dart';
import '../../theme/v_theme_data.dart';

part 'v_sheet_parts.dart';
part 'v_sheet_presenter.dart';

/// The screen edge a [VSheet] enters from.
enum VSheetEdge { top, right, bottom, left }

/// How a modal sheet responds when the keyboard is visible.
enum VSheetKeyboardBehavior { resize, overlay, none }

/// Preset modal sheet extents.
enum VSheetSize { auto, intrinsic, half, full }

/// Provides the close callback for a visible [VSheet].
class VSheetScope<T> extends InheritedWidget {
  const VSheetScope({
    super.key,
    required this.close,
    required super.child,
  });

  final void Function([T? result]) close;

  static void Function([T? result]) of<T>(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<VSheetScope<T>>();
    assert(scope != null, 'No VSheetScope found in context');
    return scope!.close;
  }

  @override
  bool updateShouldNotify(VSheetScope<T> oldWidget) => close != oldWidget.close;
}

/// A tokenized surface for modal sheets.
class VSheetSurface extends StatelessWidget {
  const VSheetSurface({
    super.key,
    required this.child,
    this.semanticLabel,
    this.showDragHandle = true,
    this.edge,
  });

  final Widget child;
  final String? semanticLabel;
  final bool showDragHandle;
  final VSheetEdge? edge;

  @override
  Widget build(BuildContext context) {
    final effectiveEdge = edge ?? _VSheetLayoutScope.edgeOf(context);
    final handle = _VSheetDragHandle(edge: effectiveEdge);
    final content = Flexible(
      fit: FlexFit.loose,
      child: IntrinsicHeight(child: child),
    );

    return Semantics(
      scopesRoute: true,
      namesRoute: true,
      explicitChildNodes: true,
      label: semanticLabel,
      child: FocusScope(
        autofocus: true,
        child: switch (effectiveEdge) {
          VSheetEdge.top => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                content,
                if (showDragHandle) handle,
              ],
            ),
          VSheetEdge.bottom => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (showDragHandle) handle,
                content,
              ],
            ),
          VSheetEdge.left => Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                content,
                if (showDragHandle) handle,
              ],
            ),
          VSheetEdge.right => Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (showDragHandle) handle,
                content,
              ],
            ),
        },
      ),
    );
  }
}

/// Displays a modal sheet from any screen edge using [VOverlay].
class VSheet {
  const VSheet._();

  static const _dragDismissThreshold = 80.0;

  static Future<T?> show<T>(
    BuildContext context, {
    required WidgetBuilder builder,
    VSheetEdge edge = VSheetEdge.bottom,
    bool barrierDismissible = true,
    bool enableDragToDismiss = true,
    VSheetKeyboardBehavior keyboardBehavior = VSheetKeyboardBehavior.resize,
    VSheetSize size = VSheetSize.intrinsic,
    double? minExtent,
    double? maxExtentFactor,
    String? semanticLabel,
    VBackground? surfaceBackground,
  }) {
    final completer = Completer<T?>();
    final host = VOverlay.of(context);
    final sourceTheme = VTheme.of(context);
    final sourceMotion = VMotionScope.maybeOf(context);
    final previousFocus = saveOverlayFocus();
    late VOverlayHandle handle;

    void complete(T? result) {
      if (!completer.isCompleted) completer.complete(result);
    }

    void remove() {
      handle.remove();
      restoreOverlayFocus(previousFocus);
    }

    handle = host.show(
      (overlayContext, handle) {
        final mediaSize = MediaQuery.sizeOf(overlayContext);
        final viewInsets = MediaQuery.viewInsetsOf(overlayContext);
        final keyboardInset = edge == VSheetEdge.bottom &&
                keyboardBehavior == VSheetKeyboardBehavior.resize
            ? viewInsets.bottom
            : 0.0;
        final factor = maxExtentFactor ?? _extentFactorFor(size);
        final axisExtent =
            _isVertical(edge) ? mediaSize.height : mediaSize.width;

        return _VSheetPresenter<T>(
          edge: edge,
          barrierDismissible: barrierDismissible,
          enableDragToDismiss: enableDragToDismiss,
          maxExtent: axisExtent * factor,
          minExtent: minExtent,
          keyboardInset: keyboardInset,
          theme: sourceTheme,
          motion: sourceMotion,
          onCloseRequested: complete,
          onDismissed: remove,
          builder: builder,
          semanticLabel: semanticLabel,
          surfaceBackground: surfaceBackground,
        );
      },
      maintainState: true,
    );

    return completer.future;
  }

  static double _extentFactorFor(VSheetSize size) {
    return switch (size) {
      VSheetSize.intrinsic => 0.9,
      VSheetSize.auto => 0.9,
      VSheetSize.half => 0.52,
      VSheetSize.full => 0.92,
    };
  }

  static bool _isVertical(VSheetEdge edge) {
    return edge == VSheetEdge.top || edge == VSheetEdge.bottom;
  }
}
