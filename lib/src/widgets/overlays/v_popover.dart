import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../foundation/background.dart';
import '../../foundation/overlay.dart';
import '../../theme/v_theme.dart';
import '../../theme/v_theme_data.dart';
import 'v_anchored_overlay.dart';
import 'v_overlay_utils.dart';

/// Controller for [VPopover] that allows programmatic open, close, and toggle.
class VPopoverController extends ChangeNotifier {
  bool _isOpen = false;

  /// Whether the popover is currently open.
  bool get isOpen => _isOpen;

  /// Opens the popover.
  void open() {
    if (_isOpen) return;
    _isOpen = true;
    notifyListeners();
  }

  /// Closes the popover.
  void close() {
    if (!_isOpen) return;
    _isOpen = false;
    notifyListeners();
  }

  /// Toggles the popover open state.
  void toggle() {
    _isOpen = !_isOpen;
    notifyListeners();
  }
}

/// Builds the trigger widget for a popover.
typedef VPopoverTriggerBuilder = Widget Function(
  BuildContext context,
  VPopoverController controller,
  bool isOpen,
);

/// Builds the content widget for a popover.
typedef VPopoverContentBuilder = Widget Function(
  BuildContext context,
  VPopoverController controller,
);

/// A popover widget that anchors content to a trigger widget.
class VPopover extends StatefulWidget {
  const VPopover({
    super.key,
    this.controller,
    required this.triggerBuilder,
    required this.contentBuilder,
    this.placement = VAnchoredOverlayPlacement.auto,
    this.gap,
    this.matchTriggerWidth = false,
    this.desiredHeight,
    this.desiredWidth,
  });

  /// Optional controller to manage the popover state externally.
  /// If null, the popover will manage its own internal controller.
  final VPopoverController? controller;

  /// Builder for the trigger widget.
  final VPopoverTriggerBuilder triggerBuilder;

  /// Builder for the popover content.
  final VPopoverContentBuilder contentBuilder;

  /// Preferred opening placement for the popover.
  final VAnchoredOverlayPlacement placement;

  /// Gap between the trigger and the popover. Defaults to theme's `spacing.xs`.
  final double? gap;

  /// When true, the popover uses the trigger's width as a *minimum* — content
  /// can still grow wider if it needs to (up to the overlay's right edge),
  /// which prevents long option labels from being wrapped or clipped when the
  /// trigger is narrow.
  final bool matchTriggerWidth;

  /// Optional desired height of the popover content. If not specified, a very large
  /// value (9999) is used, which might cause the popover to prefer opening upwards
  /// if the trigger is below the middle of the screen.
  final double? desiredHeight;

  /// Optional desired width of the popover content. If specified, it is used
  /// by horizontal placement to decide whether the menu should flip to the left.
  final double? desiredWidth;

  /// Legacy static method to show an absolute-positioned popover surface in the VidraUI overlay host.
  static VOverlayHandle show(
    BuildContext context, {
    required WidgetBuilder builder,
    Alignment alignment = Alignment.topCenter,
    Offset offset = Offset.zero,
    bool dismissOnTapOutside = true,
    VBackground? surfaceBackground,
  }) {
    final host = VOverlay.of(context);
    final sourceTheme = VTheme.of(context);

    late VOverlayHandle handle;
    handle = host.show(
      (overlayContext, overlayHandle) {
        return _VAbsolutePopoverPresenter(
          theme: sourceTheme,
          alignment: alignment,
          offset: offset,
          dismissOnTapOutside: dismissOnTapOutside,
          surfaceBackground: surfaceBackground,
          onDismiss: overlayHandle.remove,
          builder: builder,
        );
      },
      maintainState: true,
    );
    return handle;
  }

  @override
  State<VPopover> createState() => _VPopoverState();
}

class _VPopoverState extends State<VPopover> {
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
  void didUpdateWidget(VPopover oldWidget) {
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
    _closeMenu();
    super.dispose();
  }

