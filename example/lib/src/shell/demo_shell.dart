part of '../../main.dart';

class DemoShell extends StatefulWidget {
  const DemoShell({super.key});

  @override
  State<DemoShell> createState() => _DemoShellState();
}

class _DemoShellState extends State<DemoShell> {
  bool _isDark = false;
  _DemoCategory _category = _DemoCategory.buttons;
  int _appearanceIndex = 0; // 0=none, 1=glass, 2=neumorphic
  String _query = '';

  void _select(_DemoCategory c) {
    setState(() {
      _category = c;
    });
  }

  void _toggleTheme() => setState(() => _isDark = !_isDark);
  void _cycleAppearance() =>
      setState(() => _appearanceIndex = (_appearanceIndex + 1) % 3);

  String get _appearanceLabel => switch (_appearanceIndex) {
        1 => 'Glass',
        2 => 'Neumorph',
        _ => 'Default',
      };

  Widget _buildContent({Color? overrideBackground}) {
    final base = _isDark ? VThemeData.dark() : VThemeData.light();
    final theme = overrideBackground != null
        ? base.copyWith(
            colors: base.colors.copyWith(background: overrideBackground))
        : base;
    return VTheme(
      data: theme,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 640;

          if (isWide) {
            return _WideLayout(
              isDark: _isDark,
              onToggleTheme: _toggleTheme,
              onCycleAppearance: _cycleAppearance,
              appearanceLabel: _appearanceLabel,
              selected: _category,
              onSelect: _select,
              query: _query,
              onQueryChanged: (value) => setState(() => _query = value),
            );
          } else {
            return _NarrowLayout(
              isDark: _isDark,
              onToggleTheme: _toggleTheme,
              appearanceLabel: _appearanceLabel,
              selected: _category,
              onSelect: _select,
              query: _query,
              onQueryChanged: (value) => setState(() => _query = value),
            );
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return switch (_appearanceIndex) {
      1 => DecoratedBox(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF7C3AED), Color(0xFF2563EB), Color(0xFF06B6D4)],
            ),
          ),
          child: VAppearanceScope(
            appearance: const ExampleGlassmorphismAppearance(),
            child: _buildContent(overrideBackground: const Color(0x00FFFFFF)),
          ),
        ),
      2 => ColoredBox(
          color: const Color(0xFFE8ECF1),
          child: VAppearanceScope(
            appearance: const ExampleNeumorphismAppearance(),
            child: _buildContent(overrideBackground: const Color(0x00FFFFFF)),
          ),
        ),
      _ => _buildContent(),
    };
  }
}

class _WideLayout extends StatelessWidget {
  const _WideLayout({
    required this.isDark,
    required this.onToggleTheme,
    this.onCycleAppearance,
    this.appearanceLabel = 'Default',
    required this.selected,
    required this.onSelect,
    required this.query,
    required this.onQueryChanged,
  });

  final bool isDark;
  final VoidCallback onToggleTheme;
  final VoidCallback? onCycleAppearance;
  final String appearanceLabel;
  final _DemoCategory selected;
  final void Function(_DemoCategory) onSelect;
  final String query;
  final ValueChanged<String> onQueryChanged;

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);
    return VScaffold(
      safeArea: true,
      header: _Header(
        isDark: isDark,
        onToggleTheme: onToggleTheme,
        onCycleAppearance: onCycleAppearance,
        appearanceLabel: appearanceLabel,
      ),
      body: VFlex.horizontal(
        padding: EdgeInsets.all(theme.spacing.md),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 260,
            child: VSurface(
              variant: VSurfaceVariant.elevated,
              child: _SidebarNav(
                selected: selected,
                onSelect: onSelect,
                query: query,
                onQueryChanged: onQueryChanged,
              ),
            ),
          ),
          const SizedBox(width: 1),
          Expanded(
            child: _DemoContent(category: selected),
          ),
        ],
      ),
    );
  }
}

class _NarrowLayout extends StatelessWidget {
  const _NarrowLayout({
    required this.isDark,
    required this.onToggleTheme,
    this.appearanceLabel = 'Default',
    required this.selected,
    required this.onSelect,
    required this.query,
    required this.onQueryChanged,
  });

  final bool isDark;
  final VoidCallback onToggleTheme;
  final String appearanceLabel;
  final _DemoCategory selected;
  final void Function(_DemoCategory) onSelect;
  final String query;
  final ValueChanged<String> onQueryChanged;

  @override
  Widget build(BuildContext context) {
    return VScaffold(
      safeArea: true,
      header: _Header(
        isDark: isDark,
        onToggleTheme: onToggleTheme,
        appearanceLabel: appearanceLabel,
        showMenuButton: true,
        onMenu: () {
          VSheet.show<void>(
            context,
            edge: VSheetEdge.left,
            builder: (sheetCtx) {
              return SizedBox(
                width: 240,
                child: _SidebarNav(
                  selected: selected,
                  onSelect: (cat) {
                    onSelect(cat);
                    VSheetScope.of<void>(sheetCtx)();
                  },
                  query: query,
                  onQueryChanged: onQueryChanged,
                  showBackdrop: false,
                ),
              );
            },
          );
        },
      ),
      body: _DemoContent(category: selected),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.isDark,
    required this.onToggleTheme,
    this.onCycleAppearance,
    this.appearanceLabel = 'Default',
    this.showMenuButton = false,
    this.onMenu,
  });

  final bool isDark;
  final VoidCallback onToggleTheme;
  final VoidCallback? onCycleAppearance;
  final String appearanceLabel;
  final bool showMenuButton;
  final VoidCallback? onMenu;

  @override
  Widget build(BuildContext context) {
    return VSurface(
      variant: VSurfaceVariant.base,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            if (showMenuButton)
              VButton(
                onPressed: onMenu,
                variant: VButtonVariant.secondary,
                semanticLabel: 'Menu',
                child: const VText('☰', variant: VTextVariant.label),
              ),
            if (showMenuButton) const SizedBox(width: 8),
            const VText('VidraUI', variant: VTextVariant.title),
            const Spacer(),
            if (onCycleAppearance != null) ...[
              VButton(
                onPressed: onCycleAppearance,
                variant: VButtonVariant.secondary,
                semanticLabel:
                    'Appearance style: $appearanceLabel. Click to cycle.',
                child: VText(
                  'Style: $appearanceLabel',
                  variant: VTextVariant.label,
                ),
              ),
              const SizedBox(width: 4),
            ],
            VButton(
              onPressed: onToggleTheme,
              variant: VButtonVariant.secondary,
              semanticLabel:
                  isDark ? 'Switch to light mode' : 'Switch to dark mode',
              child:
                  VIcon(isDark ? LucideIcons.moon : LucideIcons.sun),
            ),
          ],
        ),
      ),
    );
  }
}

