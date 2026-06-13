part of 'v_select.dart';

class _SelectMenu<T> extends StatefulWidget {
  const _SelectMenu({
    required this.options,
    required this.selectedNotifier,
    required this.highlightIndex,
    required this.multiple,
    required this.maxHeight,
    required this.searchable,
    required this.onSelected,
    required this.onHover,
  });

  final List<VSelectOption<T>> options;
  final ValueListenable<Set<T>> selectedNotifier;
  final ValueNotifier<int> highlightIndex;
  final bool multiple;
  final double maxHeight;
  final bool searchable;
  final ValueChanged<VSelectOption<T>> onSelected;
  final ValueChanged<int> onHover;

  @override
  State<_SelectMenu<T>> createState() => _SelectMenuState<T>();
}

class _SelectMenuState<T> extends State<_SelectMenu<T>> {
  late final TextEditingController _searchController;
  late final FocusNode _searchFocusNode;
  late List<VSelectOption<T>> _filteredOptions;
  late final VListNavigator _localNavigator;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _filteredOptions = widget.options;

    _localNavigator = VListNavigator(
      itemCount: () => _filteredOptions.length,
      isItemEnabled: (index) => _filteredOptions[index].enabled,
    );

    _searchFocusNode = FocusNode(
      debugLabel: 'VSelectSearch',
      onKeyEvent: (node, event) {
        if (event is! KeyDownEvent) return KeyEventResult.ignored;
        final key = event.logicalKey;
        if (key == LogicalKeyboardKey.arrowDown ||
            key == LogicalKeyboardKey.arrowUp ||
            key == LogicalKeyboardKey.enter ||
            key == LogicalKeyboardKey.space ||
            key == LogicalKeyboardKey.escape ||
            key == LogicalKeyboardKey.home ||
            key == LogicalKeyboardKey.end) {
          final res = _localNavigator.handleKey(
            event,
            isOpen: true,
            onOpen: () {},
            onClose: () {},
            onSelect: (index) {
              if (index >= 0 && index < _filteredOptions.length) {
                widget.onSelected(_filteredOptions[index]);
              }
            },
          );
          if (res == KeyEventResult.handled) {
            // Synchronize back the highlight index
            final selectedOption = _filteredOptions[_localNavigator.highlightIndex.value];
            final origIndex = widget.options.indexOf(selectedOption);
            if (origIndex != -1) {
              widget.highlightIndex.value = origIndex;
            }
            setState(() {});
          }
          return res;
        }
        return KeyEventResult.ignored;
      },
    );

    _searchController.addListener(_onSearchChanged);

