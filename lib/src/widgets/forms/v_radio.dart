import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../theme/v_appearance_box.dart';
import '../../theme/v_appearance_scope.dart';
import '../../theme/v_component_themes.g.dart';
import '../../theme/v_theme.dart';
import '../basic/v_text.dart';
import '../interaction/v_interactive.dart';
import 'v_control_row.dart';

/// An accessible, theme-aware radio button.
///
/// Toggles [selected] via [VInteractive]. Reads [VRadioTokens] from the
/// current [VTheme]. Supports keyboard activation.
///
/// Use [VRadioGroup] for mutually exclusive selection.
class VRadio<T> extends StatelessWidget {
  const VRadio({
    super.key,
    this.selected = false,
    this.value,
    this.onSelected,
    this.label,
    this.semanticLabel,
    this.enabled = true,
    this.autofocus = false,
    this.focusNode,
  });

  final bool selected;
  final T? value;
  final VoidCallback? onSelected;
  final String? label;
  final String? semanticLabel;
  final bool enabled;
  final bool autofocus;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);
    final tokens = VRadioTheme.of(context) ?? theme.components.radio;
    final group = VRadioGroup.of<T>(context);
    final groupValue = value;
    final isSelected = group != null && groupValue != null
        ? group.value == groupValue
        : selected;

    void select() {
      if (!enabled) return;
      if (group != null && groupValue != null) {
        group.onChanged(groupValue);
      } else {
        onSelected?.call();
      }
    }

    final interactive = enabled &&
        (onSelected != null || (group != null && groupValue != null));

    return Semantics(
      checked: isSelected,
      enabled: enabled,
      label: semanticLabel ?? label,
      child: Actions(
        actions: <Type, Action<Intent>>{
          ActivateIntent: CallbackAction<ActivateIntent>(
            onInvoke: (_) {
              select();
              return null;
            },
          ),
        },
        child: Shortcuts(
          shortcuts: const <ShortcutActivator, Intent>{
            SingleActivator(LogicalKeyboardKey.enter): ActivateIntent(),
            SingleActivator(LogicalKeyboardKey.space): ActivateIntent(),
          },
          child: VInteractive(
            enabled: interactive,
            onTap: interactive ? select : null,
            autofocus: autofocus,
            focusNode: focusNode,
            builder: (context, states) {
              final background = tokens.uncheckedBackground.resolve(states);
              final border = isSelected
                  ? tokens.checkedBorder
                  : tokens.uncheckedBorder.resolve(states);
              final focused = states.contains(WidgetState.focused);

              final effectiveStates =
                  isSelected ? {...states, WidgetState.selected} : states;

              final appearance = VAppearanceScope.of(context);
              final resolvedBg =
                  appearance?.background(background, effectiveStates) ??
                      background;
              final resolvedRadius =
                  appearance?.radius(theme.radii.sm) ?? theme.radii.sm;
              final focusShadow = focused
                  ? [
                      BoxShadow(
                        color: tokens.focusRing.withValues(alpha: 0.45),
                        blurRadius: 0,
                        spreadRadius: 2,
                      ),
                    ]
                  : <BoxShadow>[];
              final resolvedShadows = appearance?.shadows(focusShadow) ??
                  (focused ? focusShadow : null);

              final control = VVisualBox(
                  appearance: appearance,
                  states: effectiveStates,
                  background: resolvedBg,
                  borderRadius:
                      BorderRadius.all(Radius.circular(resolvedRadius)),
                  child: AnimatedContainer(
                    duration: theme.motion.control.duration,
                    curve: theme.motion.control.curve,
                    width: theme.sizes.radioSize,
                    height: theme.sizes.radioSize,
                    decoration: BoxDecoration(
                      color: resolvedBg,
                      shape: BoxShape.circle,
                      border: Border.all(color: border, width: 2),
                      boxShadow: resolvedShadows,
                    ),
                    child: isSelected
                        ? Center(
                            child: AnimatedContainer(
                              duration: theme.motion.control.duration,
                              curve: theme.motion.control.curve,
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                color: tokens.checkedDot,
                                shape: BoxShape.circle,
                              ),
                            ),
                          )
                        : null,
                  ));

              if (label == null) return control;

              return VControlRow(
                control: control,
                label: VText(label!, variant: VTextVariant.body),
                enabled: enabled,
              );
            },
          ),
        ),
      ),
    );
  }
}

/// A group of [VRadio] widgets with mutually exclusive selection.
///
/// Manages which radio is currently selected. Pass the same [value]
/// to each [VRadio] in the group.
///
/// ```dart
/// VRadioGroup<String>(
///   value: _option,
///   onChanged: (v) => setState(() => _option = v),
///   child: VFlex.vertical(
///     gap: 8,
///     children: [
///       VRadio<String>(value: 'a', label: 'Option A'),
///       VRadio<String>(value: 'b', label: 'Option B'),
///     ],
///   ),
/// );
/// ```
class VRadioGroup<T> extends InheritedWidget {
  const VRadioGroup({
    super.key,
    required this.value,
    required this.onChanged,
    required super.child,
  });

  final T? value;
  final ValueChanged<T> onChanged;

  static VRadioGroup<T>? of<T>(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<VRadioGroup<T>>();
  }

  @override
  bool updateShouldNotify(VRadioGroup<T> oldWidget) =>
      value != oldWidget.value || onChanged != oldWidget.onChanged;
}
