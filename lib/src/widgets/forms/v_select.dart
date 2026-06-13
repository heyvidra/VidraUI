import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../foundation/foundation.dart';
import '../../theme/component_tokens.dart';
import '../../theme/v_component_themes.g.dart';
import '../../theme/v_theme.dart';
import '../../theme/v_theme_data.dart';
import '../basic/v_text.dart';
import '../interaction/v_chevron_icon.dart';
import '../navigation/v_list_navigator.dart';
import '../overlays/v_anchored_overlay.dart';
import '../overlays/v_popover.dart';
import 'v_text_field.dart';

part 'v_select_menu.dart';

/// An option in a [VSelect] menu.
class VSelectOption<T> {
  const VSelectOption({
    required this.value,
    required this.label,
    this.leading,
    this.enabled = true,
  });

  final T value;
  final String label;
  final Widget? leading;
  final bool enabled;
}

/// A dropdown select with typed single and multiple-selection interfaces.
///
/// Use [VSelect.new] for single selection and [VSelect.multiple] for multiple
class VSelect<T> extends StatefulWidget {
  const VSelect({
    super.key,
    required this.options,
    this.value,
    this.onChanged,
    this.placeholder,
    this.label,
    this.enabled = true,
    this.searchable = false,
    this.icon,
    this.focusNode,
    this.semanticLabel,
    this.maxMenuHeight = 280,
    this.menuPlacement = VAnchoredOverlayPlacement.auto,
    this.onMenuOpenChanged,
  })  : multiple = false,
        values = null,
        onChangedMultiple = null;

  const VSelect.multiple({
    super.key,
    required this.options,
    this.values,
    this.onChangedMultiple,
    this.placeholder,
    this.label,
    this.enabled = true,
    this.searchable = false,
    this.icon,
    this.focusNode,
    this.semanticLabel,
    this.maxMenuHeight = 280,
    this.menuPlacement = VAnchoredOverlayPlacement.auto,
    this.onMenuOpenChanged,
  })  : value = null,
        multiple = true,
        onChanged = null;

  final List<VSelectOption<T>> options;
  final T? value;
  final bool multiple;
  final Set<T>? values;
  final ValueChanged<T>? onChanged;
  final ValueChanged<Set<T>>? onChangedMultiple;
  final String? placeholder;
  final String? label;
  final bool enabled;
  final bool searchable;
  final Widget? icon;
  final FocusNode? focusNode;
  final String? semanticLabel;
  final double maxMenuHeight;
  final VAnchoredOverlayPlacement menuPlacement;
  final ValueChanged<bool>? onMenuOpenChanged;

  @override
  State<VSelect<T>> createState() => _VSelectState<T>();
}

class _VSelectState<T> extends State<VSelect<T>> {
  FocusNode? _internalFocusNode;
  FocusNode get _focusNode => widget.focusNode ?? (_internalFocusNode ??= FocusNode(debugLabel: 'VSelect'));

  late final VListNavigator _listNavigator;
  final VPopoverController _popoverController = VPopoverController();
  bool _triggerHovered = false;

  late final ValueNotifier<Set<T>> _selectedNotifier;

  bool get _isMulti => widget.multiple;
  bool get _isPlaceholder {
    if (_isMulti) {
      return widget.values == null || widget.values!.isEmpty;
    } else {
      return widget.value == null;
    }
  }

  bool get _isOpen => _popoverController.isOpen;

  @override
  void initState() {
    super.initState();
    _selectedNotifier = ValueNotifier<Set<T>>(<T>{});
    _listNavigator = VListNavigator(
      itemCount: () => widget.options.length,
      isItemEnabled: (index) => widget.options[index].enabled,
    );
    _popoverController.addListener(_onPopoverChanged);
    _syncSelectionFromWidget();
  }

