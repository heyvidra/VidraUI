import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../foundation/v_platform.dart';

/// A [GestureDetector] wrapper that automatically shows a pointing-hand
/// cursor on desktop platforms and prunes [MouseRegion] overhead on mobile.
///
/// Also accepts [onEnter], [onExit], and [onHover] callbacks, merging them
/// into the same [MouseRegion] so callers never need to stack two
/// `MouseRegion` widgets.
///
/// ```dart
/// VGestureDetector(
///   onTap: () => print('tapped'),
///   onEnter: (_) => setState(() => _hovered = true),
///   onExit:  (_) => setState(() => _hovered = false),
///   child: Container(...),
/// )
/// ```
class VGestureDetector extends StatelessWidget {
  const VGestureDetector({
    super.key,
    required this.child,
    this.enabled = true,
    this.mouseCursor,
    // MouseRegion hover callbacks
    this.onEnter,
    this.onExit,
    this.onHover,
    // Tap
    this.onTap,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
    this.onSecondaryTap,
    this.onSecondaryTapDown,
    this.onSecondaryTapUp,
    this.onSecondaryTapCancel,
    this.onTertiaryTapDown,
    this.onTertiaryTapUp,
    this.onTertiaryTapCancel,
    // Double tap
    this.onDoubleTap,
    this.onDoubleTapDown,
    this.onDoubleTapCancel,
    // Long press
    this.onLongPress,
    this.onLongPressStart,
    this.onLongPressMoveUpdate,
    this.onLongPressEnd,
    this.onLongPressUp,
    // Pan / drag
    this.onPanStart,
    this.onPanUpdate,
    this.onPanEnd,
    this.onPanCancel,
    this.onPanDown,
    this.onHorizontalDragStart,
    this.onHorizontalDragUpdate,
    this.onHorizontalDragEnd,
    this.onHorizontalDragCancel,
    this.onHorizontalDragDown,
    this.onVerticalDragStart,
    this.onVerticalDragUpdate,
    this.onVerticalDragEnd,
    this.onVerticalDragCancel,
    this.onVerticalDragDown,
    // Scale
    this.onScaleStart,
    this.onScaleUpdate,
    this.onScaleEnd,
    // Force press
    this.onForcePressStart,
    this.onForcePressUpdate,
    this.onForcePressEnd,
    // General
    this.behavior = HitTestBehavior.deferToChild,
    this.dragStartBehavior = DragStartBehavior.start,
    this.excludeFromSemantics = false,
    this.supportedDevices,
  });

  // ── our additions ──────────────────────────────────────────

  final Widget child;
  final bool enabled;

  /// Cursor shown on desktop.  Defaults to [SystemMouseCursors.click] when
  /// [enabled], or [SystemMouseCursors.basic] when disabled.
  final MouseCursor? mouseCursor;

  /// Fires when a mouse pointer enters the region (desktop only).
  final PointerEnterEventListener? onEnter;

  /// Fires when a mouse pointer leaves the region (desktop only).
  final PointerExitEventListener? onExit;

  /// Fires when a mouse pointer moves within the region (desktop only).
  final PointerHoverEventListener? onHover;

  // ── tap ─────────────────────────────────────────────────────

  final GestureTapCallback? onTap;
  final GestureTapDownCallback? onTapDown;
  final GestureTapUpCallback? onTapUp;
  final GestureTapCancelCallback? onTapCancel;
  final GestureTapCallback? onSecondaryTap;
  final GestureTapDownCallback? onSecondaryTapDown;
  final GestureTapUpCallback? onSecondaryTapUp;
  final GestureTapCancelCallback? onSecondaryTapCancel;
  final GestureTapDownCallback? onTertiaryTapDown;
  final GestureTapUpCallback? onTertiaryTapUp;
  final GestureTapCancelCallback? onTertiaryTapCancel;

  // ── double tap ──────────────────────────────────────────────

  final GestureTapCallback? onDoubleTap;
  final GestureTapDownCallback? onDoubleTapDown;
  final GestureTapCancelCallback? onDoubleTapCancel;

  // ── long press ──────────────────────────────────────────────

  final GestureLongPressCallback? onLongPress;
  final GestureLongPressStartCallback? onLongPressStart;
  final GestureLongPressMoveUpdateCallback? onLongPressMoveUpdate;
  final GestureLongPressEndCallback? onLongPressEnd;
  final GestureLongPressUpCallback? onLongPressUp;

  // ── pan / drag ──────────────────────────────────────────────

  final GestureDragStartCallback? onPanStart;
  final GestureDragUpdateCallback? onPanUpdate;
  final GestureDragEndCallback? onPanEnd;
  final GestureDragCancelCallback? onPanCancel;
  final GestureDragDownCallback? onPanDown;

