import 'package:flutter/widgets.dart';

import 'v_theme.dart';
import 'v_theme_data.dart';

/// A [Tween] that interpolates between two [VThemeData] instances.
class VThemeDataTween extends Tween<VThemeData> {
  VThemeDataTween({super.begin, super.end});

  @override
  VThemeData lerp(double t) {
    return VThemeData.lerp(begin!, end!, t);
  }
}

/// An animated variant of [VTheme] that smoothly transitions between
/// [VThemeData] values.
///
/// Wrap the widget subtree in [VAnimatedTheme] to animate light/dark
/// theme switches.
class VAnimatedTheme extends ImplicitlyAnimatedWidget {
  const VAnimatedTheme({
    super.key,
    required this.data,
    required this.child,
    super.duration = const Duration(milliseconds: 220),
    super.curve = Curves.easeInOut,
  });

  /// The target theme data.
  final VThemeData data;

  /// The child subtree.
  final Widget child;

  @override
  AnimatedWidgetBaseState<VAnimatedTheme> createState() =>
      _VAnimatedThemeState();
}

class _VAnimatedThemeState extends AnimatedWidgetBaseState<VAnimatedTheme> {
  VThemeDataTween? _themeTween;

  /// The tween currently driving the animation, if any.
  Tween<dynamic>? get animationTween => _themeTween;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _themeTween = visitor(
      _themeTween,
      widget.data,
      (value) => VThemeDataTween(begin: value as VThemeData),
    ) as VThemeDataTween?;
  }

  @override
  void didUpdateWidget(VAnimatedTheme oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Adjust animation speed to respect the target theme's reduced-motion flag.
    final ctrl = controller;
    if (widget.data.motion.reducedMotion) {
      ctrl.duration = Duration.zero;
    } else if (ctrl.duration != widget.duration) {
      ctrl.duration = widget.duration;
    }
  }

  @override
  Widget build(BuildContext context) {
    return VTheme(
      data: _themeTween!.evaluate(animation),
      child: widget.child,
    );
  }
}
