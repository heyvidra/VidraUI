part of '../../main.dart';

class _AnimatedListDemo extends StatefulWidget {
  const _AnimatedListDemo();
  @override
  State<_AnimatedListDemo> createState() => _AnimatedListDemoState();
}

class _AnimatedListDemoState extends State<_AnimatedListDemo> {
  int _nextId = 4;
  final List<int> _items = [1, 2, 3];

  void _addItem() {
    setState(() {
      _items.add(_nextId);
      _nextId++;
    });
  }

  void _removeLastItem() {
    if (_items.isEmpty) return;
    setState(() => _items.removeLast());
  }

  void _deleteItem(int item) {
    setState(() => _items.remove(item));
  }

  @override
  Widget build(BuildContext context) {
    return VFlex.vertical(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        gap: 16,
        children: [
          const VText('Animated List', variant: VTextVariant.heading),
          VSurface(
            variant: VSurfaceVariant.card,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: VFlex.vertical(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  gap: 8,
                  children: [
                    VFlex.horizontal(gap: 8, children: [
                      VButton(
                        onPressed: _addItem,
                        variant: VButtonVariant.secondary,
                        child: const VText('Add item',
                            variant: VTextVariant.label),
                      ),
                      VButton(
                        onPressed: _removeLastItem,
                        variant: VButtonVariant.secondary,
                        child: const VText('Remove item',
                            variant: VTextVariant.label),
                      ),
                    ]),
                    const VText(
                      'Swipe left on a row, then tap Delete.',
                      variant: VTextVariant.caption,
                    ),
                    VAnimatedList(
                      gap: 8,
                      key: ValueKey(_items.join(',')),
                      children: _items.map((item) {
                        return VSwipeActions(
                          key: ValueKey('swipe-item-$item'),
                          endAction: Center(
                            child: VButton(
                              onPressed: () => _deleteItem(item),
                              variant: VButtonVariant.danger,
                              child: const VText('Delete',
                                  variant: VTextVariant.label),
                            ),
                          ),
                          child: VSurface(
                            variant: VSurfaceVariant.elevated,
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: VText(
                                'Item $item',
                                variant: VTextVariant.body,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const VText(
                      'Horizontal direction',
                      variant: VTextVariant.title,
                    ),
                    SizedBox(
                      height: 56,
                      child: VAnimatedList(
                        scrollDirection: Axis.horizontal,
                        gap: 8,
                        children: _items.map((item) {
                          return VSurface(
                            variant: VSurfaceVariant.elevated,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 10,
                              ),
                              child: VText(
                                'Item $item',
                                variant: VTextVariant.body,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ]),
            ),
          ),
        ]);
  }
}

