part of 'v_menu_anchor.dart';

class _SubmenuItemTrigger<T> extends StatefulWidget {
  const _SubmenuItemTrigger({
    super.key,
    required this.item,
    required this.highlighted,
    required this.onHover,
    required this.onParentActivate,
    required this.menuTokens,
    required this.foreground,
    required this.background,
    required this.theme,
    required this.selectionMode,
    this.selectedValue,
    this.selectedValues,
    this.onSelected,
    this.onSelectionChanged,
    required this.getSubmenuController,
  });

  final VMenuItem<T> item;
  final bool highlighted;
  final VoidCallback onHover;
  final ValueChanged<VMenuItem<T>> onParentActivate;
  final VMenuTokens menuTokens;
  final Color foreground;
  final Color? background;
  final VThemeData theme;

  final VMenuSelectionMode selectionMode;
  final T? selectedValue;
  final Set<T>? selectedValues;
  final ValueChanged<T>? onSelected;
  final ValueChanged<Set<T>>? onSelectionChanged;
  final VMenuController Function(VMenuItem<T> item) getSubmenuController;

  @override
  State<_SubmenuItemTrigger<T>> createState() => _SubmenuItemTriggerState<T>();
}

class _SubmenuItemTriggerState<T> extends State<_SubmenuItemTrigger<T>> {
  late final VMenuController _submenuController;
  Timer? _openTimer;

  @override
  void initState() {
    super.initState();
    _submenuController = widget.getSubmenuController(widget.item);
  }

  @override
  void dispose() {
    _openTimer?.cancel();
    super.dispose();
  }

  void _onMouseEnter() {
    widget.onHover();
    _openTimer?.cancel();
    _openTimer = Timer(const Duration(milliseconds: 150), () {
      if (mounted) {
        _submenuController.open();
      }
    });
  }

  void _onMouseExit() {
    _openTimer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final hasHover = VPlatformScope.of(context).hasHoverCapability;

    return VMenuAnchor<T>(
      items: widget.item.children!,
      controller: _submenuController,
      placement: VAnchoredOverlayPlacement.autoHorizontal,
      isSubmenu: true,
      selectionMode: widget.selectionMode,
      selectedValue: widget.selectedValue,
      selectedValues: widget.selectedValues,
      onSelected: widget.onSelected,
      onSelectionChanged: widget.onSelectionChanged,
      onActivate: (activatedItem) {
        _submenuController.close();
        widget.onParentActivate(activatedItem as VMenuItem<T>);
      },
      builder: (context, controller, isOpen) {
        Widget row = DecoratedBox(
          decoration: BoxDecoration(color: widget.background),
          child: SizedBox(
            height: widget.menuTokens.itemHeight,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: widget.menuTokens.itemPaddingHorizontal,
                vertical: widget.menuTokens.itemPaddingVertical,
              ),
              child: VIconTheme(
                data: VIconThemeData(
                  color: widget.foreground,
                  size: widget.menuTokens.iconSize,
                ),
                child: DefaultTextStyle(
                  style: widget.theme.typography.body.copyWith(
                    color: widget.foreground,
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: widget.menuTokens.checkmarkSize,
                      ),
                      if (widget.item.leading != null) ...[
                        SizedBox(width: widget.menuTokens.iconGap),
                        widget.item.leading!,
                      ],
                      SizedBox(width: widget.menuTokens.iconGap),
                      Expanded(child: VText(widget.item.label, variant: VTextVariant.body, color: widget.foreground)),
                      SizedBox(width: widget.menuTokens.iconGap),
                      Text(
                        '▶',
                        style: TextStyle(
                          fontSize: widget.menuTokens.iconSize * 0.8,
                          color: widget.foreground.withValues(alpha: 0.5),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );

        if (hasHover) {
          row = MouseRegion(
            onEnter: (_) => _onMouseEnter(),
            onExit: (_) => _onMouseExit(),
            child: row,
          );
        }

        return GestureDetector(
          onTap: () {
            _submenuController.toggle();
          },
          child: row,
        );
      },
    );
  }
}