    if (widget.searchable) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _searchFocusNode.requestFocus();
        }
      });
    }
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _searchFocusNode.dispose();
    _localNavigator.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredOptions = widget.options
          .where((option) => option.label.toLowerCase().contains(query))
          .toList();
      _localNavigator.focusFirst();
      if (_localNavigator.highlightIndex.value != -1) {
        final selectedOption = _filteredOptions[_localNavigator.highlightIndex.value];
        widget.highlightIndex.value = widget.options.indexOf(selectedOption);
      } else {
        widget.highlightIndex.value = -1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);
    final tokens = theme.components.select;
    final hasHover = VPlatformScope.of(context).hasHoverCapability;

    final itemExtent = tokens.itemHeight;
    final desiredHeight = _filteredOptions.length * itemExtent;
    
    // Add search field height if searchable
    final searchFieldHeight = widget.searchable ? tokens.searchFieldHeight : 0.0;
    final maxContentHeight = widget.maxHeight - tokens.menuBorderWidth * 2;
    
    final listHeight = desiredHeight < (maxContentHeight - searchFieldHeight)
        ? desiredHeight
        : (maxContentHeight - searchFieldHeight);
        
    final menuHeight = listHeight + searchFieldHeight;
    final desiredWidth = _measureDesiredMenuWidth(theme, tokens);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: tokens.menuBackground,
        borderRadius: BorderRadius.circular(tokens.menuRadius),
        border: Border.all(
          color: tokens.menuBorder,
          width: tokens.menuBorderWidth,
        ),
        boxShadow: [theme.shadows.dropdown],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(tokens.menuRadius),
        child: SizedBox(
          height: menuHeight,
          width: desiredWidth,
          child: Column(
            children: [
              if (widget.searchable)
                Padding(
                  padding: EdgeInsets.all(theme.spacing.xs),
                  child: VTextField(
                    controller: _searchController,
                    focusNode: _searchFocusNode,
                    hint: 'Search...',
                    textInputAction: TextInputAction.search,
                  ),
                ),
              Expanded(
                child: ValueListenableBuilder<Set<T>>(
                  valueListenable: widget.selectedNotifier,
                  builder: (context, selected, child) {
                    return ValueListenableBuilder<int>(
                      valueListenable: widget.highlightIndex,
                      builder: (context, currentHighlight, child) {
                        return ListView.builder(
                          padding: EdgeInsets.zero,
                          itemExtent: itemExtent,
                          itemCount: _filteredOptions.length,
                          itemBuilder: (context, index) {
                            final option = _filteredOptions[index];
                            final isSelected = selected.contains(option.value);
                            
                            // Highlight check: either local highlight or parent highlight matches
                            final isHighlighted = widget.searchable 
                                ? index == _localNavigator.highlightIndex.value
                                : widget.options.indexOf(option) == currentHighlight;

                            final itemBackground = isSelected
                                ? (isHighlighted
                                    ? tokens.menuSelectedBackground
                                        .withValues(alpha: 0.85)
                                    : tokens.menuSelectedBackground)
                                : (isHighlighted ? tokens.menuHover : null);
                            final itemForeground = !option.enabled
                                ? tokens.menuDisabledText
                                : isSelected
                                    ? tokens.menuSelectedText
                                    : tokens.menuText;

                            Widget item = Semantics(
                              button: true,
                              enabled: option.enabled,
                              selected: isSelected,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: itemBackground,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: tokens.itemPaddingHorizontal,
                                    vertical: tokens.itemPaddingVertical,
                                  ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      if (widget.multiple)
                                        Container(
                                          width: tokens.checkboxSize,
                                          height: tokens.checkboxSize,
                                          margin: EdgeInsets.only(
                                            right: theme.spacing.sm,
                                          ),
                                          decoration: BoxDecoration(
                                            color: isSelected
                                                ? tokens.menuSelectedText
                                                : tokens.menuBackground,
                                            border: Border.all(
                                              color: isSelected
                                                  ? tokens.menuSelectedText
                                                  : tokens.menuBorder,
                                              width: tokens.checkboxBorderWidth,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              theme.radii.sm,
                                            ),
                                          ),
                                          child: isSelected
                                              ? Center(
                                                  child: Text(
                                                    '✓',
                                                    style: TextStyle(
                                                      color: tokens
                                                          .menuSelectedBackground,
                                                      fontSize: tokens.checkmarkSize,
                                                      fontWeight: FontWeight.w900,
                                                      height: 1,
                                                    ),
                                                  ),
                                                )
                                              : null,
                                        ),
                                      if (option.leading != null) ...[
                                        option.leading!,
                                        SizedBox(width: theme.spacing.sm),
                                      ],
                                      Expanded(
                                        child: VText(
                                          option.label,
                                          variant: VTextVariant.body,
                                          color: itemForeground,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: false,
                                        ),
                                      ),
                                      if (!widget.multiple && isSelected)
                                        Text(
                                          '✓',
                                          style: TextStyle(
                                            color: itemForeground,
                                            fontSize: tokens.checkmarkSize,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            );

                            if (hasHover) {
                              item = MouseRegion(
                                onEnter: (_) {
                                  if (option.enabled) {
                                    if (widget.searchable) {
                                      _localNavigator.highlightIndex.value = index;
                                    }
                                    final origIndex = widget.options.indexOf(option);
                                    if (origIndex != -1) {
                                      widget.onHover(origIndex);
                                    }
                                  }
                                },
                                child: item,
                              );
                            }

                            return GestureDetector(
                              onTap: option.enabled ? () => widget.onSelected(option) : null,
                              child: item,
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  double _measureDesiredMenuWidth(VThemeData theme, VSelectTokens tokens) {
    final textStyle = theme.typography.body;
    var maxLabelWidth = 0.0;
    for (final option in _filteredOptions) {
      final painter = TextPainter(
        text: TextSpan(text: option.label, style: textStyle),
        textDirection: TextDirection.ltr,
        maxLines: 1,
        textScaler: TextScaler.noScaling,
      )..layout();
      if (painter.width > maxLabelWidth) maxLabelWidth = painter.width;
      painter.dispose();
    }
    final horizontalPadding = tokens.itemPaddingHorizontal * 2;
    final leadingExtra =
        widget.multiple ? (tokens.checkboxSize + theme.spacing.sm) : 0;
    
    // Check if any option has leading widget to add spacing
    final hasLeading = _filteredOptions.any((o) => o.leading != null);
    final leadingWidgetExtra = hasLeading ? 24.0 : 0.0; // Estimate leading widget width + gap
    
    final trailingExtra = !widget.multiple &&
            _filteredOptions.any((o) => widget.selectedNotifier.value.contains(o.value))
        ? (tokens.checkmarkSize + theme.spacing.sm)
        : 0;
    return maxLabelWidth + horizontalPadding + leadingExtra + leadingWidgetExtra + trailingExtra + 1;
  }
}
