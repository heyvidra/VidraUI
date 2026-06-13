import 'package:flutter/widgets.dart';

/// A delegate for building sticky/persistent headers inside a [CustomScrollView].
class VStickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  const VStickyHeaderDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.builder,
  });

  /// The minimum height of the header (when fully collapsed and pinned).
  final double minHeight;

  /// The maximum height of the header (when fully expanded).
  final double maxHeight;

  /// Builder callback containing context, current shrinkOffset, and overlap status.
  final Widget Function(BuildContext context, double shrinkOffset, bool overlapsContent) builder;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(
      child: builder(context, shrinkOffset, overlapsContent),
    );
  }

  @override
  bool shouldRebuild(covariant VStickyHeaderDelegate oldDelegate) {
    return minHeight != oldDelegate.minHeight ||
        maxHeight != oldDelegate.maxHeight ||
        builder != oldDelegate.builder;
  }
}

/// A zero-dependency sticky header widget designed for [CustomScrollView].
///
/// Keeps the header pinned at the top of the scrollable viewport when scrolled,
/// matching premium native platform behaviors (like iOS section headers or macOS contacts).
///
/// Supports both fixed height headers and dynamic shrinking headers.
///
/// ### Fixed Height Example:
/// ```dart
/// VStickyHeader(
///   height: 48,
///   builder: (context, shrinkOffset, overlapsContent) => VSurface(
///     variant: VSurfaceVariant.panel,
///     child: VText('Section Header'),
///   ),
/// )
/// ```
///
/// ### Dynamic Shrinking Example:
/// ```dart
/// VStickyHeader(
///   minHeight: 50,
///   maxHeight: 120,
///   builder: (context, shrinkOffset, overlapsContent) {
///     final progress = shrinkOffset / (120 - 50); // 0.0 to 1.0
///     return VSurface(
///       variant: VSurfaceVariant.panel,
///       child: Center(
///         child: VText(
///           'Dynamic Title',
///           style: TextStyle(fontSize: 24 - (progress * 8)),
///         ),
///       ),
///     );
///   },
/// )
/// ```
class VStickyHeader extends StatelessWidget {
  const VStickyHeader({
    super.key,
    required this.builder,
    double? height,
    double? minHeight,
    double? maxHeight,
    this.pinned = true,
    this.floating = false,
  })  : minHeight = minHeight ?? height ?? 48.0,
        maxHeight = maxHeight ?? height ?? 48.0,
        assert(
          height != null || (minHeight != null && maxHeight != null),
          'Provide either a fixed height or both minHeight and maxHeight.',
        );

  /// Builder callback providing current shrinkOffset and overlap status.
  final Widget Function(BuildContext context, double shrinkOffset, bool overlapsContent) builder;

  /// Minimum height when fully collapsed/吸顶.
  final double minHeight;

  /// Maximum height when fully expanded.
  final double maxHeight;

  /// Whether the header should remain pinned/stuck to the top of the viewport.
  final bool pinned;

  /// Whether the header should immediately float back into view when scrolling down,
  /// even before reaching the top of the scrollable content.
  final bool floating;

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: pinned,
      floating: floating,
      delegate: VStickyHeaderDelegate(
        minHeight: minHeight,
        maxHeight: maxHeight,
        builder: builder,
      ),
    );
  }
}