  void _onControllerChanged() {
    if (!mounted) return;
    if (_controller.isOpen) {
      if (_overlayHandle == null) {
        _openMenu();
      }
    } else {
      if (_overlayHandle != null) {
        _closeMenu();
      }
    }
    setState(() {}); // Rebuild trigger with new isOpen state
  }

  void _openMenu() {
    final box = context.findRenderObject() as RenderBox?;
    if (box == null || !box.hasSize) return;

    _capturedTheme = VTheme.of(context);
    _overlayHandle = showVWidgetOverlay(
      context,
      (context, handle) => _buildOverlay(box),
      maintainState: true,
    );
  }

  void _closeMenu() {
    _overlayHandle?.remove();
    _overlayHandle = null;
  }

  Widget _buildOverlay(RenderBox box) {
    return Positioned.fill(
      child: Builder(
        builder: (overlayContext) {
          // Use the captured theme exclusively — never fall back to
          // VTheme.of(context) here, because the host State's context
          // may already be deactivated when the overlay rebuilds.
          final theme = _capturedTheme!;
          final gap = widget.gap ?? theme.spacing.xs;

          final geometry = resolveVAnchoredOverlayGeometry(
            overlayContext: overlayContext,
            triggerBox: box,
            placement: widget.placement,
            desiredHeight: widget.desiredHeight ?? 9999,
            desiredWidth: widget.desiredWidth,
            gap: gap,
          );

          final minWidth = widget.matchTriggerWidth ? box.size.width : 0.0;
          // Defend against degenerate cases where maxWidth ends up below
          // minWidth (e.g. trigger pushed off-screen during a layout pass).
          final maxWidth =
              geometry.maxWidth < minWidth ? minWidth : geometry.maxWidth;

          return GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: _controller.close,
            child: Stack(
              children: [
                Positioned(
                  child: CompositedTransformFollower(
                    link: _layerLink,
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
                            _controller.close();
                            return KeyEventResult.handled;
                          }
                          return KeyEventResult.ignored;
                        },
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minWidth: minWidth,
                            maxWidth: maxWidth,
                            maxHeight: geometry.maxHeight,
                          ),
                          child: GestureDetector(
                            // Catch taps on the popover content so they don't
                            // bubble up to the background and close the popover.
                            onTap: () {},
                            child: widget.contentBuilder(context, _controller),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: widget.triggerBuilder(context, _controller, _controller.isOpen),
    );
  }
}

class _VAbsolutePopoverPresenter extends StatelessWidget {
  const _VAbsolutePopoverPresenter({
    required this.theme,
    required this.alignment,
    required this.offset,
    required this.dismissOnTapOutside,
    required this.surfaceBackground,
    required this.onDismiss,
    required this.builder,
  });

  final VThemeData theme;
  final Alignment alignment;
  final Offset offset;
  final bool dismissOnTapOutside;
  final VBackground? surfaceBackground;
  final VoidCallback onDismiss;
  final WidgetBuilder builder;

  @override
  Widget build(BuildContext context) {
    return VTheme(
      data: theme,
      child: Stack(
        children: [
          if (dismissOnTapOutside)
            Positioned.fill(
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: onDismiss,
              ),
            ),
          Align(
            alignment: alignment,
            child: Transform.translate(
              offset: offset,
              child: _VPopoverSurface(
                surfaceBackground: surfaceBackground,
                child: Builder(builder: builder),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _VPopoverSurface extends StatelessWidget {
  const _VPopoverSurface({
    required this.child,
    this.surfaceBackground,
  });

  final Widget child;
  final VBackground? surfaceBackground;

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);
    final background =
        surfaceBackground ?? VBackground.color(theme.colors.surface);

    return Semantics(
      container: true,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: background.gradient == null ? background.color : null,
          gradient: background.gradient,
          borderRadius: BorderRadius.circular(theme.radii.lg),
          border: Border.all(color: theme.colors.border),
          boxShadow: [theme.shadows.dialog],
        ),
        child: Padding(
          padding: EdgeInsets.all(theme.spacing.md),
          child: child,
        ),
      ),
    );
  }
}
