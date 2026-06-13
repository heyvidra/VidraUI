import 'package:flutter/widgets.dart';

import '../../foundation/foundation.dart';
import '../../theme/v_theme.dart';
import '../../theme/v_theme_data.dart';

part 'v_resizable_handles.dart';
part 'v_resizable_state.dart';
part 'v_resizable_types.dart';

// ---------------------------------------------------------------------------
// VResizable
// ---------------------------------------------------------------------------

class VResizable extends StatefulWidget {
  /// Size mode — the parent layout owns the position.
  const VResizable({
    super.key,
    required this.child,
    this.size,
    this.initialSize,
    this.onSizeChanged,
    this.constraints = const BoxConstraints(minWidth: 48, minHeight: 48),
    this.enabledHandles = VResizeHandles.all,
    this.constrainToParent = false,
    this.boundaryPadding = EdgeInsets.zero,
    this.boundaryBehavior = VResizeBoundaryBehavior.fixed,
    this.handleSize,
    this.handleHitSize,
    this.showHandles = true,
    this.handleBuilder,
    this.semanticLabel,
    this.onResizeStart,
    this.onResizeUpdate,
    this.onResizeEnd,
    this.childBuilder,
  })  : rect = null,
        onRectChanged = null;

  /// Positioned mode — rect owns both position and size.
  const VResizable.positioned({
    super.key,
    required this.child,
    required this.rect,
    required this.onRectChanged,
    this.constraints = const BoxConstraints(minWidth: 48, minHeight: 48),
    this.enabledHandles = VResizeHandles.all,
    this.constrainToParent = true,
    this.boundaryPadding = EdgeInsets.zero,
    this.boundaryBehavior = VResizeBoundaryBehavior.fixed,
    this.handleSize,
    this.handleHitSize,
    this.showHandles = true,
    this.handleBuilder,
    this.semanticLabel,
    this.onResizeStart,
    this.onResizeUpdate,
    this.onResizeEnd,
    this.childBuilder,
  })  : size = null,
        initialSize = null,
        onSizeChanged = null;

  final Widget child;
  final Size? size;
  final Size? initialSize;
  final ValueChanged<Size>? onSizeChanged;
  final Rect? rect;
  final ValueChanged<Rect>? onRectChanged;
  final BoxConstraints constraints;
  final Set<VResizeHandle> enabledHandles;
  final bool constrainToParent;
  final EdgeInsets boundaryPadding;
  final VResizeBoundaryBehavior boundaryBehavior;
  final double? handleSize;
  final double? handleHitSize;
  final bool showHandles;
  final VResizeHandleBuilder? handleBuilder;
  final String? semanticLabel;
  final ValueChanged<VResizeStartDetails>? onResizeStart;
  final ValueChanged<VResizeUpdateDetails>? onResizeUpdate;
  final ValueChanged<VResizeEndDetails>? onResizeEnd;
  final Widget Function(BuildContext, Size, VResizeHandle?, Widget)?
      childBuilder;

  bool get _isPositioned => rect != null;

  @override
  State<VResizable> createState() => _VResizableState();
}
