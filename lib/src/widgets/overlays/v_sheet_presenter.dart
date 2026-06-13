part of 'v_sheet.dart';

class _VSheetPresenter<T> extends StatefulWidget {
  const _VSheetPresenter({
    required this.edge,
    required this.barrierDismissible,
    required this.enableDragToDismiss,
    required this.maxExtent,
    this.minExtent,
    required this.keyboardInset,
    required this.theme,
    required this.motion,
    required this.onCloseRequested,
    required this.onDismissed,
    required this.builder,
    this.semanticLabel,
    this.surfaceBackground,
  });

  final VSheetEdge edge;
  final bool barrierDismissible;
  final bool enableDragToDismiss;
  final double maxExtent;
  final double? minExtent;
  final double keyboardInset;
  final VThemeData theme;
  final VMotion? motion;
  final ValueChanged<T?> onCloseRequested;
  final VoidCallback onDismissed;
  final WidgetBuilder builder;
  final String? semanticLabel;
  final VBackground? surfaceBackground;

  @override
  State<_VSheetPresenter<T>> createState() => _VSheetPresenterState<T>();
}

class _VSheetPresenterState<T> extends State<_VSheetPresenter<T>>
    with VOverlayAnimationState {
  double _dragOffset = 0;

  void _onDragUpdate(DragUpdateDetails details) {
    if (!widget.enableDragToDismiss || isOverlayClosing) return;
    final delta = _dismissDelta(details.delta);
    if (delta > 0) {
      setState(() => _dragOffset += delta);
    }
  }

  void _onDragEnd(DragEndDetails details) {
    if (!widget.enableDragToDismiss || isOverlayClosing) return;
    final velocity = _dismissVelocity(details.velocity.pixelsPerSecond);
    if (_dragOffset > VSheet._dragDismissThreshold || velocity > 300) {
      _close(null);
    } else {
      setState(() => _dragOffset = 0);
    }
  }

  double _dismissDelta(Offset delta) {
    return switch (widget.edge) {
      VSheetEdge.top => -delta.dy,
      VSheetEdge.right => delta.dx,
      VSheetEdge.bottom => delta.dy,
      VSheetEdge.left => -delta.dx,
    };
  }

  double _dismissVelocity(Offset velocity) {
    return switch (widget.edge) {
      VSheetEdge.top => -velocity.dy,
      VSheetEdge.right => velocity.dx,
      VSheetEdge.bottom => velocity.dy,
      VSheetEdge.left => -velocity.dx,
    };
  }

  void _close([T? result]) {
    if (isOverlayClosing) return;
    widget.onCloseRequested(result);
    reverseOverlay();
  }

  @override
  void dispose() {
    disposeOverlayAnimation();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final motion = widget.motion ?? widget.theme.motion;
    final spec = motion.emphasized;
    final availableExtent =
        math.max(widget.maxExtent - widget.keyboardInset - _dragOffset, 100.0);
    final effectiveMinExtent = widget.minExtent == null
        ? 0.0
        : math.min(math.max(widget.minExtent!, 0.0), availableExtent);
    final surfaceBackground = widget.surfaceBackground ??
        VBackground.color(widget.theme.colors.surface);

    return VOverlayAnimation(
      motionSpec: spec,
      onReverseComplete: widget.onDismissed,
      builder: (animationContext, controller) {
        final slide =
            setupOverlayAnimation(controller, spec, animationContext);

        final result = VTheme(
          data: widget.theme,
          child: Stack(
            children: [
              Positioned.fill(
                child: GestureDetector(
                  onTap: widget.barrierDismissible ? () => _close(null) : null,
                  child: FadeTransition(
                    opacity: slide,
                    child: ColoredBox(
                      color: widget.theme.colors.surfaceElevated
                          .withValues(alpha: 0.7),
                    ),
                  ),
                ),
              ),
              AnimatedBuilder(
                animation: slide,
                child: Builder(
                  builder: (descendantCtx) => widget.builder(descendantCtx),
                ),
                builder: (context, sheetChild) {
                  return _positionedSheet(
                    child: AnimatedPadding(
                      duration: VMotionResolver.duration(
                          animationContext, spec),
                      curve: VMotionResolver.curve(animationContext, spec),
                      padding:
                          EdgeInsets.only(bottom: widget.keyboardInset),
                      child: FractionalTranslation(
                        translation: _entryOffset(slide.value),
                        child: Transform.translate(
                          offset: _dragTranslation(),
                          child: Opacity(
                            opacity: slide.value.clamp(0.0, 1.0),
                            child: VSheetScope<T>(
                              close: _close,
                              child: _VSheetLayoutScope(
                                edge: widget.edge,
                                child: CallbackShortcuts(
                                  bindings: <ShortcutActivator, VoidCallback>{
                                    const SingleActivator(
                                      LogicalKeyboardKey.escape,
                                    ): () => _close(null),
                                  },
                                  child: GestureDetector(
                                    onPanUpdate: _onDragUpdate,
                                    onPanEnd: _onDragEnd,
                                    child: ConstrainedBox(
                                      constraints: _constraints(
                                        minExtent: effectiveMinExtent,
                                        maxExtent: availableExtent,
                                      ),
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                          color: surfaceBackground
                                                      .gradient ==
                                                  null
                                              ? surfaceBackground.color
                                              : null,
                                          gradient:
                                              surfaceBackground.gradient,
                                          borderRadius: _borderRadius(
                                              widget.edge),
                                          boxShadow: [
                                            widget.theme.shadows.dialog,
                                          ],
                                        ),
                                        child: sheetChild,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
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

  Widget _positionedSheet({required Widget child}) {
    return switch (widget.edge) {
      VSheetEdge.top => Positioned(left: 0, top: 0, right: 0, child: child),
      VSheetEdge.right =>
        Positioned(top: 0, right: 0, bottom: 0, child: child),
      VSheetEdge.bottom =>
        Positioned(left: 0, right: 0, bottom: 0, child: child),
      VSheetEdge.left =>
        Positioned(left: 0, top: 0, bottom: 0, child: child),
    };
  }

  Offset _entryOffset(double animationValue) {
    final begin = switch (widget.edge) {
      VSheetEdge.top => const Offset(0, -1),
      VSheetEdge.right => const Offset(1, 0),
      VSheetEdge.bottom => const Offset(0, 1),
      VSheetEdge.left => const Offset(-1, 0),
    };
    return Tween<Offset>(begin: begin, end: Offset.zero).transform(
      animationValue,
    );
  }

  Offset _dragTranslation() {
    return switch (widget.edge) {
      VSheetEdge.top => Offset(0, -_dragOffset),
      VSheetEdge.right => Offset(_dragOffset, 0),
      VSheetEdge.bottom => Offset(0, _dragOffset),
      VSheetEdge.left => Offset(-_dragOffset, 0),
    };
  }

  BoxConstraints _constraints({
    required double minExtent,
    required double maxExtent,
  }) {
    return switch (widget.edge) {
      VSheetEdge.top || VSheetEdge.bottom => BoxConstraints(
          minHeight: minExtent,
          maxHeight: maxExtent,
        ),
      VSheetEdge.left || VSheetEdge.right => BoxConstraints(
          minWidth: minExtent,
          maxWidth: maxExtent,
        ),
    };
  }

  BorderRadius _borderRadius(VSheetEdge edge) {
    final radius = Radius.circular(VTheme.of(context).radii.xl);
    return switch (edge) {
      VSheetEdge.top => BorderRadius.vertical(bottom: radius),
      VSheetEdge.right => BorderRadius.horizontal(left: radius),
      VSheetEdge.bottom => BorderRadius.vertical(top: radius),
      VSheetEdge.left => BorderRadius.horizontal(right: radius),
    };
  }
}
