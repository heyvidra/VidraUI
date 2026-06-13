part of '../../main.dart';

class _ScrollableListDemo extends StatefulWidget {
  const _ScrollableListDemo();

  @override
  State<_ScrollableListDemo> createState() => _ScrollableListDemoState();
}

class _ScrollableListDemoState extends State<_ScrollableListDemo> {
  final VScrollableListController _listController = VScrollableListController();
  final List<int> _items = List<int>.generate(24, (index) => index + 1);
  bool _loadingMore = false;

  Future<void> _refresh() async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    if (!mounted) return;
    setState(() {
      final next = (_items.isEmpty ? 1 : _items.first) - 1;
      _items.insert(0, next);
    });
  }

  Future<void> _loadMore() async {
    if (_loadingMore || _items.length >= 60) return;
    setState(() => _loadingMore = true);
    await Future<void>.delayed(const Duration(milliseconds: 600));
    if (!mounted) return;
    setState(() {
      final start = _items.last + 1;
      _items.addAll(List<int>.generate(8, (index) => start + index));
      _loadingMore = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);
    return VFlex.vertical(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      gap: 16,
      children: [
        const VText('Scrollable List', variant: VTextVariant.heading),
        VSurface(
          variant: VSurfaceVariant.card,
          child: Padding(
            padding: EdgeInsets.all(theme.spacing.lg),
            child: VFlex.vertical(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              gap: theme.spacing.md,
              children: [
                VFlex.horizontal(
                  gap: theme.spacing.sm,
                  children: [
                    VButton(
                      onPressed: _listController.scrollToTop,
                      variant: VButtonVariant.secondary,
                      child: const VText(
                        'Top',
                        variant: VTextVariant.label,
                      ),
                    ),
                    VButton(
                      onPressed: _listController.scrollToBottom,
                      variant: VButtonVariant.secondary,
                      child: const VText(
                        'Bottom',
                        variant: VTextVariant.label,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 360,
                  child: VScrollableList.animatedBuilder(
                    listController: _listController,
                    itemCount: _items.length,
                    padding: EdgeInsets.all(theme.spacing.xs),
                    showScrollToTopAfter: 120,
                    showScrollToBottomAfter: 240,
                    onRefresh: _refresh,
                    refreshBuilder: (context, pulled, trigger, refreshing) {
                      final armed = pulled >= trigger;
                      return Center(
                        child: VSurface(
                          variant: VSurfaceVariant.elevated,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: theme.spacing.md,
                              vertical: theme.spacing.sm,
                            ),
                            child: VFlex.horizontal(
                              mainAxisAlignment: MainAxisAlignment.center,
                              gap: theme.spacing.sm,
                              children: [
                                const VSpinner(size: 16),
                                VText(
                                  refreshing
                                      ? 'Refreshing'
                                      : armed
                                          ? 'Release to refresh'
                                          : 'Pull to refresh',
                                  variant: VTextVariant.caption,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    onLoadMore: _loadMore,
                    hasMore: _items.length < 60,
                    isLoadingMore: _loadingMore,
                    loadMoreBuilder: (context) => Padding(
                      padding: EdgeInsets.all(theme.spacing.lg),
                      child: const Center(
                        child: VText(
                          'Loading the next page...',
                          variant: VTextVariant.caption,
                        ),
                      ),
                    ),
                    separatorBuilder: (context, index) =>
                        SizedBox(height: theme.spacing.sm),
                    itemBuilder: (context, index) {
                      final item = _items[index];
                      return VSurface(
                        variant: VSurfaceVariant.elevated,
                        child: Padding(
                          padding: EdgeInsets.all(theme.spacing.md),
                          child: VFlex.horizontal(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              VText(
                                'Lazy row $item',
                                variant: VTextVariant.body,
                              ),
                              VText(
                                index.isEven ? 'new' : 'paged',
                                variant: VTextVariant.caption,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}


// docs-snippet:start scrollable-list-basic
// VScrollableList.builder(
//   itemCount: items.length,
//   onRefresh: refreshItems,
//   onLoadMore: loadMoreItems,
//   hasMore: hasMoreItems,
//   showScrollToTopAfter: 240,
//   itemBuilder: (context, index) => VListTile(title: items[index].title),
// )
// docs-snippet:end scrollable-list-basic

