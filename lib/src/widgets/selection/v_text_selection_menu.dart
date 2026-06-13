import 'package:flutter/widgets.dart';

import '../../foundation/foundation.dart';
import '../../theme/theme.dart';
import '../basic/v_text.dart';
import '../interaction/v_interactive.dart';

part 'v_text_selection_menu_items.dart';
part 'v_text_selection_menu_painter.dart';

class VTextSelectionMenuItem {
  const VTextSelectionMenuItem({
    required this.label,
    this.shortcut,
    required this.enabled,
    required this.onTap,
  });

  final String label;
  final String? shortcut;
  final bool enabled;
  final VoidCallback onTap;
}

class VTextSelectionMenuLayoutDelegate extends SingleChildLayoutDelegate {
  VTextSelectionMenuLayoutDelegate({
    required this.primaryAnchor,
    required this.secondaryAnchor,
    required this.margin,
    required this.isDesktop,
    required this.radius,
    this.currentPosition = const (arrowOnTop: false, arrowX: 0.0),
    required this.onPositionChanged,
  });

  final Offset primaryAnchor;
  final Offset secondaryAnchor;
  final double margin;
  final bool isDesktop;
  final double radius;
  final ({bool arrowOnTop, double arrowX}) currentPosition;
  final ValueChanged<({bool arrowOnTop, double arrowX})> onPositionChanged;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return constraints.loosen();
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    // 1. Horizontal positioning: place to the side of or centered relative to cursor/anchor.
    double x;
    if (isDesktop) {
      x = primaryAnchor.dx;
      if (x + childSize.width > size.width - margin) {
        x = primaryAnchor.dx - childSize.width;
      }
    } else {
      x = primaryAnchor.dx - childSize.width / 2;
    }
    x = x.clamp(margin, size.width - childSize.width - margin);

    // 2. Vertical positioning: place below primary selection cursor on desktop by default,
    // and above primary selection cursor on mobile by default.
    double y;
    bool arrowOnTop = false;
    if (isDesktop) {
      y = primaryAnchor.dy + 4.0;
      if (y + childSize.height > size.height - margin) {
        y = primaryAnchor.dy - childSize.height - 4.0;
      }
    } else {
      y = primaryAnchor.dy - childSize.height - 8.0;
      if (y < margin) {
        y = secondaryAnchor.dy + 8.0;
        arrowOnTop = true;
      }
    }
    y = y.clamp(margin, size.height - childSize.height - margin);

    // 3. Arrow position relative to child left edge
    double arrowX = primaryAnchor.dx - x;
    arrowX = arrowX.clamp(radius + 12.0, childSize.width - radius - 12.0);

    final nextPosition = (arrowOnTop: arrowOnTop, arrowX: arrowX);
    if (nextPosition != currentPosition) {
      // Notify asynchronously to prevent setState-during-layout exceptions.
      Future.microtask(() {
        onPositionChanged(nextPosition);
      });
    }

    return Offset(x, y);
  }

  @override
  bool shouldRelayout(VTextSelectionMenuLayoutDelegate oldDelegate) {
    return primaryAnchor != oldDelegate.primaryAnchor ||
        secondaryAnchor != oldDelegate.secondaryAnchor ||
        margin != oldDelegate.margin ||
        isDesktop != oldDelegate.isDesktop ||
        radius != oldDelegate.radius ||
        currentPosition != oldDelegate.currentPosition;
  }
}

class VTextSelectionMenu extends StatefulWidget {
  const VTextSelectionMenu({
    super.key,
    required this.theme,
    required this.state,
    this.isDesktop,
    required this.items,
  });

  final VThemeData theme;
  final EditableTextState state;
  final bool? isDesktop;
  final List<VTextSelectionMenuItem> items;

  @override
  State<VTextSelectionMenu> createState() => _VTextSelectionMenuState();
}

class _VTextSelectionMenuState extends State<VTextSelectionMenu>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _opacityAnimation;

  // Track bubble position calculated by layout delegate
  late final ValueNotifier<({bool arrowOnTop, double arrowX})>
      _positionNotifier;

  double get _itemHeight => VPlatformScope.of(context).selectionMenuItemHeight;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 180),
    );
    _scaleAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutBack, // Playful, springy scale entrance like iOS!
    );
    _opacityAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );
    _positionNotifier = ValueNotifier((arrowOnTop: false, arrowX: 0.0));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _positionNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme;
    final anchors = widget.state.contextMenuAnchors;
    final resolvedIsDesktop =
        widget.isDesktop ?? VPlatformScope.of(context).isDesktop;
    final radius = resolvedIsDesktop
        ? theme.radii.md
        : VPlatformScope.of(context).selectionMenuRadius;

    Widget menuContent;

    if (resolvedIsDesktop) {
      menuContent = ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: 180,
          maxWidth: 280,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: widget.items.map((item) {
            return _VTextSelectionMenuRow(
              label: item.label,
              shortcut: item.shortcut,
              enabled: item.enabled,
              onTap: item.onTap,
              height: _itemHeight,
            );
          }).toList(),
        ),
      );
    } else {
      final rowChildren = <Widget>[];
      for (int i = 0; i < widget.items.length; i++) {
        if (i > 0) {
          rowChildren.add(
            Container(
              width: 1,
              height: 20,
              color: theme.colors.border,
            ),
          );
        }
        rowChildren.add(
          _VTextSelectionMobileItem(
            label: widget.items[i].label,
            enabled: widget.items[i].enabled,
            onTap: widget.items[i].onTap,
            height: _itemHeight,
          ),
        );
      }

      menuContent = IntrinsicWidth(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: rowChildren,
        ),
      );
    }

    return VTheme(
      data: theme,
      child: Stack(
        children: [
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => widget.state.hideToolbar(),
            child: const SizedBox.expand(),
          ),
          CustomSingleChildLayout(
            delegate: VTextSelectionMenuLayoutDelegate(
              primaryAnchor: anchors.primaryAnchor,
              secondaryAnchor: anchors.secondaryAnchor ?? anchors.primaryAnchor,
              margin: 8.0,
              isDesktop: resolvedIsDesktop,
              radius: radius,
              currentPosition: _positionNotifier.value,
              onPositionChanged: (pos) {
                if (_positionNotifier.value != pos) {
                  _positionNotifier.value = pos;
                }
              },
            ),
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: FadeTransition(
                opacity: _opacityAnimation,
                child: ValueListenableBuilder(
                  valueListenable: _positionNotifier,
                  builder: (context, pos, _) {
                    const arrowHeight = 6.0;

                    return CustomPaint(
                      painter: _VTextSelectionMenuBubblePainter(
                        color: theme.colors.surface,
                        borderColor: theme.colors.border,
                        arrowX: pos.arrowX,
                        arrowOnTop: pos.arrowOnTop,
                        radius: radius,
                        isDesktop: resolvedIsDesktop,
                        shadow: theme.shadows.dropdown,
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: (!resolvedIsDesktop && pos.arrowOnTop)
                              ? arrowHeight
                              : 0.0,
                          bottom: (!resolvedIsDesktop && !pos.arrowOnTop)
                              ? arrowHeight
                              : 0.0,
                        ),
                        child: menuContent,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
