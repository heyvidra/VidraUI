part of 'v_context_menu.dart';

class _VContextMenuItemsList extends StatelessWidget {
  const _VContextMenuItemsList({
    required this.actions,
    required this.theme,
    required this.style,
    required this.onItemTapped,
  });

  final List<VContextMenuItem> actions;
  final VThemeData theme;
  final VContextMenuStyle style;
  final VoidCallback onItemTapped;

  @override
  Widget build(BuildContext context) {
    List<Widget> buildItemList() {
      return List.generate(actions.length, (index) {
        final action = actions[index];
        return _VContextMenuTile(
          action: action,
          theme: theme,
          style: style,
          onTapped: () {
            if (action.enabled) {
              action.onTap?.call();
              onItemTapped();
            }
          },
        );
      });
    }

    List<Widget> buildItemListWithDividers() {
      return List.generate(actions.length * 2 - 1, (index) {
        if (index.isOdd) {
          return VDivider(thickness: theme.components.menu.separatorThickness);
        }
        final itemIndex = index ~/ 2;
        final action = actions[itemIndex];
        return _VContextMenuTile(
          action: action,
          theme: theme,
          style: style,
          onTapped: () {
            if (action.enabled) {
              action.onTap?.call();
              onItemTapped();
            }
          },
        );
      });
    }

    final bool isModern = style == VContextMenuStyle.modern;
    final tokens = theme.components.menu;

    final double borderRadius = isModern ? tokens.radius : theme.radii.lg;
    final Color backgroundColor =
        isModern ? tokens.background : theme.colors.surfaceElevated;
    final BoxShadow boxShadow =
        isModern ? theme.shadows.dropdown : theme.shadows.dialog;

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: tokens.border, width: tokens.borderWidth),
        boxShadow: [boxShadow],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius - 1.0),
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: isModern ? buildItemList() : buildItemListWithDividers(),
          ),
        ),
      ),
    );
  }
}

class _VContextMenuTile extends StatefulWidget {
  const _VContextMenuTile({
    required this.action,
    required this.theme,
    required this.style,
    required this.onTapped,
  });

  final VContextMenuItem action;
  final VThemeData theme;
  final VContextMenuStyle style;
  final VoidCallback onTapped;

  @override
  State<_VContextMenuTile> createState() => _VContextMenuTileState();
}

class _VContextMenuTileState extends State<_VContextMenuTile> {
  bool _isHovered = false;
  bool _isPressed = false;

  void _handleTapDown(TapDownDetails details) {
    if (!widget.action.enabled) return;
    if (!_isPressed) setState(() => _isPressed = true);
  }

  void _handleTapUp(TapUpDetails details) {
    if (_isPressed) {
      setState(() => _isPressed = false);
      widget.onTapped();
    }
  }

  void _handleTapCancel() {
    if (_isPressed) {
      setState(() {
        _isPressed = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final action = widget.action;
    final theme = widget.theme;
    final tokens = theme.components.menu;
    final bool active = action.enabled;
    final bool isModern = widget.style == VContextMenuStyle.modern;

    Color itemColor =
        action.isDestructive ? tokens.destructiveText : tokens.text;
    if (!active) {
      itemColor = tokens.disabledText;
    }

    Color? tileBgColor;
    if (isModern) {
      if (_isPressed) {
        tileBgColor = tokens.hoverBackground.withValues(
          alpha: tokens.modernPressedOverlayOpacity,
        );
      } else if (_isHovered) {
        tileBgColor = tokens.hoverBackground;
      }
    } else {
      final double bgOpacity = _isPressed
          ? tokens.iosPressedOverlayOpacity
          : _isHovered
              ? tokens.iosHoverOverlayOpacity
              : 0.0;
      tileBgColor = theme.colors.text.withValues(alpha: bgOpacity);
    }

    Widget content = Row(
      children: [
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VText(
                action.label,
                variant: VTextVariant.body,
                color: itemColor,
              ),
              if (action.description != null)
                VText(
                  action.description!,
                  variant: VTextVariant.caption,
                  color: itemColor.withValues(alpha: 0.65),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
            ],
          ),
        ),
        if (action.icon != null) ...[
          SizedBox(width: tokens.iconGap),
          VIconTheme(
            data: VIconThemeData(
              color: itemColor,
              size: tokens.iconSize,
            ),
            child: action.icon!,
          ),
        ],
      ],
    );

    if (isModern) {
      content = SizedBox(
        height: tokens.itemHeight,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: tokens.itemPaddingHorizontal,
            vertical: tokens.itemPaddingVertical,
          ),
          child: content,
        ),
      );
    } else {
      content = Padding(
        padding: EdgeInsets.symmetric(
          horizontal: theme.spacing.md,
          vertical: theme.spacing.sm + 2.0,
        ),
        child: content,
      );
    }

    Widget result = GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      behavior: HitTestBehavior.opaque,
      child: Container(
        color: tileBgColor,
        child: content,
      ),
    );

    if (VPlatformScope.of(context).hasHoverCapability) {
      result = MouseRegion(
        onEnter: (_) {
          if (active && !_isHovered) setState(() => _isHovered = true);
        },
        onExit: (_) {
          if (active && _isHovered) setState(() => _isHovered = false);
        },
        child: result,
      );
    }

    return result;
  }
}
