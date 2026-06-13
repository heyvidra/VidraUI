import 'package:flutter/widgets.dart';

/// Internal opening direction for anchored overlay surfaces.
enum VAnchoredOverlayPlacement {
  auto,
  down,
  up,
  left,
  right,
  autoHorizontal,
}

/// Internal resolved geometry for an anchored overlay surface.
class VAnchoredOverlayGeometry {
  const VAnchoredOverlayGeometry({
    required this.offset,
    required this.maxHeight,
    required this.maxWidth,
    required this.openUp,
    this.targetAnchor = Alignment.bottomLeft,
    this.followerAnchor = Alignment.topLeft,
  });

  final Offset offset;
  final double maxHeight;
  final double maxWidth;
  final bool openUp;
  final Alignment targetAnchor;
  final Alignment followerAnchor;
}

/// Internal resolved geometry for a fixed-size anchored surface.
class VAnchoredOverlaySurfaceGeometry {
  const VAnchoredOverlaySurfaceGeometry({
    required this.offset,
    required this.maxHeight,
    required this.maxWidth,
    required this.openUp,
    required this.openLeft,
    required this.isHorizontal,
    required this.targetAnchor,
    required this.followerAnchor,
    required this.crossAxisOffset,
  });

  final Offset offset;
  final double maxHeight;
  final double maxWidth;
  final bool openUp;
  final bool openLeft;
  final bool isHorizontal;
  final Alignment targetAnchor;
  final Alignment followerAnchor;
  final double crossAxisOffset;
}

/// Resolves vertical or horizontal menu geometry relative to a trigger render box.
VAnchoredOverlayGeometry resolveVAnchoredOverlayGeometry({
  required BuildContext overlayContext,
  required RenderBox triggerBox,
  required VAnchoredOverlayPlacement placement,
  required double desiredHeight,
  required double gap,
  double? desiredWidth,
}) {
  final overlayRenderObject =
      Overlay.maybeOf(overlayContext)?.context.findRenderObject() ??
          overlayContext.findRenderObject();
  final overlayBox =
      overlayRenderObject is RenderBox ? overlayRenderObject : null;

  if (overlayBox == null || !overlayBox.hasSize || !triggerBox.hasSize) {
    return VAnchoredOverlayGeometry(
      offset: Offset(0, gap),
      maxHeight: desiredHeight,
      maxWidth: double.infinity,
      openUp: false,
    );
  }

  final triggerTopLeft = overlayBox.globalToLocal(
    triggerBox.localToGlobal(Offset.zero),
  );
  final triggerRect = triggerTopLeft & triggerBox.size;

  final isHorizontal = placement == VAnchoredOverlayPlacement.left ||
      placement == VAnchoredOverlayPlacement.right ||
      placement == VAnchoredOverlayPlacement.autoHorizontal;

  if (isHorizontal) {
    final spaceLeft = triggerRect.left - gap;
    final spaceRight = overlayBox.size.width - triggerRect.right - gap;

    final openLeft = switch (placement) {
      VAnchoredOverlayPlacement.left => true,
      VAnchoredOverlayPlacement.right => false,
      _ => (desiredWidth ?? 200.0) > spaceRight && spaceLeft > spaceRight,
    };

    final targetAnchor = openLeft ? Alignment.topLeft : Alignment.topRight;
    final followerAnchor = openLeft ? Alignment.topRight : Alignment.topLeft;
    final offset = Offset(openLeft ? -gap : gap, 0);

    final availableHeight = overlayBox.size.height - triggerRect.top - 8.0;
    final maxHeight = _clampOverlayHeight(desiredHeight, availableHeight);
    final maxWidth = openLeft
        ? spaceLeft.clamp(0.0, double.infinity)
        : spaceRight.clamp(0.0, double.infinity);

    return VAnchoredOverlayGeometry(
      offset: offset,
      maxHeight: maxHeight,
      maxWidth: maxWidth,
      openUp: false,
      targetAnchor: targetAnchor,
      followerAnchor: followerAnchor,
    );
  }

  // Vertical placement logic (default)
  final spaceBelow = overlayBox.size.height - triggerRect.bottom - gap;
  final spaceAbove = triggerRect.top - gap;

  final openUp = switch (placement) {
    VAnchoredOverlayPlacement.up => true,
    VAnchoredOverlayPlacement.down => false,
    VAnchoredOverlayPlacement.auto =>
      desiredHeight > spaceBelow && spaceAbove > spaceBelow,
    _ => false,
  };

  final availableHeight = openUp ? spaceAbove : spaceBelow;
  final maxHeight = _clampOverlayHeight(desiredHeight, availableHeight);
  final dy = openUp ? -gap : gap;

  // Horizontal-overflow handling for vertical placement.
  //
  // The default cross-axis behaviour anchors the menu's LEFT edge to the
  // trigger's LEFT edge — fine when the trigger sits near the LEFT of the
  // overlay, but it lets the menu extend past the RIGHT edge of the overlay
  // when the trigger is right-aligned (e.g. a button at the end of a narrow
  // sidebar). When the caller passes a [desiredWidth] hint we can detect
  // the overflow and flip to right-aligned anchoring so the menu extends
  // LEFTWARD from the trigger's right edge instead.
  final hintedMenuWidth = desiredWidth ?? triggerRect.width;
  final spaceRightOfTriggerLeft =
      (overlayBox.size.width - triggerRect.left).clamp(0.0, double.infinity);
  final wouldOverflowRight =
      triggerRect.left + hintedMenuWidth + 8.0 > overlayBox.size.width;

  final Alignment targetAnchor;
  final Alignment followerAnchor;
  final double maxWidth;
  if (wouldOverflowRight) {
    targetAnchor = openUp ? Alignment.topRight : Alignment.bottomRight;
    followerAnchor = openUp ? Alignment.bottomRight : Alignment.topRight;
    final spaceFromLeftToTriggerRight =
        triggerRect.right.clamp(0.0, double.infinity);
    maxWidth = spaceFromLeftToTriggerRight < triggerRect.width
        ? triggerRect.width
        : spaceFromLeftToTriggerRight;
  } else {
    targetAnchor = openUp ? Alignment.topLeft : Alignment.bottomLeft;
    followerAnchor = openUp ? Alignment.bottomLeft : Alignment.topLeft;
    maxWidth = spaceRightOfTriggerLeft < triggerRect.width
        ? triggerRect.width
        : spaceRightOfTriggerLeft;
  }

  return VAnchoredOverlayGeometry(
    offset: Offset(0, dy),
    maxHeight: maxHeight,
    maxWidth: maxWidth,
    openUp: openUp,
    targetAnchor: targetAnchor,
    followerAnchor: followerAnchor,
  );
}

