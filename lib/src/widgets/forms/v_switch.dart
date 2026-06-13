import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../theme/v_component_themes.g.dart';
import '../../theme/v_theme.dart';
import '../basic/v_text.dart';
import '../interaction/v_interactive.dart';
import 'v_control_row.dart';

/// An accessible, theme-aware toggle switch.
class VSwitch extends StatelessWidget {
  const VSwitch({
    super.key,
    required this.checked,
    this.onChanged,
    this.label,
    this.labelWidget,
    this.semanticLabel,
    this.enabled = true,
    this.autofocus = false,
    this.focusNode,
  });

  final bool checked;
  final ValueChanged<bool>? onChanged;
  final String? label;
  final Widget? labelWidget;
  final String? semanticLabel;
  final bool enabled;
  final bool autofocus;
  final FocusNode? focusNode;

  static const double _thumbInset = 3;
  static const Curve _springCurve = Cubic(0.34, 1.56, 0.64, 1.0);

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);
    final tokens = VSwitchTheme.of(context) ?? theme.components.switch_;
    final sizes = theme.sizes;

    return Semantics(
      toggled: checked,
      enabled: enabled,
      label: semanticLabel ?? label,
      child: Actions(
        actions: <Type, Action<Intent>>{
          ActivateIntent: CallbackAction<ActivateIntent>(
            onInvoke: (_) {
              if (enabled) onChanged?.call(!checked);
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
            enabled: enabled && onChanged != null,
            onTap: onChanged != null ? () => onChanged!(!checked) : null,
            autofocus: autofocus,
            focusNode: focusNode,
            builder: (context, states) {
              final trackColor = tokens.trackBackground.resolve(states);
              final focused = states.contains(WidgetState.focused);
              final isPressed = states.contains(WidgetState.pressed);
              final isHovered = states.contains(WidgetState.hovered);

              double thumbWidth = sizes.switchThumb;
              double thumbHeight = sizes.switchThumb;
              double currentTopInset = _thumbInset;

              if (isPressed) {
                thumbWidth = sizes.switchThumb * 1.35;
                thumbHeight = sizes.switchThumb * 0.9;
                currentTopInset = _thumbInset + (sizes.switchThumb - thumbHeight) / 2;
              } else if (isHovered) {
                thumbWidth = sizes.switchThumb * 1.08;
                thumbHeight = sizes.switchThumb * 1.08;
                currentTopInset = _thumbInset + (sizes.switchThumb - thumbHeight) / 2;
              }

              final leftOffset = checked
                  ? sizes.switchWidth - thumbWidth - _thumbInset
                  : _thumbInset;

              final control = AnimatedContainer(
                duration: theme.motion.control.duration,
                curve: theme.motion.control.curve,
                width: sizes.switchWidth,
                height: sizes.switchHeight,
                decoration: BoxDecoration(
                  color: checked ? theme.colors.actionPrimary : trackColor,
                  borderRadius: BorderRadius.circular(sizes.switchHeight / 2),
                  boxShadow: focused
                      ? [
                          BoxShadow(
                            color: tokens.focusRing.withValues(alpha: 0.45),
                            blurRadius: 0,
                            spreadRadius: 2,
                          ),
                        ]
                      : null,
                ),
                child: Stack(
                  children: [
                    AnimatedPositioned(
                      duration: theme.motion.control.duration,
                      curve: _springCurve,
                      left: leftOffset,
                      top: currentTopInset,
                      width: thumbWidth,
                      height: thumbHeight,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: tokens.thumbBackground,
                          borderRadius: BorderRadius.circular(thumbHeight / 2),
                        ),
                        child: const SizedBox.expand(),
                      ),
                    ),
                  ],
                ),
              );

              if (labelWidget != null) {
                return VControlRow(
                  control: control,
                  label: labelWidget!,
                  enabled: enabled,
                );
              } else if (label != null) {
                return VControlRow(
                  control: control,
                  label: VText(label!, variant: VTextVariant.body),
                  enabled: enabled,
                );
              } else {
                return control;
              }
            },
          ),
        ),
      ),
    );
  }
}
