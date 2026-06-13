part of 'v_context_menu.dart';

class _VContextMenuOverlay extends StatefulWidget {
  const _VContextMenuOverlay({
    required this.targetRect,
    required this.actions,
    required this.targetWidget,
    required this.hasPreview,
    required this.capturedTheme,
    required this.style,
    required this.onDismiss,
  });

  final Rect targetRect;
  final List<VContextMenuItem> actions;
  final Widget targetWidget;
  final bool hasPreview;
  final VThemeData capturedTheme;
  final VContextMenuStyle style;
  final VoidCallback onDismiss;

  @override
  State<_VContextMenuOverlay> createState() => _VContextMenuOverlayState();
}

class _VContextMenuOverlayState extends State<_VContextMenuOverlay>
    with VOverlayAnimationState {

  // Geometry computed once per dependency change, not per animation frame.
  late VContextMenuGeometry _geometry;

  // Token-derived values stored so animation builders don't re-read tokens.
  late double _menuWidth;
  late double _screenMargin;
  late double _gap;
  late double _previewWidth;
  late double _colWidth;
  late double _colLeft;
  late double? _colTop;
  late double? _colBottom;

  void _dismiss() {
    if (isOverlayClosing) return;
    reverseOverlay();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _computeGeometry();
  }

  void _computeGeometry() {
    final theme = widget.capturedTheme;
    final tokens = theme.components.menu;

    _menuWidth = tokens.width;
    _screenMargin = tokens.screenMargin;
    _gap = theme.spacing.sm;

    if (widget.hasPreview) {
      _previewWidth = tokens.previewWidth;
      _geometry = resolveVContextMenuPreviewGeometry(
        overlayContext: context,
        targetRect: widget.targetRect,
        desiredHeight: tokens.maxHeight,
        previewWidth: tokens.previewWidth,
        menuWidth: tokens.width,
        screenMargin: tokens.screenMargin,
        gap: theme.spacing.sm,
      );
      _colWidth = _previewWidth > _menuWidth ? _previewWidth : _menuWidth;
      _colLeft = (_geometry.maxWidth) / 2 > 0
          ? (MediaQuery.sizeOf(context).width - _colWidth) / 2
          : 0.0;
      // Clamp colLeft to screen margin.
      final screenWidth = MediaQuery.sizeOf(context).width;
      if (_colLeft < _screenMargin) {
        _colLeft = _screenMargin;
      }
      if (_geometry.openBelow) {
        _colTop = (widget.targetRect.bottom - widget.targetRect.height)
            .clamp(_screenMargin, screenWidth - _screenMargin);
        _colBottom = null;
      } else {
        _colTop = null;
        _colBottom = (screenWidth - widget.targetRect.top)
            .clamp(_screenMargin, screenWidth - _screenMargin);
      }
    } else {
      _geometry = resolveVContextMenuGeometry(
        overlayContext: context,
        targetRect: widget.targetRect,
        desiredHeight: tokens.maxHeight,
        menuWidth: tokens.width,
        screenMargin: tokens.screenMargin,
        gap: theme.spacing.sm,
      );
    }
  }

  @override
  void dispose() {
    disposeOverlayAnimation();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final spec = widget.capturedTheme.motion.overlay;

    return VOverlayAnimation(
      motionSpec: spec,
      onReverseComplete: widget.onDismiss,
      builder: (animationContext, controller) {
        final curved =
            setupOverlayAnimation(controller, spec, animationContext);

        return VTheme(
          data: widget.capturedTheme,
          child: Stack(
            children: [
              AnimatedBuilder(
                animation: curved,
                builder: (context, child) {
                  final tokens =
                      widget.capturedTheme.components.menu;
                  final blurVal =
                      curved.value * tokens.backdropBlurSigma;
                  final opacityVal =
                      curved.value * tokens.backdropOpacity;
                  return GestureDetector(
                    onTap: _dismiss,
                    behavior: HitTestBehavior.opaque,
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                          sigmaX: blurVal, sigmaY: blurVal),
                      child: Container(
                        color: tokens.backdropColor
                            .withValues(alpha: opacityVal),
                      ),
                    ),
                  );
                },
              ),
              _buildLiftedAndMenuContent(curved),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLiftedAndMenuContent(CurvedAnimation curved) {
    final theme = widget.capturedTheme;
    final tokens = theme.components.menu;
    final geometry = _geometry;
    final openBelow = geometry.openBelow;
    final menuLeft = geometry.menuLeft;
    final menuWidth = _menuWidth;
    final gap = _gap;
    final screenMargin = _screenMargin;
    final screenSize = MediaQuery.sizeOf(context);

    if (widget.hasPreview) {
      final colWidth = _colWidth;
      final colLeft = _colLeft;
      final colTop = _colTop;
      final colBottom = _colBottom;

      return AnimatedBuilder(
        animation: curved,
        builder: (context, child) {
          final double scale =
              1.0 + (curved.value * tokens.liftScaleDelta);
          final double shadowOpacity =
              curved.value * tokens.liftShadowOpacity;

          final Widget liftedWidget = Transform.scale(
            scale: scale,
            alignment: Alignment.center,
            child: DecoratedBox(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: tokens.liftShadowColor.withValues(
                      alpha: shadowOpacity,
                    ),
                    blurRadius:
                        tokens.liftShadowBlur * curved.value,
                    offset: Offset(
                      0.0,
                      tokens.liftShadowOffsetY * curved.value,
                    ),
                  ),
                ],
              ),
              child: widget.targetWidget,
            ),
          );

          final double maxMenuHeight = openBelow
              ? (screenSize.height -
                      widget.targetRect.bottom -
                      gap * 1.5 -
                      screenMargin)
                  .clamp(tokens.minHeight, tokens.maxHeight)
              : (widget.targetRect.top - gap * 1.5 - screenMargin)
                  .clamp(tokens.minHeight, tokens.maxHeight);

          final Widget menuWidget = Opacity(
            opacity: curved.value.clamp(0.0, 1.0),
            child: Transform.scale(
              scale: tokens.menuScaleBegin +
                  (curved.value * (1.0 - tokens.menuScaleBegin)),
              alignment: Alignment.center,
              child: SizedBox(
                width: menuWidth,
                child: ConstrainedBox(
                  constraints:
                      BoxConstraints(maxHeight: maxMenuHeight),
                  child: _VContextMenuItemsList(
                    actions: widget.actions,
                    theme: theme,
                    style: widget.style,
                    onItemTapped: _dismiss,
                  ),
                ),
              ),
            ),
          );

          final columnChildren = <Widget>[
            liftedWidget,
            SizedBox(height: gap * 1.5),
            menuWidget,
          ];

          return Positioned(
            top: colTop,
            bottom: colBottom,
            left: colLeft,
            width: colWidth,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: openBelow
                  ? columnChildren
                  : columnChildren.reversed.toList(),
            ),
          );
        },
      );
    }

    return AnimatedBuilder(
      animation: curved,
      builder: (context, child) {
        final double scale =
            1.0 + (curved.value * tokens.liftScaleDelta);
        final double shadowOpacity =
            curved.value * tokens.liftShadowOpacity;

        final Widget liftedWidget = Transform.scale(
          scale: scale,
          alignment: Alignment.center,
          child: DecoratedBox(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: tokens.liftShadowColor.withValues(
                    alpha: shadowOpacity,
                  ),
                  blurRadius:
                      tokens.liftShadowBlur * curved.value,
                  offset: Offset(
                    0.0,
                    tokens.liftShadowOffsetY * curved.value,
                  ),
                ),
              ],
            ),
            child: widget.targetWidget,
          ),
        );

        final double maxMenuHeight = openBelow
            ? (screenSize.height -
                    widget.targetRect.bottom -
                    gap -
                    screenMargin)
                .clamp(tokens.minHeight, tokens.maxHeight)
            : (widget.targetRect.top - gap - screenMargin)
                .clamp(tokens.minHeight, tokens.maxHeight);

        final Widget menuWidget = Opacity(
          opacity: curved.value.clamp(0.0, 1.0),
          child: Transform.scale(
            scale: tokens.menuScaleBegin +
                (curved.value * (1.0 - tokens.menuScaleBegin)),
            alignment: openBelow
                ? Alignment.topCenter
                : Alignment.bottomCenter,
            child: SizedBox(
              width: menuWidth,
              child: ConstrainedBox(
                constraints:
                    BoxConstraints(maxHeight: maxMenuHeight),
                child: _VContextMenuItemsList(
                  actions: widget.actions,
                  theme: theme,
                  style: widget.style,
                  onItemTapped: _dismiss,
                ),
              ),
            ),
          ),
        );

        return Stack(
          children: [
            Positioned(
              top: widget.targetRect.top,
              left: widget.targetRect.left,
              width: widget.targetRect.width,
              height: widget.targetRect.height,
              child: IgnorePointer(
                child: liftedWidget,
              ),
            ),
            if (openBelow)
              Positioned(
                top: widget.targetRect.bottom + gap,
                left: menuLeft,
                child: menuWidget,
              )
            else
              Positioned(
                bottom: (screenSize.height -
                        widget.targetRect.top) +
                    gap,
                left: menuLeft,
                child: menuWidget,
              ),
          ],
        );
      },
    );
  }
}