double _clampOverlayHeight(double desiredHeight, double availableHeight) {
  if (availableHeight <= 0) return 0;
  if (desiredHeight <= availableHeight) return desiredHeight;
  return availableHeight;
}

/// Resolves centered anchored-surface geometry with viewport collision handling.
VAnchoredOverlaySurfaceGeometry resolveVAnchoredOverlaySurfaceGeometry({
  required BuildContext overlayContext,
  required RenderBox triggerBox,
  required VAnchoredOverlayPlacement placement,
  required double desiredWidth,
  required double desiredHeight,
  required double gap,
  required double margin,
}) {
  final overlayRenderObject =
      Overlay.maybeOf(overlayContext)?.context.findRenderObject() ??
          overlayContext.findRenderObject();
  final overlayBox =
      overlayRenderObject is RenderBox ? overlayRenderObject : null;

  if (overlayBox == null || !overlayBox.hasSize || !triggerBox.hasSize) {
    return VAnchoredOverlaySurfaceGeometry(
      offset: Offset(0, gap),
      maxHeight: desiredHeight,
      maxWidth: desiredWidth,
      openUp: false,
      openLeft: false,
      isHorizontal: false,
      targetAnchor: Alignment.bottomCenter,
      followerAnchor: Alignment.topCenter,
      crossAxisOffset: 0,
    );
  }

  final triggerTopLeft = overlayBox.globalToLocal(
    triggerBox.localToGlobal(Offset.zero),
  );
  final triggerRect = triggerTopLeft & triggerBox.size;
  final overlaySize = overlayBox.size;
  final isHorizontal = placement == VAnchoredOverlayPlacement.left ||
      placement == VAnchoredOverlayPlacement.right ||
      placement == VAnchoredOverlayPlacement.autoHorizontal;

  final availableViewportWidth =
      (overlaySize.width - margin * 2).clamp(0.0, double.infinity);
  final availableViewportHeight =
      (overlaySize.height - margin * 2).clamp(0.0, double.infinity);
  final surfaceWidth = desiredWidth <= availableViewportWidth
      ? desiredWidth
      : availableViewportWidth;
  final surfaceHeight = desiredHeight <= availableViewportHeight
      ? desiredHeight
      : availableViewportHeight;

  if (isHorizontal) {
    final spaceLeft = triggerRect.left - gap - margin;
    final spaceRight = overlaySize.width - triggerRect.right - gap - margin;
    final openLeft = switch (placement) {
      VAnchoredOverlayPlacement.left => true,
      VAnchoredOverlayPlacement.right => false,
      _ => desiredWidth > spaceRight && spaceLeft > spaceRight,
    };

    final triggerCenterY = triggerRect.top + triggerRect.height / 2;
    final surfaceTop = triggerCenterY - surfaceHeight / 2;
    final surfaceBottom = triggerCenterY + surfaceHeight / 2;
    var crossAxisOffset = 0.0;
    if (surfaceTop < margin) {
      crossAxisOffset = margin - surfaceTop;
    } else if (surfaceBottom > overlaySize.height - margin) {
      crossAxisOffset = (overlaySize.height - margin) - surfaceBottom;
    }

    final availableWidth = openLeft ? spaceLeft : spaceRight;
    final maxWidth = desiredWidth <= availableWidth
        ? desiredWidth
        : availableWidth.clamp(0.0, desiredWidth);

    return VAnchoredOverlaySurfaceGeometry(
      offset: Offset(openLeft ? -gap : gap, crossAxisOffset),
      maxHeight: surfaceHeight,
      maxWidth: maxWidth,
      openUp: false,
      openLeft: openLeft,
      isHorizontal: true,
      targetAnchor: openLeft ? Alignment.centerLeft : Alignment.centerRight,
      followerAnchor: openLeft ? Alignment.centerRight : Alignment.centerLeft,
      crossAxisOffset: crossAxisOffset,
    );
  }

  final spaceBelow = overlaySize.height - triggerRect.bottom - gap - margin;
  final spaceAbove = triggerRect.top - gap - margin;
  final openUp = switch (placement) {
    VAnchoredOverlayPlacement.up => true,
    VAnchoredOverlayPlacement.down => false,
    VAnchoredOverlayPlacement.auto =>
      desiredHeight > spaceBelow && spaceAbove > spaceBelow,
    _ => false,
  };

  final triggerCenterX = triggerRect.left + triggerRect.width / 2;
  final surfaceLeft = triggerCenterX - surfaceWidth / 2;
  final surfaceRight = triggerCenterX + surfaceWidth / 2;
  var crossAxisOffset = 0.0;
  if (surfaceLeft < margin) {
    crossAxisOffset = margin - surfaceLeft;
  } else if (surfaceRight > overlaySize.width - margin) {
    crossAxisOffset = (overlaySize.width - margin) - surfaceRight;
  }

  final availableHeight = openUp ? spaceAbove : spaceBelow;
  final maxHeight = desiredHeight <= availableHeight
      ? desiredHeight
      : availableHeight.clamp(0.0, desiredHeight);

  return VAnchoredOverlaySurfaceGeometry(
    offset: Offset(crossAxisOffset, openUp ? -gap : gap),
    maxHeight: maxHeight,
    maxWidth: surfaceWidth,
    openUp: openUp,
    openLeft: false,
    isHorizontal: false,
    targetAnchor: openUp ? Alignment.topCenter : Alignment.bottomCenter,
    followerAnchor: openUp ? Alignment.bottomCenter : Alignment.topCenter,
    crossAxisOffset: crossAxisOffset,
  );
}

