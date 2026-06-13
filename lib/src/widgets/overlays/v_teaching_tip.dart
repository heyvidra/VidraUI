import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../foundation/overlay.dart';
import '../../theme/component_tokens.dart';
import '../../theme/v_theme.dart';
import '../../theme/v_theme_data.dart';
import '../basic/v_text.dart';
import 'v_anchored_overlay.dart';
import 'v_overlay_utils.dart';
import 'v_popover.dart';

part 'v_teaching_tip_painters.dart';
part 'v_teaching_tip_presenter.dart';

/// Direction the teaching tip arrow is pointing.
enum VTeachingTipArrowDirection {
  up,
  down,
  left,
  right,
}

/// Transition style for showing/hiding the teaching tip.
enum VTeachingTipTransitionStyle {
  spring,
  fade,
  scale,
  slide,
}

/// A premium, contextual pop-up tip pointing directly to a target widget
/// to guide users through workflows or feature discoverability.
class VTeachingTip extends StatefulWidget {
  const VTeachingTip({
    super.key,
    required this.child,
    this.controller,
    this.title,
    this.subtitle,
    this.illustration,
    this.primaryButton,
    this.secondaryButton,
    this.placement = VAnchoredOverlayPlacement.auto,
    this.gap,
    this.showCloseButton = true,
    this.onClose,
    this.transitionStyle = VTeachingTipTransitionStyle.spring,
  });

  /// The target widget that this teaching tip points to.
  final Widget child;

  /// Optional controller to programmatically open or close the tip.
  final VPopoverController? controller;

  /// The main header text of the teaching tip.
  final String? title;

  /// The description text of the teaching tip.
  final String? subtitle;

  /// Optional illustration widget displayed at the top of the card.
  final Widget? illustration;

  /// Primary button action (e.g. “Next” or “Got it”).
  final Widget? primaryButton;

  /// Secondary button action (e.g. “Skip” or “Back”).
  final Widget? secondaryButton;

  /// Preferred overlay opening direction.
  final VAnchoredOverlayPlacement placement;

  /// Distance between target and popover bubble. Defaults to arrow size + 4.
  final double? gap;

  /// Whether to show the top-right dismiss button.
  final bool showCloseButton;

  /// Callback when the close/dismiss button is clicked.
  final VoidCallback? onClose;

  /// The transition style used when showing or hiding the tip.
  final VTeachingTipTransitionStyle transitionStyle;

  @override
  State<VTeachingTip> createState() => _VTeachingTipState();

