import 'package:flutter/widgets.dart';

import '../../foundation/semantic_tokens.dart';
import '../../foundation/state.dart';
import 'component_token_utils.dart';

/// Component-level tokens for checkboxes.
@immutable
class VCheckboxTokens {
  factory VCheckboxTokens.fromColors(VColors colors) {
    return VCheckboxTokens(
      uncheckedBackground: VStateProperty.resolveWith(
        normal: colors.surface,
        hovered: colors.surfaceHover,
        pressed: colors.surfaceElevated,
        disabled: colors.surfaceElevated,
      ),
      uncheckedBorder: VStateProperty.resolveWith(
        normal: colors.border,
        hovered: colors.borderStrong,
        focused: colors.focusRing,
        disabled: colors.border,
      ),
      checkedBackground: VStateProperty.resolveWith(
        normal: colors.actionPrimary,
        hovered: colors.actionPrimaryHover,
        pressed: colors.actionPrimaryPressed,
        disabled: colors.surfaceElevated,
      ),
      checkedBorder: VStateProperty.all(const Color(0x00000000)),
      checkmark: colors.actionPrimaryText,
      focusRing: colors.focusRing,
    );
  }

  const VCheckboxTokens({
    required this.uncheckedBackground,
    required this.uncheckedBorder,
    required this.checkedBackground,
    required this.checkedBorder,
    required this.checkmark,
    required this.focusRing,
  });

  final WidgetStateProperty<Color> uncheckedBackground;
  final WidgetStateProperty<Color> uncheckedBorder;
  final WidgetStateProperty<Color> checkedBackground;
  final WidgetStateProperty<Color> checkedBorder;
  final Color checkmark;
  final Color focusRing;

  static VCheckboxTokens lerp(VCheckboxTokens a, VCheckboxTokens b, double t) {
    return VCheckboxTokens(
      uncheckedBackground: lerpComponentTokenStateColor(
          a.uncheckedBackground, b.uncheckedBackground, t),
      uncheckedBorder:
          lerpComponentTokenStateColor(a.uncheckedBorder, b.uncheckedBorder, t),
      checkedBackground: lerpComponentTokenStateColor(
          a.checkedBackground, b.checkedBackground, t),
      checkedBorder:
          lerpComponentTokenStateColor(a.checkedBorder, b.checkedBorder, t),
      checkmark: lerpComponentTokenColor(a.checkmark, b.checkmark, t),
      focusRing: lerpComponentTokenColor(a.focusRing, b.focusRing, t),
    );
  }

  VCheckboxTokens copyWith({
    WidgetStateProperty<Color>? uncheckedBackground,
    WidgetStateProperty<Color>? uncheckedBorder,
    WidgetStateProperty<Color>? checkedBackground,
    WidgetStateProperty<Color>? checkedBorder,
    Color? checkmark,
    Color? focusRing,
  }) {
    return VCheckboxTokens(
      uncheckedBackground: uncheckedBackground ?? this.uncheckedBackground,
      uncheckedBorder: uncheckedBorder ?? this.uncheckedBorder,
      checkedBackground: checkedBackground ?? this.checkedBackground,
      checkedBorder: checkedBorder ?? this.checkedBorder,
      checkmark: checkmark ?? this.checkmark,
      focusRing: focusRing ?? this.focusRing,
    );
  }
}
