part of '../../main.dart';

class _ApiTable extends StatelessWidget {
  const _ApiTable({required this.symbols});

  final List<VDocApiSymbol> symbols;

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);
    if (symbols.isEmpty) {
      return const VText(
        'No generated API metadata is available for this page.',
        variant: VTextVariant.body,
      );
    }
    return VFlex.vertical(
      gap: theme.spacing.md,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: symbols.map((symbol) {
        return VSurface(
          variant: VSurfaceVariant.elevated,
          child: Padding(
            padding: EdgeInsets.all(theme.spacing.md),
            child: VFlex.vertical(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              gap: theme.spacing.sm,
              children: [
                Wrap(
                  spacing: theme.spacing.sm,
                  runSpacing: theme.spacing.xs,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    VText(symbol.name, variant: VTextVariant.title),
                    VChip(
                      label: Text(symbol.kind),
                      variant: VChipVariant.soft,
                      size: VControlSize.sm,
                    ),
                    VText(symbol.library, variant: VTextVariant.caption),
                  ],
                ),
                if (symbol.members.isEmpty)
                  const VText(
                    'No public members detected.',
                    variant: VTextVariant.caption,
                  )
                else
                  VFlex.vertical(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    gap: theme.spacing.xs,
                    children: symbol.members.map((member) {
                      return _ApiMemberRow(member: member);
                    }).toList(),
                  ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _ApiMemberRow extends StatelessWidget {
  const _ApiMemberRow({required this.member});

  final VDocApiMember member;

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: theme.colors.border)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: theme.spacing.xs),
        child: VFlex.vertical(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          gap: 2,
          children: [
            Wrap(
              spacing: theme.spacing.xs,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                VText(member.name, variant: VTextVariant.label),
                VText(member.kind, variant: VTextVariant.caption),
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                member.signature,
                style: theme.typography.caption.copyWith(
                  color: theme.colors.textMuted,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

