import 'dart:async';

import 'package:flutter/rendering.dart' show ScrollCacheExtent;
import 'package:flutter/widgets.dart';

import '../../foundation/foundation.dart';
import '../../theme/v_theme.dart';
import '../basic/v_flex.dart';
import '../basic/v_text.dart';
import '../buttons/v_button.dart';
import '../feedback/v_progress.dart';
import '../scrolling/v_scroll_indicators.dart';

part 'v_scrollable_list_parts.dart';
part 'v_scrollable_list_state.dart';

/// Builds a lazily created item for [VScrollableList].
typedef VScrollableListItemBuilder = Widget Function(
  BuildContext context,
  int index,
);

/// Builds a separator between lazily created list items.
typedef VScrollableListSeparatorBuilder = Widget Function(
  BuildContext context,
  int index,
);

/// Builds a pull-to-refresh area.
typedef VScrollableListRefreshBuilder = Widget Function(
  BuildContext context,
  double pulledExtent,
  double triggerDistance,
  bool refreshing,
);

/// Builds a floating scroll affordance.
typedef VScrollableListScrollButtonBuilder = Widget Function(
  BuildContext context,
  VoidCallback onPressed,
);

/// Controls an attached [VScrollableList].
class VScrollableListController extends ChangeNotifier {
  _VScrollableListState? _state;

  /// Whether this controller is attached to a scrollable list.
  bool get hasClients => _state?._effectiveController.hasClients ?? false;

  void _attach(_VScrollableListState state) {
    _state = state;
  }

  void _detach(_VScrollableListState state) {
    if (_state == state) _state = null;
  }

  /// Scrolls the attached list to its top edge.
  Future<void> scrollToTop({
    Duration? duration,
    Curve? curve,
  }) {
    return _state?._scrollToTop(duration: duration, curve: curve) ??
        Future<void>.value();
  }

  /// Scrolls the attached list to its bottom edge.
  Future<void> scrollToBottom({
    Duration? duration,
    Curve? curve,
  }) {
    return _state?._scrollToBottom(duration: duration, curve: curve) ??
        Future<void>.value();
  }
}

/// A lazy, theme-aware scrollable list for large data sets.
///
/// Use [VScrollableList.builder] for ordinary large lists and
/// [VScrollableList.animatedBuilder] when newly visible rows should fade and
/// slide in. Pull-to-refresh, load-more pagination, and floating scroll
/// affordances are implemented without Material or Cupertino components.
class VScrollableList extends StatefulWidget {
  const VScrollableList.builder({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.separatorBuilder,
    this.padding,
    this.controller,
    this.listController,
    this.cacheExtent,
    this.physics,
    this.shrinkWrap = false,
    this.showScrollToTopAfter,
    this.showScrollToBottomAfter,
    this.scrollToTopBuilder,
    this.scrollToBottomBuilder,
    this.onRefresh,
    this.refreshBuilder,
    this.refreshTriggerDistance = 72,
    this.onLoadMore,
    this.hasMore = true,
    this.isLoadingMore = false,
    this.loadMoreThreshold = 240,
    this.loadMoreBuilder,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
  }) : _animated = false;

  const VScrollableList.animatedBuilder({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.separatorBuilder,
    this.padding,
    this.controller,
    this.listController,
    this.cacheExtent,
    this.physics,
    this.shrinkWrap = false,
    this.showScrollToTopAfter,
    this.showScrollToBottomAfter,
    this.scrollToTopBuilder,
    this.scrollToBottomBuilder,
    this.onRefresh,
    this.refreshBuilder,
    this.refreshTriggerDistance = 72,
    this.onLoadMore,
    this.hasMore = true,
    this.isLoadingMore = false,
    this.loadMoreThreshold = 240,
    this.loadMoreBuilder,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
  }) : _animated = true;

  /// Number of items in the list.
  final int itemCount;

  /// Lazily builds an item for [index].
  final VScrollableListItemBuilder itemBuilder;

  /// Lazily builds a separator after item [index].
  final VScrollableListSeparatorBuilder? separatorBuilder;

  /// Padding applied around the list items.
  final EdgeInsetsGeometry? padding;

  /// Optional Flutter scroll controller.
  final ScrollController? controller;

  /// Optional VidraUI controller for programmatic list actions.
  final VScrollableListController? listController;

  /// The viewport cache extent passed to [CustomScrollView].
  final double? cacheExtent;

  /// Optional scroll physics.
  final ScrollPhysics? physics;

  /// Whether the scroll view should size itself to its contents.
  final bool shrinkWrap;

  /// Shows a scroll-to-top affordance after this many pixels from the top.
  final double? showScrollToTopAfter;

  /// Shows a scroll-to-bottom affordance after this many pixels from bottom.
  final double? showScrollToBottomAfter;

  /// Custom scroll-to-top affordance.
  final VScrollableListScrollButtonBuilder? scrollToTopBuilder;

  /// Custom scroll-to-bottom affordance.
  final VScrollableListScrollButtonBuilder? scrollToBottomBuilder;

  /// Called when pull-down refresh is triggered.
  final Future<void> Function()? onRefresh;

  /// Custom pull-down refresh area.
  final VScrollableListRefreshBuilder? refreshBuilder;

  /// Pulled distance required to trigger [onRefresh].
  final double refreshTriggerDistance;

  /// Called when scrolling near the bottom and more data is available.
  final Future<void> Function()? onLoadMore;

  /// Whether more pages can be requested.
  final bool hasMore;

  /// External loading-more state.
  final bool isLoadingMore;

  /// Remaining scroll distance that triggers [onLoadMore].
  final double loadMoreThreshold;

  /// Custom loading-more footer.
  final WidgetBuilder? loadMoreBuilder;

  /// Passed to the underlying [SliverChildBuilderDelegate].
  final bool addAutomaticKeepAlives;

  /// Passed to the underlying [SliverChildBuilderDelegate].
  final bool addRepaintBoundaries;

  /// Passed to the underlying [SliverChildBuilderDelegate].
  final bool addSemanticIndexes;

  final bool _animated;

  @override
  State<VScrollableList> createState() => _VScrollableListState();
}
