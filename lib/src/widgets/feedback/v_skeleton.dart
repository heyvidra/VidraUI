import 'package:flutter/widgets.dart';

import '../../theme/v_motion_scope.dart';
import '../../theme/v_theme.dart';

/// A shimmer skeleton loading placeholder.
///
/// Use [VShimmer] to wrap content that's loading. Use [VSkeletonBox] for
/// placeholder boxes of various shapes.
///
/// ```dart
/// VShimmer(
///   child: VFlex.vertical(
///     gap: 8,
///     children: [
///       VSkeletonBox(width: 200, height: 16),
///       VSkeletonBox(width: 150, height: 14),
///       VSkeletonBox(width: 280, height: 14),
///     ],
///   ),
/// );
/// ```
class VSkeletonBox extends StatelessWidget {
  const VSkeletonBox({
    super.key,
    this.width,
    this.height = 14,
    this.borderRadius,
  });

  final double? width;
  final double height;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: theme.colors.border,
        borderRadius: BorderRadius.circular(borderRadius ?? theme.radii.sm),
      ),
    );
  }
}

/// A circle skeleton placeholder.
class VSkeletonCircle extends StatelessWidget {
  const VSkeletonCircle({
    super.key,
    this.size = 40,
  });

  final double size;

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: theme.colors.border,
        shape: BoxShape.circle,
      ),
    );
  }
}

/// A shimmer animation wrapper.
///
/// Wraps [child] in an animated gradient shimmer effect.
class VShimmer extends StatefulWidget {
  const VShimmer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<VShimmer> createState() => _VShimmerState();
}

class _VShimmerState extends State<VShimmer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final spec = VMotionScope.of(context).slow;
    _controller.duration = VMotionResolver.duration(context, spec);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);
    // Use theme text color for shimmer so it is visible on any background.
    final shimmerColor = theme.colors.text;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final gradient = LinearGradient(
          begin: Alignment(-1.5 + _controller.value * 3, 0),
          end: Alignment(-1.0 + _controller.value * 3, 0),
          colors: [
            shimmerColor.withValues(alpha: 0),
            shimmerColor.withValues(alpha: 0.08),
            shimmerColor.withValues(alpha: 0),
          ],
        );
        return ShaderMask(
          shaderCallback: (bounds) => gradient.createShader(bounds),
          blendMode: BlendMode.srcIn,
          child: widget.child,
        );
      },
    );
  }
}
