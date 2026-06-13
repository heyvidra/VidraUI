part of 'v_teaching_tip.dart';

class _VTeachingTipPresenter extends StatefulWidget {
  const _VTeachingTipPresenter({
    required this.controller,
    required this.triggerBox,
    required this.layerLink,
    required this.theme,
    required this.widget,
    required this.onDismissed,
  });

  final VPopoverController controller;
  final RenderBox triggerBox;
  final LayerLink layerLink;
  final VThemeData theme;
  final VTeachingTip widget;
  final VoidCallback onDismissed;

  @override
  State<_VTeachingTipPresenter> createState() => _VTeachingTipPresenterState();
}

class _VTeachingTipPresenterState extends State<_VTeachingTipPresenter>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animController;
  late Animation<double> _opacity;
  late Animation<double> _scale;
  bool _closing = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onControllerChanged);

    final bool reduced = widget.theme.motion.reducedMotion;

    _animController = AnimationController(
      duration:
          reduced ? Duration.zero : widget.theme.motion.emphasized.duration,
      reverseDuration: reduced
          ? Duration.zero
          : widget.theme.motion.emphasized.effectiveReverseDuration,
      vsync: this,
    );

    _configureAnimations();
    _animController.forward();
  }

  void _configureAnimations() {
    final VTeachingTipTransitionStyle style = widget.widget.transitionStyle;

    switch (style) {
      case VTeachingTipTransitionStyle.spring:
        _opacity = CurvedAnimation(
          parent: _animController,
          curve: Curves.easeOut,
          reverseCurve: Curves.easeIn,
        );
        _scale = ConstantTween<double>(1.0).animate(_animController);
        break;
      case VTeachingTipTransitionStyle.scale:
        _opacity = CurvedAnimation(
          parent: _animController,
          curve: Curves.easeOut,
          reverseCurve: Curves.easeIn,
        );
        _scale = Tween<double>(begin: 0.90, end: 1.0).animate(
          CurvedAnimation(
            parent: _animController,
            curve: Curves.easeOutCubic,
            reverseCurve: Curves.easeInCubic,
          ),
        );
        break;
      case VTeachingTipTransitionStyle.slide:
        _opacity = CurvedAnimation(
          parent: _animController,
          curve: Curves.easeOut,
          reverseCurve: Curves.easeIn,
        );
        _scale = ConstantTween<double>(1.0).animate(_animController);
        break;
      case VTeachingTipTransitionStyle.fade:
        _opacity = CurvedAnimation(
          parent: _animController,
          curve: Curves.easeOut,
          reverseCurve: Curves.easeIn,
        );
        _scale = ConstantTween<double>(1.0).animate(_animController);
        break;
    }
  }

  @override
  void didUpdateWidget(_VTeachingTipPresenter oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller.removeListener(_onControllerChanged);
      widget.controller.addListener(_onControllerChanged);
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onControllerChanged);
    _animController.dispose();
    super.dispose();
  }

  void _onControllerChanged() {
    if (!mounted) return;
    if (!widget.controller.isOpen && !_closing) {
      _closeTipPresenter();
    }
  }

  Future<void> _closeTipPresenter() async {
    if (_closing) return;
    _closing = true;
    await _animController.reverse();
    if (mounted) {
      widget.onDismissed();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme;
    final tokens = theme.components.teachingTip;
    final gap = widget.widget.gap ?? tokens.gap;

    final double bubbleWidth = tokens.surfaceWidth;
    final double bubbleHeight = widget.widget._estimatedSurfaceHeight(tokens);
    final double margin = tokens.margin;
    final geometry = resolveVAnchoredOverlaySurfaceGeometry(
      overlayContext: context,
      triggerBox: widget.triggerBox,
      placement: widget.widget.placement,
      desiredWidth: bubbleWidth,
      desiredHeight: bubbleHeight,
      gap: gap,
      margin: margin,
    );

    final VTeachingTipArrowDirection arrowDirection;
    if (geometry.isHorizontal) {
      arrowDirection = geometry.openLeft
          ? VTeachingTipArrowDirection.right
          : VTeachingTipArrowDirection.left;
    } else {
      arrowDirection = geometry.openUp
          ? VTeachingTipArrowDirection.down
          : VTeachingTipArrowDirection.up;
    }

    double arrowAlignmentX = 0.0;
    double arrowAlignmentY = 0.0;

    if (geometry.isHorizontal) {
      final double maxArrowOffset =
          (bubbleHeight / 2) - tokens.radius - tokens.arrowSize;
      final double clampedOffset = maxArrowOffset > 0
          ? (-geometry.crossAxisOffset).clamp(-maxArrowOffset, maxArrowOffset)
          : -geometry.crossAxisOffset;
      arrowAlignmentY = clampedOffset / (bubbleHeight / 2);
    } else {
      final double maxArrowOffset =
          (bubbleWidth / 2) - tokens.radius - tokens.arrowSize;
      final double clampedOffset = maxArrowOffset > 0
          ? (-geometry.crossAxisOffset).clamp(-maxArrowOffset, maxArrowOffset)
          : -geometry.crossAxisOffset;
      arrowAlignmentX = clampedOffset / (bubbleWidth / 2);
    }

    return Positioned.fill(
      child: Stack(
        children: [
          Positioned(
            child: CompositedTransformFollower(
              link: widget.layerLink,
              showWhenUnlinked: false,
              offset: geometry.offset,
              targetAnchor: geometry.targetAnchor,
              followerAnchor: geometry.followerAnchor,
              child: VTheme(
                data: theme,
                child: FocusScope(
                  autofocus: true,
                  onKeyEvent: (node, event) {
                    if (event is KeyDownEvent &&
                        event.logicalKey == LogicalKeyboardKey.escape) {
                      widget.controller.close();
                      widget.widget.onClose?.call();
                      return KeyEventResult.handled;
                    }
                    return KeyEventResult.ignored;
                  },
                  child: AnimatedBuilder(
                    animation: _animController,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: geometry.maxWidth,
                        maxWidth: geometry.maxWidth,
                      ),
                      child: widget.widget._buildBubble(
                        tokens: tokens,
                        theme: theme,
                        arrowDirection: arrowDirection,
                        arrowAlignmentX: arrowAlignmentX,
                        arrowAlignmentY: arrowAlignmentY,
                        onClosePressed: () {
                          widget.controller.close();
                          widget.widget.onClose?.call();
                        },
                      ),
                    ),
                    builder: (context, bubbleChild) {
                      final style = widget.widget.transitionStyle;
                      Offset slideTranslation = Offset.zero;
                      if (style == VTeachingTipTransitionStyle.slide) {
                        const double slideDistance = 16.0;
                        final double progress = 1.0 - _animController.value;
                        switch (arrowDirection) {
                          case VTeachingTipArrowDirection.up:
                            slideTranslation =
                                Offset(0.0, slideDistance * progress);
                            break;
                          case VTeachingTipArrowDirection.down:
                            slideTranslation =
                                Offset(0.0, -slideDistance * progress);
                            break;
                          case VTeachingTipArrowDirection.left:
                            slideTranslation =
                                Offset(slideDistance * progress, 0.0);
                            break;
                          case VTeachingTipArrowDirection.right:
                            slideTranslation =
                                Offset(-slideDistance * progress, 0.0);
                            break;
                        }
                      }

                      return Opacity(
                        opacity: _opacity.value,
                        child: Transform.translate(
                          offset: slideTranslation,
                          child: Transform.scale(
                            scale: _scale.value,
                            alignment: switch (arrowDirection) {
                              VTeachingTipArrowDirection.up =>
                                Alignment(arrowAlignmentX, -1.0),
                              VTeachingTipArrowDirection.down =>
                                Alignment(arrowAlignmentX, 1.0),
                              VTeachingTipArrowDirection.left =>
                                Alignment(-1.0, arrowAlignmentY),
                              VTeachingTipArrowDirection.right =>
                                Alignment(1.0, arrowAlignmentY),
                            },
                            child: bubbleChild,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
