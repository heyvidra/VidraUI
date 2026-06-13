import 'package:flutter/widgets.dart';

import '../../../../theme/v_motion_scope.dart';
import '../v_animated_text_data.dart';
import 'animated_text_effect.dart';

/// Soft opacity reveal effect — fades text from ~70% to 100% opacity using
/// VidraUI motion tokens.
///
/// Migrated from `VTypewriterMode.reveal`.
class RevealEffect extends VAnimatedTextEffect {
  const RevealEffect();

  @override
  Widget build(BuildContext context, VAnimatedTextData data) {
    return _RevealEffectWidget(data: data);
  }
}

class _RevealEffectWidget extends StatefulWidget {
  const _RevealEffectWidget({required this.data});

  final VAnimatedTextData data;

  @override
  State<_RevealEffectWidget> createState() => _RevealEffectWidgetState();
}

class _RevealEffectWidgetState extends State<_RevealEffectWidget>
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
      _startReveal();
    }
  }

  void _startReveal() {
    _controller.duration = VMotionResolver.duration(
      context,
      widget.data.motion,
    );
    _controller.forward(from: 0.0);
    widget.data.onComplete?.call();
  }

  @override
  void didUpdateWidget(_RevealEffectWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.data.text != widget.data.text) {
      _startReveal();
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
          opacity: 0.7 + (_animation.value * 0.3),
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
