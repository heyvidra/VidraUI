import 'package:flutter/widgets.dart';

import '../../../foundation/motion.dart';

/// The animation effect applied by [VAnimatedText].
///
/// Each value maps to a concrete [VAnimatedTextEffect] implementation.
enum VTextAnimationEffect {
  /// Soft opacity reveal using motion tokens when text changes.
  reveal,

  /// Letter-by-letter typing animation with optional blinking cursor.
  typewriter,

  /// Simple fade-in from 0 to 1 opacity.
  fade,

  /// Combined scale (0.95 → 1.0) and fade (0 → 1) entrance.
  scale,

  /// Per-character sine-wave vertical oscillation.
  wavy,

  /// Character scramble gradually converging to the target text.
  scramble,

  /// Neon-like flickering opacity pattern, repeats indefinitely.
  flicker,

  /// Bounce entrance — translates down then springs up.
  bounce,
}

/// Immutable configuration object consumed by all [VAnimatedTextEffect]
/// implementations.
///
/// Centralising text properties and motion tokens here prevents parameter
/// drift across effects as new animation types are added.
@immutable
class VAnimatedTextData {
  const VAnimatedTextData({
    required this.text,
    required this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap = true,
    required this.motion,
    this.speed = const Duration(milliseconds: 35),
    this.showCursor = false,
    this.cursorChar = '▋',
    this.cursorColor,
    this.onComplete,
  });

  /// The target text to animate.
  final String text;

  /// Resolved [TextStyle] (typography + user overrides already merged).
  final TextStyle style;

  /// How the text should be aligned horizontally.
  final TextAlign? textAlign;

  /// Optional maximum number of lines.
  final int? maxLines;

  /// How visual overflow should be handled.
  final TextOverflow? overflow;

  /// Whether the text should break at soft line breaks.
  final bool softWrap;

  /// Motion spec resolved from the theme / user override.
  final VMotionSpec motion;

  // ---------------------------------------------------------------------------
  // Effect-specific options — honoured by effects that recognise them
  // ---------------------------------------------------------------------------

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

  /// Creates a copy with selected fields replaced.
  VAnimatedTextData copyWith({
    String? text,
    TextStyle? style,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    bool? softWrap,
    VMotionSpec? motion,
    Duration? speed,
    bool? showCursor,
    String? cursorChar,
    Color? cursorColor,
    VoidCallback? onComplete,
  }) {
    return VAnimatedTextData(
      text: text ?? this.text,
      style: style ?? this.style,
      textAlign: textAlign ?? this.textAlign,
      maxLines: maxLines ?? this.maxLines,
      overflow: overflow ?? this.overflow,
      softWrap: softWrap ?? this.softWrap,
      motion: motion ?? this.motion,
      speed: speed ?? this.speed,
      showCursor: showCursor ?? this.showCursor,
      cursorChar: cursorChar ?? this.cursorChar,
      cursorColor: cursorColor ?? this.cursorColor,
      onComplete: onComplete ?? this.onComplete,
    );
  }
}
