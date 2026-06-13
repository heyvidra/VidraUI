import 'package:flutter/widgets.dart';

import '../foundation/foundation.dart';
import '../theme/theme.dart';

// ---------------------------------------------------------------------------
// Public entry point
// ---------------------------------------------------------------------------

/// Builds the correct VidraUI page transition widget for the given [motion].
///
/// Called by [VPageRoute.transitionsBuilder].
Widget buildVPageTransition(
  BuildContext context,
  Widget child,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  VMotion motion,
) {
  final curved = CurvedAnimation(
    parent: animation,
    curve: motion.page.curve,
    reverseCurve: motion.page.effectiveReverseCurve,
  );

  final secondaryCurved = CurvedAnimation(
    parent: secondaryAnimation,
    curve: motion.page.curve,
    reverseCurve: motion.page.effectiveReverseCurve,
  );

  return switch (motion.pageTransition) {
    VPageTransition.none => child,
    VPageTransition.fade => FadeTransition(
        opacity: curved,
        child: child,
      ),
    VPageTransition.slide => _SlideFadeTransition(
        animation: curved,
        secondaryAnimation: secondaryCurved,
        fade: false,
        child: child,
      ),
    VPageTransition.slideFade => _SlideFadeTransition(
        animation: curved,
        secondaryAnimation: secondaryCurved,
        fade: true,
        child: child,
      ),
    VPageTransition.scaleFade => ScaleTransition(
        scale: Tween<double>(begin: 0.96, end: 1.0).animate(curved),
        child: FadeTransition(
          opacity: curved,
          child: child,
        ),
      ),
    VPageTransition.iosDepthSlide => _IosDepthSlideTransition(
        animation: curved,
        secondaryAnimation: secondaryCurved,
        child: child,
      ),
    VPageTransition.sharedAxisX => _SharedAxisXTransition(
        animation: curved,
        secondaryAnimation: secondaryCurved,
        child: child,
      ),
    VPageTransition.sharedAxisY => _SharedAxisYTransition(
        animation: curved,
        secondaryAnimation: secondaryCurved,
        child: child,
      ),
    VPageTransition.sharedAxisZ => _SharedAxisZTransition(
        animation: curved,
        secondaryAnimation: secondaryCurved,
        child: child,
      ),
    VPageTransition.zoomUpReveal => _ZoomUpRevealTransition(
        animation: curved,
        secondaryAnimation: secondaryCurved,
        child: child,
      ),
    VPageTransition.perspective3D => _Perspective3DTransition(
        animation: curved,
        secondaryAnimation: secondaryCurved,
        child: child,
      ),
    VPageTransition.adaptive => buildAdaptiveTransition(
        context,
        child,
        curved,
        secondaryCurved,
        motion,
      ),
  };
}

/// Platform-adaptive transition: iOS depth slide on Apple platforms,
/// zoom-up reveal on other platforms.
Widget buildAdaptiveTransition(
  BuildContext context,
  Widget child,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  VMotion motion,
) {
  final isApple = VPlatformScope.of(context).isApple;
  if (isApple) {
    return _IosDepthSlideTransition(
      animation: animation,
      secondaryAnimation: secondaryAnimation,
      child: child,
    );
  } else {
    return _ZoomUpRevealTransition(
      animation: animation,
      secondaryAnimation: secondaryAnimation,
      child: child,
    );
  }
}

// ---------------------------------------------------------------------------
// Transition widget classes (file-private)
// ---------------------------------------------------------------------------

/// Slide + optional fade transition.
///
/// Incoming: slides 4% from the right while fading in.
/// Secondary: slides 2% to the left.
class _SlideFadeTransition extends StatelessWidget {
  const _SlideFadeTransition({
    required this.animation,
    required this.secondaryAnimation,
    required this.fade,
    required this.child,
  });

  final Animation<double> animation;
  final Animation<double> secondaryAnimation;
  final bool fade;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    Widget result = SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0.04, 0),
        end: Offset.zero,
      ).animate(animation),
      child: SlideTransition(
        position: Tween<Offset>(
          begin: Offset.zero,
          end: const Offset(-0.02, 0),
        ).animate(secondaryAnimation),
        child: child,
      ),
    );

    if (fade) {
      result = FadeTransition(opacity: animation, child: result);
    }

    return result;
  }
}

/// iOS-style depth slide with parallax and custom left edge shadow.
class _IosDepthSlideTransition extends StatelessWidget {
  const _IosDepthSlideTransition({
    required this.animation,
    required this.secondaryAnimation,
    required this.child,
  });

