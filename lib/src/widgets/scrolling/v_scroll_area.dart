import 'package:flutter/widgets.dart';

import '../../foundation/v_scroll_behavior.dart';
import 'v_scrollbar.dart';

/// A scrollable container that integrates [VScrollbar] and custom scroll behavior.
///
/// Uses [VScrollBehavior] to remove default Material/Cupertino glow or stretch effects
/// and uses [VScrollbar] for a custom-styled, platform-adaptive scrollbar.
class VScrollArea extends StatefulWidget {
  const VScrollArea({
    super.key,
    required this.child,
    this.scrollDirection = Axis.vertical,
    this.controller,
    this.physics,
    this.showScrollbar = true,
    this.interactiveScrollbar = true,
    this.thumbVisibility,
    this.padding,
    this.scrollbarPadding,
  });

  /// The scrollable content.
  final Widget child;

  /// The axis along which the scroll view scrolls.
  final Axis scrollDirection;

  /// An optional [ScrollController] to control the scroll position.
  ///
  /// If null, [VScrollArea] will create and manage its own internal controller.
  final ScrollController? controller;

  /// How the scroll view should respond to user input.
  final ScrollPhysics? physics;

  /// Whether to display the styled scrollbar.
  final bool showScrollbar;

  /// Whether the scrollbar can be dragged or clicked to scroll.
  final bool interactiveScrollbar;

  /// Whether the scrollbar thumb should be visible even when not scrolling.
  final bool? thumbVisibility;

  /// Padding around the scrollable content.
  final EdgeInsetsGeometry? padding;

  /// Padding around the scrollbar track.  Defaults to a small platform-adaptive
  /// inset based on [scrollDirection].
  final EdgeInsets? scrollbarPadding;

  @override
  State<VScrollArea> createState() => _VScrollAreaState();
}

class _VScrollAreaState extends State<VScrollArea> {
  ScrollController? _internalController;

  ScrollController get _effectiveController =>
      widget.controller ?? (_internalController ??= ScrollController());

  @override
  void didUpdateWidget(VScrollArea oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      if (oldWidget.controller == null) {
        _internalController?.dispose();
        _internalController = null;
      } else if (widget.controller == null) {
        _internalController = ScrollController();
      }
    }
  }

  @override
  void dispose() {
    _internalController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget inner = widget.child;
    if (widget.padding != null) {
      inner = Padding(padding: widget.padding!, child: inner);
    }

    Widget content = SingleChildScrollView(
      scrollDirection: widget.scrollDirection,
      controller: _effectiveController,
      physics: widget.physics,
      child: inner,
    );

    if (widget.showScrollbar) {
      final defaultOrientation = widget.scrollDirection == Axis.horizontal
          ? ScrollbarOrientation.bottom
          : ScrollbarOrientation.right;

      final defaultScrollbarPadding = widget.scrollDirection == Axis.horizontal
          ? const EdgeInsets.only(left: 4, right: 4, bottom: 4)
          : const EdgeInsets.only(top: 4, bottom: 4, right: 4);

      content = VScrollbar(
        controller: _effectiveController,
        interactive: widget.interactiveScrollbar,
        thumbVisibility: widget.thumbVisibility,
        padding: widget.scrollbarPadding ?? defaultScrollbarPadding,
        scrollbarOrientation: defaultOrientation,
        child: content,
      );
    }

    return ScrollConfiguration(
      behavior: const VScrollBehavior(),
      child: content,
    );
  }
}

/// An extension to easily wrap any widget in a [VScrollArea] using fluent API.
extension VWidgetScrollExtension on Widget {
  /// Wraps this widget in a [VScrollArea] to make it scrollable.
  Widget scrollable({
    Key? key,
    Axis scrollDirection = Axis.vertical,
    ScrollController? controller,
    ScrollPhysics? physics,
    bool showScrollbar = true,
    bool interactiveScrollbar = true,
    bool? thumbVisibility,
    EdgeInsetsGeometry? padding,
    EdgeInsets? scrollbarPadding,
  }) {
    return VScrollArea(
      key: key,
      scrollDirection: scrollDirection,
      controller: controller,
      physics: physics,
      showScrollbar: showScrollbar,
      interactiveScrollbar: interactiveScrollbar,
      thumbVisibility: thumbVisibility,
      padding: padding,
      scrollbarPadding: scrollbarPadding,
      child: this,
    );
  }
}
