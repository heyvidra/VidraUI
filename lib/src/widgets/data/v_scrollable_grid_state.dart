part of 'v_scrollable_grid.dart';

class _VScrollableGridState<T> extends State<VScrollableGrid<T>> {
  late ScrollController _ownedController;
  double _refreshExtent = 0;
  bool _refreshing = false;
  bool _loadingMore = false;
  bool _loadMoreQueued = false;

  // Same-instance widget caching for extreme rendering optimization
  final Map<Key, CachedWidget> _listItemCache = <Key, CachedWidget>{};
  final Map<int, CachedWidget> _indexItemCache = <int, CachedWidget>{};

  Set<Key> _currentFrameKeys = <Key>{};
  Set<Key> _lastFrameKeys = <Key>{};
  Set<int> _currentFrameIndices = <int>{};
  Set<int> _lastFrameIndices = <int>{};

  ScrollController get _effectiveController =>
      widget.controller ?? _ownedController;

  bool get _isLoadingMore => widget.isLoadingMore || _loadingMore;

  @override
  void initState() {
    super.initState();
    _ownedController = ScrollController();
    _effectiveController.addListener(_handleScrollChanged);
  }

  @override
  void didUpdateWidget(VScrollableGrid<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller?.removeListener(_handleScrollChanged);
      if (oldWidget.controller == null) {
        _ownedController.removeListener(_handleScrollChanged);
      }
      _effectiveController.addListener(_handleScrollChanged);
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _handleScrollChanged();
    });
  }

  @override
  void dispose() {
    _effectiveController.removeListener(_handleScrollChanged);
    _ownedController.dispose();
    super.dispose();
  }

  void _handleScrollChanged() {
    if (!_effectiveController.hasClients) return;
    _maybeLoadMore(_effectiveController.position);
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    _maybeLoadMore(notification.metrics);

    if (widget.onRefresh == null) return false;

    if (notification is OverscrollNotification &&
        notification.overscroll < 0 &&
        !_refreshing &&
        notification.metrics.pixels <= notification.metrics.minScrollExtent) {
      setState(() {
        _refreshExtent =
            (_refreshExtent - notification.overscroll).clamp(0, 72.0 * 1.5);
      });
    } else if (notification is ScrollEndNotification && !_refreshing) {
      if (_refreshExtent >= 72.0) {
        unawaited(_runRefresh());
      } else if (_refreshExtent > 0) {
        setState(() => _refreshExtent = 0);
      }
    }
    return false;
  }

  Future<void> _runRefresh() async {
    final onRefresh = widget.onRefresh;
    if (onRefresh == null || _refreshing) return;
    setState(() {
      _refreshing = true;
      _refreshExtent = 72.0;
    });
    try {
      await onRefresh();
    } finally {
      if (mounted) {
        setState(() {
          _refreshing = false;
          _refreshExtent = 0;
        });
      }
    }
  }

  void _maybeLoadMore(ScrollMetrics metrics) {
    final onLoadMore = widget.onLoadMore;
    if (onLoadMore == null ||
        !widget.hasMore ||
        _isLoadingMore ||
        _loadMoreQueued ||
        metrics.extentAfter > widget.loadMoreThreshold) {
      return;
    }
    _loadMoreQueued = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final latestOnLoadMore = widget.onLoadMore;
      if (latestOnLoadMore == null || !widget.hasMore || _isLoadingMore) {
        _loadMoreQueued = false;
        return;
      }
      setState(() {
        _loadMoreQueued = false;
        _loadingMore = true;
      });
      unawaited(latestOnLoadMore().whenComplete(() {
        if (mounted) setState(() => _loadingMore = false);
      }));
    });
  }

  Widget _buildGridChild(BuildContext context, int itemIndex) {
    final child =
        widget.itemBuilder(context, widget.items[itemIndex], itemIndex);

    final key = child.key;
    if (key != null) {
      _currentFrameKeys.add(key);
      final cached = _listItemCache[key];
      if (cached != null &&
          (identical(cached.child, child) || cached.child == child)) {
        return cached.result;
      }
    } else {
      _currentFrameIndices.add(itemIndex);
      final cached = _indexItemCache[itemIndex];
      if (cached != null &&
          (identical(cached.child, child) || cached.child == child)) {
        return cached.result;
      }
    }

    final result = child;

    if (key != null) {
      _listItemCache[key] = CachedWidget(child: child, result: result);
    } else {
      _indexItemCache[itemIndex] =
          CachedWidget(child: child, result: result);
    }

    return result;
  }

  Widget _buildMasonryGrid(BuildContext context) {
    final columns = List.generate(
      widget.crossAxisCount,
      (_) => <Widget>[],
    );

    for (int i = 0; i < widget.items.length; i++) {
      final columnIndex = i % widget.crossAxisCount;
      final child = _buildGridChild(context, i);

      if (columns[columnIndex].isNotEmpty) {
        columns[columnIndex].add(SizedBox(height: widget.runSpacing));
      }
      columns[columnIndex].add(child);
    }

    final columnWidgets = <Widget>[];
    for (int i = 0; i < widget.crossAxisCount; i++) {
      columnWidgets.add(
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: columns[i],
          ),
        ),
      );
      if (i < widget.crossAxisCount - 1) {
        columnWidgets.add(SizedBox(width: widget.spacing));
      }
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: columnWidgets,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Prune cache: remove items not built in the last two frames to bound memory
    final keysToKeep = _currentFrameKeys.union(_lastFrameKeys);
    _listItemCache.removeWhere((key, _) => !keysToKeep.contains(key));

    final indicesToKeep = _currentFrameIndices.union(_lastFrameIndices);
    _indexItemCache.removeWhere((index, _) => !indicesToKeep.contains(index));

    _lastFrameKeys = _currentFrameKeys;
    _currentFrameKeys = <Key>{};

    _lastFrameIndices = _currentFrameIndices;
    _currentFrameIndices = <int>{};

    final refreshSliver = _buildRefreshSliver(context);

    Widget mainSliver;
    if (widget.error != null && widget.items.isEmpty) {
      mainSliver = SliverFillRemaining(
        hasScrollBody: false,
        child: widget.errorBuilder?.call(context, widget.error!) ??
            _DefaultErrorState(error: widget.error!),
      );
    } else if (widget.items.isEmpty) {
      mainSliver = SliverFillRemaining(
        hasScrollBody: false,
        child: widget.emptyBuilder?.call(context) ?? const _DefaultEmptyState(),
      );
    } else {
      if (widget.layout == VGridLayout.fixed) {
        mainSliver = SliverGrid(
          delegate: SliverChildBuilderDelegate(
            _buildGridChild,
            childCount: widget.items.length,
            addAutomaticKeepAlives: true,
            addRepaintBoundaries: true,
            addSemanticIndexes: true,
          ),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: widget.crossAxisCount,
            crossAxisSpacing: widget.spacing,
            mainAxisSpacing: widget.runSpacing,
            childAspectRatio: widget.childAspectRatio,
          ),
        );
      } else {
        mainSliver = SliverToBoxAdapter(
          child: _buildMasonryGrid(context),
        );
      }
    }

    if (widget.padding != null && widget.items.isNotEmpty) {
      mainSliver = SliverPadding(
        padding: widget.padding!,
        sliver: mainSliver,
      );
    }

    final slivers = <Widget>[
      if (refreshSliver != null) refreshSliver,
      mainSliver,
      if (widget.items.isNotEmpty) ...[
        if (widget.error != null)
          SliverToBoxAdapter(
            child: widget.errorBuilder?.call(context, widget.error!) ??
                _DefaultBottomError(error: widget.error!),
          )
        else if (_isLoadingMore)
          SliverToBoxAdapter(
            child: widget.loadingMoreBuilder?.call(context) ??
                const DefaultLoadMoreIndicator(),
          )
        else if (!widget.hasMore && widget.noMoreBuilder != null)
          SliverToBoxAdapter(
            child: widget.noMoreBuilder!(context),
          ),
      ],
    ];

    return NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: CustomScrollView(
        controller: _effectiveController,
        physics: AlwaysScrollableScrollPhysics(parent: widget.physics),
        scrollCacheExtent: widget.cacheExtent == null
            ? null
            : ScrollCacheExtent.pixels(widget.cacheExtent!),
        shrinkWrap: widget.shrinkWrap,
        slivers: slivers,
      ),
    );
  }

  Widget? _buildRefreshSliver(BuildContext context) {
    if (widget.onRefresh == null) return null;
    final height = _refreshing ? 72.0 : _refreshExtent;
    if (height <= 0) {
      return const SliverToBoxAdapter(child: SizedBox.shrink());
    }
    return SliverToBoxAdapter(
      child: SizedBox(
        height: height,
        child: Center(
          child: Semantics(
            liveRegion: _refreshing,
            label: _refreshing ? 'Refreshing' : 'Pull to refresh',
            child: VFlex.horizontal(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const VSpinner(size: 16),
                const SizedBox(width: 8),
                VText(
                  _refreshing ? 'Refreshing' : 'Pull to refresh',
                  variant: VTextVariant.caption,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