// ---------------------------------------------------------------------------
// VContextMenu geometry
// ---------------------------------------------------------------------------

/// Resolved geometry for a context menu overlay.
class VContextMenuGeometry {
  const VContextMenuGeometry({
    required this.openBelow,
    required this.menuTop,
    required this.menuLeft,
    required this.maxHeight,
    required this.maxWidth,
  });

  /// Whether the menu opens below the trigger.
  final bool openBelow;

  /// Distance from overlay top to the menu top edge.
  final double menuTop;

  /// Distance from overlay left to the menu left edge.
  final double menuLeft;

  /// Available height for the menu content (after gap and margin).
  final double maxHeight;

  /// Available width for the menu content.
  final double maxWidth;
}

/// Resolves non-preview context menu geometry.
VContextMenuGeometry resolveVContextMenuGeometry({
  required BuildContext overlayContext,
  required Rect targetRect,
  required double desiredHeight,
  required double menuWidth,
  required double screenMargin,
  required double gap,
}) {
  final overlayRenderObject =
      Overlay.maybeOf(overlayContext)?.context.findRenderObject() ??
          overlayContext.findRenderObject();
  final overlayBox =
      overlayRenderObject is RenderBox ? overlayRenderObject : null;

  if (overlayBox == null || !overlayBox.hasSize) {
    return VContextMenuGeometry(
      openBelow: true,
      menuTop: targetRect.bottom + gap,
      menuLeft: targetRect.left,
      maxHeight: desiredHeight,
      maxWidth: menuWidth,
    );
  }

  final overlaySize = overlayBox.size;
  final localTarget =
      overlayBox.globalToLocal(targetRect.topLeft) & targetRect.size;

  final spaceBelow = overlaySize.height - localTarget.bottom - gap;
  final spaceAbove = localTarget.top - gap;
  final openBelow = !(desiredHeight > spaceBelow && spaceAbove > spaceBelow);

  final availableHeight = (openBelow ? spaceBelow : spaceAbove).clamp(
    0.0,
    double.infinity,
  );
  final maxHeight = availableHeight;

  final maxWidth =
      (overlaySize.width - 2 * screenMargin).clamp(0.0, double.infinity);

  var menuLeft = localTarget.left;
  if (menuLeft + menuWidth > overlaySize.width - screenMargin) {
    menuLeft = localTarget.right - menuWidth;
  }
  if (menuLeft < screenMargin) {
    menuLeft = screenMargin;
  }

  final menuTop = openBelow
      ? localTarget.bottom + gap
      : localTarget.top - gap - maxHeight;

  return VContextMenuGeometry(
    openBelow: openBelow,
    menuTop: menuTop,
    menuLeft: menuLeft,
    maxHeight: maxHeight,
    maxWidth: maxWidth,
  );
}

