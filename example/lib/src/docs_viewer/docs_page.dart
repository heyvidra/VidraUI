part of '../../main.dart';

class _DocsPage extends StatelessWidget {
  const _DocsPage({required this.metadata, required this.demo});

  final VDocPageMetadata metadata;
  final Widget demo;

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);
    final snippets = metadata.snippetIds
        .map((id) => vDocSnippets[id])
        .whereType<VDocCodeSnippet>()
        .toList();
    final apiSymbols = metadata.symbols
        .map((symbol) => vApiInventory[symbol])
        .whereType<VDocApiSymbol>()
        .toList();

    return VFlex.vertical(
      gap: theme.spacing.lg,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _DocsHero(metadata: metadata),
        const _MaturityOverview(),
        _DocsSection(
          title: 'Demo / 示例',
          child: demo,
        ),
        _DocsSection(
          title: 'Code / 调用方法',
          child: snippets.isEmpty
              ? const VText(
                  'No snippet has been extracted for this page yet.',
                  variant: VTextVariant.body,
                )
              : VFlex.vertical(
                  gap: theme.spacing.md,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: snippets.map(_CodeBlock.new).toList(),
                ),
        ),
        _DocsSection(
          title: 'API / 接口',
          child: _ApiTable(symbols: apiSymbols),
        ),
        _DocsSection(
          title: 'Usage Notes / 使用说明',
          child: VFlex.vertical(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            gap: theme.spacing.sm,
            children: metadata.usageNotes
                .map(
                  (note) => Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      VText('• ', variant: VTextVariant.body),
                      Expanded(
                        child: VText(note, variant: VTextVariant.body),
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}

class _MaturityOverview extends StatelessWidget {
  const _MaturityOverview();

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);
    return _DocsSection(
      title: 'Maturity / 成熟度',
      child: VFlex.vertical(
        gap: theme.spacing.sm,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          _MaturityRow(
            label: 'Stable',
            body:
                'Core controls and layout such as VButton, VTextField, VSurface, VBox, VFlex, VScaffold, plus overlay primitives.',
          ),
          _MaturityRow(
            label: 'Beta',
            body:
                'Form controls, VTable, VDatePicker, VTimePicker, and feedback primitives are usable while a11y, tokens, docs, and edge cases continue to mature.',
          ),
          _MaturityRow(
            label: 'Experimental',
            body:
                'Carousel, animated helpers, swipe actions, resizable surfaces, and appearance hooks may still evolve.',
          ),
          VText(
            'Use VTimeOfDay instead of the deprecated TimeOfDay alias. VTable is not a full data-grid. VTimePicker is 24-hour only and has no AM/PM period column.',
            variant: VTextVariant.caption,
          ),
        ],
      ),
    );
  }
}

class _MaturityRow extends StatelessWidget {
  const _MaturityRow({required this.label, required this.body});

  final String label;
  final String body;

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);
    return VFlex.horizontal(
      gap: theme.spacing.sm,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        VChip(
          label: Text(label),
          variant: VChipVariant.outlined,
        ),
        Expanded(
          child: VText(body, variant: VTextVariant.body),
        ),
      ],
    );
  }
}

class _DocsHero extends StatelessWidget {
  const _DocsHero({required this.metadata});

  final VDocPageMetadata metadata;

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);
    return VSurface(
      variant: VSurfaceVariant.panel,
      child: Padding(
        padding: EdgeInsets.all(theme.spacing.lg),
        child: VFlex.vertical(
          gap: theme.spacing.sm,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VText(
              metadata.category,
              variant: VTextVariant.caption,
              textAlign: TextAlign.center,
            ),
            VText(
              metadata.navLabel,
              variant: VTextVariant.heading,
              textAlign: TextAlign.center,
            ),
            VText(
              metadata.summary,
              variant: VTextVariant.body,
              textAlign: TextAlign.center,
            ),
            Wrap(
              spacing: theme.spacing.xs,
              runSpacing: theme.spacing.xs,
              children: metadata.symbols
                  .map(
                    (symbol) => VChip(
                      label: Text(symbol),
                      variant: VChipVariant.outlined,
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _DocsSection extends StatelessWidget {
  const _DocsSection({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);
    return VSurface(
      variant: VSurfaceVariant.card,
      child: Padding(
        padding: EdgeInsets.all(theme.spacing.lg),
        child: VFlex.vertical(
          gap: theme.spacing.md,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            VText(title, variant: VTextVariant.title),
            child,
          ],
        ),
      ),
    );
  }
}