  @override
  void didUpdateWidget(VSelect<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value ||
        !setEquals(oldWidget.values, widget.values)) {
      // Defer: the notifier's listener is inside the popover overlay (a
      // separate element tree). Notifying synchronously here happens during
      // the parent's build phase, which would mark a non-descendant dirty.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _syncSelectionFromWidget();
      });
    }
  }

  @override
  void dispose() {
    _popoverController.removeListener(_onPopoverChanged);
    _popoverController.dispose();
    _listNavigator.dispose();
    _internalFocusNode?.dispose();
    _selectedNotifier.dispose();
    super.dispose();
  }

  void _onPopoverChanged() {
    widget.onMenuOpenChanged?.call(_isOpen);
    if (_isOpen) {
      _focusNode.requestFocus();
      final isDesktop = VPlatformScope.of(context).isDesktop;
      if (isDesktop) {
        _listNavigator.focusFirst();
      }
    } else {
      _listNavigator.clearFocus();
    }
  }

  void _syncSelectionFromWidget() {
    final value = widget.value;
    _selectedNotifier.value = _isMulti
        ? Set<T>.from(widget.values ?? <T>{})
        : (value == null ? <T>{} : <T>{value});
  }

  String get _displayLabel {
    final selected = _isMulti
        ? Set<T>.from(widget.values ?? <T>{})
        : (widget.value == null ? <T>{} : <T>{widget.value as T});
    if (selected.isEmpty) return widget.placeholder ?? '';
    if (selected.length == 1) {
      final selectedValue = selected.first;
      for (final option in widget.options) {
        if (option.value == selectedValue) return option.label;
      }
      return widget.placeholder ?? '';
    }
    return '${selected.length} selected';
  }

  void _toggleMenu() {
    if (widget.options.isEmpty) return;
    _popoverController.toggle();
  }

  void _onOptionSelected(VSelectOption<T> option) {
    if (!option.enabled) return;
    // Emit subtle tactile confirmation on touch platforms.
    if (VPlatformScope.of(context).hasHapticFeedback) {
      HapticFeedback.lightImpact();
    }
    if (_isMulti) {
      final next = Set<T>.from(_selectedNotifier.value);
      if (next.contains(option.value)) {
        next.remove(option.value);
      } else {
        next.add(option.value);
      }
      _selectedNotifier.value = next;
      widget.onChangedMultiple?.call(next);
      setState(() {});
    } else {
      widget.onChanged?.call(option.value);
      _popoverController.close();
    }
  }

  KeyEventResult _handleKey(FocusNode node, KeyEvent event) {
    if (!widget.enabled) return KeyEventResult.ignored;

    return _listNavigator.handleKey(
      event,
      isOpen: _isOpen,
      onOpen: _popoverController.open,
      onClose: _popoverController.close,
      onSelect: (index) => _onOptionSelected(widget.options[index]),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);
    final scopedTheme = resolveOverlayTheme(
        context, VSelectTheme.of, (c, t) => c.copyWith(select: t));
    final tokens = scopedTheme.components.select;

    final itemExtent = tokens.itemHeight;
    final calculatedHeight =
        (widget.options.length * itemExtent) + (tokens.menuBorderWidth * 2);
    final menuHeight = calculatedHeight < widget.maxMenuHeight
        ? calculatedHeight
        : widget.maxMenuHeight;

    return Column(
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
        VPopover(
          controller: _popoverController,
          matchTriggerWidth: true,
          gap: theme.spacing.xs,
          desiredHeight: menuHeight,
          placement: widget.menuPlacement,
          triggerBuilder: (context, controller, isOpen) {
            final states = <WidgetState>{
              if (!widget.enabled) WidgetState.disabled,
              if (_triggerHovered && widget.enabled) WidgetState.hovered,
              if (_focusNode.hasFocus || isOpen) WidgetState.focused,
              if (!_isPlaceholder) WidgetState.selected,
            };
            final triggerBackground = tokens.background.resolve(states);
            final triggerBorder = tokens.border.resolve(states);
            final triggerText = _isPlaceholder
                ? tokens.placeholder
                : tokens.text.resolve(states);
            final triggerShadow = states.contains(WidgetState.focused)
                ? [
                    BoxShadow(
                      color: tokens.focusRing.withValues(alpha: 0.25),
                      blurRadius: 0,
                      spreadRadius: 2,
                    ),
                  ]
                : null;

            final hasHover =
                VPlatformScope.of(context).hasHoverCapability;

            Widget trigger = Semantics(
              button: true,
              enabled: widget.enabled,
              expanded: isOpen,
              label: widget.semanticLabel ?? widget.label ?? 'Select',
              value: _displayLabel,
              child: GestureDetector(
                onTap: widget.enabled ? _toggleMenu : null,
                child: Focus(
                  focusNode: _focusNode,
                  canRequestFocus: widget.enabled,
                  onKeyEvent: _handleKey,
                  child: AnimatedContainer(
                    duration: scopedTheme.motion.control.duration,
                    curve: scopedTheme.motion.control.curve,
                    constraints:
                        BoxConstraints(minHeight: tokens.triggerHeight),
                    padding: EdgeInsets.symmetric(
                      horizontal: tokens.triggerPaddingHorizontal,
                      vertical: tokens.triggerPaddingVertical,
                    ),
                    decoration: BoxDecoration(
                      color: triggerBackground,
                      borderRadius:
                          BorderRadius.circular(tokens.triggerRadius),
                      border: Border.all(
                        color: triggerBorder,
                        width: tokens.triggerBorderWidth,
                      ),
                      boxShadow: triggerShadow,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: VText(
                            _displayLabel,
                            variant: VTextVariant.body,
                            color: triggerText,
                          ),
                        ),
                        SizedBox(width: scopedTheme.spacing.sm),
                        widget.icon ??
                            VChevronIcon(
                              isOpen: isOpen,
                              color: tokens.placeholder,
                              size: tokens.indicatorSize,
                            ),
                      ],
                    ),
                  ),
                ),
              ),
            );

            if (hasHover) {
              trigger = MouseRegion(
                onEnter: (_) {
                  if (widget.enabled) setState(() => _triggerHovered = true);
                },
                onExit: (_) {
                  if (_triggerHovered) setState(() => _triggerHovered = false);
                },
                child: trigger,
              );
            }

            return trigger;
          },
          contentBuilder: (context, controller) {
            final scopedTheme = resolveOverlayTheme(
                context, VSelectTheme.of, (c, t) => c.copyWith(select: t));
            return VTheme(
              data: scopedTheme,
              child: _SelectMenu<T>(
                options: widget.options,
                selectedNotifier: _selectedNotifier,
                highlightIndex: _listNavigator.highlightIndex,
                multiple: _isMulti,
                maxHeight: widget.maxMenuHeight,
                searchable: widget.searchable,
                onSelected: _onOptionSelected,
                onHover: (index) {
                  _listNavigator.highlightIndex.value = index;
                },
              ),
            );
          },
        ),
      ],
    );
  }
}




