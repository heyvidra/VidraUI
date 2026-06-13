part of '../../main.dart';

class _SidebarNav extends StatelessWidget {
  const _SidebarNav({
    required this.selected,
    required this.onSelect,
    required this.query,
    required this.onQueryChanged,
    this.showBackdrop = true,
  });

  final _DemoCategory selected;
  final void Function(_DemoCategory) onSelect;
  final String query;
  final ValueChanged<String> onQueryChanged;
  final bool showBackdrop;

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);
    // Group categories by section, filtered by search query.
    final q = query.trim().toLowerCase();
    final grouped = <String, List<_DemoCategory>>{};
    for (final c in _DemoCategory.values) {
      if (q.isNotEmpty &&
          !c.label.toLowerCase().contains(q) &&
          !_zhTitleFor(c).toLowerCase().contains(q)) {
        continue;
      }
      final section = _sectionFor(c);
      (grouped[section.title] ??= []).add(c);
    }
    final sections = grouped.entries
        .map((e) => _SidebarSection(e.key, e.value))
        .toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(theme.spacing.md),
      child: VFlex.vertical(
        gap: theme.spacing.sm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const VText('Docs / 文档', variant: VTextVariant.title),
          VTextField(
            label: 'Search',
            hint: 'Component or API',
            semanticLabel: 'Search documentation',
            onChanged: onQueryChanged,
          ),
          VDivider(),
          ...sections.map((section) => _SidebarNavSection(
                section: section,
                selected: selected,
                onSelect: onSelect,
              )),
        ],
      ),
    );
  }
}

class _SidebarNavSection extends StatelessWidget {
  const _SidebarNavSection({
    required this.section,
    required this.selected,
    required this.onSelect,
  });

  final _SidebarSection section;
  final _DemoCategory selected;
  final void Function(_DemoCategory) onSelect;

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);

    return VFlex.vertical(
      gap: theme.spacing.xs,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.only(
            // left: theme.spacing.md,
            // right: theme.spacing.md,
            top: theme.spacing.xs,
          ),
          child: VText(
            section.title,
            variant: VTextVariant.title,
            color: theme.colors.textMuted,
          ),
        ),
        ...section.categories.map((category) => _SidebarNavItem(
              category: category,
              selected: category == selected,
              onSelect: onSelect,
            )),
      ],
    );
  }
}

class _SidebarNavItem extends StatelessWidget {
  const _SidebarNavItem({
    required this.category,
    required this.selected,
    required this.onSelect,
  });

  final _DemoCategory category;
  final bool selected;
  final void Function(_DemoCategory) onSelect;

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);
    return GestureDetector(
      onTap: () => onSelect(category),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: selected ? theme.colors.surfaceHover : null,
          borderRadius: BorderRadius.circular(theme.radii.md),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: theme.spacing.md,
            vertical: theme.spacing.sm,
          ),
          child: VFlex.horizontal(
            gap: 10,
            children: [
              VText(
                category.label,
                variant: VTextVariant.label,
                color:
                    selected ? theme.colors.actionPrimary : theme.colors.text,
              ),
              VText(
                _zhTitleFor(category),
                variant: VTextVariant.caption,
                color: theme.colors.textMuted,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

