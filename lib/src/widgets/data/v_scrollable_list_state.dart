part of 'v_scrollable_list.dart';

class _VScrollableListState extends State<VScrollableList> {
  late ScrollController _ownedController;
  final Set<int> _animatedIndexes = <int>{};
  late final ValueNotifier<double> _refreshExtentNotifier;
  bool _refreshing = false;
  bool _loadingMore = false;
  bool _loadMoreQueued = false;
  final ValueNotifier<bool> _showTopNotifier = ValueNotifier<bool>(false);
  final ValueNotifier<bool> _showBottomNotifier = ValueNotifier<bool>(false);

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
    _refreshExtentNotifier = ValueNotifier<double>(0.0);
    _ownedController = ScrollController();
    _effectiveController.addListener(_handleScrollChanged);
    widget.listController?._attach(this);
  }

  @override
  void didUpdateWidget(VScrollableList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller?.removeListener(_handleScrollChanged);
      if (oldWidget.controller == null) {
        _ownedController.removeListener(_handleScrollChanged);
      }
      _effectiveController.addListener(_handleScrollChanged);
    }
    if (oldWidget.listController != widget.listController) {
      oldWidget.listController?._detach(this);
      widget.listController?._attach(this);
    }
    if (widget.itemCount < oldWidget.itemCount) {
      _animatedIndexes.removeWhere((index) => index >= widget.itemCount);
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _handleScrollChanged();
    });
  }

  @override
  void dispose() {
    widget.listController?._detach(this);
    _effectiveController.removeListener(_handleScrollChanged);
    _ownedController.dispose();
    _showTopNotifier.dispose();
    _showBottomNotifier.dispose();
    _refreshExtentNotifier.dispose();
    super.dispose();
  }

  Future<void> _scrollToTop({
    Duration? duration,
    Curve? curve,
  }) {
    return _scrollTo(
      _effectiveController.position.minScrollExtent,
      duration: duration,
      curve: curve,
    );
  }

  Future<void> _scrollToBottom({
    Duration? duration,
    Curve? curve,
  }) {
    return _scrollTo(
      _effectiveController.position.maxScrollExtent,
      duration: duration,
      curve: curve,
    );
  }

  Future<void> _scrollTo(
    double offset, {
    Duration? duration,
    Curve? curve,
  }) {
    if (!_effectiveController.hasClients) return Future<void>.value();
    final motion = VTheme.of(context).motion;
    if (motion.reducedMotion) {
      _effectiveController.jumpTo(offset);
      return Future<void>.value();
    }
    return _effectiveController.animateTo(
      offset,
      duration: duration ?? motion.normal.duration,
      curve: curve ?? motion.normal.curve,
    );
  }

  void _handleScrollChanged() {
    if (!_effectiveController.hasClients) return;
    final position = _effectiveController.position;
    final nextShowTop = widget.showScrollToTopAfter != null &&
        position.pixels > widget.showScrollToTopAfter!;
    final nextShowBottom = widget.showScrollToBottomAfter != null &&
        position.extentAfter > widget.showScrollToBottomAfter!;
    if (nextShowTop != _showTopNotifier.value) {
      _showTopNotifier.value = nextShowTop;
    }
    if (nextShowBottom != _showBottomNotifier.value) {
      _showBottomNotifier.value = nextShowBottom;
    }
    _maybeLoadMore(position);
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    _maybeLoadMore(notification.metrics);

    if (widget.onRefresh == null) return false;

    if (notification is OverscrollNotification &&
        notification.overscroll < 0 &&
        !_refreshing &&
        notification.metrics.pixels <= notification.metrics.minScrollExtent) {
      _refreshExtentNotifier.value =
          (_refreshExtentNotifier.value - notification.overscroll)
              .clamp(0, widget.refreshTriggerDistance * 1.5);
    } else if (notification is ScrollEndNotification && !_refreshing) {
      if (_refreshExtentNotifier.value >= widget.refreshTriggerDistance) {
        unawaited(_runRefresh());
      } else if (_refreshExtentNotifier.value > 0) {
        _refreshExtentNotifier.value = 0;
      }
    }
    return false;
  }

  Future<void> _runRefresh() async {
    final onRefresh = widget.onRefresh;
    if (onRefresh == null || _refreshing) return;
    setState(() {
      _refreshing = true;
    });
    _refreshExtentNotifier.value = widget.refreshTriggerDistance;
    try {
      await onRefresh();
    } finally {
      if (mounted) {
        setState(() {
          _refreshing = false;
        });
        _refreshExtentNotifier.value = 0;
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

  Widget _buildListChild(BuildContext context, int childIndex) {
    if (widget.separatorBuilder != null && childIndex.isOdd) {
      return widget.separatorBuilder!(context, childIndex ~/ 2);
    }

    final itemIndex =
        widget.separatorBuilder == null ? childIndex : childIndex ~/ 2;
    final child = widget.itemBuilder(context, itemIndex);

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

    Widget result = child;
    if (widget._animated) {
      final shouldAnimate = _animatedIndexes.add(itemIndex);
      result = _LazyAnimatedListItem(
        key: key ?? ValueKey<int>(itemIndex),
        animate: shouldAnimate,
        child: child,
      );
    }

    if (key != null) {
      _listItemCache[key] = CachedWidget(child: child, result: result);
    } else {
      _indexItemCache[itemIndex] =
          CachedWidget(child: child, result: result);
    }

    return result;
  }

  int get _sliverChildCount {
    if (widget.itemCount == 0) return 0;
    if (widget.separatorBuilder == null) return widget.itemCount;
    return widget.itemCount * 2 - 1;
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
    final listSliver = SliverList(
      delegate: SliverChildBuilderDelegate(
        _buildListChild,
        childCount: _sliverChildCount,
        addAutomaticKeepAlives: widget.addAutomaticKeepAlives,
        addRepaintBoundaries: widget.addRepaintBoundaries,
        addSemanticIndexes: widget.addSemanticIndexes,
      ),
    );
    final slivers = <Widget>[
      if (refreshSliver != null) refreshSliver,
      if (widget.padding != null)
        SliverPadding(
          padding: widget.padding!,
          sliver: listSliver,
        )
      else
        listSliver,
      if (_isLoadingMore) _buildLoadMoreSliver(context),
    ];

    return Stack(
      children: [
        NotificationListener<ScrollNotification>(
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
        ),
        ValueListenableBuilder<bool>(
          valueListenable: _showTopNotifier,
          builder: (context, showTop, child) {
            if (!showTop) return const SizedBox.shrink();
            return ValueListenableBuilder<bool>(
              valueListenable: _showBottomNotifier,
              builder: (context, showBottom, child) {
                return _buildScrollButton(
                  context,
                  top: true,
                  showBottom: showBottom,
                );
              },
            );
          },
        ),
        ValueListenableBuilder<bool>(
          valueListenable: _showBottomNotifier,
          builder: (context, showBottom, child) {
            if (!showBottom) return const SizedBox.shrink();
            return _buildScrollButton(context, top: false, showBottom: false);
          },
        ),
      ],
    );
  }

  Widget? _buildRefreshSliver(BuildContext context) {
    if (widget.onRefresh == null) return null;

    return SliverToBoxAdapter(
      child: ValueListenableBuilder<double>(
        valueListenable: _refreshExtentNotifier,
        builder: (context, currentExtent, child) {
          final height =
              _refreshing ? widget.refreshTriggerDistance : currentExtent;
          if (height <= 0) {
            return const SizedBox.shrink();
          }
          return SizedBox(
            height: height,
            child: widget.refreshBuilder?.call(
                  context,
                  currentExtent,
                  widget.refreshTriggerDistance,
                  _refreshing,
                ) ??
                _DefaultRefreshIndicator(
                  pulledExtent: currentExtent,
                  triggerDistance: widget.refreshTriggerDistance,
                  refreshing: _refreshing,
                ),
          );
        },
      ),
    );
  }

  Widget _buildLoadMoreSliver(BuildContext context) {
    return SliverToBoxAdapter(
      child: widget.loadMoreBuilder?.call(context) ??
          const DefaultLoadMoreIndicator(),
    );
  }

  Widget _buildScrollButton(
    BuildContext context, {
    required bool top,
    required bool showBottom,
  }) {
    final theme = VTheme.of(context);
    final onPressed = top ? _scrollToTop : _scrollToBottom;
    final builder =
        top ? widget.scrollToTopBuilder : widget.scrollToBottomBuilder;
    return Positioned(
      right: theme.spacing.lg,
      bottom: top && showBottom ? theme.spacing.x3l : theme.spacing.lg,
      child: builder?.call(context, onPressed) ??
          _DefaultScrollButton(
            semanticLabel: top ? 'Scroll to top' : 'Scroll to bottom',
            direction: top ? AxisDirection.up : AxisDirection.down,
            onPressed: onPressed,
          ),
    );
  }
}
