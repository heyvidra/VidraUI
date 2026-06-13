import 'package:flutter/widgets.dart';

import '../v_animated_text_data.dart';
import 'bounce_effect.dart';
import 'fade_effect.dart';
import 'flicker_effect.dart';
import 'reveal_effect.dart';
import 'scale_effect.dart';
import 'scramble_effect.dart';
import 'typewriter_effect.dart';
import 'wavy_effect.dart';

/// Abstract base for all text animation strategies.
///
/// Each concrete effect is a self-contained file managing its own animation
/// state (controllers, timers, etc.). New effects are added by:
///
/// 1. Creating a new effect file in `effects/`
/// 2. Subclassing [VAnimatedTextEffect]
/// 3. Adding a case in the [from] factory
///
/// This follows the Open-Closed Principle: the core [VAnimatedText] widget
/// never needs to change when a new animation style is introduced.
abstract class VAnimatedTextEffect {
  const VAnimatedTextEffect();

  /// Returns the concrete [VAnimatedTextEffect] for the given [effect] enum
  /// value.
  ///
  /// This is the single registration point for new effects — no other source
  /// file needs to change when a new animation type is added.
  factory VAnimatedTextEffect.from(VTextAnimationEffect effect) =>
      switch (effect) {
        VTextAnimationEffect.reveal => const RevealEffect(),
        VTextAnimationEffect.typewriter => const TypewriterEffect(),
        VTextAnimationEffect.fade => const FadeEffect(),
        VTextAnimationEffect.scale => const ScaleEffect(),
        VTextAnimationEffect.wavy => const WavyEffect(),
        VTextAnimationEffect.scramble => const ScrambleEffect(),
        VTextAnimationEffect.flicker => const FlickerEffect(),
        VTextAnimationEffect.bounce => const BounceEffect(),
      };

  /// Builds the animated widget tree for this effect.
  ///
  /// The returned widget is typically a [StatefulWidget] that manages its
  /// own [AnimationController] and timer lifecycle. [VAnimatedText] is
  /// intentionally a [StatelessWidget] — all animation state lives in the
  /// concrete effect implementations.
  Widget build(BuildContext context, VAnimatedTextData data);
}
