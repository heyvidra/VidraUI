part of 'v_resizable.dart';

class _VResizableState extends State<VResizable> {
  late Size _localSize;
  VResizeHandle? _activeHandle;
  Offset _dragStart = Offset.zero;
  Size _sizeAtDragStart = Size.zero;
  Rect? _rectAtDragStart;

  @override
  void initState() {
    super.initState();
    _localSize = widget.initialSize ?? const Size(320, 200);
  }

  Size get _currentSize => widget._isPositioned
      ? (widget.rect?.size ?? _localSize)
      : (widget.size ?? _localSize);

  Rect get _currentRect => widget._isPositioned
      ? (widget.rect ??
          Rect.fromLTWH(0, 0, _localSize.width, _localSize.height))
      : Rect.fromLTWH(0, 0, _currentSize.width, _currentSize.height);

  void _setSize(Size s) {
    if (widget._isPositioned) return;
    if (widget.size == null) {
      setState(() => _localSize = s);
    }
    widget.onSizeChanged?.call(s);
  }

  bool _isLeft(VResizeHandle h) =>
      h == VResizeHandle.left ||
      h == VResizeHandle.topLeft ||
      h == VResizeHandle.bottomLeft;
  bool _isTop(VResizeHandle h) =>
      h == VResizeHandle.top ||
      h == VResizeHandle.topLeft ||
      h == VResizeHandle.topRight;
  bool _isRight(VResizeHandle h) =>
      h == VResizeHandle.right ||
      h == VResizeHandle.topRight ||
      h == VResizeHandle.bottomRight;
  bool _isBottom(VResizeHandle h) =>
      h == VResizeHandle.bottom ||
      h == VResizeHandle.bottomLeft ||
      h == VResizeHandle.bottomRight;

  void _onDragStart(VResizeHandle handle, Offset global) {
    setState(() => _activeHandle = handle);
    _dragStart = global;
    _sizeAtDragStart = _currentSize;
    if (widget._isPositioned) _rectAtDragStart = _currentRect;
    widget.onResizeStart?.call(
      VResizeStartDetails(
        handle: handle,
        size: _currentSize,
        globalPosition: global,
      ),
    );
  }

  void _onDragUpdate(Offset global) {
    final handle = _activeHandle;
    if (handle == null) return;
    final delta = global - _dragStart;
    final c = widget.constraints;
    double w = _sizeAtDragStart.width;
    double h = _sizeAtDragStart.height;
    double left = _rectAtDragStart?.left ?? 0;
    double top = _rectAtDragStart?.top ?? 0;

    if (_isRight(handle)) {
      w = (_sizeAtDragStart.width + delta.dx).clamp(
        c.minWidth,
        c.maxWidth.isFinite ? c.maxWidth : double.infinity,
      );
    }
    if (_isLeft(handle)) {
      final newW = (_sizeAtDragStart.width - delta.dx).clamp(
        c.minWidth,
        c.maxWidth.isFinite ? c.maxWidth : double.infinity,
      );
      if (widget._isPositioned) {
        left = _rectAtDragStart!.left + _sizeAtDragStart.width - newW;
      }
      w = newW;
    }
    if (_isBottom(handle)) {
      h = (_sizeAtDragStart.height + delta.dy).clamp(
        c.minHeight,
        c.maxHeight.isFinite ? c.maxHeight : double.infinity,
      );
    }
    if (_isTop(handle)) {
      final newH = (_sizeAtDragStart.height - delta.dy).clamp(
        c.minHeight,
        c.maxHeight.isFinite ? c.maxHeight : double.infinity,
      );
      if (widget._isPositioned) {
        top = _rectAtDragStart!.top + _sizeAtDragStart.height - newH;
      }
      h = newH;
    }

    var updatedSize = Size(w, h);

    if (widget._isPositioned) {
      var newRect = Rect.fromLTWH(left, top, w, h);
      if (widget.constrainToParent) {
        newRect = _clampToParent(newRect, handle);
      }
      updatedSize = newRect.size;
      widget.onRectChanged?.call(newRect);
    } else {
      if (widget.constrainToParent) {
        final pw = _parentSize?.width;
        final ph = _parentSize?.height;
        if (pw != null && pw > 0) {
          w = w.clamp(0, pw - widget.boundaryPadding.horizontal);
        }
        if (ph != null && ph > 0) {
          h = h.clamp(0, ph - widget.boundaryPadding.vertical);
        }
        w = w.clamp(
          c.minWidth,
          c.maxWidth.isFinite ? c.maxWidth : double.infinity,
        );
        h = h.clamp(
          c.minHeight,
          c.maxHeight.isFinite ? c.maxHeight : double.infinity,
        );
      }
      updatedSize = Size(w, h);
      _setSize(updatedSize);
    }

    widget.onResizeUpdate?.call(
      VResizeUpdateDetails(
        handle: handle,
        size: updatedSize,
        delta: delta,
        globalPosition: global,
      ),
    );
  }

