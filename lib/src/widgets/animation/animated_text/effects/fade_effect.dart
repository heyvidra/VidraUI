import 'package:flutter/widgets.dart';

import '../../../../theme/v_motion_scope.dart';
import '../v_animated_text_data.dart';
import 'animated_text_effect.dart';

/// Standard fade-in effect — smoothly transitions text opacity from 0 to 1
/// using VidraUI motion tokens.
class FadeEffect extends VAnimatedTextEffect {
  const FadeEffect();

  @override
  Widget build(BuildContext context, VAnimatedTextData data) {
    return _FadeEffectWidget(data: data);
  }
}

class _FadeEffectWidget extends StatefulWidget {
  const _FadeEffectWidget({required this.data});

  final VAnimatedTextData data;

  @override
  State<_FadeEffectWidget> createState() => _FadeEffectWidgetState();
}

class _FadeEffectWidgetState extends State<_FadeEffectWidget>
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
      _startFade();
    }
  }

  void _startFade() {
    _controller.duration = VMotionResolver.duration(
      context,
      widget.data.motion,
    );
    _controller.forward(from: 0.0).then((_) {
      widget.data.onComplete?.call();
    });
  }

  @override
  void didUpdateWidget(_FadeEffectWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.data.text != widget.data.text) {
      _startFade();
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
    );
  }
}
