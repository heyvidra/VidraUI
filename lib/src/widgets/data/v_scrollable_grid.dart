import 'dart:async';

import 'package:flutter/rendering.dart' show ScrollCacheExtent;
import 'package:flutter/widgets.dart';

import '../../theme/v_theme.dart';
import '../basic/v_flex.dart';
import '../basic/v_text.dart';
import '../feedback/v_progress.dart';
import '../scrolling/v_scroll_indicators.dart';

part 'v_scrollable_grid_parts.dart';
part 'v_scrollable_grid_state.dart';

/// Layout style for [VScrollableGrid].
enum VGridLayout {
  /// Regular grid with fixed cross-axis count and aspect ratio.
  fixed,

  /// Waterfall/masonry grid where items in columns are stacked naturally.
  masonry,
}

/// Builds a grid item for [VScrollableGrid].
typedef VGridItemBuilder<T> = Widget Function(
  BuildContext context,
  T item,
  int index,
);

/// A high-performance, theme-aware grid and masonry layout supporting pull-to-refresh
/// and infinite-scroll pagination.
class VScrollableGrid<T> extends StatefulWidget {
  const VScrollableGrid({
    super.key,
    required this.items,
    required this.itemBuilder,
    this.layout = VGridLayout.fixed,
    this.crossAxisCount = 2,
    this.spacing = 8,
    this.runSpacing = 8,
    this.childAspectRatio = 1.0,
    this.padding,
    this.controller,
    this.physics,
    this.shrinkWrap = false,
    this.cacheExtent,
    this.onRefresh,
    this.onLoadMore,
    this.hasMore = false,
    this.isLoadingMore = false,
    this.loadMoreThreshold = 300,
    this.emptyBuilder,
    this.loadingMoreBuilder,
    this.noMoreBuilder,
    this.errorBuilder,
    this.error,
  });

  /// The list of items to display.
  final List<T> items;

  /// Builds a grid item for [index].
  final VGridItemBuilder<T> itemBuilder;

  /// The layout model (fixed or masonry).
  final VGridLayout layout;

  /// The number of columns in the grid.
  final int crossAxisCount;

  /// Spacing between columns.
  final double spacing;

  /// Spacing between rows or vertical items in columns.
  final double runSpacing;

  /// Aspect ratio for items when using [VGridLayout.fixed].
  final double childAspectRatio;

  /// Padding applied around the grid items.
  final EdgeInsetsGeometry? padding;

  /// Optional ScrollController.
  final ScrollController? controller;

  /// Optional scroll physics.
  final ScrollPhysics? physics;

  /// Whether the scroll view should size itself to its contents.
  final bool shrinkWrap;

  /// The viewport cache extent passed to [CustomScrollView].
  final double? cacheExtent;

  /// Called when pull-down refresh is triggered.
  final Future<void> Function()? onRefresh;

  /// Called when scrolling near the bottom and more data is available.
  final Future<void> Function()? onLoadMore;

  /// Whether more pages can be requested.
  final bool hasMore;

  /// External loading-more state.
  final bool isLoadingMore;

  /// Remaining scroll distance that triggers [onLoadMore].
  final double loadMoreThreshold;

  /// Custom empty state builder.
  final WidgetBuilder? emptyBuilder;

  /// Custom loading more footer builder.
  final WidgetBuilder? loadingMoreBuilder;

  /// Custom no more footer builder.
  final WidgetBuilder? noMoreBuilder;

  /// Custom error builder.
  final Widget Function(BuildContext context, Object error)? errorBuilder;

  /// Optional error object indicating a failure state.
  final Object? error;

  @override
  State<VScrollableGrid<T>> createState() => _VScrollableGridState<T>();
}
