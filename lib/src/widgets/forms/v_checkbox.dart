import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../theme/v_appearance_box.dart';
import '../../theme/v_appearance_scope.dart';
import '../../theme/v_component_themes.g.dart';
import '../../theme/v_theme.dart';
import '../basic/v_text.dart';
import '../interaction/v_interactive.dart';
import 'v_control_row.dart';

/// An accessible, theme-aware checkbox.
///
/// Toggles [checked] via [VInteractive]. Reads [VCheckboxTokens] from the
/// current [VTheme]. Supports keyboard activation.
class VCheckbox extends StatelessWidget {
  const VCheckbox({
    super.key,
    required this.checked,
    this.onChanged,
    this.label,
    this.semanticLabel,
    this.enabled = true,
    this.tristate = false,
    this.autofocus = false,
    this.focusNode,
  });

  /// Whether the checkbox is checked, unchecked, or indeterminate.
  final bool? checked;

  /// Called when the checkbox is toggled.
  final ValueChanged<bool?>? onChanged;

  /// An optional label displayed to the right of the checkbox.
  final String? label;

  /// Semantic label for accessibility.
  final String? semanticLabel;

  /// When false, the checkbox is greyed out and non-interactive.
  final bool enabled;

  /// Whether the checkbox cycles through three states (false -> true -> null -> false).
  final bool tristate;

  /// Whether to focus this checkbox initially.
  final bool autofocus;

  /// An optional external focus node.
  final FocusNode? focusNode;

  void _handleTap() {
    if (onChanged == null) return;
    switch (checked) {
      case null:
        onChanged!(true);
      case true:
        onChanged!(false);
      case false:
        onChanged!(tristate ? null : true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);
    final tokens = VCheckboxTheme.of(context) ?? theme.components.checkbox;

    return Semantics(
      checked: checked == true,
      mixed: checked == null ? true : null,
      enabled: enabled,
      label: semanticLabel ?? label,
      child: Actions(
        actions: <Type, Action<Intent>>{
          ActivateIntent: CallbackAction<ActivateIntent>(
            onInvoke: (_) {
              if (enabled) _handleTap();
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
            onTap: onChanged != null ? _handleTap : null,
            autofocus: autofocus,
            focusNode: focusNode,
            builder: (context, states) {
              final isCheckedOrIndeterminate = checked != false;
              final background = isCheckedOrIndeterminate
                  ? tokens.checkedBackground.resolve(states)
                  : tokens.uncheckedBackground.resolve(states);
              final border = isCheckedOrIndeterminate
                  ? tokens.checkedBorder.resolve(states)
                  : tokens.uncheckedBorder.resolve(states);
              final focused = states.contains(WidgetState.focused);

              final effectiveStates =
                  isCheckedOrIndeterminate ? {...states, WidgetState.selected} : states;

              final appearance = VAppearanceScope.of(context);
              final resolvedBg =
                  appearance?.background(background, effectiveStates) ??
                      background;
              final resolvedBorder =
                  appearance?.borderColor(border, effectiveStates) ?? border;
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
                  borderRadius: BorderRadius.circular(resolvedRadius),
                  child: AnimatedContainer(
                    duration: theme.motion.control.duration,
                    curve: theme.motion.control.curve,
                    width: theme.sizes.checkboxSize,
                    height: theme.sizes.checkboxSize,
                    decoration: BoxDecoration(
                      color: resolvedBg,
                      borderRadius: BorderRadius.circular(resolvedRadius),
                      border: Border.all(color: resolvedBorder, width: 2),
                      boxShadow: resolvedShadows,
                    ),
                    child: switch (checked) {
                      true => Center(child: _Checkmark(color: tokens.checkmark)),
                      null => Center(child: _IndeterminateDash(color: tokens.checkmark)),
                      false => null,
                    },
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

/// Draws a simple checkmark using [CustomPaint].
class _Checkmark extends StatelessWidget {
  const _Checkmark({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(12, 12),
      painter: _CheckmarkPainter(color: color),
    );
  }
}

class _CheckmarkPainter extends CustomPainter {
  const _CheckmarkPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..moveTo(size.width * 0.2, size.height * 0.55)
      ..lineTo(size.width * 0.4, size.height * 0.75)
      ..lineTo(size.width * 0.8, size.height * 0.3);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_CheckmarkPainter oldDelegate) =>
      color != oldDelegate.color;
}

class _IndeterminateDash extends StatelessWidget {
  const _IndeterminateDash({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(12, 12),
      painter: _IndeterminatePainter(color: color),
    );
  }
}

class _IndeterminatePainter extends CustomPainter {
  const _IndeterminatePainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawLine(
      Offset(size.width * 0.25, size.height * 0.5),
      Offset(size.width * 0.75, size.height * 0.5),
      paint,
    );
  }

  @override
  bool shouldRepaint(_IndeterminatePainter oldDelegate) =>
      color != oldDelegate.color;
}
