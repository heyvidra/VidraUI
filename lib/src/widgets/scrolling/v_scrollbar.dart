import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

import '../../foundation/v_platform.dart';
import '../../theme/v_theme.dart';

/// A styled scrollbar that adheres to the VidraUI design system.
///
/// Uses [RawScrollbar] underneath to avoid Material or Cupertino dependencies.
/// Hover state switches to [VScrollbarTokens.thumbColorHover] and
/// [VScrollbarTokens.thicknessHover] automatically.
class VScrollbar extends StatefulWidget {
  const VScrollbar({
    super.key,
    required this.child,
    this.controller,
    this.interactive = true,
    this.thumbVisibility,
    this.trackVisibility,
    this.padding,
    this.thickness,
    this.radius,
    this.thumbColor,
    this.trackColor,
    this.scrollbarOrientation,
  });

  /// The widget scrollable subtree that this scrollbar wraps.
  final Widget child;

  /// The [ScrollController] used to control the scrolling of [child].
  final ScrollController? controller;

  /// Whether the scrollbar should be interactive (drag-to-scroll, click track).
  final bool interactive;

  /// Whether the scrollbar thumb should be visible even when not scrolling.
  final bool? thumbVisibility;

  /// Whether the scrollbar track should be visible even when not scrolling.
  final bool? trackVisibility;

  /// Optional padding around the scrollbar.
  final EdgeInsets? padding;

  /// Override for the thickness of the scrollbar thumb.
  /// When null, uses [VScrollbarTokens.thickness] (or [VScrollbarTokens.thicknessHover] on hover).
  final double? thickness;

  /// Override for the radius of the scrollbar thumb.
  final Radius? radius;

  /// Override for the color of the scrollbar thumb.
  /// When null, uses [VScrollbarTokens.thumbColor] (or [VScrollbarTokens.thumbColorHover] on hover).
  final Color? thumbColor;

  /// Override for the color of the scrollbar track.
  final Color? trackColor;

  /// Controls the position of the scrollbar in relation to the child.
  final ScrollbarOrientation? scrollbarOrientation;

  @override
  State<VScrollbar> createState() => _VScrollbarState();
}

class _VScrollbarState extends State<VScrollbar> {
  bool _hovered = false;

  void _onEnter(PointerEnterEvent _) => setState(() => _hovered = true);
  void _onExit(PointerExitEvent _) => setState(() => _hovered = false);

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);
    final tokens = theme.components.scrollbar;

    final effectiveThickness = widget.thickness ??
        (_hovered ? tokens.thicknessHover : tokens.thickness);
    final effectiveThumbColor = widget.thumbColor ??
        (_hovered ? tokens.thumbColorHover : tokens.thumbColor);

    Widget result = RawScrollbar(
      controller: widget.controller,
      interactive: widget.interactive,
      thumbVisibility: widget.thumbVisibility,
      trackVisibility: widget.trackVisibility,
      padding: widget.padding,
      scrollbarOrientation: widget.scrollbarOrientation,
      thickness: effectiveThickness,
      radius: widget.radius ?? Radius.circular(tokens.radius),
      thumbColor: effectiveThumbColor,
      trackColor: widget.trackColor ?? tokens.trackColor,
      minThumbLength: tokens.minThumbLength,
      child: widget.child,
    );

    if (VPlatformScope.of(context).hasHoverCapability) {
      result = MouseRegion(
        onEnter: _onEnter,
        onExit: _onExit,
        child: result,
      );
    }

    return result;
  }
}
