import 'package:flutter/widgets.dart';

import '../../foundation/semantic_tokens.dart';
import '../../foundation/state.dart';
import 'component_token_utils.dart';

/// Component-level tokens for sliders.
@immutable
class VSliderTokens {
  factory VSliderTokens.fromColors(VColors colors) {
    return VSliderTokens(
      trackBackground: VStateProperty.resolveWith(
        normal: colors.border,
        disabled: colors.textDisabled,
      ),
      trackActive: VStateProperty.resolveWith(
        normal: colors.actionPrimary,
        disabled: colors.textDisabled,
      ),
      thumbBackground: VStateProperty.resolveWith(
        normal: colors.actionPrimary,
        disabled: colors.textDisabled,
      ),
      focusRing: colors.focusRing,
    );
  }

  const VSliderTokens({
    required this.trackBackground,
    required this.trackActive,
    required this.thumbBackground,
    required this.focusRing,
  });

  final WidgetStateProperty<Color> trackBackground;
  final WidgetStateProperty<Color> trackActive;
  final WidgetStateProperty<Color> thumbBackground;
  final Color focusRing;

  static VSliderTokens lerp(VSliderTokens a, VSliderTokens b, double t) {
    return VSliderTokens(
      trackBackground:
          lerpComponentTokenStateColor(a.trackBackground, b.trackBackground, t),
      trackActive:
          lerpComponentTokenStateColor(a.trackActive, b.trackActive, t),
      thumbBackground:
          lerpComponentTokenStateColor(a.thumbBackground, b.thumbBackground, t),
      focusRing: lerpComponentTokenColor(a.focusRing, b.focusRing, t),
    );
  }

  VSliderTokens copyWith({
    WidgetStateProperty<Color>? trackBackground,
    WidgetStateProperty<Color>? trackActive,
    WidgetStateProperty<Color>? thumbBackground,
    Color? focusRing,
  }) {
    return VSliderTokens(
      trackBackground: trackBackground ?? this.trackBackground,
      trackActive: trackActive ?? this.trackActive,
      thumbBackground: thumbBackground ?? this.thumbBackground,
      focusRing: focusRing ?? this.focusRing,
    );
  }
}
