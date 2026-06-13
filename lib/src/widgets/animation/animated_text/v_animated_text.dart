import 'package:flutter/widgets.dart';

import '../../../foundation/motion.dart';
import '../../../theme/v_motion_scope.dart';
import '../../../theme/v_theme.dart';
import '../../basic/v_text.dart';
import 'effects/animated_text_effect.dart';
import 'v_animated_text_data.dart';

export 'effects/animated_text_effect.dart' show VAnimatedTextEffect;
export 'v_animated_text_data.dart' show VTextAnimationEffect, VAnimatedTextData;

/// A unified animated text component that delegates animation logic to
/// a pluggable [VAnimatedTextEffect].
///
/// Future animation styles are added by creating a new effect file and
/// registering it in [VAnimatedTextEffect.from] — no changes to this
/// widget are required.
///
/// ```dart
/// VAnimatedText(
///   'Hello World',
///   effect: VTextAnimationEffect.typewriter,
/// )
/// ```
class VAnimatedText extends StatelessWidget {
  const VAnimatedText(
    this.text, {
    super.key,
    this.effect = VTextAnimationEffect.typewriter,
    this.customEffect,
    this.variant = VTextVariant.body,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap = true,
    this.motion,
    this.speed = const Duration(milliseconds: 35),
    this.showCursor = false,
    this.cursorChar = '▋',
    this.cursorColor,
    this.onComplete,
  });

  /// The target text to animate.
  final String text;

  /// The animation effect to apply. Defaults to [VTextAnimationEffect.typewriter].
  ///
  /// Ignored when [customEffect] is provided.
  final VTextAnimationEffect effect;

  /// A custom [VAnimatedTextEffect] instance.
  ///
  /// When non-null, this takes precedence over [effect]. Use this to supply
  /// a user-defined animation strategy without modifying the library.
  ///
  /// ```dart
  /// VAnimatedText(
  ///   'Hello',
  ///   customEffect: MyRainbowEffect(),
  /// )
  /// ```
  final VAnimatedTextEffect? customEffect;

  /// The text variant from typography.
  final VTextVariant variant;

  /// Optional text colour override.
  final Color? color;

  /// How the text should be aligned horizontally.
  final TextAlign? textAlign;

  /// Optional maximum number of lines.
  final int? maxLines;

  /// How visual overflow should be handled.
  final TextOverflow? overflow;

  /// Whether the text should break at soft line breaks.
  final bool softWrap;

  /// Visual transition motion tokens. If null, resolves from [VTheme.motion.control].
  final VMotionSpec? motion;

  /// Duration between character strokes in typewriter mode.
  final Duration speed;

  /// Whether to show a blinking cursor at the end in typewriter mode.
  final bool showCursor;

  /// The character to use for the cursor.
  final String cursorChar;

  /// Optional custom cursor colour.
  final Color? cursorColor;

  /// Callback fired when the animation is completely finished.
  final VoidCallback? onComplete;

  VAnimatedTextData _buildData(BuildContext context) {
    final theme = VTheme.of(context);
    final baseStyle = resolveVariantStyle(theme, variant);

    final effectiveStyle = color != null
        ? baseStyle.copyWith(color: color)
        : baseStyle.copyWith(color: theme.colors.text);

    final spec = motion ?? VMotionScope.of(context).control;

    return VAnimatedTextData(
      text: text,
      style: effectiveStyle,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      motion: spec,
      speed: speed,
      showCursor: showCursor,
      cursorChar: cursorChar,
      cursorColor: cursorColor ?? color ?? theme.colors.actionPrimary,
      onComplete: onComplete,
    );
  }

  @override
  Widget build(BuildContext context) {
    final data = _buildData(context);

    // Honour the OS-level "remove animations" accessibility setting.
    if (MediaQuery.maybeDisableAnimationsOf(context) == true) {
      return Text(
        data.text,
        style: data.style,
        textAlign: data.textAlign,
        maxLines: data.maxLines,
        overflow: data.overflow,
        softWrap: data.softWrap,
      );
    }

    final resolvedEffect = customEffect ?? VAnimatedTextEffect.from(effect);
    return resolvedEffect.build(context, data);
  }
}
