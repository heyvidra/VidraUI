part of 'v_scrollable_grid.dart';

class _DefaultEmptyState extends StatelessWidget {
  const _DefaultEmptyState();

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
        child: VFlex.vertical(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            VText(
              'No items',
              variant: VTextVariant.title,
              color: theme.colors.textMuted,
            ),
            const SizedBox(height: 8),
            VText(
              'There is no data to show here right now.',
              variant: VTextVariant.caption,
              color: theme.colors.textDisabled,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _DefaultErrorState extends StatelessWidget {
  const _DefaultErrorState({required this.error});

  final Object error;

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
        child: VFlex.vertical(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            VText(
              'Failed to load data',
              variant: VTextVariant.title,
              color: theme.colors.danger,
            ),
            const SizedBox(height: 8),
            VText(
              error.toString(),
              variant: VTextVariant.caption,
              color: theme.colors.textMuted,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _DefaultBottomError extends StatelessWidget {
  const _DefaultBottomError({required this.error});

  final Object error;

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: VText(
          'Error loading more: $error',
          variant: VTextVariant.caption,
          color: theme.colors.danger,
        ),
      ),
    );
  }
}