  Size? get _parentSize {
    if (!widget.constrainToParent) return null;
    final box = context.findRenderObject() as RenderBox?;
    final parent = box?.parent;
    if (parent is RenderBox && parent.hasSize) return parent.size;
    return null;
  }

  Rect _clampToParent(Rect r, VResizeHandle handle) {
    if (widget.boundaryBehavior == VResizeBoundaryBehavior.fixed) {
      return _clampFixedToParent(r, handle);
    }
    return _clampExpandedToParent(r);
  }

  Rect _clampExpandedToParent(Rect r) {
    final ps = _parentSize;
    if (ps == null) return r;
    final pad = widget.boundaryPadding;
    final availableWidth = _nonNegative(ps.width - pad.horizontal);
    final availableHeight = _nonNegative(ps.height - pad.vertical);
    final width = _clampExtent(
      r.width,
      widget.constraints.minWidth,
      widget.constraints.maxWidth,
      availableWidth,
    );
    final height = _clampExtent(
      r.height,
      widget.constraints.minHeight,
      widget.constraints.maxHeight,
      availableHeight,
    );
    final left = _clampPosition(
      r.left,
      pad.left,
      ps.width - pad.right - width,
    );
    final top = _clampPosition(
      r.top,
      pad.top,
      ps.height - pad.bottom - height,
    );
    return Rect.fromLTWH(left, top, width, height);
  }

  Rect _clampFixedToParent(Rect r, VResizeHandle handle) {
    final ps = _parentSize;
    if (ps == null) return r;
    final start = _rectAtDragStart ?? r;
    final pad = widget.boundaryPadding;
    final minX = pad.left;
    final minY = pad.top;
    final maxX = ps.width - pad.right;
    final maxY = ps.height - pad.bottom;
    final width = _fixedExtent(
      value: r.width,
      minExtent: widget.constraints.minWidth,
      maxExtent: widget.constraints.maxWidth,
      availableExtent: _nonNegative(maxX - minX),
    );
    final height = _fixedExtent(
      value: r.height,
      minExtent: widget.constraints.minHeight,
      maxExtent: widget.constraints.maxHeight,
      availableExtent: _nonNegative(maxY - minY),
    );

    final horizontal = _fixedAxis(
      leadingValue: r.left,
      trailingValue: r.right,
      startLeading: start.left,
      startTrailing: start.right,
      minPosition: minX,
      maxPosition: maxX,
      minExtent: widget.constraints.minWidth,
      maxExtent: widget.constraints.maxWidth,
      availableExtent: _nonNegative(maxX - minX),
      leadingHandle: _isLeft(handle),
      trailingHandle: _isRight(handle),
      fallbackExtent: width,
    );
    final vertical = _fixedAxis(
      leadingValue: r.top,
      trailingValue: r.bottom,
      startLeading: start.top,
      startTrailing: start.bottom,
      minPosition: minY,
      maxPosition: maxY,
      minExtent: widget.constraints.minHeight,
      maxExtent: widget.constraints.maxHeight,
      availableExtent: _nonNegative(maxY - minY),
      leadingHandle: _isTop(handle),
      trailingHandle: _isBottom(handle),
      fallbackExtent: height,
    );

    return Rect.fromLTRB(
      horizontal.leading,
      vertical.leading,
      horizontal.trailing,
      vertical.trailing,
    );
  }

