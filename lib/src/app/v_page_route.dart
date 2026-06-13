import 'package:flutter/widgets.dart';

import '../foundation/foundation.dart';
import 'v_page_route_back_gesture.dart';
import 'v_page_route_transitions.dart';

/// A [PageRouteBuilder] subclass that applies VidraUI page transitions.
///
/// Reads animation parameters from a [VMotion] instance.
/// Supports all [VPageTransition] variants via [motion.pageTransition].
///
/// Back gesture (swipe-to-pop) is enabled for [VPageTransition.iosDepthSlide]
/// and [VPageTransition.adaptive] on Apple platforms.
class VPageRoute<T> extends PageRouteBuilder<T> {
  VPageRoute({
    required RouteSettings settings,
    required WidgetBuilder builder,
    required VMotion motion,
  }) : super(
          settings: settings,
          transitionDuration: motion.page.duration,
          reverseTransitionDuration: motion.page.effectiveReverseDuration,
          pageBuilder: (context, animation, secondaryAnimation) {
            return builder(context);
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final transition = buildVPageTransition(
              context,
              child,
              animation,
              secondaryAnimation,
              motion,
            );
            return _VBackGestureScopeHost(
              motion: motion,
              transition: transition,
            );
          },
        );

  /// Exposes the protected [controller] for use by back-gesture detection.
  AnimationController get routeController => controller as AnimationController;

  /// Returns whether the back gesture should be active for this route.
  static bool _shouldEnableBackGesture(VMotion motion, BuildContext context) {
    final isApple = VPlatformScope.of(context).isApple;
    return motion.pageTransition == VPageTransition.iosDepthSlide ||
        (motion.pageTransition == VPageTransition.adaptive && isApple);
  }
}

/// Resolves the route's [AnimationController] from [ModalRoute.of] and
/// inserts a [VBackGestureScope] into the widget tree.
///
/// This exists because [VPageRoute.transitionsBuilder] runs inside the
/// super constructor, where Dart disallows `this` references.
class _VBackGestureScopeHost extends StatelessWidget {
  const _VBackGestureScopeHost({
    required this.motion,
    required this.transition,
  });

  final VMotion motion;
  final Widget transition;

  @override
  Widget build(BuildContext context) {
    final route = ModalRoute.of(context);
    final ctrl = (route is VPageRoute<dynamic>)
        ? route.routeController
        : null;
    final gestureEnabled =
        VPageRoute._shouldEnableBackGesture(motion, context);
    return VBackGestureScope(
      controller: ctrl,
      onCommitPop: () => Navigator.of(context).maybePop(),
      isGestureEnabled: gestureEnabled,
      child: VBackGestureDetector(
        child: transition,
      ),
    );
  }
}
