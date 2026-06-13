import 'package:flutter/widgets.dart';

import '../../foundation/semantic_tokens.dart';
import '../../foundation/state.dart';
import 'component_token_utils.dart';

/// Component-level tokens for switches.
@immutable
class VSwitchTokens {
  factory VSwitchTokens.fromColors(VColors colors) {
    return VSwitchTokens(
      trackBackground: VStateProperty.resolveWith(
        normal: colors.border,
        hovered: colors.borderStrong,
        pressed: colors.actionPrimary,
        disabled: colors.surfaceElevated,
      ),
      thumbBackground: colors.actionPrimaryText,
      focusRing: colors.focusRing,
    );
  }

  const VSwitchTokens({
    required this.trackBackground,
    required this.thumbBackground,
    required this.focusRing,
  });

  final WidgetStateProperty<Color> trackBackground;
  final Color thumbBackground;
  final Color focusRing;

  static VSwitchTokens lerp(VSwitchTokens a, VSwitchTokens b, double t) {
    return VSwitchTokens(
      trackBackground:
          lerpComponentTokenStateColor(a.trackBackground, b.trackBackground, t),
      thumbBackground:
          lerpComponentTokenColor(a.thumbBackground, b.thumbBackground, t),
      focusRing: lerpComponentTokenColor(a.focusRing, b.focusRing, t),
    );
  }

  VSwitchTokens copyWith({
    WidgetStateProperty<Color>? trackBackground,
    Color? thumbBackground,
    Color? focusRing,
  }) {
    return VSwitchTokens(
      trackBackground: trackBackground ?? this.trackBackground,
      thumbBackground: thumbBackground ?? this.thumbBackground,
      focusRing: focusRing ?? this.focusRing,
    );
  }
}
