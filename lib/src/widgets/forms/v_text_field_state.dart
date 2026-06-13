part of 'v_text_field.dart';

class _VTextFieldState extends State<VTextField>
    implements TextSelectionGestureDetectorBuilderDelegate {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _ownsController = true;
  bool _ownsFocusNode = true;
  bool _isFocused = false;
  bool _isHovered = false;
  VThemeData? _cachedTheme;
  late final TextSelectionGestureDetectorBuilder
      _selectionGestureDetectorBuilder;

  // Stable references prevent EditableText.didUpdateWidget from disposing and
  // re-creating _selectionOverlay (which inserts OverlayEntry handles) on every
  // rebuild. Without stability, handles get disposed before they are first
  // mounted in the same overlay build pass.
  static final _kSelectionControls = VTextSelectionControls();
  late final Widget Function(BuildContext, EditableTextState)
      _stableContextMenuBuilder;

  @override
  final GlobalKey<EditableTextState> editableTextKey =
      GlobalKey<EditableTextState>();

  @override
  bool get forcePressEnabled => false;

  @override
  bool get selectionEnabled => widget.enabled;

  @override
  void initState() {
    super.initState();
    _stableContextMenuBuilder = _buildContextMenuWidget;
    _selectionGestureDetectorBuilder =
        _VTextFieldSelectionGestureDetectorBuilder(state: this);
    _attachControllerAndFocus();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Cache the theme so it's available to the context menu builder callback,
    // which may fire after the State's context is deactivated.
    _cachedTheme = VTheme.of(context);
  }

  Widget _buildContextMenuWidget(
    BuildContext context,
    EditableTextState editableTextState,
  ) {
    final theme = _cachedTheme ?? VTheme.of(this.context);
    final data = _buildContextMenuData(editableTextState);
    return widget.contextMenuBuilder?.call(context, editableTextState, data) ??
        VTextSelectionMenu(
          theme: theme,
          state: editableTextState,
          isDesktop: data.isDesktop,
          items: data.items
              .map(
                (item) => VTextSelectionMenuItem(
                  label: item.label,
                  shortcut: item.shortcut,
                  enabled: item.enabled,
                  onTap: item.onTap,
                ),
              )
              .toList(growable: false),
        );
  }

  void _attachControllerAndFocus() {
    _ownsController = widget.controller == null;
    _ownsFocusNode = widget.focusNode == null;
    _controller = widget.controller ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode(debugLabel: 'VTextField');

    _focusNode.addListener(_handleFocusChange);
    _controller.addListener(_handleTextChange);
  }

  void _detachControllerAndFocus() {
    _focusNode.removeListener(_handleFocusChange);
    _controller.removeListener(_handleTextChange);
    if (_ownsController) _controller.dispose();
    if (_ownsFocusNode) _focusNode.dispose();
  }

  @override
  void didUpdateWidget(VTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    // Handle controller ownership transitions
    if (widget.controller != oldWidget.controller) {
      _controller.removeListener(_handleTextChange);
      
      final oldOwnsController = _ownsController;
      _ownsController = widget.controller == null;
      
      // Preserve text when switching from external to internal controller
      if (oldWidget.controller != null && widget.controller == null) {
        // External → Internal: preserve current text
        final currentText = _controller.text;
        final currentSelection = _controller.selection;
        if (oldOwnsController) _controller.dispose();
        _controller = TextEditingController(text: currentText);
        _controller.selection = currentSelection;
      } else if (oldWidget.controller == null && widget.controller != null) {
        // Internal → External: dispose old internal controller
        if (oldOwnsController) _controller.dispose();
        _controller = widget.controller!;
      } else if (oldWidget.controller != null && widget.controller != null) {
        // External → Different External: just switch reference
        _controller = widget.controller!;
      }
      
      _controller.addListener(_handleTextChange);
    }
    
    // Handle focus node ownership transitions
    if (widget.focusNode != oldWidget.focusNode) {
      _focusNode.removeListener(_handleFocusChange);
      
      final oldOwnsFocusNode = _ownsFocusNode;
      _ownsFocusNode = widget.focusNode == null;
      
      if (oldWidget.focusNode != null && widget.focusNode == null) {
        // External → Internal: create new internal focus node
        if (oldOwnsFocusNode) _focusNode.dispose();
        _focusNode = FocusNode(debugLabel: 'VTextField');
      } else if (oldWidget.focusNode == null && widget.focusNode != null) {
        // Internal → External: dispose old internal focus node
        if (oldOwnsFocusNode) _focusNode.dispose();
        _focusNode = widget.focusNode!;
      } else if (oldWidget.focusNode != null && widget.focusNode != null) {
        // External → Different External: just switch reference
        _focusNode = widget.focusNode!;
      }
      
      _focusNode.addListener(_handleFocusChange);
      
      // Update focus state to match new focus node
      _isFocused = _focusNode.hasFocus;
    }
  }

  void _handleFocusChange() {
    if (!mounted) return;
    if (_isFocused != _focusNode.hasFocus) {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    }
  }

  void _handleTextChange() {
    // Hint visibility is driven by a ValueListenableBuilder below.
  }

  @override
  void dispose() {
    _detachControllerAndFocus();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);
    final tokens = VInputTheme.of(context) ?? theme.components.input;

    final hasError = widget.errorText != null && widget.errorText!.isNotEmpty;

    final borderColor = hasError
        ? tokens.borderError
        : _isFocused
            ? tokens.borderFocused
            : _isHovered
                ? theme.colors.actionPrimary.withValues(alpha: 0.6)
                : tokens.border;

    final textStyle = theme.typography.body.copyWith(
      color: widget.enabled ? tokens.text : theme.colors.textDisabled,
    );

    final placeholderStyle = textStyle.copyWith(color: tokens.placeholder);

    final isMultiLine = widget.maxLines > 1 ||
        (widget.minLines != null && widget.minLines! > 1);
    final stackAlignment = isMultiLine
        ? AlignmentDirectional.topStart
        : AlignmentDirectional.centerStart;

    return Semantics(
      textField: true,
      enabled: widget.enabled,
      label: widget.semanticLabel ?? widget.label,
      hint: widget.hint,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.label != null)
            Padding(
              padding: EdgeInsets.only(bottom: theme.spacing.xs),
              child: VText(
                widget.label!,
                variant: VTextVariant.label,
                color: theme.colors.text,
              ),
            ),
          _maybeWrapMouseRegion(
            context,
            DecoratedBox(
              decoration: BoxDecoration(
                color: widget.enabled
                    ? tokens.background
                    : theme.colors.surfaceHover,
                borderRadius: BorderRadius.circular(theme.radii.md),
                border: Border.all(color: borderColor),
                boxShadow: _isFocused && !hasError
                    ? [
                        BoxShadow(
                          color: tokens.focusRing.withValues(alpha: 0.25),
                          blurRadius: 0,
                          spreadRadius: 2,
                        ),
                      ]
                    : null,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: theme.spacing.md,
                  vertical: theme.spacing.sm,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (widget.leading != null) ...[
                      widget.leading!,
                      SizedBox(width: theme.spacing.sm),
                    ],
                    Expanded(
                      child: Stack(
                        alignment: stackAlignment,
                        textDirection: TextDirection.ltr,
                        children: [
                          ValueListenableBuilder<TextEditingValue>(
                            valueListenable: _controller,
                            builder: (context, value, _) {
                              if (widget.hint == null ||
                                  value.text.isNotEmpty) {
                                return const SizedBox.shrink();
                              }
                              return IgnorePointer(
                                child: Text(
                                  widget.hint!,
                                  style: placeholderStyle,
                                  maxLines: widget.maxLines,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              );
                            },
                          ),
                          IgnorePointer(
                            ignoring: !widget.enabled,
                            child: _selectionGestureDetectorBuilder
                                .buildGestureDetector(
                              behavior: HitTestBehavior.translucent,
                              child: EditableText(
                                key: editableTextKey,
                                controller: _controller,
                                focusNode: _focusNode,
                                readOnly: widget.readOnly,
                                obscureText: widget.obscureText,
                                keyboardType: widget.keyboardType,
                                textInputAction: widget.textInputAction,
                                textCapitalization: widget.textCapitalization,
                                inputFormatters: widget.inputFormatters,
                                maxLines: widget.maxLines,
                                minLines: widget.minLines,
                                autofocus: widget.autofocus,
                                style: textStyle,
                                cursorColor: tokens.borderFocused,
                                backgroundCursorColor: tokens.placeholder,
                                selectionColor: tokens.borderFocused
                                    .withValues(alpha: 0.35),
                                enableInteractiveSelection: widget.enabled,
                                showCursor: widget.enabled,
                                dragStartBehavior: DragStartBehavior.down,
                                selectionControls: _kSelectionControls,
                                rendererIgnoresPointer: true,
                                contextMenuBuilder: _stableContextMenuBuilder,
                                onChanged: widget.onChanged,
                                onSubmitted: widget.onSubmitted,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (widget.trailing != null) ...[
                      SizedBox(width: theme.spacing.sm),
                      widget.trailing!,
                    ],
                  ],
                ),
              ),
            ),
          ),
          if (hasError)
            Padding(
              padding: EdgeInsets.only(top: theme.spacing.xs),
              child: Semantics(
                liveRegion: true,
                child: VText(
                  widget.errorText!,
                  variant: VTextVariant.caption,
                  color: theme.colors.danger,
                ),
              ),
            ),
        ],
      ),
    );
  }

  /// Only mount [MouseRegion] on platforms that support hover, matching
  /// [VInteractive]'s behaviour and avoiding idle pointer-event overhead.
  Widget _maybeWrapMouseRegion(BuildContext context, Widget child) {
    final hasHover = VPlatformScope.of(context).hasHoverCapability;
    if (!hasHover) return child;
    return MouseRegion(
      onEnter: (_) {
        if (widget.enabled) setState(() => _isHovered = true);
      },
      onExit: (_) {
        if (_isHovered) setState(() => _isHovered = false);
      },
      child: child,
    );
  }
}
