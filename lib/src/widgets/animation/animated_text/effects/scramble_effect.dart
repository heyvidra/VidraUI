import 'dart:math' as math;
import 'package:flutter/widgets.dart';

import '../v_animated_text_data.dart';
import 'animated_text_effect.dart';

/// Character-scramble effect — random characters gradually converge to the
/// target text.
///
/// Behaviour:
/// - ASCII letters scramble through random letters.
/// - ASCII digits scramble through random digits.
/// - Non-ASCII characters are preserved as-is.
/// - After the animation completes, the target text is displayed stably.
///
/// Uses a single [AnimationController] with periodic updates — each tick
/// randomly mutates unresolved characters with decreasing probability
/// as the animation progresses.
class ScrambleEffect extends VAnimatedTextEffect {
  const ScrambleEffect();

  @override
  Widget build(BuildContext context, VAnimatedTextData data) {
    return _ScrambleEffectWidget(data: data);
  }
}

class _ScrambleEffectWidget extends StatefulWidget {
  const _ScrambleEffectWidget({required this.data});

  final VAnimatedTextData data;

  @override
  State<_ScrambleEffectWidget> createState() => _ScrambleEffectWidgetState();
}

class _ScrambleEffectWidgetState extends State<_ScrambleEffectWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  String _displayText = '';
  bool _initialised = false;

  static const _letters =
      'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
  static const _digits = '0123456789';

  final _random = math.Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _controller.addListener(_onTick);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialised) {
      _initialised = true;
      _startScramble();
    }
  }

  void _startScramble() {
    _displayText = _buildScrambledSeed(widget.data.text);
    _controller.duration = widget.data.motion.duration;
    _controller.forward(from: 0.0).then((_) {
      // Ensure the final text is exactly the target.
      setState(() {
        _displayText = widget.data.text;
      });
      widget.data.onComplete?.call();
    });
  }

  String _buildScrambledSeed(String target) {
    final buffer = StringBuffer();
    for (var i = 0; i < target.length; i++) {
      buffer.write(_scrambleChar(target[i]));
    }
    return buffer.toString();
  }

  String _scrambleChar(String char) {
    final code = char.codeUnitAt(0);
    if (code >= 65 && code <= 90) {
      // Uppercase letter
      return _letters[_random.nextInt(26)];
    }
    if (code >= 97 && code <= 122) {
      // Lowercase letter
      return _letters[26 + _random.nextInt(26)];
    }
    if (code >= 48 && code <= 57) {
      // Digit
      return _digits[_random.nextInt(10)];
    }
    // Preserve non-ASCII characters as-is.
    return char;
  }

  void _onTick() {
    final t = _controller.value;
    final target = widget.data.text;
    final buffer = StringBuffer();

    // Probability of mutation decreases as t → 1.
    // At t=0.5, ~50% of non-matching chars mutate.
    // At t=0.9, ~10% of non-matching chars mutate.
    final mutationChance = ((1.0 - t) * 0.8).clamp(0.0, 1.0);

    for (var i = 0; i < target.length; i++) {
      if (i >= _displayText.length) {
        buffer.write(target[i]);
      } else if (_displayText[i] == target[i]) {
        // Already converged — keep the correct character.
        buffer.write(target[i]);
      } else if (_random.nextDouble() < mutationChance) {
        // Mutate this character.
        buffer.write(_scrambleChar(target[i]));
      } else {
        // Keep the current scrambled character.
        buffer.write(_displayText[i]);
      }
    }

    setState(() {
      _displayText = buffer.toString();
    });
  }

  @override
  void didUpdateWidget(_ScrambleEffectWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.data.text != widget.data.text) {
      _startScramble();
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onTick);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _displayText,
      style: widget.data.style,
      textAlign: widget.data.textAlign,
      maxLines: widget.data.maxLines,
      overflow: widget.data.overflow,
      softWrap: widget.data.softWrap,
    );
  }
}
