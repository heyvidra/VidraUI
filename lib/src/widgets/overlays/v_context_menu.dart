import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../foundation/overlay.dart';
import '../../foundation/v_platform.dart';
import '../../theme/theme.dart';
import '../basic/v_divider.dart';
import '../basic/v_text.dart';
import 'v_anchored_overlay.dart';
import 'v_overlay_utils.dart';

part 'v_context_menu_items.dart';
part 'v_context_menu_overlay.dart';

// ---------------------------------------------------------------------------
// VContextMenuItem
// ---------------------------------------------------------------------------

/// A single action item inside a [VContextMenu].
class VContextMenuItem {
  const VContextMenuItem({
    required this.label,
    this.description,
    this.icon,
    this.onTap,
    this.isDestructive = false,
    this.enabled = true,
  });

  /// The text label displayed for this action.
  final String label;

  /// Optional secondary text displayed below [label].
  ///
  /// Truncated with an ellipsis when it overflows the menu width.
  final String? description;

  /// An optional icon shown next to the label.
  final Widget? icon;

  /// Called when the user taps this action.
  final VoidCallback? onTap;

  /// Whether this action is destructive (renders in danger color).
  final bool isDestructive;

  /// Whether the user can tap this item.
  final bool enabled;
}

// ---------------------------------------------------------------------------
// VContextMenuStyle
// ---------------------------------------------------------------------------

/// The visual and interaction style of a [VContextMenu].
enum VContextMenuStyle {
  /// Clean, modern lightweight style (default).
  /// Uses the same contextual lift and backdrop behavior as the iOS style,
  /// but renders the opened menu with VidraUI's modern menu treatment.
  modern,

  /// iOS / SwiftUI style.
  /// Uses the contextual lift and backdrop behavior with an iOS-style opened
  /// menu treatment, and supports custom preview cards.
  ios,
}

// ---------------------------------------------------------------------------
// VContextMenu
// ---------------------------------------------------------------------------

/// A premium context menu triggered by a long-press or secondary tap.
///
/// Supports customizable visual styles, including a clean lightweight popover
/// ([VContextMenuStyle.modern]) or an immersive, haptic-enhanced, blurred iOS lift style
/// ([VContextMenuStyle.ios]).
class VContextMenu extends StatefulWidget {
  const VContextMenu({
    super.key,
    required this.child,
    required this.actions,
    this.previewBuilder,
    this.enabled = true,
    this.style = VContextMenuStyle.modern,
  });

  /// The widget that triggers the context menu.
  final Widget child;

  /// The list of options shown inside the popup menu.
  final List<VContextMenuItem> actions;

  /// Optional builder for a custom preview shown in the lifted overlay state.
  /// If omitted, a copy of [child] itself is scaled and lifted. Only applicable
  /// when [style] is [VContextMenuStyle.ios].
  final WidgetBuilder? previewBuilder;

  /// Whether the context menu is active.
  final bool enabled;

  /// The visual and interaction style of the context menu.
  final VContextMenuStyle style;

  @override
  State<VContextMenu> createState() => _VContextMenuState();
}

class _VContextMenuState extends State<VContextMenu>
    with SingleTickerProviderStateMixin {
  // Managed via VOverlayHandle for correct remove + dispose lifecycle.
  VOverlayHandle? _overlayHandle;
  // Theme captured from the trigger's context before the overlay opens,
  // so the overlay builder never references a potentially-deactivated context.
  VThemeData? _capturedTheme;

  late AnimationController _pressController;
  late Animation<double> _pressScale;
  bool _isMenuOpen = false;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _pressController = AnimationController(
      vsync: this,
      duration: Duration.zero,
    );
    _pressScale = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _pressController, curve: Curves.easeOut),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final motion = VTheme.of(context).motion.control;
    _pressController.duration = motion.duration;
    _pressController.reverseDuration = motion.effectiveReverseDuration;
  }

  @override
  void dispose() {
    _closeMenu();
    _pressController.dispose();
    super.dispose();
  }

  // ---------------------------------------------------------------------------
  // Overlay lifecycle — mirrors VPopover._openMenu / _closeMenu
  // ---------------------------------------------------------------------------

  void _openMenu(Rect targetRect, Widget targetWidget) {
    final theme = _capturedTheme!;
    _overlayHandle = showVWidgetOverlay(
      context,
      (overlayContext, handle) => _buildOverlayWidget(
        targetRect: targetRect,
        targetWidget: targetWidget,
        theme: theme,
      ),
      maintainState: true,
    );
  }

  void _closeMenu() {
    _overlayHandle?.remove();
    _overlayHandle = null;
  }

  Widget _buildOverlayWidget({
    required Rect targetRect,
    required Widget targetWidget,
    required VThemeData theme,
  }) {
    return _VContextMenuOverlay(
      targetRect: targetRect,
      actions: widget.actions,
      targetWidget: targetWidget,
      hasPreview: widget.previewBuilder != null,
      capturedTheme: theme,
      style: widget.style,
      onDismiss: _handleOverlayDismiss,
    );
  }

  // ---------------------------------------------------------------------------
  // Gesture / pointer handlers
  // ---------------------------------------------------------------------------

  void _onPointerDown(PointerDownEvent event) {
    if (!widget.enabled || _isMenuOpen) return;
    if (!_isPressed) {
      setState(() => _isPressed = true);
    }
    _pressController.forward();
  }

  void _onPointerUp(PointerUpEvent event) {
    if (_isPressed) {
      setState(() => _isPressed = false);
      if (!_isMenuOpen) _pressController.reverse();
    }
  }

  void _onPointerCancel(PointerCancelEvent event) {
    if (_isPressed) {
      setState(() => _isPressed = false);
      _pressController.reverse();
    }
  }

  void _handleOverlayDismiss() {
    _closeMenu();
    if (mounted) {
      setState(() => _isMenuOpen = false);
    }
  }

  void _showMenu() {
    if (!widget.enabled || _isMenuOpen) return;

    HapticFeedback.mediumImpact();

    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null || !renderBox.hasSize) return;

    // Capture theme now, from the live trigger context.
    _capturedTheme = VTheme.of(context);

    final targetRect = renderBox.localToGlobal(Offset.zero) & renderBox.size;
    final targetWidget = widget.previewBuilder != null
        ? widget.previewBuilder!(context)
        : widget.child;

    setState(() {
      _isMenuOpen = true;
      _isPressed = false;
    });
    _pressController.reverse();

    _openMenu(targetRect, targetWidget);
  }

  @override
  Widget build(BuildContext context) {
    Widget result = AnimatedBuilder(
      animation: _pressScale,
      builder: (context, child) {
        return Transform.scale(
          scale: _pressScale.value,
          child: child,
        );
      },
      child: widget.child,
    );

    // Hide original child in layout when lifted into overlay (iOS style).
    result = Opacity(
      opacity: _isMenuOpen ? 0.0 : 1.0,
      child: result,
    );

    if (widget.enabled) {
      result = Listener(
        onPointerDown: _onPointerDown,
        onPointerUp: _onPointerUp,
        onPointerCancel: _onPointerCancel,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onLongPress: _showMenu,
          onSecondaryTapUp: (_) => _showMenu(),
          child: result,
        ),
      );
    }

    return result;
  }
}
