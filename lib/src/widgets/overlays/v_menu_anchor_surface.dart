part of 'v_menu_anchor.dart';

class _MenuSurface<T> extends StatelessWidget {
  const _MenuSurface({
    required this.items,
    required this.selectionMode,
    required this.selectedValueNotifier,
    required this.selectedValuesNotifier,
    required this.highlightIndex,
    required this.menuHeight,
    required this.maxHeight,
    required this.minWidth,
    required this.onHover,
    required this.onActivate,
    this.selectedValue,
    this.selectedValues,
    this.onSelected,
    this.onSelectionChanged,
    required this.getSubmenuController,
  });

  final List<VMenuItem<T>> items;
  final VMenuSelectionMode selectionMode;
  final ValueListenable<T?> selectedValueNotifier;
  final ValueListenable<Set<T>> selectedValuesNotifier;
  final ValueListenable<int> highlightIndex;
  final double menuHeight;
  final double maxHeight;
  final double minWidth;
  final ValueChanged<int> onHover;
  final ValueChanged<VMenuItem<T>> onActivate;

  final T? selectedValue;
  final Set<T>? selectedValues;
  final ValueChanged<T>? onSelected;
  final ValueChanged<Set<T>>? onSelectionChanged;
  final VMenuController Function(VMenuItem<T> item) getSubmenuController;

