part of 'v_auto_suggest_box.dart';

class _VAutoSuggestBoxState extends State<VAutoSuggestBox> {
  // ---- text-field owned resources ----
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _ownsController = true;
  bool _ownsFocusNode = true;

  // ---- overlay / suggestions ----
  final VPopoverController _popover = VPopoverController();
  List<VAutoSuggestItem> _suggestions = const [];
  bool _loading = false;

  // ---- keyboard navigation ----
  late VListNavigator _listNavigator;

  // ---- async debounce ----
  Timer? _debounceTimer;
  int _fetchGeneration = 0;

  // ---- track current query for highlight ----
  String _currentQuery = '';

  // ---- GlobalKey to measure trigger width ----
  final GlobalKey _triggerKey = GlobalKey();

  double? get _triggerWidth {
    if (!mounted) return null;
    final box = _triggerKey.currentContext?.findRenderObject() as RenderBox?;
    if (box != null && box.hasSize) {
      return box.size.width;
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    _attachResources();
    _listNavigator = VListNavigator(
      itemCount: () => _suggestions.length,
      isItemEnabled: (i) => _suggestions[i].enabled,
    );
    _popover.addListener(_onPopoverChanged);
  }

  @override
  void didUpdateWidget(VAutoSuggestBox old) {
    super.didUpdateWidget(old);
    if (widget.controller != old.controller ||
        widget.focusNode != old.focusNode) {
      _detachResources();
      _attachResources();
    }
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _popover.removeListener(_onPopoverChanged);
    _popover.dispose();
    _listNavigator.dispose();
    _detachResources();
    super.dispose();
  }

  void _attachResources() {
    _ownsController = widget.controller == null;
    _ownsFocusNode = widget.focusNode == null;
    _controller = widget.controller ?? TextEditingController();
    _currentQuery = _controller.text;
    _focusNode = widget.focusNode ?? FocusNode(debugLabel: 'VAutoSuggestBox');
    _focusNode.addListener(_onFocusChanged);
    _controller.addListener(_syncTextQuery);
  }

  void _syncTextQuery() {
    if (_controller.text != _currentQuery) {
      _currentQuery = _controller.text;
    }
  }

  void _detachResources() {
    _focusNode.removeListener(_onFocusChanged);
    _controller.removeListener(_syncTextQuery);
    if (_ownsController) _controller.dispose();
    if (_ownsFocusNode) _focusNode.dispose();
  }

  void _onFocusChanged() {
    if (!_focusNode.hasFocus && _popover.isOpen) {
      _popover.close();
    }
  }

  void _onPopoverChanged() {
    if (!_popover.isOpen) {
      _listNavigator.clearFocus();
    }
  }

  void _onTextChanged(String query) {
    widget.onChanged?.call(query);
    _currentQuery = query;
    if (query.isEmpty) {
      _debounceTimer?.cancel();
      _closeDropdown();
      return;
    }
    _fetchSuggestions(query);
  }

  void _onSubmitted(String text) {
    if (_popover.isOpen) {
      final idx = _listNavigator.highlightIndex.value;
      if (idx >= 0 && idx < _suggestions.length && _suggestions[idx].enabled) {
        _selectItem(_suggestions[idx]);
        return;
      }
    }
    widget.onSubmitted?.call(text);
  }

  void _fetchSuggestions(String query) {
    if (widget.suggestionsBuilder != null) {
      final results = widget.suggestionsBuilder!(query);
      _applySuggestions(results);
      return;
    }

    _debounceTimer?.cancel();
    _debounceTimer = Timer(widget.debounceDuration, () {
      _fetchAsync(query);
    });
  }

  Future<void> _fetchAsync(String query) async {
    final generation = ++_fetchGeneration;
    if (!mounted) return;
    setState(() => _loading = true);

    try {
      final results = await widget.asyncSuggestionsBuilder!(query);

      if (!mounted || generation != _fetchGeneration) return;
      if (results != null) _applySuggestions(results);
    } catch (e, stack) {
      // Route the error through the app's FlutterError handler rather than
      // printing to the console; skip stale/superseded fetches.
      if (!mounted || generation != _fetchGeneration) return;
      FlutterError.reportError(FlutterErrorDetails(
        exception: e,
        stack: stack,
        library: 'vidraui',
        context: ErrorDescription('while fetching async suggestions'),
      ));
    } finally {
      if (mounted && generation == _fetchGeneration) {
        setState(() => _loading = false);
      }
    }
  }

  void _applySuggestions(List<VAutoSuggestItem> items) {
    final capped = items.length > widget.maxSuggestions
        ? items.sublist(0, widget.maxSuggestions)
        : items;
    setState(() => _suggestions = capped);
    _listNavigator.clearFocus();
    if (capped.isNotEmpty) {
      _popover.open();
    } else {
      _closeDropdown();
    }
  }

  void _closeDropdown() {
    if (_popover.isOpen) _popover.close();
    setState(() => _suggestions = const []);
  }

  void _selectItem(VAutoSuggestItem item) {
    if (!item.enabled) return;
    _controller.value = TextEditingValue(
      text: item.label,
      selection: TextSelection.collapsed(offset: item.label.length),
    );
    _currentQuery = item.label;
    _closeDropdown();
    widget.onSelected?.call(item);
  }

  KeyEventResult _handleKey(FocusNode node, KeyEvent event) {
    if (!widget.enabled) return KeyEventResult.ignored;
    if (event is! KeyDownEvent) return KeyEventResult.ignored;
    if (!_popover.isOpen) return KeyEventResult.ignored;

    return _listNavigator.handleKey(
      event,
      isOpen: _popover.isOpen,
      onOpen: () {},
      onClose: _closeDropdown,
      onSelect: (i) => _selectItem(_suggestions[i]),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);
    final tokens = theme.components.autoSuggest;

    var totalHeight = 0.0;
    for (final item in _suggestions) {
      totalHeight += item.subtitle != null ? tokens.itemSubtitleHeight : tokens.itemHeight;
    }
    final panelHeight =
        totalHeight.clamp(0.0, widget.maxDropdownHeight.toDouble());

    return Focus(
      onKeyEvent: _handleKey,
      child: VPopover(
        controller: _popover,
        matchTriggerWidth: true,
        placement: widget.placement,
        desiredHeight: panelHeight,
        triggerBuilder: (ctx, ctrl, isOpen) {
          return VTextField(
            key: _triggerKey,
            controller: _controller,
            focusNode: _focusNode,
            label: widget.label,
            hint: widget.hint,
            errorText: widget.errorText,
            enabled: widget.enabled,
            semanticLabel: widget.semanticLabel,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            leading: widget.leading,
            trailing: _buildTrailing(theme, tokens),
            onChanged: _onTextChanged,
            onSubmitted: _onSubmitted,
          );
        },
        contentBuilder: (ctx, ctrl) {
          return _SuggestionPanel(
            suggestions: _suggestions,
            query: _currentQuery,
            highlightIndex: _listNavigator.highlightIndex,
            tokens: tokens,
            highlightMatch: widget.highlightMatch,
            width: _triggerWidth,
            maxHeight: widget.maxDropdownHeight,
            onSelected: _selectItem,
            onHover: (i) => _listNavigator.highlightIndex.value = i,
          );
        },
      ),
    );
  }

  Widget? _buildTrailing(VThemeData theme, VAutoSuggestTokens tokens) {
    if (_loading) {
      return VSpinner(size: 18, color: tokens.itemSelected, strokeWidth: 2.0);
    }
    return widget.trailing;
  }
}
