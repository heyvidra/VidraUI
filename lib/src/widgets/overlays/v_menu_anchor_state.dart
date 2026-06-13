part of 'v_menu_anchor.dart';

class _VMenuAnchorState<T> extends State<VMenuAnchor<T>> {
  final FocusNode _focusNode = FocusNode(debugLabel: 'VMenuAnchor');
  late VListNavigator _listNavigator;
  late VMenuController _controller;
  late final ValueNotifier<Set<T>> _selectedValuesNotifier;
  late final ValueNotifier<T?> _selectedValueNotifier;
  bool _ownsController = false;

  final Map<VMenuItem<T>, VMenuController> _submenuControllers = {};

  VMenuController _getSubmenuController(VMenuItem<T> item) {
    return _submenuControllers.putIfAbsent(item, () => VMenuController());
  }

  void _onHighlightChanged() {
    final index = _listNavigator.highlightIndex.value;
    if (index >= 0 && index < widget.items.length) {
      final item = widget.items[index];
      _closeAllSubmenusExcept(item.isSubmenu ? item : null);
    } else {
      _closeAllSubmenusExcept(null);
    }
  }

  void _closeAllSubmenusExcept(VMenuItem<T>? exceptItem) {
    for (final entry in _submenuControllers.entries) {
      if (entry.key != exceptItem) {
        entry.value.close();
      }
    }
  }

  bool get _isOpen => _controller.isOpen;

  @override
  void initState() {
    super.initState();
    _listNavigator = VListNavigator(
      itemCount: () => widget.items.length,
      isItemEnabled: (index) => _isActivatable(widget.items[index]),
    );
    _controller = widget.controller ?? VMenuController();
    _ownsController = widget.controller == null;
    _selectedValuesNotifier = ValueNotifier(widget.selectedValues ?? <T>{});
    _selectedValueNotifier = ValueNotifier(widget.selectedValue);
    _controller.addListener(_onControllerChanged);
    _listNavigator.highlightIndex.addListener(_onHighlightChanged);
  }

