import 'package:flutter/widgets.dart';

import '../theme/v_appearance.dart';
import '../theme/v_appearance_scope.dart';
import 'v_inner_shadow.dart';

/// Internal visual augmentation primitive.
///
/// Does NOT render its own background/border/shadows. The host widget
/// (Container/AnimatedContainer) is expected to provide those through
/// its own [BoxDecoration].
///
/// When [appearance] is null, resolves from [VAppearanceScope].
///
/// NOT exported from widgets.dart.
class VVisualBox extends StatelessWidget {
  const VVisualBox({
    super.key,
    required this.child,
    this.appearance,
    required this.states,
    required this.background,
    required this.borderRadius,
  });

  final Widget child;
  final VAppearance? appearance;
  final Set<WidgetState> states;
  final Color background;
  final BorderRadiusGeometry borderRadius;

  @override
  Widget build(BuildContext context) {
    final resolved = appearance ?? VAppearanceScope.of(context);
    final inner = resolved?.innerShadows(states, background: background) ??
        const <BoxShadow>[];
    final gradient = resolved?.gradient(background, states);

    Widget result = child;

    if (gradient != null) {
      result = DecoratedBox(
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: borderRadius,
        ),
        child: result,
      );
    }

    if (inner.isNotEmpty) {
      result = Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: VInnerShadowPainter(
                shadows: inner,
                borderRadius: borderRadius,
              ),
            ),
          ),
          result,
        ],
      );
    }

    if (resolved != null) {
      result = resolved.wrap(
        context,
        result,
        borderRadius: borderRadius,
        states: states,
      );
    }

    return result;
  }
}
