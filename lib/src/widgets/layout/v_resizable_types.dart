part of 'v_resizable.dart';

enum VResizeHandle {
  left,
  top,
  right,
  bottom,
  topLeft,
  topRight,
  bottomLeft,
  bottomRight,
}

/// How a constrained [VResizable.positioned] behaves at parent boundaries.
enum VResizeBoundaryBehavior {
  /// Stop the dragged edge at the boundary.
  fixed,

  /// Keep the rect inside the parent while allowing it to expand inward.
  expandWithinBounds,
}

/// Builds the visible resize handle while preserving VidraUI hit testing.
typedef VResizeHandleBuilder = Widget Function(
  BuildContext context,
  VResizeHandle handle,
  bool active,
  Widget defaultHandle,
);

class VResizeHandles {
  const VResizeHandles._();

  static const all = {
    VResizeHandle.left,
    VResizeHandle.top,
    VResizeHandle.right,
    VResizeHandle.bottom,
    VResizeHandle.topLeft,
    VResizeHandle.topRight,
    VResizeHandle.bottomLeft,
    VResizeHandle.bottomRight,
  };

  static const edges = {
    VResizeHandle.left,
    VResizeHandle.top,
    VResizeHandle.right,
    VResizeHandle.bottom,
  };

  static const corners = {
    VResizeHandle.topLeft,
    VResizeHandle.topRight,
    VResizeHandle.bottomLeft,
    VResizeHandle.bottomRight,
  };

  static const horizontal = {VResizeHandle.left, VResizeHandle.right};
  static const vertical = {VResizeHandle.top, VResizeHandle.bottom};
  static const rightBottom = {
    VResizeHandle.right,
    VResizeHandle.bottom,
    VResizeHandle.bottomRight,
  };
}

@immutable
class VResizeStartDetails {
  const VResizeStartDetails({
    required this.handle,
    required this.size,
    required this.globalPosition,
  });

  final VResizeHandle handle;
  final Size size;
  final Offset globalPosition;
}

@immutable
class VResizeUpdateDetails {
  const VResizeUpdateDetails({
    required this.handle,
    required this.size,
    required this.delta,
    required this.globalPosition,
  });

  final VResizeHandle handle;
  final Size size;
  final Offset delta;
  final Offset globalPosition;
}

@immutable
class VResizeEndDetails {
  const VResizeEndDetails({required this.handle, required this.size});

  final VResizeHandle handle;
  final Size size;
}
