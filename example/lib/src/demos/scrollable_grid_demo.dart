part of '../../main.dart';

class _ScrollableGridDemo extends StatefulWidget {
  const _ScrollableGridDemo();

  @override
  State<_ScrollableGridDemo> createState() => _ScrollableGridDemoState();
}

class _ScrollableGridDemoState extends State<_ScrollableGridDemo> {
  final List<int> _items = List<int>.generate(24, (index) => index + 1);
  VGridLayout _layout = VGridLayout.fixed;
  bool _loadingMore = false;
  bool _showEmpty = false;
  bool _showError = false;

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
      final start = _items.isEmpty ? 1 : _items.last + 1;
      _items.addAll(List<int>.generate(8, (index) => start + index));
      _loadingMore = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);

    double getItemHeight(int item) {
      if (_layout == VGridLayout.fixed) return 100;
      return (80 + (item % 3) * 40).toDouble();
    }

    return VFlex.vertical(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      gap: 16,
      children: [
        const VText('Scrollable Grid', variant: VTextVariant.heading),
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
                      onPressed: () => setState(() {
                        _layout = _layout == VGridLayout.fixed
                            ? VGridLayout.masonry
                            : VGridLayout.fixed;
                      }),
                      variant: VButtonVariant.secondary,
                      child: VText(
                        _layout == VGridLayout.fixed ? 'Switch to Masonry' : 'Switch to Fixed',
                        variant: VTextVariant.label,
                      ),
                    ),
                    VButton(
                      onPressed: () => setState(() {
                        _showEmpty = !_showEmpty;
                        _showError = false;
                      }),
                      variant: _showEmpty ? VButtonVariant.primary : VButtonVariant.secondary,
                      child: const VText(
                        'Toggle Empty',
                        variant: VTextVariant.label,
                      ),
                    ),
                    VButton(
                      onPressed: () => setState(() {
                        _showError = !_showError;
                        _showEmpty = false;
                      }),
                      variant: _showError ? VButtonVariant.danger : VButtonVariant.secondary,
                      child: const VText(
                        'Toggle Error',
                        variant: VTextVariant.label,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 360,
                  child: VScrollableGrid<int>(
                    items: _showEmpty ? [] : _items,
                    layout: _layout,
                    crossAxisCount: _layout == VGridLayout.fixed ? 3 : 2,
                    spacing: theme.spacing.md,
                    runSpacing: theme.spacing.md,
                    childAspectRatio: 1.0,
                    padding: EdgeInsets.all(theme.spacing.xs),
                    onRefresh: _refresh,
                    onLoadMore: _loadMore,
                    hasMore: _items.length < 60 && !_showEmpty,
                    isLoadingMore: _loadingMore,
                    error: _showError ? 'Simulated network or database timeout.' : null,
                    itemBuilder: (context, item, index) {
                      final height = getItemHeight(item);
                      return VSurface(
                        key: ValueKey<int>(item),
                        variant: VSurfaceVariant.elevated,
                        child: SizedBox(
                          height: height,
                          child: Center(
                            child: VFlex.vertical(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              gap: 4,
                              children: [
                                VText(
                                  'Item $item',
                                  variant: VTextVariant.body,
                                ),
                                VText(
                                  'H: ${height.toInt()}px',
                                  variant: VTextVariant.caption,
                                  color: theme.colors.textMuted,
                                ),
                              ],
                            ),
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

