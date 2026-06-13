import 'package:flutter/widgets.dart';

import '../../../../theme/v_motion_scope.dart';
import '../v_animated_text_data.dart';
import 'animated_text_effect.dart';

/// Bounce entrance effect — text translates down then springs up into
/// position using an elastic-out curve. Combined with a simultaneous
/// fade-in from 0 → 1 opacity.
///
/// Suitable for chat messages, notifications, or playful UI moments.
class BounceEffect extends VAnimatedTextEffect {
  const BounceEffect();

  @override
  Widget build(BuildContext context, VAnimatedTextData data) {
    return _BounceEffectWidget(data: data);
  }
}

class _BounceEffectWidget extends StatefulWidget {
  const _BounceEffectWidget({required this.data});

  final VAnimatedTextData data;

  @override
  State<_BounceEffectWidget> createState() => _BounceEffectWidgetState();
}

class _BounceEffectWidgetState extends State<_BounceEffectWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late Animation<double> _animation;
  bool _initialised = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );
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
  void didUpdateWidget(_BounceEffectWidget oldWidget) {
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
        final translateY = 12.0 * (1.0 - _animation.value);

        return Opacity(
          opacity: _animation.value.clamp(0.0, 1.0),
          child: Transform.translate(
            offset: Offset(0, translateY),
            child: RepaintBoundary(
              child: Text(
                widget.data.text,
                style: widget.data.style,
                textAlign: widget.data.textAlign,
                maxLines: widget.data.maxLines,
                overflow: widget.data.overflow,
                softWrap: widget.data.softWrap,
              ),
            ),
          ),
        );
      },
    );
  }
}
