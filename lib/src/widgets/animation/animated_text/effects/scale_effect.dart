import 'package:flutter/widgets.dart';

import '../../../../theme/v_motion_scope.dart';
import '../v_animated_text_data.dart';
import 'animated_text_effect.dart';

/// Scale + fade entrance effect — text scales from 0.95 → 1.0 while fading
/// from 0 → 1 opacity. Uses VidraUI motion tokens for timing.
///
/// Ideal for emphasis text — headings, callouts, hero messages.
class ScaleEffect extends VAnimatedTextEffect {
  const ScaleEffect();

  @override
  Widget build(BuildContext context, VAnimatedTextData data) {
    return _ScaleEffectWidget(data: data);
  }
}

class _ScaleEffectWidget extends StatefulWidget {
  const _ScaleEffectWidget({required this.data});

  final VAnimatedTextData data;

  @override
  State<_ScaleEffectWidget> createState() => _ScaleEffectWidgetState();
}

class _ScaleEffectWidgetState extends State<_ScaleEffectWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late Animation<double> _animation;
  bool _initialised = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialised) {
      _initialised = true;
      _startAnimation();
    }
  }

  void _startAnimation() {
    _controller.duration = VMotionResolver.duration(
      context,
      widget.data.motion,
    );
    _controller.forward(from: 0.0).then((_) {
      widget.data.onComplete?.call();
    });
  }

  @override
  void didUpdateWidget(_ScaleEffectWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.data.text != widget.data.text) {
      _startAnimation();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, _) {
        return Opacity(
          opacity: _animation.value,
          child: Transform.scale(
            scale: 0.95 + (_animation.value * 0.05),
            alignment: Alignment.centerLeft,
            child: Text(
              widget.data.text,
              style: widget.data.style,
              textAlign: widget.data.textAlign,
              maxLines: widget.data.maxLines,
              overflow: widget.data.overflow,
              softWrap: widget.data.softWrap,
            ),
          ),
        );
      },
    );
  }
}