  Widget _buildBubble({
    required VTeachingTipTokens tokens,
    required VThemeData theme,
    required VTeachingTipArrowDirection arrowDirection,
    required double arrowAlignmentX,
    required double arrowAlignmentY,
    required VoidCallback onClosePressed,
  }) {
    final arrowSize = tokens.arrowSize;
    final isVerticalArrow = arrowDirection == VTeachingTipArrowDirection.up ||
        arrowDirection == VTeachingTipArrowDirection.down;

    final bubbleBody = Container(
      decoration: BoxDecoration(
        color: tokens.background,
        borderRadius: BorderRadius.circular(tokens.radius),
        border: Border.all(color: tokens.border),
        boxShadow: [theme.shadows.dialog],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (illustration != null) illustration!,
          Padding(
            padding: tokens.padding,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (title != null)
                      Expanded(
                        child: VText(
                          title!,
                          variant: VTextVariant.subtitle,
                          style: TextStyle(
                            color: tokens.titleColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    if (showCloseButton)
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: onClosePressed,
                        child: SizedBox(
                          width: tokens.closeButtonSize,
                          height: tokens.closeButtonSize,
                          child: Center(
                            child: CustomPaint(
                              size: const Size(10, 10),
                              painter: _VCloseIconPainter(
                                color: tokens.subtitleColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                if (subtitle != null) ...[
                  SizedBox(height: tokens.titleSubtitleGap),
                  VText(
                    subtitle!,
                    variant: VTextVariant.body,
                    style: TextStyle(
                      color: tokens.subtitleColor,
                      height: 1.4,
                    ),
                  ),
                ],
                if (primaryButton != null || secondaryButton != null) ...[
                  SizedBox(height: tokens.contentActionGap),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (secondaryButton != null) ...[
                        secondaryButton!,
                        SizedBox(width: tokens.actionButtonGap),
                      ],
                      if (primaryButton != null) primaryButton!,
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: arrowDirection == VTeachingTipArrowDirection.left
                ? arrowSize
                : 0.0,
            right: arrowDirection == VTeachingTipArrowDirection.right
                ? arrowSize
                : 0.0,
            top: arrowDirection == VTeachingTipArrowDirection.up
                ? arrowSize
                : 0.0,
            bottom: arrowDirection == VTeachingTipArrowDirection.down
                ? arrowSize
                : 0.0,
          ),
          child: bubbleBody,
        ),
        Positioned.fill(
          child: Align(
            alignment: switch (arrowDirection) {
              VTeachingTipArrowDirection.up => Alignment(arrowAlignmentX, -1.0),
              VTeachingTipArrowDirection.down =>
                Alignment(arrowAlignmentX, 1.0),
              VTeachingTipArrowDirection.left =>
                Alignment(-1.0, arrowAlignmentY),
              VTeachingTipArrowDirection.right =>
                Alignment(1.0, arrowAlignmentY),
            },
            child: Transform.translate(
              offset: switch (arrowDirection) {
                VTeachingTipArrowDirection.up => const Offset(0, 1.0),
                VTeachingTipArrowDirection.down => const Offset(0, -1.0),
                VTeachingTipArrowDirection.left => const Offset(1.0, 0),
                VTeachingTipArrowDirection.right => const Offset(-1.0, 0),
              },
              child: CustomPaint(
                size: isVerticalArrow
                    ? Size(arrowSize * 2, arrowSize)
                    : Size(arrowSize, arrowSize * 2),
                painter: _VTeachingTipArrowPainter(
                  color: tokens.background,
                  borderColor: tokens.border,
                  direction: arrowDirection,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  double _estimatedSurfaceHeight(VTeachingTipTokens tokens) {
    final padding = tokens.padding.resolve(TextDirection.ltr);
    var height = tokens.arrowSize;

    if (illustration != null) {
      height += tokens.illustrationHeight;
    }

    height += padding.vertical;

    if (title != null || showCloseButton) {
      height += 24.0;
    }

    if (subtitle != null) {
      height += 8.0;
      height += illustration != null
          ? tokens.estimatedSubtitleHeightIllustration
          : tokens.estimatedSubtitleHeightNormal;
    }

    if (primaryButton != null || secondaryButton != null) {
      height += tokens.estimatedActionsHeight;
    }

    return height.clamp(96.0, 340.0);
  }
}

class _VTeachingTipState extends State<VTeachingTip> {
  late VPopoverController _internalController;
  VPopoverController get _controller =>
      widget.controller ?? _internalController;

  final LayerLink _layerLink = LayerLink();
  VOverlayHandle? _overlayHandle;
  VThemeData? _capturedTheme;

  @override
  void initState() {
    super.initState();
    _internalController = VPopoverController();
    _controller.addListener(_onControllerChanged);
  }

  @override
  void didUpdateWidget(VTeachingTip oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      (oldWidget.controller ?? _internalController)
          .removeListener(_onControllerChanged);
      _controller.addListener(_onControllerChanged);

      if (_controller.isOpen !=
          (oldWidget.controller ?? _internalController).isOpen) {
        _onControllerChanged();
      }
    }

    if (_overlayHandle != null && _controller.isOpen) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _overlayHandle?.markNeedsBuild();
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onControllerChanged);
    _internalController.dispose();
    _closeTip();
    super.dispose();
  }

  void _onControllerChanged() {
    if (!mounted) return;
    if (_controller.isOpen) {
      if (_overlayHandle == null) {
        _openTip();
      }
    }
    setState(() {});
  }

  void _openTip() {
    final box = context.findRenderObject() as RenderBox?;
    if (box == null || !box.hasSize) return;

    _capturedTheme = VTheme.of(context);
    _overlayHandle = showVWidgetOverlay(
      context,
      (context, handle) => _buildOverlay(box),
      maintainState: true,
    );
  }

  void _closeTip() {
    _overlayHandle?.remove();
    _overlayHandle = null;
  }

  Widget _buildOverlay(RenderBox box) {
    // Use the captured theme exclusively — never fall back to
    // VTheme.of(context) here, because the host State's context
    // may already be deactivated when the overlay rebuilds.
    return _VTeachingTipPresenter(
      controller: _controller,
      triggerBox: box,
      layerLink: _layerLink,
      theme: _capturedTheme!,
      widget: widget,
      onDismissed: _closeTip,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: widget.child,
    );
  }
}
