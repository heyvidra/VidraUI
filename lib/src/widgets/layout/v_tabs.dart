import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../theme/v_theme.dart';
import '../basic/v_text.dart';
import '../interaction/v_interactive.dart';

/// A tab descriptor with a label and an optional icon.
class VTabItem {
  const VTabItem({
    required this.label,
    this.icon,
  });

  final String label;
  final Widget? icon;
}

/// A horizontal tab bar with keyboard arrow key navigation.
///
/// Each entry in [tabs] must be one of:
/// - [String] — rendered as a [VText] label.
/// - [VTabItem] — rendered with an optional leading icon.
/// - [Widget] — rendered as-is inside the tab button.
///
/// Passing any other type will throw an [ArgumentError] at runtime.
class VTabBar extends StatefulWidget {
  const VTabBar({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onChanged,
    this.semanticLabel,
  });

  /// The tab descriptors. Each entry must be a [String], [VTabItem], or [Widget].
  final List<Object> tabs;
  final int selectedIndex;
  final ValueChanged<int> onChanged;
  final String? semanticLabel;

  @override
  State<VTabBar> createState() => _VTabBarState();
}

class _VTabBarState extends State<VTabBar> {
  late List<FocusNode> _focusNodes;

  FocusNode _createFocusNode(int index) => FocusNode(
        debugLabel: 'VTab',
        onKeyEvent: (node, event) {
          if (event is KeyDownEvent) {
            if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
              _goTo(index - 1);
              return KeyEventResult.handled;
            }
            if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
              _goTo(index + 1);
              return KeyEventResult.handled;
            }
          }
          return KeyEventResult.ignored;
        },
      );

  @override
  void initState() {
    super.initState();
    _focusNodes = List.generate(
      widget.tabs.length,
      (index) => _createFocusNode(index),
    );
  }

  @override
  void didUpdateWidget(VTabBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    final oldLength = _focusNodes.length;
    final newLength = widget.tabs.length;
    if (newLength > oldLength) {
      // Grow: append new focus nodes; existing ones keep their state.
      _focusNodes.addAll(
        List.generate(
          newLength - oldLength,
          (i) => _createFocusNode(oldLength + i),
        ),
      );
    } else if (newLength < oldLength) {
      // Shrink: dispose excess nodes from the end.
      for (var i = oldLength - 1; i >= newLength; i--) {
        _focusNodes[i].dispose();
      }
      _focusNodes.removeRange(newLength, oldLength);
    }
  }

  @override
  void dispose() {
    for (final node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _goTo(int index) {
    if (index >= 0 && index < widget.tabs.length) {
      widget.onChanged(index);
      _focusNodes[index].requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);

    return Semantics(
      label: widget.semanticLabel,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(widget.tabs.length, (i) {
            final isSelected = i == widget.selectedIndex;
            return VInteractive(
              focusNode: _focusNodes[i],
              requestFocusOnTap: true,
              onTap: () => _goTo(i),
              builder: (context, states) {
                final isHovered = states.contains(WidgetState.hovered);
                final isFocused = states.contains(WidgetState.focused);
                final isPressed = states.contains(WidgetState.pressed);

                final bg = isPressed
                    ? theme.colors.surfaceElevated
                    : isHovered
                        ? theme.colors.surfaceHover
                        : null;

                final fg = isSelected
                    ? theme.colors.actionPrimary
                    : isHovered || isFocused
                        ? theme.colors.text
                        : theme.colors.textMuted;

                // Separate the indicator from the background decoration.
                // Mixing a non-uniform Border (bottom-only) with borderRadius
                // in a single BoxDecoration causes Flutter to fall back to
                // paintBorder, which ignores borderRadius and produces corner
                // artifacts on the top and right edges of the tab.
                final indicatorColor = isSelected
                    ? theme.colors.actionPrimary
                    : isFocused
                        ? theme.colors.focusRing
                        : const Color(0x00000000);

                final tabContent = switch (widget.tabs[i]) {
                  final String tab => VText(
                      tab,
                      variant: VTextVariant.label,
                      color: fg,
                    ),
                  final VTabItem tab => Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (tab.icon != null) ...[
                          tab.icon!,
                          SizedBox(width: theme.spacing.xs),
                        ],
                        VText(
                          tab.label,
                          variant: VTextVariant.label,
                          color: fg,
                        ),
                      ],
                    ),
                  final Widget tab => tab,
                  final Object? unsupported => throw ArgumentError.value(
                      unsupported,
                      'tabs[$i]',
                      'VTabBar.tabs entries must be String, VTabItem, or Widget',
                    ),
                };

                return IntrinsicWidth(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Background + content — borderRadius only, no border.
                      AnimatedContainer(
                        duration: theme.motion.normal.duration,
                        curve: theme.motion.normal.curve,
                        padding: EdgeInsets.symmetric(
                          horizontal: theme.spacing.lg,
                          vertical: theme.spacing.sm + 2,
                        ),
                        decoration: BoxDecoration(
                          color: bg,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(theme.radii.sm),
                            topRight: Radius.circular(theme.radii.sm),
                          ),
                        ),
                        child: tabContent,
                      ),
                      // Indicator line — separate widget, no borderRadius conflict.
                      AnimatedContainer(
                        duration: theme.motion.normal.duration,
                        curve: theme.motion.normal.curve,
                        height: 2,
                        color: indicatorColor,
                      ),
                    ],
                  ),
                );
              },
            );
          }),
        ),
      ),
    );
  }
}

/// A tabbed content container.
class VTabs extends StatefulWidget {
  const VTabs({
    super.key,
    required this.tabs,
    required this.children,
    this.initialIndex = 0,
  });

  final List<Object> tabs;
  final List<Widget> children;
  final int initialIndex;

  @override
  State<VTabs> createState() => _VTabsState();
}

class _VTabsState extends State<VTabs> {
  late int _index = widget.initialIndex;

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        VTabBar(
          tabs: widget.tabs,
          selectedIndex: _index,
          onChanged: (i) => setState(() => _index = i),
        ),
        Container(height: 1, color: theme.colors.border),
        AnimatedSwitcher(
          duration: theme.motion.normal.duration,
          switchInCurve: theme.motion.normal.curve,
          child: KeyedSubtree(
            key: ValueKey<int>(_index),
            child: _index < widget.children.length
                ? widget.children[_index]
                : const SizedBox.shrink(),
          ),
        ),
      ],
    );
  }
}
