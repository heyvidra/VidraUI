import 'package:flutter/widgets.dart';

import '../../theme/v_theme.dart';

/// Internal shared layout for control + label rows.
///
/// Not exported from the widget barrel. Used by VCheckbox, VRadio, and
/// similar components to guarantee consistent vertical alignment.
class VControlRow extends StatelessWidget {
  const VControlRow({
    super.key,
    required this.control,
    required this.label,
    this.gap,
    this.enabled = true,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  });

  final Widget control;
  final Widget label;
  final double? gap;
  final bool enabled;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);
    final effectiveGap = gap ?? theme.spacing.sm;

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: crossAxisAlignment,
      children: [
        control,
        SizedBox(width: effectiveGap),
        Flexible(
          child: DefaultTextStyle.merge(
            style: TextStyle(
              color: enabled ? theme.colors.text : theme.colors.textDisabled,
            ),
            child: label,
          ),
        ),
      ],
    );
  }
}