/// Resolves preview-mode context menu geometry (iOS lift style).
VContextMenuGeometry resolveVContextMenuPreviewGeometry({
  required BuildContext overlayContext,
  required Rect targetRect,
  required double desiredHeight,
  required double previewWidth,
  required double menuWidth,
  required double screenMargin,
  required double gap,
}) {
  final overlayRenderObject =
      Overlay.maybeOf(overlayContext)?.context.findRenderObject() ??
          overlayContext.findRenderObject();
  final overlayBox =
      overlayRenderObject is RenderBox ? overlayRenderObject : null;

  if (overlayBox == null || !overlayBox.hasSize) {
    final colWidth = previewWidth > menuWidth ? previewWidth : menuWidth;
    return VContextMenuGeometry(
      openBelow: true,
      menuTop: targetRect.bottom + gap,
      menuLeft: 0,
      maxHeight: desiredHeight,
      maxWidth: colWidth,
    );
  }

  final overlaySize = overlayBox.size;
  final localTarget =
      overlayBox.globalToLocal(targetRect.topLeft) & targetRect.size;

  final spaceBelow = overlaySize.height - localTarget.bottom - gap;
  final spaceAbove = localTarget.top - gap;
  final openBelow = !(desiredHeight > spaceBelow && spaceAbove > spaceBelow);

  final availableHeight = (openBelow ? spaceBelow : spaceAbove).clamp(
    0.0,
    double.infinity,
  );
  final maxHeight = availableHeight;

  final colWidth = previewWidth > menuWidth ? previewWidth : menuWidth;
  final maxWidth =
      (colWidth <= overlaySize.width - 2 * screenMargin)
          ? colWidth
          : (overlaySize.width - 2 * screenMargin).clamp(0.0, colWidth);

  var menuLeft = (overlaySize.width - colWidth) / 2;
  if (menuLeft < screenMargin) {
    menuLeft = screenMargin;
  }
  if (menuLeft + colWidth > overlaySize.width - screenMargin) {
    menuLeft = (overlaySize.width - colWidth - screenMargin)
        .clamp(screenMargin, overlaySize.width);
  }

  final menuTop = openBelow
      ? localTarget.bottom + gap
      : localTarget.top - gap - maxHeight;

  return VContextMenuGeometry(
    openBelow: openBelow,
    menuTop: menuTop,
    menuLeft: menuLeft,
    maxHeight: maxHeight,
    maxWidth: maxWidth,
  );
}
