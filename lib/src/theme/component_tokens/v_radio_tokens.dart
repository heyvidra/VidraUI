import 'package:flutter/widgets.dart';

import '../../foundation/semantic_tokens.dart';
import '../../foundation/state.dart';
import 'component_token_utils.dart';

/// Component-level tokens for radio buttons.
@immutable
class VRadioTokens {
  factory VRadioTokens.fromColors(VColors colors) {
    return VRadioTokens(
      uncheckedBackground: VStateProperty.resolveWith(
        normal: colors.surface,
        hovered: colors.surfaceHover,
        disabled: colors.surfaceElevated,
      ),
      uncheckedBorder: VStateProperty.resolveWith(
        normal: colors.border,
        hovered: colors.borderStrong,
        focused: colors.focusRing,
        disabled: colors.border,
      ),
      checkedDot: colors.actionPrimary,
      checkedBorder: colors.actionPrimary,
      focusRing: colors.focusRing,
    );
  }

  const VRadioTokens({
    required this.uncheckedBackground,
    required this.uncheckedBorder,
    required this.checkedDot,
    required this.checkedBorder,
    required this.focusRing,
  });

  final WidgetStateProperty<Color> uncheckedBackground;
  final WidgetStateProperty<Color> uncheckedBorder;
  final Color checkedDot;
  final Color checkedBorder;
  final Color focusRing;

  static VRadioTokens lerp(VRadioTokens a, VRadioTokens b, double t) {
    return VRadioTokens(
      uncheckedBackground: lerpComponentTokenStateColor(
          a.uncheckedBackground, b.uncheckedBackground, t),
      uncheckedBorder:
          lerpComponentTokenStateColor(a.uncheckedBorder, b.uncheckedBorder, t),
      checkedDot: lerpComponentTokenColor(a.checkedDot, b.checkedDot, t),
      checkedBorder:
          lerpComponentTokenColor(a.checkedBorder, b.checkedBorder, t),
      focusRing: lerpComponentTokenColor(a.focusRing, b.focusRing, t),
    );
  }

  VRadioTokens copyWith({
    WidgetStateProperty<Color>? uncheckedBackground,
    WidgetStateProperty<Color>? uncheckedBorder,
    Color? checkedDot,
    Color? checkedBorder,
    Color? focusRing,
  }) {
    return VRadioTokens(
      uncheckedBackground: uncheckedBackground ?? this.uncheckedBackground,
      uncheckedBorder: uncheckedBorder ?? this.uncheckedBorder,
      checkedDot: checkedDot ?? this.checkedDot,
      checkedBorder: checkedBorder ?? this.checkedBorder,
      focusRing: focusRing ?? this.focusRing,
    );
  }
}
