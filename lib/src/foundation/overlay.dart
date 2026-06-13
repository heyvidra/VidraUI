import 'package:flutter/widgets.dart';
import 'toast.dart';

/// Builds content for an entry managed by a VidraUI overlay controller.
typedef VOverlayEntryBuilder = Widget Function(
  BuildContext context,
  VOverlayHandle handle,
);

/// A removable handle for VidraUI-managed overlay content.
abstract interface class VOverlayHandle {
  /// Whether the underlying overlay entry is currently mounted.
  bool get mounted;

  /// Marks the underlying overlay entry dirty.
  void markNeedsBuild();

  /// Removes and disposes the associated overlay entry.
  void remove();
}

/// Extended handle that provides toast-specific functionality.
abstract interface class VToastHandle extends VOverlayHandle {
  /// The position of this toast.
  VToastPosition get position;
  
  /// The stack mode of this toast.
  VToastStackMode get stackMode;
}

/// A controller that owns overlay entry insertion and removal.
abstract interface class VOverlayController {
  /// Inserts overlay content and returns a removable handle.
  VOverlayHandle show(
    VOverlayEntryBuilder builder, {
    bool maintainState = false,
  });

  /// Shows a toast with stack management support.
  VToastHandle showToast(
    VOverlayEntryBuilder builder, {
    required VToastPosition position,
    required VToastStackMode stackMode,
    bool maintainState = false,
  });
}

/// Provides the nearest VidraUI overlay controller to descendants.
class VOverlayControllerScope extends InheritedWidget {
  const VOverlayControllerScope({
    super.key,
    required this.controller,
    required super.child,
  });

  /// The overlay controller for descendants.
  final VOverlayController controller;

  /// Returns the nearest overlay controller, or null if none is available.
  static VOverlayController? maybeOf(BuildContext context) {
    final scope =
        context.getInheritedWidgetOfExactType<VOverlayControllerScope>();
    return scope?.controller;
  }

  /// Returns the nearest overlay controller.
  static VOverlayController of(BuildContext context) {
    final controller = maybeOf(context);
    assert(controller != null, 'No VOverlayControllerScope found in context');
    return controller!;
  }

  @override
  bool updateShouldNotify(VOverlayControllerScope oldWidget) =>
      controller != oldWidget.controller;
}

/// Utility class to access the nearest [VOverlayController].
class VOverlay {
  VOverlay._();

  /// Returns the nearest overlay controller, or null if none is available.
  static VOverlayController? maybeOf(BuildContext context) {
    return VOverlayControllerScope.maybeOf(context);
  }

  /// Returns the nearest overlay controller.
  static VOverlayController of(BuildContext context) {
    return VOverlayControllerScope.of(context);
  }
}
