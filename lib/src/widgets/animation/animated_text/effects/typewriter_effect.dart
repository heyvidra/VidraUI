import 'dart:async';
import 'package:flutter/widgets.dart';

import '../v_animated_text_data.dart';
import 'animated_text_effect.dart';

/// Letter-by-letter typing effect with optional blinking cursor.
///
/// Supports streaming optimisation: when text additions are appended
/// dynamically (e.g. streaming LLM responses), the typing effect continues
/// smoothly from the prefix instead of restarting.
///
/// Migrated from `VTypewriterMode.typewriter`.
class TypewriterEffect extends VAnimatedTextEffect {
  const TypewriterEffect();

  @override
  Widget build(BuildContext context, VAnimatedTextData data) {
    return _TypewriterEffectWidget(data: data);
  }
}

class _TypewriterEffectWidget extends StatefulWidget {
  const _TypewriterEffectWidget({required this.data});

  final VAnimatedTextData data;

  @override
  State<_TypewriterEffectWidget> createState() =>
      _TypewriterEffectWidgetState();
}

class _TypewriterEffectWidgetState extends State<_TypewriterEffectWidget> {
  String _typedText = '';
  Timer? _typeTimer;
  int _charIndex = 0;
  bool _cursorVisible = true;
  Timer? _cursorBlinkTimer;
  bool _initialised = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialised) {
      _initialised = true;
      _startTypewriter(0);
      if (widget.data.showCursor) {
        _startCursorBlink();
      }
    }
  }

  void _startCursorBlink() {
    _cursorBlinkTimer?.cancel();
    _cursorBlinkTimer =
        Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (mounted) {
        setState(() {
          _cursorVisible = !_cursorVisible;
        });
      }
    });
  }

  void _startTypewriter(int startIndex) {
    _typeTimer?.cancel();
    _charIndex = startIndex;
    final targetText = widget.data.text;

    if (_charIndex >= targetText.length) {
      setState(() {
        _typedText = targetText;
      });
      widget.data.onComplete?.call();
      return;
    }

    _typeTimer = Timer.periodic(widget.data.speed, (timer) {
      if (!mounted) return;
      if (_charIndex < targetText.length) {
        setState(() {
          _charIndex++;
          _typedText = targetText.substring(0, _charIndex);
        });
      } else {
        _typeTimer?.cancel();
        widget.data.onComplete?.call();
      }
    });
  }

  @override
  void didUpdateWidget(_TypewriterEffectWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.data.text != widget.data.text) {
      // Streaming optimisation: if the new text starts with the old text,
      // continue typing from where we left off.
      if (widget.data.text.startsWith(oldWidget.data.text)) {
        _startTypewriter(oldWidget.data.text.length);
      } else {
        _startTypewriter(0);
      }
    }

    if (widget.data.showCursor != oldWidget.data.showCursor) {
      if (widget.data.showCursor) {
        _startCursorBlink();
      } else {
        _cursorBlinkTimer?.cancel();
        _cursorBlinkTimer = null;
      }
    }
  }

  @override
  void dispose() {
    _typeTimer?.cancel();
    _cursorBlinkTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cursorColor = widget.data.cursorColor!;

    // Cursor visibility logic:
    // - During typing: cursor is always solid (showCursor=true)
    // - After typing completes: cursor blinks via _cursorVisible
    // - showCursor=false: cursor is always transparent
    // The TextSpan is ALWAYS present so layout metrics stay constant.
    final Color effectiveCursorColor;
    if (!widget.data.showCursor) {
      effectiveCursorColor = cursorColor.withValues(alpha: 0);
    } else if (_charIndex < widget.data.text.length) {
      effectiveCursorColor = cursorColor;
    } else {
      effectiveCursorColor =
          _cursorVisible ? cursorColor : cursorColor.withValues(alpha: 0);
    }

    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: _typedText,
            style: widget.data.style,
          ),
          // Always present — prevents relayout on each blink tick
          TextSpan(
            text: widget.data.cursorChar,
            style: widget.data.style.copyWith(color: effectiveCursorColor),
          ),
        ],
      ),
      textAlign: widget.data.textAlign,
      maxLines: widget.data.maxLines,
      overflow: widget.data.overflow,
      softWrap: widget.data.softWrap,
    );
  }
}
