part of '../../main.dart';

class _EmptyStateDemo extends StatelessWidget {
  const _EmptyStateDemo();

  @override
  Widget build(BuildContext context) {
    return VFlex.vertical(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      gap: 16,
      children: [
        const VText('Empty State', variant: VTextVariant.heading),
        VSurface(
          variant: VSurfaceVariant.card,
          child: SizedBox(
            height: 300,
            child: VEmptyState(
              icon: LucideIcons.inbox,
              title: 'No items yet',
              description: 'Items you add will appear here.',
            ),
          ),
        ),
        const VText('With Action', variant: VTextVariant.heading),
        VSurface(
          variant: VSurfaceVariant.card,
          child: SizedBox(
            height: 300,
            child: VEmptyState(
              icon: LucideIcons.search,
              title: 'No results found',
              description: 'Try adjusting your search or filter criteria.',
              action: VButton(
                variant: VButtonVariant.primary,
                onPressed: () {},
                child: const VText('Clear filters'),
              ),
            ),
          ),
        ),
        const VText('Minimal (text only)', variant: VTextVariant.heading),
        VSurface(
          variant: VSurfaceVariant.card,
          child: SizedBox(
            height: 200,
            child: const VEmptyState(
              title: 'Nothing here',
              description: 'This list is empty.',
            ),
          ),
        ),
      ],
    );
  }
}
