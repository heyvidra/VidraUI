import 'dart:async';

import 'package:flutter/widgets.dart';

import '../../foundation/motion.dart';
import '../../foundation/overlay.dart';
import '../../theme/v_theme.dart';

/// A tooltip that appears on hover after a short delay.
///
/// The tooltip is rendered via [VOverlay] and positioned relative to
/// the wrapped child. It automatically clamps to overlay edges and
/// flips above the anchor when there is not enough room below.
class VTooltip extends StatefulWidget {
  const VTooltip({
    super.key,
    required this.message,
    required this.child,
    this.waitDuration = VMotion.tooltipWait,
    this.showDuration = VMotion.tooltipShow,
    this.maxWidth = 280,
  });

  final String message;
  final Widget child;
  final Duration waitDuration;
  final Duration showDuration;

  /// Maximum width of the tooltip surface. Long text wraps within this limit.
  final double maxWidth;

  @override
  State<VTooltip> createState() => _VTooltipState();
}

class _VTooltipState extends State<VTooltip> {
  static _VTooltipState? _activeTooltip;

  final GlobalKey _childKey = GlobalKey();
  Timer? _timer;
  Timer? _hideTimer;
  VOverlayHandle? _handle;

  void _showAfterDelay() {
    if (_handle != null || _timer != null) return;
    if (widget.waitDuration == Duration.zero) {
      _show();
    } else {
      _timer = Timer(widget.waitDuration, _show);
    }
  }

  void _show({Duration? autoHideAfter}) {
    _timer?.cancel();
    _timer = null;
    _hideTimer?.cancel();
    if (_handle != null) {
      if (autoHideAfter != null) {
        _hideTimer = Timer(autoHideAfter, _hide);
      }
      return;
    }

    if (_activeTooltip != null && _activeTooltip != this) {
      _activeTooltip!._hide();
    }

    final host = VOverlay.of(context);
    final theme = VTheme.of(context);
    final box = _childKey.currentContext?.findRenderObject() as RenderBox?;
    if (box == null || !box.hasSize) return;
    final anchorSize = box.size;

    _handle = host.show(
      (overlayContext, handle) {
        final overlayBox = overlayContext.findRenderObject() as RenderBox?;
        final anchorOffset = overlayBox == null
            ? box.localToGlobal(Offset.zero)
            : box.localToGlobal(Offset.zero, ancestor: overlayBox);

        return CustomSingleChildLayout(
          delegate: _TooltipPositionDelegate(
            anchorOffset: anchorOffset,
            anchorSize: anchorSize,
          ),
          child: VTheme(
            data: theme,
            child: _TooltipView(
              message: widget.message,
              maxWidth: widget.maxWidth,
            ),
          ),
        );
      },
    );
    _activeTooltip = this;

    if (autoHideAfter != null) {
      _hideTimer = Timer(autoHideAfter, _hide);
    }
  }

  void _showForTouch() {
    _show(autoHideAfter: widget.showDuration);
  }

  void _hide() {
    _timer?.cancel();
    _timer = null;
    _hideTimer?.cancel();
    _hideTimer = null;
    _handle?.remove();
    _handle = null;
    // Only clear the global reference when it still points at this instance.
    if (identical(_activeTooltip, this)) {
      _activeTooltip = null;
    }
  }

  @override
  void dispose() {
    // Cancel timers before calling _hide to prevent _dismiss firing during
    // dispose, which could access a partially-torn-down context.
    _timer?.cancel();
    _timer = null;
    _hideTimer?.cancel();
    _hideTimer = null;
    _handle?.remove();
    _handle = null;
    if (identical(_activeTooltip, this)) {
      _activeTooltip = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      tooltip: widget.message,
      child: Listener(
        behavior: HitTestBehavior.translucent,
        onPointerHover: (_) => _showAfterDelay(),
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onLongPressStart: (_) => _showForTouch(),
          child: MouseRegion(
            opaque: false,
            onEnter: (_) => _showAfterDelay(),
            onHover: (_) => _showAfterDelay(),
            onExit: (_) => _hide(),
            child: Container(key: _childKey, child: widget.child),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Positioning delegate
// ---------------------------------------------------------------------------

/// Gap between the anchor and the tooltip surface.
const double _kTooltipGap = 4;

/// Minimum distance from the tooltip to the overlay edge.
const double _kEdgePadding = 8;

class _TooltipPositionDelegate extends SingleChildLayoutDelegate {
  _TooltipPositionDelegate({
    required this.anchorOffset,
    required this.anchorSize,
  });

  final Offset anchorOffset;
  final Size anchorSize;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return constraints.loosen();
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    // Center horizontally relative to the anchor.
    double dx = anchorOffset.dx + (anchorSize.width - childSize.width) / 2;

    // Prefer below the anchor.
    double dy = anchorOffset.dy + anchorSize.height + _kTooltipGap;

    // Flip above if there is not enough room below.
    if (dy + childSize.height > size.height - _kEdgePadding) {
      dy = anchorOffset.dy - childSize.height - _kTooltipGap;
    }

    // Clamp to overlay bounds.
    dx = dx.clamp(
      _kEdgePadding,
      (size.width - childSize.width - _kEdgePadding)
          .clamp(_kEdgePadding, double.infinity),
    );
    dy = dy.clamp(
      _kEdgePadding,
      (size.height - childSize.height - _kEdgePadding)
          .clamp(_kEdgePadding, double.infinity),
    );

    return Offset(dx, dy);
  }

  @override
  bool shouldRelayout(_TooltipPositionDelegate oldDelegate) {
    return anchorOffset != oldDelegate.anchorOffset ||
        anchorSize != oldDelegate.anchorSize;
  }
}

// ---------------------------------------------------------------------------
// Tooltip visual
// ---------------------------------------------------------------------------

class _TooltipView extends StatelessWidget {
  const _TooltipView({
    required this.message,
    required this.maxWidth,
  });

  final String message;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);

    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: theme.colors.text,
          borderRadius: BorderRadius.circular(theme.radii.sm),
        ),
        child: Padding(
          padding: EdgeInsets.all(
            theme.spacing.sm,
          ),
          child: Text(
            message,
            softWrap: true,
            style: theme.typography.caption.copyWith(
              color: theme.colors.background,
            ),
          ),
        ),
      ),
    );
  }
}