  @override
  Widget build(BuildContext context) {
    final theme = resolveOverlayTheme(
        context, VMenuTheme.of, (c, t) => c.copyWith(menu: t));
    final tokens = theme.components.menu;
    final menuWidth = _computeMenuWidth(
      context: context,
      theme: theme,
      tokens: tokens,
      items: items,
      selectionMode: selectionMode,
      minWidth: minWidth,
    );

    return DecoratedBox(
      decoration: BoxDecoration(
        color: tokens.background,
        borderRadius: BorderRadius.circular(tokens.radius),
        border: Border.all(
          color: tokens.border,
          width: tokens.borderWidth,
        ),
        boxShadow: [theme.shadows.dropdown],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(tokens.radius),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: minWidth,
            maxHeight: maxHeight,
          ),
          child: SizedBox(
            width: menuWidth,
            height: menuHeight,
            child: ValueListenableBuilder<T?>(
              valueListenable: selectedValueNotifier,
              builder: (context, selectedValue, child) {
                return ValueListenableBuilder<Set<T>>(
                  valueListenable: selectedValuesNotifier,
                  builder: (context, selectedValues, child) {
                    return ValueListenableBuilder<int>(
                      valueListenable: highlightIndex,
                      builder: (context, currentHighlight, child) {
                        return ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            final item = items[index];
                            if (item.isSeparator) {
                              return _buildSeparator(theme, tokens);
                            }

                            final selected = _isSelected(
                              item,
                              selectedValue,
                              selectedValues,
                            );
                            final highlighted = index == currentHighlight;
                            final foreground =
                                _foregroundFor(tokens, item, selected);
                            final background = selected
                                ? tokens.selectedBackground
                                : highlighted
                                    ? tokens.hoverBackground
                                    : null;

                            final isDesktop =
                                VPlatformScope.of(context).isDesktop;
                            if (item.isSubmenu && isDesktop) {
                              return _SubmenuItemTrigger<T>(
                                item: item,
                                highlighted: highlighted,
                                onHover: () => onHover(index),
                                onParentActivate: onActivate,
                                menuTokens: tokens,
                                foreground: foreground,
                                background: background,
                                theme: theme,
                                selectionMode: selectionMode,
                                selectedValue: selectedValue,
                                selectedValues: selectedValues,
                                onSelected: onSelected,
                                onSelectionChanged: onSelectionChanged,
                                getSubmenuController: getSubmenuController,
                              );
                            }

                            return _buildMenuItem(
                              context,
                              theme: theme,
                              tokens: tokens,
                              item: item,
                              selected: selected,
                              foreground: foreground,
                              background: background,
                              onTap: () => onActivate(item),
                              onHover: () => onHover(index),
                            );
                          },
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSeparator(VThemeData theme, VMenuTokens tokens) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: theme.spacing.xs,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(color: tokens.separatorColor),
        child: SizedBox(height: tokens.separatorThickness),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required VThemeData theme,
    required VMenuTokens tokens,
    required VMenuItem<T> item,
    required bool selected,
    required Color foreground,
    required Color? background,
    required VoidCallback onTap,
    required VoidCallback onHover,
  }) {
    Widget result = Semantics(
      button: true,
      enabled: item.enabled,
      selected: selected,
      label: item.semanticLabel ?? item.label,
      child: DecoratedBox(
        decoration: BoxDecoration(color: background),
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: tokens.itemHeight),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: tokens.itemPaddingHorizontal,
              vertical: tokens.itemPaddingVertical,
            ),
            child: VIconTheme(
              data: VIconThemeData(
                color: foreground,
                size: tokens.iconSize,
              ),
              child: DefaultTextStyle(
                style: theme.typography.body.copyWith(
                  color: foreground,
                ),
                child: Row(
                  children: [
                    if (selectionMode != VMenuSelectionMode.none)
                      SizedBox(
                        width: tokens.checkmarkSize,
                        child: selected
                            ? Text(
                                '✓',
                                style: theme.typography.label.copyWith(
                                  color: foreground,
                                ),
                              )
                            : null,
                      ),
                    if (item.leading != null) ...[
                      SizedBox(width: tokens.iconGap),
                      item.leading!,
                    ],
                    SizedBox(width: tokens.iconGap),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          VText(item.label, variant: VTextVariant.body, color: foreground),
                          if (item.description != null)
                            VText(
                              item.description!,
                              variant: VTextVariant.caption,
                              color: foreground.withValues(alpha: 0.65),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                        ],
                      ),
                    ),
                    if (item.trailing != null) ...[
                      SizedBox(width: tokens.iconGap),
                      item.trailing!,
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );

    if (VPlatformScope.of(context).hasHoverCapability) {
      result = MouseRegion(
        onEnter: (_) {
          if (item.enabled) onHover();
        },
        child: result,
      );
    }

    return GestureDetector(
      onTap: item.enabled ? onTap : null,
      child: result,
    );
  }



  bool _isSelected(VMenuItem<T> item, T? selectedValue, Set<T> selectedValues) {
    if (item.value == null) return false;
    return switch (selectionMode) {
      VMenuSelectionMode.none => false,
      VMenuSelectionMode.single => item.value == selectedValue,
      VMenuSelectionMode.multiple => selectedValues.contains(item.value),
    };
  }

  Color _foregroundFor(
    VMenuTokens tokens,
    VMenuItem<T> item,
    bool selected,
  ) {
    if (!item.enabled) return tokens.disabledText;
    if (selected) return tokens.selectedText;
    if (item.role == VMenuItemRole.destructive) return tokens.destructiveText;
    return tokens.text;
  }
}

/// Measures the desired pixel width for a menu surface given its items and tokens.
///
/// Called both from [_VMenuAnchorState] (as a geometry hint before layout) and
/// from [_MenuSurface] (to set the actual surface width). Keeping both callers
/// in sync prevents the horizontal-flip heuristic from making the wrong decision
/// when the estimated width differs from the rendered width.
double _computeMenuWidth<T>({
  required BuildContext context,
  required VThemeData theme,
  required VMenuTokens tokens,
  required List<VMenuItem<T>> items,
  required VMenuSelectionMode selectionMode,
  double minWidth = 0.0,
}) {
  var maxLabelWidth = 0.0;
  final direction = Directionality.maybeOf(context) ?? TextDirection.ltr;
  final textStyle = theme.typography.body;
  for (final item in items) {
    if (item.isSeparator) continue;
    final painter = TextPainter(
      text: TextSpan(text: item.label, style: textStyle),
      textDirection: direction,
      maxLines: 1,
      textScaler: TextScaler.noScaling,
    )..layout();
    if (painter.width > maxLabelWidth) maxLabelWidth = painter.width;
    painter.dispose();

    if (item.description != null) {
      final subPainter = TextPainter(
        text: TextSpan(text: item.description, style: theme.typography.caption),
        textDirection: direction,
        maxLines: 1,
        textScaler: TextScaler.noScaling,
      )..layout();
      if (subPainter.width > maxLabelWidth) maxLabelWidth = subPainter.width;
      subPainter.dispose();
    }
  }

  final hasLeading = items.any((item) => item.leading != null);
  final hasTrailing = items.any((item) => item.trailing != null);
  final hasSubmenu = items.any((item) => item.isSubmenu);
  final leadingWidth = hasLeading ? tokens.iconGap + tokens.iconSize : 0.0;
  final trailingWidth =
      hasTrailing || hasSubmenu ? tokens.iconGap + tokens.iconSize : 0.0;
  final checkmarkWidth =
      selectionMode != VMenuSelectionMode.none ? tokens.checkmarkSize : 0.0;
  final fixedWidth = tokens.itemPaddingHorizontal * 2 +
      checkmarkWidth +
      tokens.iconGap +
      leadingWidth +
      trailingWidth;
  final desiredWidth = maxLabelWidth + fixedWidth + 1.0;
  return desiredWidth < minWidth ? minWidth : desiredWidth;
}