  _FixedAxis _fixedAxis({
    required double leadingValue,
    required double trailingValue,
    required double startLeading,
    required double startTrailing,
    required double minPosition,
    required double maxPosition,
    required double minExtent,
    required double maxExtent,
    required double availableExtent,
    required bool leadingHandle,
    required bool trailingHandle,
    required double fallbackExtent,
  }) {
    if (leadingHandle) {
      final anchor = startTrailing.clamp(minPosition, maxPosition).toDouble();
      final availableToBoundary = _nonNegative(anchor - minPosition);
      final extent = _fixedExtent(
        value: anchor - leadingValue,
        minExtent: minExtent,
        maxExtent: maxExtent,
        availableExtent: availableToBoundary,
      );
      return _FixedAxis(anchor - extent, anchor);
    }
    if (trailingHandle) {
      final anchor = startLeading.clamp(minPosition, maxPosition).toDouble();
      final availableToBoundary = _nonNegative(maxPosition - anchor);
      final extent = _fixedExtent(
        value: trailingValue - anchor,
        minExtent: minExtent,
        maxExtent: maxExtent,
        availableExtent: availableToBoundary,
      );
      return _FixedAxis(anchor, anchor + extent);
    }

    final leading = _clampPosition(
      leadingValue,
      minPosition,
      maxPosition - fallbackExtent,
    );
    return _FixedAxis(leading, leading + fallbackExtent);
  }

  double _clampExtent(
    double value,
    double minExtent,
    double maxExtent,
    double availableExtent,
  ) {
    final effectiveMax = maxExtent.isFinite && maxExtent < availableExtent
        ? maxExtent
        : availableExtent;
    final effectiveMin = minExtent < effectiveMax ? minExtent : effectiveMax;
    return value.clamp(effectiveMin, effectiveMax).toDouble();
  }

  double _fixedExtent({
    required double value,
    required double minExtent,
    required double maxExtent,
    required double availableExtent,
  }) {
    final effectiveMax = maxExtent.isFinite && maxExtent < availableExtent
        ? maxExtent
        : availableExtent;
    final effectiveMin = minExtent < effectiveMax ? minExtent : effectiveMax;
    return value.clamp(effectiveMin, effectiveMax).toDouble();
  }

  double _clampPosition(double value, double minPosition, double maxPosition) {
    if (maxPosition < minPosition) return minPosition;
    return value.clamp(minPosition, maxPosition).toDouble();
  }

  double _nonNegative(double value) {
    return value < 0 ? 0 : value;
  }

