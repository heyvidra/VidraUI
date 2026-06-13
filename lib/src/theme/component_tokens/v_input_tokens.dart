import 'package:flutter/widgets.dart';

import '../../foundation/semantic_tokens.dart';
import 'component_token_utils.dart';

/// Component-level tokens for text inputs.
@immutable
class VInputTokens {
  factory VInputTokens.fromColors(VColors colors) {
    return VInputTokens(
      background: colors.surface,
      border: colors.border,
      borderFocused: colors.actionPrimary,
      borderError: colors.danger,
      text: colors.text,
      placeholder: colors.textMuted,
      focusRing: colors.focusRing,
    );
  }

  const VInputTokens({
    required this.background,
    required this.border,
    required this.borderFocused,
    required this.borderError,
    required this.text,
    required this.placeholder,
    required this.focusRing,
  });

  final Color background;
  final Color border;
  final Color borderFocused;
  final Color borderError;
  final Color text;
  final Color placeholder;
  final Color focusRing;

  static VInputTokens lerp(VInputTokens a, VInputTokens b, double t) {
    return VInputTokens(
      background: lerpComponentTokenColor(a.background, b.background, t),
      border: lerpComponentTokenColor(a.border, b.border, t),
      borderFocused:
          lerpComponentTokenColor(a.borderFocused, b.borderFocused, t),
      borderError: lerpComponentTokenColor(a.borderError, b.borderError, t),
      text: lerpComponentTokenColor(a.text, b.text, t),
      placeholder: lerpComponentTokenColor(a.placeholder, b.placeholder, t),
      focusRing: lerpComponentTokenColor(a.focusRing, b.focusRing, t),
    );
  }

  VInputTokens copyWith({
    Color? background,
    Color? border,
    Color? borderFocused,
    Color? borderError,
    Color? text,
    Color? placeholder,
    Color? focusRing,
  }) {
    return VInputTokens(
      background: background ?? this.background,
      border: border ?? this.border,
      borderFocused: borderFocused ?? this.borderFocused,
      borderError: borderError ?? this.borderError,
      text: text ?? this.text,
      placeholder: placeholder ?? this.placeholder,
      focusRing: focusRing ?? this.focusRing,
    );
  }
}