  final Animation<double> animation;
  final Animation<double> secondaryAnimation;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);
    final result = SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: Offset.zero,
      ).animate(animation),
      child: DecoratedBox(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: theme.colors.text.withValues(alpha: 0.12),
              blurRadius: 24.0,
              offset: const Offset(-3.0, 0.0),
            ),
          ],
        ),
        child: child,
      ),
    );

    return SlideTransition(
      position: Tween<Offset>(
        begin: Offset.zero,
        end: const Offset(-0.15, 0.0),
      ).animate(secondaryAnimation),
      child: Stack(
        fit: StackFit.expand,
        children: [
          result,
          IgnorePointer(
            child: FadeTransition(
              opacity: Tween<double>(begin: 0.0, end: 0.25)
                  .animate(secondaryAnimation),
              child: DecoratedBox(
                decoration: BoxDecoration(color: theme.colors.scrim),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Premium Shared Axis X (horizontal slide + fade) transition.
class _SharedAxisXTransition extends StatelessWidget {
  const _SharedAxisXTransition({
    required this.animation,
    required this.secondaryAnimation,
    required this.child,
  });

  final Animation<double> animation;
  final Animation<double> secondaryAnimation;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final result = SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0.3, 0.0),
        end: Offset.zero,
      ).animate(animation),
      child: FadeTransition(
        opacity: animation,
        child: child,
      ),
    );

    return SlideTransition(
      position: Tween<Offset>(
        begin: Offset.zero,
        end: const Offset(-0.15, 0.0),
      ).animate(secondaryAnimation),
      child: FadeTransition(
        opacity:
            Tween<double>(begin: 1.0, end: 0.0).animate(secondaryAnimation),
        child: result,
      ),
    );
  }
}

/// Premium Shared Axis Y (vertical slide + fade) transition.
class _SharedAxisYTransition extends StatelessWidget {
  const _SharedAxisYTransition({
    required this.animation,
    required this.secondaryAnimation,
    required this.child,
  });

  final Animation<double> animation;
  final Animation<double> secondaryAnimation;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final result = SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0.0, 0.3),
        end: Offset.zero,
      ).animate(animation),
      child: FadeTransition(
        opacity: animation,
        child: child,
      ),
    );

    return SlideTransition(
      position: Tween<Offset>(
        begin: Offset.zero,
        end: const Offset(0.0, -0.15),
      ).animate(secondaryAnimation),
      child: FadeTransition(
        opacity:
            Tween<double>(begin: 1.0, end: 0.0).animate(secondaryAnimation),
        child: result,
      ),
    );
  }
}

/// Premium Shared Axis Z (scale + fade) transition.
class _SharedAxisZTransition extends StatelessWidget {
  const _SharedAxisZTransition({
    required this.animation,
    required this.secondaryAnimation,
    required this.child,
  });

  final Animation<double> animation;
  final Animation<double> secondaryAnimation;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final result = ScaleTransition(
      scale: Tween<double>(begin: 0.95, end: 1.0).animate(animation),
      child: FadeTransition(
        opacity: animation,
        child: child,
      ),
    );

    return ScaleTransition(
      scale: Tween<double>(begin: 1.0, end: 1.05).animate(secondaryAnimation),
      child: FadeTransition(
        opacity:
            Tween<double>(begin: 1.0, end: 0.0).animate(secondaryAnimation),
        child: result,
      ),
    );
  }
}

/// Modern Zoom-Up Reveal transition.
class _ZoomUpRevealTransition extends StatelessWidget {
  const _ZoomUpRevealTransition({
    required this.animation,
    required this.secondaryAnimation,
    required this.child,
  });

  final Animation<double> animation;
  final Animation<double> secondaryAnimation;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final result = SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0.0, 0.08),
        end: Offset.zero,
      ).animate(animation),
      child: ScaleTransition(
        scale: Tween<double>(begin: 0.92, end: 1.0).animate(animation),
        child: FadeTransition(
          opacity: animation,
          child: child,
        ),
      ),
    );

    return FadeTransition(
      opacity: Tween<double>(begin: 1.0, end: 0.85).animate(secondaryAnimation),
      child: result,
    );
  }
}

/// Futuristic 3D perspective flip transition.
class _Perspective3DTransition extends StatelessWidget {
  const _Perspective3DTransition({
    required this.animation,
    required this.secondaryAnimation,
    required this.child,
  });

  final Animation<double> animation;
  final Animation<double> secondaryAnimation;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final incoming = AnimatedBuilder(
      animation: animation,
      child: child,
      builder: (context, child) {
        final val = animation.value;
        final angle = -0.26 * (1.0 - val);
        final scale = 0.9 + 0.1 * val;

        final transform = Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateY(angle);
        transform.multiply(Matrix4.diagonal3Values(scale, scale, 1.0));

        return Transform(
          transform: transform,
          alignment: Alignment.center,
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
    );

    return AnimatedBuilder(
      animation: secondaryAnimation,
      child: incoming,
      builder: (context, child) {
        final val = secondaryAnimation.value;
        if (val == 0.0) return child!;
        final angle = 0.26 * val;
        final scale = 1.0 - 0.1 * val;

        final transform = Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateY(angle);
        transform.multiply(Matrix4.diagonal3Values(scale, scale, 1.0));

        return Transform(
          transform: transform,
          alignment: Alignment.center,
          child: FadeTransition(
            opacity:
                Tween<double>(begin: 1.0, end: 0.0).animate(secondaryAnimation),
            child: child,
          ),
        );
      },
    );
  }
}