  final GestureDragStartCallback? onHorizontalDragStart;
  final GestureDragUpdateCallback? onHorizontalDragUpdate;
  final GestureDragEndCallback? onHorizontalDragEnd;
  final GestureDragCancelCallback? onHorizontalDragCancel;
  final GestureDragDownCallback? onHorizontalDragDown;

  final GestureDragStartCallback? onVerticalDragStart;
  final GestureDragUpdateCallback? onVerticalDragUpdate;
  final GestureDragEndCallback? onVerticalDragEnd;
  final GestureDragCancelCallback? onVerticalDragCancel;
  final GestureDragDownCallback? onVerticalDragDown;

  // ── scale ───────────────────────────────────────────────────

  final GestureScaleStartCallback? onScaleStart;
  final GestureScaleUpdateCallback? onScaleUpdate;
  final GestureScaleEndCallback? onScaleEnd;

  // ── force press ─────────────────────────────────────────────

  final GestureForcePressStartCallback? onForcePressStart;
  final GestureForcePressUpdateCallback? onForcePressUpdate;
  final GestureForcePressEndCallback? onForcePressEnd;

  // ── general ─────────────────────────────────────────────────

  final HitTestBehavior behavior;
  final DragStartBehavior dragStartBehavior;
  final bool excludeFromSemantics;
  final Set<PointerDeviceKind>? supportedDevices;

  // ── build ───────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final hasHover = VPlatformScope.of(context).hasHoverCapability;
    final cursor = mouseCursor ??
        (enabled ? SystemMouseCursors.click : SystemMouseCursors.basic);

    Widget result = GestureDetector(
      behavior: behavior,
      dragStartBehavior: dragStartBehavior,
      excludeFromSemantics: excludeFromSemantics,
      supportedDevices: supportedDevices,
      onTap: enabled ? onTap : null,
      onTapDown: enabled ? onTapDown : null,
      onTapUp: enabled ? onTapUp : null,
      onTapCancel: enabled ? onTapCancel : null,
      onSecondaryTap: enabled ? onSecondaryTap : null,
      onSecondaryTapDown: enabled ? onSecondaryTapDown : null,
      onSecondaryTapUp: enabled ? onSecondaryTapUp : null,
      onSecondaryTapCancel: enabled ? onSecondaryTapCancel : null,
      onTertiaryTapDown: enabled ? onTertiaryTapDown : null,
      onTertiaryTapUp: enabled ? onTertiaryTapUp : null,
      onTertiaryTapCancel: enabled ? onTertiaryTapCancel : null,
      onDoubleTap: enabled ? onDoubleTap : null,
      onDoubleTapDown: enabled ? onDoubleTapDown : null,
      onDoubleTapCancel: enabled ? onDoubleTapCancel : null,
      onLongPress: enabled ? onLongPress : null,
      onLongPressStart: enabled ? onLongPressStart : null,
      onLongPressMoveUpdate: enabled ? onLongPressMoveUpdate : null,
      onLongPressEnd: enabled ? onLongPressEnd : null,
      onLongPressUp: enabled ? onLongPressUp : null,
      onPanStart: enabled ? onPanStart : null,
      onPanUpdate: enabled ? onPanUpdate : null,
      onPanEnd: enabled ? onPanEnd : null,
      onPanCancel: enabled ? onPanCancel : null,
      onPanDown: enabled ? onPanDown : null,
      onHorizontalDragStart: enabled ? onHorizontalDragStart : null,
      onHorizontalDragUpdate: enabled ? onHorizontalDragUpdate : null,
      onHorizontalDragEnd: enabled ? onHorizontalDragEnd : null,
      onHorizontalDragCancel: enabled ? onHorizontalDragCancel : null,
      onHorizontalDragDown: enabled ? onHorizontalDragDown : null,
      onVerticalDragStart: enabled ? onVerticalDragStart : null,
      onVerticalDragUpdate: enabled ? onVerticalDragUpdate : null,
      onVerticalDragEnd: enabled ? onVerticalDragEnd : null,
      onVerticalDragCancel: enabled ? onVerticalDragCancel : null,
      onVerticalDragDown: enabled ? onVerticalDragDown : null,
      onScaleStart: enabled ? onScaleStart : null,
      onScaleUpdate: enabled ? onScaleUpdate : null,
      onScaleEnd: enabled ? onScaleEnd : null,
      onForcePressStart: enabled ? onForcePressStart : null,
      onForcePressUpdate: enabled ? onForcePressUpdate : null,
      onForcePressEnd: enabled ? onForcePressEnd : null,
      child: child,
    );

    if (hasHover) {
      result = MouseRegion(
        cursor: cursor,
        onEnter: onEnter,
        onExit: onExit,
        onHover: onHover,
        child: result,
      );
    }

    return result;
  }

}
