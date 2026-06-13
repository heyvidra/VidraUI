import 'dart:math' as math;
import 'package:flutter/widgets.dart';

import '../v_animated_text_data.dart';
import 'animated_text_effect.dart';

/// Per-character sine-wave vertical oscillation.
///
/// Each character oscillates with a phase offset proportional to its index,
/// creating a flowing wave pattern. Uses a single repeating
/// [AnimationController] — no per-character controllers or layout shifts.
///
/// The oscillation is purely via [Transform.translate] so the text layout
/// remains stable throughout the animation.
class WavyEffect extends VAnimatedTextEffect {
  const WavyEffect();

  @override
  Widget build(BuildContext context, VAnimatedTextData data) {
    return _WavyEffectWidget(data: data);
  }
}

class _WavyEffectWidget extends StatefulWidget {
  const _WavyEffectWidget({required this.data});

  final VAnimatedTextData data;

  @override
  State<_WavyEffectWidget> createState() => _WavyEffectWidgetState();
}

class _WavyEffectWidgetState extends State<_WavyEffectWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  bool _initialised = false;

  /// Amplitude in logical pixels.
  static const double _amplitude = 4.0;

  /// Phase offset per character index.
  static const double _phasePerChar = 0.15;

  /// Duration for one full wave cycle. Derived from the motion token but
  /// lengthened to feel natural for a repeating wave (~2× normal duration).
  static const Duration _defaultWaveCycle = Duration(milliseconds: 800);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialised) {
      _initialised = true;
      _startWave();
    }
  }

  void _startWave() {
    // Derive cycle duration from the motion token's duration, with a floor.
    final baseDuration = widget.data.motion.duration;
    _controller.duration = baseDuration.inMilliseconds < 200
        ? _defaultWaveCycle
        : baseDuration * 2;
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final text = widget.data.text;
    final style = widget.data.style;

    if (text.isEmpty) return const SizedBox.shrink();

    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          final t = _controller.value;

          // Build individual character widgets with per-char translation.
          // We use per-character Text widgets because Text.rich TextSpans
          // cannot be individually transformed.
          return Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: List.generate(text.length, (i) {
              final offset =
                  math.sin((t + i * _phasePerChar) * 2 * math.pi) * _amplitude;
              return Transform.translate(
                offset: Offset(0, offset),
                child: Text(
                  text[i],
                  style: style,
                  textAlign: widget.data.textAlign,
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
