import 'dart:math' as math;
import 'package:flutter/widgets.dart';

import '../v_animated_text_data.dart';
import 'animated_text_effect.dart';

/// Neon-like flickering opacity effect — text fades between random opacity
/// levels creating an ambient "sign" or "neon" feel.
///
/// Uses a single repeating [AnimationController] with a pre-computed
/// opacity sequence to avoid per-frame random calls inside build.
/// The sequence length and values are deterministic after initialisation,
/// preventing excessive rebuilds.
class FlickerEffect extends VAnimatedTextEffect {
  const FlickerEffect();

  @override
  Widget build(BuildContext context, VAnimatedTextData data) {
    return _FlickerEffectWidget(data: data);
  }
}

class _FlickerEffectWidget extends StatefulWidget {
  const _FlickerEffectWidget({required this.data});

  final VAnimatedTextData data;

  @override
  State<_FlickerEffectWidget> createState() => _FlickerEffectWidgetState();
}

class _FlickerEffectWidgetState extends State<_FlickerEffectWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late List<double> _opacitySequence;
  bool _initialised = false;

  /// Number of opacity keyframes per animation cycle.
  static const int _sequenceLength = 12;

  /// Minimum opacity during flicker dips.
  static const double _minOpacity = 0.55;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _opacitySequence = _generateSequence();
  }

  List<double> _generateSequence() {
    final random = math.Random(42); // Seeded for stable sequences
    return List.generate(_sequenceLength, (_) {
      // Generate values biased toward 1.0 with occasional dips.
      return _minOpacity + random.nextDouble() * (1.0 - _minOpacity);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialised) {
      _initialised = true;
      _startFlicker();
    }
  }

  void _startFlicker() {
    final baseDuration = widget.data.motion.duration;
    // Each flicker cycle takes ~3× the base motion duration so it doesn't
    // feel frantic.
    _controller.duration = baseDuration * 3;
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Interpolates between the pre-computed opacity keyframes based on the
  /// controller's progress through the sequence.
  double _resolveOpacity() {
    if (_opacitySequence.isEmpty) return 1.0;

    // Map controller value [0, 1] to a position in the sequence.
    final position = _controller.value * (_opacitySequence.length - 1);
    final index = position.floor();
    final frac = position - index;

    final a = _opacitySequence[index];
    final b = index + 1 < _opacitySequence.length
        ? _opacitySequence[index + 1]
        : _opacitySequence[0];

    return a + (b - a) * frac;
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return Opacity(
            opacity: _resolveOpacity(),
            child: Text(
              widget.data.text,
              style: widget.data.style,
              textAlign: widget.data.textAlign,
              maxLines: widget.data.maxLines,
              overflow: widget.data.overflow,
              softWrap: widget.data.softWrap,
            ),
          );
        },
      ),
    );
  }
}
