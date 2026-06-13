import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../foundation/foundation.dart';
import '../../theme/theme.dart';
import '../basic/v_text.dart';

/// An option item inside [VSegmentedControl].
class VSegmentedControlOption<T> {
  const VSegmentedControlOption({
    required this.value,
    required this.label,
    this.icon,
    this.enabled = true,
  });

  final T value;
  final String label;
  final Widget? icon;
  final bool enabled;
}

/// A premium, theme-aware segmented control with sliding active highlight.
///
/// Features iOS/macOS-style sliding selection pill with elastic spring animation,
/// full arrow key keyboard navigation, and thorough screen reader support.
class VSegmentedControl<T> extends StatefulWidget {
  const VSegmentedControl({
    super.key,
    required this.value,
    required this.options,
    required this.onChanged,
    this.size = VControlSize.md,
    this.enabled = true,
    this.semanticLabel,
  }) : assert(options.length >= 2,
            'VSegmentedControl requires at least two options.');

  final T value;
  final List<VSegmentedControlOption<T>> options;
  final ValueChanged<T> onChanged;
  final VControlSize size;
  final bool enabled;
  final String? semanticLabel;

  @override
  State<VSegmentedControl<T>> createState() => _VSegmentedControlState<T>();
}

class _VSegmentedControlState<T> extends State<VSegmentedControl<T>> {
  final FocusNode _focusNode = FocusNode();
  bool _isPressed = false;
  T? _pressedValue;

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  int get _selectedIndex {
    final idx = widget.options.indexWhere((opt) => opt.value == widget.value);
    return idx >= 0 ? idx : 0;
  }

  void _select(T value) {
    if (!widget.enabled) return;
    final opt = widget.options.firstWhere((opt) => opt.value == value);
    if (!opt.enabled) return;
    widget.onChanged(value);
  }