  void _onDragEnd() {
    final handle = _activeHandle;
    if (handle != null) {
      widget.onResizeEnd?.call(
        VResizeEndDetails(handle: handle, size: _currentSize),
      );
    }
    setState(() => _activeHandle = null);
  }

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);
    final size = _currentSize;

    final content =
        widget.childBuilder?.call(context, size, _activeHandle, widget.child) ??
            widget.child;

    // On touch platforms, resize handles are inaccessible (too small to target
    // with a finger) and their gesture detectors interfere with system scroll
    // and swipe-back gestures. We skip the entire Stack/handle infrastructure
    // and render only the child inside a lean sizing wrapper.
    final isDesktop = VPlatformScope.of(context).isDesktop;
    if (!isDesktop) {
      final bare = Semantics(label: widget.semanticLabel, child: content);
      if (widget._isPositioned) {
        return Positioned.fromRect(rect: _currentRect, child: bare);
      }
      return SizedBox(width: size.width, height: size.height, child: bare);
    }

    final visSize = widget.handleSize ?? 6;
    final hitSize = widget.handleHitSize ?? 20;

    final frame = Semantics(
      label: widget.semanticLabel,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(child: content),
          if (widget.enabledHandles.isNotEmpty)
            ..._buildHandles(theme, size, visSize, hitSize),
        ],
      ),
    );

    if (widget._isPositioned) {
      return Positioned.fromRect(rect: _currentRect, child: frame);
    }

    return SizedBox(width: size.width, height: size.height, child: frame);
  }

  List<Widget> _buildHandles(
    VThemeData theme,
    Size size,
    double visSize,
    double hitSize,
  ) {
    final handles = <Widget>[];
    final active = _activeHandle;

    for (final h in widget.enabledHandles) {
      if (h == VResizeHandle.topLeft ||
          h == VResizeHandle.topRight ||
          h == VResizeHandle.bottomLeft ||
          h == VResizeHandle.bottomRight) {
        continue;
      }

      final cursor = _cursorFor(h);
      final isActive = h == active;
      final isHorizontalEdge =
          h == VResizeHandle.top || h == VResizeHandle.bottom;
      final isVerticalEdge =
          h == VResizeHandle.left || h == VResizeHandle.right;

      handles.add(
        Positioned(
          left: h == VResizeHandle.left
              ? -hitSize / 2
              : isHorizontalEdge
                  ? 0
                  : null,
          top: h == VResizeHandle.top
              ? -hitSize / 2
              : isVerticalEdge
                  ? 0
                  : null,
          right: h == VResizeHandle.right
              ? -hitSize / 2
              : isHorizontalEdge
                  ? 0
                  : null,
          bottom: h == VResizeHandle.bottom
              ? -hitSize / 2
              : isVerticalEdge
                  ? 0
                  : null,
          width: isVerticalEdge ? hitSize : null,
          height: isHorizontalEdge ? hitSize : null,
          child: MouseRegion(
            cursor: cursor,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onPanStart: (d) => _onDragStart(h, d.globalPosition),
              onPanUpdate: (d) => _onDragUpdate(d.globalPosition),
              onPanEnd: (_) => _onDragEnd(),
              child: Center(
                child: _buildHandleVisual(
                  context,
                  theme,
                  h,
                  isActive,
                  h == VResizeHandle.top || h == VResizeHandle.bottom
                      ? visSize * 4
                      : visSize,
                  h == VResizeHandle.left || h == VResizeHandle.right
                      ? visSize * 4
                      : visSize,
                ),
              ),
            ),
          ),
        ),
      );
    }

    for (final h in [
      VResizeHandle.topLeft,
      VResizeHandle.topRight,
      VResizeHandle.bottomLeft,
      VResizeHandle.bottomRight,
    ]) {
      if (!widget.enabledHandles.contains(h)) continue;
      final cursor = _cursorFor(h);
      final isActive = h == active;
      final dx = h == VResizeHandle.topLeft || h == VResizeHandle.bottomLeft
          ? -hitSize / 2
          : null;
      final dy = h == VResizeHandle.topLeft || h == VResizeHandle.topRight
          ? -hitSize / 2
          : null;
      handles.add(
        Positioned(
          left: dx,
          top: dy,
          right: h == VResizeHandle.topRight || h == VResizeHandle.bottomRight
              ? -hitSize / 2
              : null,
          bottom:
              h == VResizeHandle.bottomLeft || h == VResizeHandle.bottomRight
                  ? -hitSize / 2
                  : null,
          width: hitSize,
          height: hitSize,
          child: MouseRegion(
            cursor: cursor,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onPanStart: (d) => _onDragStart(h, d.globalPosition),
              onPanUpdate: (d) => _onDragUpdate(d.globalPosition),
              onPanEnd: (_) => _onDragEnd(),
              child: Center(
                child: _buildHandleVisual(
                  context,
                  theme,
                  h,
                  isActive,
                  visSize,
                  visSize,
                ),
              ),
            ),
          ),
        ),
      );
    }

    return handles;
  }

  Widget _buildHandleVisual(
    BuildContext context,
    VThemeData theme,
    VResizeHandle handle,
    bool active,
    double width,
    double height,
  ) {
    if (!widget.showHandles) return const SizedBox.shrink();
    final defaultHandle = _HandleVisual(
      width: width,
      height: height,
      active: active,
      theme: theme,
    );
    return widget.handleBuilder?.call(context, handle, active, defaultHandle) ??
        defaultHandle;
  }

  MouseCursor _cursorFor(VResizeHandle h) => switch (h) {
        VResizeHandle.left ||
        VResizeHandle.right =>
          SystemMouseCursors.resizeLeftRight,
        VResizeHandle.top ||
        VResizeHandle.bottom =>
          SystemMouseCursors.resizeUpDown,
        VResizeHandle.topLeft ||
        VResizeHandle.bottomRight =>
          SystemMouseCursors.resizeUpLeftDownRight,
        VResizeHandle.topRight ||
        VResizeHandle.bottomLeft =>
          SystemMouseCursors.resizeUpRightDownLeft,
      };
}
