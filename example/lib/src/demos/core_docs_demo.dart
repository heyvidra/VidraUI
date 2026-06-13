part of '../../main.dart';

class _CoreDocsDemo extends StatelessWidget {
  const _CoreDocsDemo({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);
    return VFlex.vertical(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      gap: theme.spacing.md,
      children: [
        VText(title, variant: VTextVariant.heading),
        VSurface(
          variant: VSurfaceVariant.card,
          child: Padding(
            padding: EdgeInsets.all(theme.spacing.lg),
            child: VFlex.vertical(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              gap: theme.spacing.md,
              children: [
                VText(body, variant: VTextVariant.body),
                VFlex.horizontal(
                  gap: theme.spacing.sm,
                  children: const [
                    VButton(
                      onPressed: _CoreDocsDemo._noop,
                      child: VText('Primary action'),
                    ),
                    VButton(
                      onPressed: _CoreDocsDemo._noop,
                      variant: VButtonVariant.secondary,
                      child: VText('Secondary action'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  static void _noop() {}
}