  void _handleArrowKey(bool forward) {
    if (!widget.enabled) return;
    final len = widget.options.length;
    int index = _selectedIndex;
    for (int i = 0; i < len; i++) {
      index = (index + (forward ? 1 : -1)) % len;
      if (widget.options[index].enabled) {
        _select(widget.options[index].value);
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);
    final tokens =
        VSegmentedControlTheme.of(context) ?? theme.components.segmentedControl;

    final double height = switch (widget.size) {
      VControlSize.sm => tokens.heightSm,
      VControlSize.md => tokens.heightMd,
      VControlSize.lg => tokens.heightLg,
    };

    final double pillPadding = switch (widget.size) {
      VControlSize.sm => tokens.paddingHorizontalSm,
      VControlSize.md => tokens.paddingHorizontalMd,
      VControlSize.lg => tokens.paddingHorizontalLg,
    };

    final textVariant = switch (widget.size) {
      VControlSize.sm => VTextVariant.caption,
      VControlSize.md => VTextVariant.label,
      VControlSize.lg => VTextVariant.body,
    };

    final activeIndex = _selectedIndex;

    // Track state properties
    final Set<WidgetState> controlStates = {
      if (!widget.enabled) WidgetState.disabled,
    };

    final containerBg = tokens.background.resolve(controlStates);
    final containerBorder = tokens.border.resolve(controlStates);

    return FocusableActionDetector(
      focusNode: _focusNode,
      autofocus: false,
      enabled: widget.enabled,
      shortcuts: const <ShortcutActivator, Intent>{
        SingleActivator(LogicalKeyboardKey.arrowLeft):
            DirectionalFocusIntent(TraversalDirection.left),
        SingleActivator(LogicalKeyboardKey.arrowRight):
            DirectionalFocusIntent(TraversalDirection.right),
      },
      actions: <Type, Action<Intent>>{
        DirectionalFocusIntent: CallbackAction<DirectionalFocusIntent>(
          onInvoke: (intent) {
            final left = intent.direction == TraversalDirection.left;
            _handleArrowKey(!left);
            return null;
          },
        ),
      },
      child: Semantics(
        label: widget.semanticLabel ?? 'Segmented Control',
        enabled: widget.enabled,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final totalWidth = constraints.maxWidth;
            final count = widget.options.length;
            final segmentWidth = totalWidth / count;

            // Pressed stretch offsets for premium squash-and-stretch
            double pillLeftOffset = activeIndex * segmentWidth + pillPadding;
            double pillWidth = segmentWidth - (pillPadding * 2);

            if (_isPressed && _pressedValue != null) {
              final pressedIdx = widget.options
                  .indexWhere((opt) => opt.value == _pressedValue);
              if (pressedIdx != activeIndex && pressedIdx >= 0) {
                // Squash the pill towards the pressed target option
                final goingForward = pressedIdx > activeIndex;
                pillWidth = pillWidth * 1.15;
                if (goingForward) {
                  // stretch right side forward
                  pillLeftOffset =
                      pillLeftOffset + (segmentWidth - pillWidth) / 4;
                } else {
                  // stretch left side backward
                  pillLeftOffset =
                      pillLeftOffset - (pillWidth - segmentWidth) / 4;
                }
              }
            }

            final isFocused = _focusNode.hasFocus;
            final focusShadow = isFocused
                ? [
                    BoxShadow(
                      color: tokens.focusRing.withValues(alpha: 0.45),
                      blurRadius: 0,
                      spreadRadius: 2,
                    ),
                  ]
                : <BoxShadow>[];

            return Container(
              height: height,
              decoration: BoxDecoration(
                color: containerBg,
                borderRadius: BorderRadius.circular(tokens.radius),
                border: containerBorder != const Color(0x00000000)
                    ? Border.all(color: containerBorder)
                    : null,
                boxShadow: focusShadow,
              ),
              child: Stack(
                children: [
                  // Smooth sliding pill
                  AnimatedPositioned(
                    duration: theme.motion.control.duration,
                    curve: theme.motion.control.curve,
                    left: pillLeftOffset,
                    top: pillPadding,
                    width: pillWidth,
                    height: height - (pillPadding * 2),
                    child: Container(
                      decoration: BoxDecoration(
                        color:
                            tokens.indicatorBackground.resolve(controlStates),
                        borderRadius:
                            BorderRadius.circular(tokens.indicatorRadius),
                        boxShadow: tokens.indicatorShadow,
                      ),
                    ),
                  ),

                  // Option text rows
                  Row(
                    children: List.generate(count, (i) {
                      final option = widget.options[i];
                      final isSelected = i == activeIndex;
                      final optionEnabled = widget.enabled && option.enabled;

                      final Set<WidgetState> optionStates = {
                        if (isSelected) WidgetState.selected,
                        if (!optionEnabled) WidgetState.disabled,
                      };

                      final textStyleColor =
                          tokens.foreground.resolve(optionStates);

                      return Expanded(
                        child: Semantics(
                          selected: isSelected,
                          enabled: optionEnabled,
                          button: true,
                          label: option.label,
                          child: GestureDetector(
                            onTapDown: (_) {
                              if (optionEnabled) {
                                setState(() {
                                  _isPressed = true;
                                  _pressedValue = option.value;
                                });
                              }
                            },
                            onTapUp: (_) {
                              if (optionEnabled) {
                                setState(() {
                                  _isPressed = false;
                                  _pressedValue = null;
                                });
                                _select(option.value);
                                if (!_focusNode.hasFocus) {
                                  _focusNode.requestFocus();
                                }
                              }
                            },
                            onTapCancel: () {
                              setState(() {
                                _isPressed = false;
                                _pressedValue = null;
                              });
                            },
                            child: MouseRegion(
                              cursor: optionEnabled
                                  ? SystemMouseCursors.click
                                  : SystemMouseCursors.forbidden,
                              child: Container(
                                height: double.infinity,
                                alignment: Alignment.center,
                                color: const Color(
                                    0x00000000), // Transparent to receive gesture events
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    if (option.icon != null) ...[
                                      DefaultTextStyle(
                                        style: TextStyle(color: textStyleColor),
                                        child: VIconTheme(
                                          data: VIconThemeData(
                                              color: textStyleColor,
                                              size: height * 0.45),
                                          child: option.icon!,
                                        ),
                                      ),
                                      const SizedBox(width: 6),
                                    ],
                                    VText(
                                      option.label,
                                      variant: textVariant,
                                      color: textStyleColor,
                                      style: isSelected
                                          ? TextStyle(
                                              fontWeight: theme
                                                  .typography.label.fontWeight)
                                          : null,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