  @override
  void didUpdateWidget(VMenuAnchor<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      _controller.removeListener(_onControllerChanged);
      if (_ownsController) _controller.dispose();
      _controller = widget.controller ?? VMenuController();
      _ownsController = widget.controller == null;
      _controller.addListener(_onControllerChanged);
    }
    if (oldWidget.selectedValue != widget.selectedValue) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _selectedValueNotifier.value = widget.selectedValue;
      });
    }
    if (!setEquals(oldWidget.selectedValues, widget.selectedValues)) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _selectedValuesNotifier.value = widget.selectedValues ?? <T>{};
        }
      });
    }
    if (!widget.enabled && _isOpen) {
      _controller.close();
    }
  }

  void _onControllerChanged() {
    if (_isOpen) {
      _focusNode.requestFocus();
      _listNavigator.focusFirst();
    } else {
      _listNavigator.clearFocus();
    }
  }

  bool _isActivatable(VMenuItem<T> item) {
    return !item.isSeparator && item.enabled;
  }

  void _activateItem(VMenuItem<T> item) {
    if (!_isActivatable(item)) return;

    if (item.isSubmenu) {
      _getSubmenuController(item).open();
      return;
    }

    widget.onActivate?.call(item);

    final value = item.value;
    if (widget.selectionMode == VMenuSelectionMode.single && value != null) {
      widget.onSelected?.call(value);
    } else if (widget.selectionMode == VMenuSelectionMode.multiple &&
        value != null) {
      final next = Set<T>.from(widget.selectedValues ?? <T>{});
      if (next.contains(value)) {
        next.remove(value);
      } else {
        next.add(value);
      }
      widget.onSelectionChanged?.call(next);
      // Update the notifier so _MenuSurface's ValueListenableBuilder rebuilds
      // only the affected items — no full-tree setState needed.
      _selectedValuesNotifier.value = next;
    }

    item.onPressed?.call();

    final closeOnActivate = item.closeOnActivate ??
        (widget.selectionMode != VMenuSelectionMode.multiple);
    if (closeOnActivate) {
      _controller.close();
    }
  }

  KeyEventResult _handleKey(FocusNode node, KeyEvent event) {
    if (!widget.enabled) return KeyEventResult.ignored;

    if (event is KeyDownEvent && _isOpen) {
      final key = event.logicalKey;
      if (key == LogicalKeyboardKey.arrowLeft && widget.isSubmenu) {
        _controller.close();
        return KeyEventResult.handled;
      }
      if (key == LogicalKeyboardKey.arrowRight) {
        final index = _listNavigator.highlightIndex.value;
        if (index >= 0 && index < widget.items.length) {
          final item = widget.items[index];
          if (item.isSubmenu) {
            _activateItem(item);
            return KeyEventResult.handled;
          }
        }
      }
    }

    return _listNavigator.handleKey(
      event,
      isOpen: _isOpen,
      onOpen: _controller.open,
      onClose: _controller.close,
      onSelect: (index) => _activateItem(widget.items[index]),
    );
  }

  @override
  void dispose() {
    _listNavigator.highlightIndex.removeListener(_onHighlightChanged);
    _controller.removeListener(_onControllerChanged);
    if (_ownsController) _controller.dispose();
    for (final controller in _submenuControllers.values) {
      controller.dispose();
    }
    _listNavigator.dispose();
    _focusNode.dispose();
    _selectedValuesNotifier.dispose();
    _selectedValueNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);
    final scopedTheme = resolveOverlayTheme(
        context, VMenuTheme.of, (c, t) => c.copyWith(menu: t));
    final tokens = scopedTheme.components.menu;

    double calculatedHeight = tokens.borderWidth * 2;
    for (final item in widget.items) {
      if (item.isSeparator) {
        calculatedHeight +=
            tokens.separatorThickness + scopedTheme.spacing.xs * 2;
      } else {
        calculatedHeight += tokens.itemHeight;
      }
    }
    final menuHeight = calculatedHeight < widget.maxMenuHeight
        ? calculatedHeight
        : widget.maxMenuHeight;

    // Measure the actual content width using the same logic as _MenuSurface so
    // the geometry resolver's horizontal-flip heuristic uses a precise value.
    // Using a generic fallback (tokens.width) caused submenus to incorrectly
    // flip to the left when the overestimated hint barely exceeded spaceRight.
    final desiredWidthHint = _computeMenuWidth(
      context: context,
      theme: scopedTheme,
      tokens: tokens,
      items: widget.items,
      selectionMode: widget.selectionMode,
    ).clamp(0.0, 320.0);

    return VPopover(
      controller: _controller,
      gap: theme.spacing.xs,
      desiredHeight: menuHeight,
      desiredWidth: desiredWidthHint,
      placement: widget.placement,
      triggerBuilder: (context, controller, isOpen) {
        return Focus(
          focusNode: _focusNode,
          canRequestFocus: widget.enabled,
          onKeyEvent: _handleKey,
          child: Semantics(
            button: true,
            enabled: widget.enabled,
            expanded: isOpen,
            label: widget.semanticLabel,
            child: widget.builder(context, _controller, isOpen),
          ),
        );
      },
      contentBuilder: (context, controller) {
        final scopedTheme = resolveOverlayTheme(
            context, VMenuTheme.of, (c, t) => c.copyWith(menu: t));
        return VTheme(
          data: scopedTheme,
          child: _MenuSurface<T>(
            items: widget.items,
            selectionMode: widget.selectionMode,
            selectedValueNotifier: _selectedValueNotifier,
            selectedValuesNotifier: _selectedValuesNotifier,
            highlightIndex: _listNavigator.highlightIndex,
            menuHeight: menuHeight,
            maxHeight: widget.maxMenuHeight,
            minWidth: 0,
            onHover: (index) => _listNavigator.highlightIndex.value = index,
            onActivate: _activateItem,
            selectedValue: widget.selectedValue,
            selectedValues: widget.selectedValues,
            onSelected: widget.onSelected,
            onSelectionChanged: widget.onSelectionChanged,
            getSubmenuController: _getSubmenuController,
          ),
        );
      },
    );
  }
}
