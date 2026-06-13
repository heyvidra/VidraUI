import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../foundation/foundation.dart';

/// Internal primitive — collects interaction state for interactive widgets.
///
/// Tracks hovered, pressed, focused, and disabled via [WidgetStatesController].
/// Used by [VButton] and other interactive components.
///
/// On touch platforms ([VPlatformBehavior.hasHoverCapability] == false) the
/// [MouseRegion] subtree is pruned entirely, eliminating idle pointer-event
/// routing overhead during scroll and gesture dispatch.
///
/// On haptic-capable platforms ([VPlatformBehavior.hasHapticFeedback] == true)
/// a subtle [HapticFeedback.lightImpact] is emitted on each confirmed tap,
/// providing premium tactile confirmation for touch interactions.
///
/// **Do not export this widget.** It is an implementation detail.
class VInteractive extends StatefulWidget {
  const VInteractive({
    super.key,
    required this.builder,
    this.enabled = true,
    this.onTap,
    this.mouseCursor,
    this.autofocus = false,
    this.focusNode,
    this.requestFocusOnTap = true,
  });

  final bool enabled;
  final VoidCallback? onTap;
  final MouseCursor? mouseCursor;
  final bool autofocus;
  final FocusNode? focusNode;
  final bool requestFocusOnTap;

  final Widget Function(
    BuildContext context,
    Set<WidgetState> states,
  ) builder;

  @override
  State<VInteractive> createState() => _VInteractiveState();
}

class _VInteractiveState extends State<VInteractive> {
  late final WidgetStatesController _statesController;
  FocusNode? _internalFocusNode;

  FocusNode get _effectiveFocusNode =>
      widget.focusNode ??
      (_internalFocusNode ??= FocusNode(debugLabel: 'VInteractive'));

  bool get _enabled => widget.enabled && widget.onTap != null;

  @override
  void initState() {
    super.initState();
    _statesController = WidgetStatesController();
    _statesController.update(WidgetState.disabled, !_enabled);
  }

  @override
  void didUpdateWidget(VInteractive oldWidget) {
    super.didUpdateWidget(oldWidget);
    _statesController.update(WidgetState.disabled, !_enabled);
  }

  @override
  void dispose() {
    _statesController.dispose();
    _internalFocusNode?.dispose();
    super.dispose();
  }

  void _setPressed(bool value) {
    if (_enabled) {
      _statesController.update(WidgetState.pressed, value);
    }
  }

  @override
  Widget build(BuildContext context) {
    final behavior = VPlatformScope.of(context);

    Widget content = ListenableBuilder(
      listenable: _statesController,
      builder: (context, _) {
        return widget.builder(
          context,
          Set<WidgetState>.unmodifiable(_statesController.value),
        );
      },
    );

    // Only mount MouseRegion on platforms that have hover pointer capability
    // (mouse/trackpad). On touch-only devices this subtree is pruned entirely,
    // reducing idle pointer-event routing overhead during scroll and gestures.
    if (behavior.hasHoverCapability) {
      content = MouseRegion(
        cursor: widget.mouseCursor ??
            (_enabled ? SystemMouseCursors.click : SystemMouseCursors.basic),
        onEnter: (_) {
          if (_enabled) {
            _statesController.update(WidgetState.hovered, true);
          }
        },
        onExit: (_) {
          _statesController.update(WidgetState.hovered, false);
        },
        child: content,
      );
    }

    return Focus(
      autofocus: widget.autofocus,
      focusNode: _effectiveFocusNode,
      canRequestFocus: _enabled,
      onFocusChange: (focused) {
        _statesController.update(WidgetState.focused, focused);
      },
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: _enabled ? (_) => _setPressed(true) : null,
        onTapUp: _enabled ? (_) => _setPressed(false) : null,
        onTapCancel: _enabled ? () => _setPressed(false) : null,
        onTap: _enabled
            ? () {
                if (widget.requestFocusOnTap) {
                  _effectiveFocusNode.requestFocus();
                }
                // Emit subtle tactile confirmation on touch-capable platforms
                // (i.e. mobile devices with vibration motors).
                if (behavior.hasHapticFeedback) {
                  HapticFeedback.lightImpact();
                }
                widget.onTap?.call();
              }
            : null,
        child: content,
      ),
    );
  }
}
