part of '../../main.dart';

class _NavigationBarDemo extends StatefulWidget {
  const _NavigationBarDemo();

  @override
  State<_NavigationBarDemo> createState() => _NavigationBarDemoState();
}

class _NavigationBarDemoState extends State<_NavigationBarDemo> {
  // Each bar gets its own selected index so they're independently interactive.
  final _shapesIndex = <int>[0, 1, 0];
  final _indicatorsIndex = <int>[1, 0, 0, 1];
  final _contentIndex = <int>[0, 0, 0];
  final _fabIndex = <int>[0, 0];
  int _badgeIndex = 0;
  int _disabledIndex = 0;
  int _brandIndex = 0;
  int _capsuleIndex = 0;

  // Simulator State
  VNavigationBarShape _simShape = VNavigationBarShape.flat;
  VNavigationBarIndicator _simIndicator = VNavigationBarIndicator.pill;
  VNavigationBarContentMode _simContentMode = VNavigationBarContentMode.labeled;
  VNavigationBarAnimation _simAnimation = VNavigationBarAnimation.scale;
  bool _simHasFab = false;
  bool _simHasBadges = true;
  int _simSelectedIndex = 0;

  void _setShapeIdx(int bar, int i) => setState(() => _shapesIndex[bar] = i);
  void _setIndicatorIdx(int bar, int i) =>
      setState(() => _indicatorsIndex[bar] = i);
  void _setContentIdx(int bar, int i) => setState(() => _contentIndex[bar] = i);
  void _setFabIdx(int bar, int i) => setState(() => _fabIndex[bar] = i);

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);

    return VFlex.vertical(
      gap: theme.spacing.xl,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const VText('VNavigationBar', variant: VTextVariant.heading),
        const VText(
          'A bottom navigation bar for top-level app navigation. Supports multiple shapes, indicator styles, content modes, badges, disabled states, theme overrides, and optional center FAB.',
        ),

        // ── 0. Mobile Simulator ──
        _DocsSection(
          title: 'Interactive Mobile Simulator — 异形屏实时适配模拟器',
          child: VFlex.horizontal(
            gap: theme.spacing.xl,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _SimulatedPhone(
                shape: _simShape,
                indicator: _simIndicator,
                contentMode: _simContentMode,
                animation: _simAnimation,
                hasFab: _simHasFab,
                hasBadges: _simHasBadges,
                selectedIndex: _simSelectedIndex,
                onChanged: (i) => setState(() => _simSelectedIndex = i),
              ),
              Expanded(
                child: VFlex.vertical(
                  gap: theme.spacing.md,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const VText(
                      '改变以下属性，在左侧模拟手机中实时预览。扁平底栏会自动向下延伸铺满系统 Home 指示条；悬浮/胶囊底栏会自动整体被安全区推起浮动，极为灵动。',
                      variant: VTextVariant.body,
                    ),
                    SizedBox(height: theme.spacing.sm),
                    const VText('底栏外形形状 (Shape)',
                        variant: VTextVariant.caption),
                    VSegmentedControl<VNavigationBarShape>(
                      value: _simShape,
                      options: const [
                        VSegmentedControlOption(
                            value: VNavigationBarShape.flat,
                            label: 'Flat (直角吸底)'),
                        VSegmentedControlOption(
                            value: VNavigationBarShape.floating,
                            label: 'Floating (悬浮)'),
                        VSegmentedControlOption(
                            value: VNavigationBarShape.capsule,
                            label: 'Capsule (胶囊)'),
                      ],
                      onChanged: (v) => setState(() => _simShape = v),
                    ),
                    const VText('选中指示器风格 (Indicator)',
                        variant: VTextVariant.caption),
                    VSegmentedControl<VNavigationBarIndicator>(
                      value: _simIndicator,
                      options: const [
                        VSegmentedControlOption(
                            value: VNavigationBarIndicator.pill,
                            label: 'Pill (药丸)'),
                        VSegmentedControlOption(
                            value: VNavigationBarIndicator.dot,
                            label: 'Dot (圆点)'),
                        VSegmentedControlOption(
                            value: VNavigationBarIndicator.topLine,
                            label: 'TopLine (上划线)'),
                        VSegmentedControlOption(
                            value: VNavigationBarIndicator.none,
                            label: 'None (无)'),
                      ],
                      onChanged: (v) => setState(() => _simIndicator = v),
                    ),
                    const VText('显示内容模式 (Content Mode)',
                        variant: VTextVariant.caption),
                    VSegmentedControl<VNavigationBarContentMode>(
                      value: _simContentMode,
                      options: const [
                        VSegmentedControlOption(
                            value: VNavigationBarContentMode.labeled,
                            label: 'Labeled (图文)'),
                        VSegmentedControlOption(
                            value: VNavigationBarContentMode.iconsOnly,
                            label: 'Icons (纯图标)'),
                        VSegmentedControlOption(
                            value: VNavigationBarContentMode.labelsOnly,
                            label: 'Labels (纯文本)'),
                      ],
                      onChanged: (v) => setState(() => _simContentMode = v),
                    ),
                    const VText('过渡切换动画 (Animation Mode)',
                        variant: VTextVariant.caption),
                    VSegmentedControl<VNavigationBarAnimation>(
                      value: _simAnimation,
                      options: const [
                        VSegmentedControlOption(
                            value: VNavigationBarAnimation.scale,
                            label: 'Scale (回弹缩放)'),
                        VSegmentedControlOption(
                            value: VNavigationBarAnimation.shift,
                            label: 'Shift (平移渐显)'),
                        VSegmentedControlOption(
                            value: VNavigationBarAnimation.none,
                            label: 'None (瞬变色)'),
                      ],
                      onChanged: (v) => setState(() => _simAnimation = v),
                    ),
                    VFlex.horizontal(
                      gap: theme.spacing.lg,
                      children: [
                        VFlex.horizontal(
                          gap: theme.spacing.xs,
                          children: [
                            VSwitch(
                              checked: _simHasFab,
                              onChanged: (v) => setState(() => _simHasFab = v),
                            ),
                            const VText('Raised Center FAB (中心加号)',
                                variant: VTextVariant.body),
                          ],
                        ),
                        VFlex.horizontal(
                          gap: theme.spacing.xs,
                          children: [
                            VSwitch(
                              checked: _simHasBadges,
                              onChanged: (v) =>
                                  setState(() => _simHasBadges = v),
                            ),
                            const VText('Show Badges (未读角标)',
                                variant: VTextVariant.body),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // ── 1. Shapes ──
        _DocsSection(
          title: 'Shapes — Flat · Floating · Capsule',
          child: VFlex.vertical(
            gap: theme.spacing.md,
            children: [
              for (int i = 0; i < VNavigationBarShape.values.length; i++)
                _DemoBar(
                  label: VNavigationBarShape.values[i].name,
                  child: VNavigationBar(
                    shape: VNavigationBarShape.values[i],
                    destinations: _destinations(4),
                    selectedIndex: _shapesIndex[i],
                    onChanged: (v) => _setShapeIdx(i, v),
                  ),
                ),
            ],
          ),
        ),

        // ── 2. Indicators ──
        _DocsSection(
          title: 'Indicators — Pill · Dot · TopLine · None',
          child: VFlex.vertical(
            gap: theme.spacing.md,
            children: [
              for (int i = 0; i < VNavigationBarIndicator.values.length; i++)
                _DemoBar(
                  label: VNavigationBarIndicator.values[i].name,
                  child: VNavigationBar(
                    indicator: VNavigationBarIndicator.values[i],
                    destinations: _destinations(4),
                    selectedIndex: _indicatorsIndex[i],
                    onChanged: (v) => _setIndicatorIdx(i, v),
                  ),
                ),
            ],
          ),
        ),

        // ── 3. Content modes ──
        _DocsSection(
          title: 'Content Modes — Labeled · Icons Only · Labels Only',
          child: VFlex.vertical(
            gap: theme.spacing.md,
            children: [
              for (int i = 0; i < VNavigationBarContentMode.values.length; i++)
                _DemoBar(
                  label: VNavigationBarContentMode.values[i].name,
                  child: VNavigationBar(
                    shape: VNavigationBarShape.floating,
                    contentMode: VNavigationBarContentMode.values[i],
                    destinations: _destinations(3),
                    selectedIndex: _contentIndex[i],
                    onChanged: (v) => _setContentIdx(i, v),
                  ),
                ),
            ],
          ),
        ),

        // ── 4. Capsule — more realistic (5 items, colorful bg) ──
        _DocsSection(
          title: 'Capsule — with 5 items & page background',
          child: VFlex.vertical(
            gap: theme.spacing.md,
            children: [
              const VText(
                'A capsule bar floating over colored page content, like Telegram / Apple Music.',
                variant: VTextVariant.caption,
              ),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F0F5),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.only(bottom: 8),
                child: VNavigationBar(
                  shape: VNavigationBarShape.capsule,
                  destinations: _destinations(5),
                  selectedIndex: _capsuleIndex,
                  onChanged: (v) => setState(() => _capsuleIndex = v),
                ),
              ),
            ],
          ),
        ),

        // ── 5. Center FAB ──
        _DocsSection(
          title: 'Center FAB — Flat + Notch · Floating + Notch',
          child: VFlex.vertical(
            gap: theme.spacing.md,
            children: [
              for (int i = 0; i < 2; i++)
                _DemoBar(
                  label: VNavigationBarShape.values[i].name,
                  child: VNavigationBar(
                    shape: VNavigationBarShape.values[i],
                    destinations: _destinations(4),
                    selectedIndex: _fabIndex[i],
                    onChanged: (v) => _setFabIdx(i, v),
                    centerDestination: VNavigationDestination(
                      icon: Icon(LucideIcons.plus, size: 24),
                      label: 'Create',
                    ),
                  ),
                ),
            ],
          ),
        ),

        // ── 6. Badges ──
        _DocsSection(
          title: 'Badges — Count · Dot · No badge',
          child: VFlex.vertical(
            gap: theme.spacing.md,
            children: [
              _DemoBar(
                label: 'With badges (count + dot)',
                child: VNavigationBar(
                  shape: VNavigationBarShape.floating,
                  destinations: [
                    _dest('Home', LucideIcons.home),
                    VNavigationDestination(
                      icon: Icon(LucideIcons.messageCircle, size: 24),
                      selectedIcon: Icon(LucideIcons.messageCircle, size: 24),
                      label: 'Messages',
                      badge: const VBadge(count: 5, child: SizedBox.shrink()),
                    ),
                    VNavigationDestination(
                      icon: Icon(LucideIcons.bell, size: 24),
                      selectedIcon: Icon(LucideIcons.bell, size: 24),
                      label: 'Alerts',
                      badge:
                          const VBadge(showDot: true, child: SizedBox.shrink()),
                    ),
                    _dest('Profile', LucideIcons.user),
                  ],
                  selectedIndex: _badgeIndex,
                  onChanged: (v) => setState(() => _badgeIndex = v),
                ),
              ),
            ],
          ),
        ),

        // ── 7. Disabled ──
        _DocsSection(
          title: 'Disabled — Full bar · Individual item',
          child: VFlex.vertical(
            gap: theme.spacing.md,
            children: [
              _DemoBar(
                label: 'Entire bar disabled',
                child: VNavigationBar(
                  enabled: false,
                  destinations: _destinations(3),
                  selectedIndex: _disabledIndex,
                  onChanged: (v) => setState(() => _disabledIndex = v),
                ),
              ),
              _DemoBar(
                label: 'Single destination disabled',
                child: VNavigationBar(
                  shape: VNavigationBarShape.floating,
                  destinations: [
                    _dest('Home', LucideIcons.home),
                    VNavigationDestination(
                      icon: Icon(LucideIcons.search, size: 24),
                      label: 'Search',
                      enabled: false,
                    ),
                    _dest('Settings', LucideIcons.settings),
                  ],
                  selectedIndex: 0,
                  onChanged: (_) {},
                ),
              ),
            ],
          ),
        ),

        // ── 8. Theme override ──
        _DocsSection(
          title: 'Theme Override — Custom brand colors',
          child: VFlex.vertical(
            gap: theme.spacing.md,
            children: [
              _DemoBar(
                label: 'Green theme',
                child: VNavigationBarTheme.override(
                  data: (theme, tokens) => tokens.copyWith(
                    foreground: VStateProperty.resolveWith(
                      normal: theme.colors.textMuted,
                      selected: const Color(0xFF10B981),
                    ),
                    indicatorBackground: VStateProperty.resolveWith(
                      normal: const Color(0xFF10B981).withValues(alpha: 0.15),
                    ),
                    borderRadius: 20,
                    indicatorRadius: 14,
                    centerFabBackground: const Color(0xFF10B981),
                  ),
                  child: VNavigationBar(
                    shape: VNavigationBarShape.floating,
                    destinations: _destinations(4),
                    selectedIndex: _brandIndex,
                    onChanged: (v) => setState(() => _brandIndex = v),
                  ),
                ),
              ),
              _DemoBar(
                label: 'Violet / rounded pill indicator',
                child: VNavigationBarTheme.override(
                  data: (theme, tokens) => tokens.copyWith(
                    foreground: VStateProperty.resolveWith(
                      normal: theme.colors.textMuted,
                      selected: const Color(0xFF8B5CF6),
                    ),
                    indicatorBackground: VStateProperty.resolveWith(
                      normal: const Color(0xFF8B5CF6).withValues(alpha: 0.15),
                    ),
                    indicatorRadius: 99,
                    iconSize: 22,
                  ),
                  child: VNavigationBar(
                    indicator: VNavigationBarIndicator.pill,
                    destinations: _destinations(4),
                    selectedIndex: 1,
                    onChanged: (_) {},
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  static const _icons = <IconData>[
    LucideIcons.home,
    LucideIcons.search,
    LucideIcons.bell,
    LucideIcons.user,
    LucideIcons.settings,
    LucideIcons.compass,
  ];

  static const _labels = <String>[
    'Home',
    'Search',
    'Alerts',
    'Profile',
    'Settings',
    'Explore',
  ];

  static VNavigationDestination _dest(String label, IconData icon) =>
      VNavigationDestination(
        icon: Icon(icon, size: 24),
        selectedIcon: Icon(icon, size: 24),
        label: label,
      );

  static List<VNavigationDestination> _destinations(int count) {
    return List.generate(
      count,
      (i) => VNavigationDestination(
        icon: Icon(_icons[i], size: 24),
        selectedIcon: Icon(_icons[i], size: 24),
        label: _labels[i],
      ),
    );
  }
}

class _SimulatedPhone extends StatelessWidget {
  const _SimulatedPhone({
    required this.shape,
    required this.indicator,
    required this.contentMode,
    required this.animation,
    required this.hasFab,
    required this.hasBadges,
    required this.selectedIndex,
    required this.onChanged,
  });

  final VNavigationBarShape shape;
  final VNavigationBarIndicator indicator;
  final VNavigationBarContentMode contentMode;
  final VNavigationBarAnimation animation;
  final bool hasFab;
  final bool hasBadges;
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);

    return Container(
      width: 440,
      height: 956,
      decoration: BoxDecoration(
        color: theme.colors.background,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color: const Color(0xFF1E293B), // slate-800
          width: 8,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            // 1. Simulated screen content
            Positioned.fill(
              child: MediaQuery(
                data: const MediaQueryData(
                  padding: EdgeInsets.only(top: 40, bottom: 15),
                ),
                child: VScaffold(
                  safeArea: true,
                  safeAreaTop: true,
                  safeAreaBottom: true,
                  header: const VAppBar(
                    title: VText('Phone Preview',
                        variant: VTextVariant.body,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  body: Container(
                    color: const Color(0xFFF1F5F9), // slate-100
                    child: VFlex.vertical(
                      padding: const EdgeInsets.all(16),
                      gap: 12,
                      children: [
                        const VText(
                          '🌟 Live Mockup',
                          variant: VTextVariant.title,
                        ),
                        const VText(
                          '此面板模拟了一台运行中的异形屏智能手机（含顶部 Dynamic Island 刘海和底部 Home 条）。',
                          variant: VTextVariant.caption,
                        ),
                        VBox(
                          height: 120,
                          child: VFlex.vertical(
                            gap: 8,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(
                                height: 8,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFCBD5E1),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              Container(
                                height: 8,
                                width: 140,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFCBD5E1),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  footer: VNavigationBar(
                    shape: shape,
                    indicator: indicator,
                    contentMode: contentMode,
                    animation: animation,
                    selectedIndex: selectedIndex,
                    onChanged: onChanged,
                    centerDestination: hasFab
                        ? const VNavigationDestination(
                            icon: Icon(LucideIcons.plus, size: 24),
                            label: 'Create',
                          )
                        : null,
                    destinations: [
                      const VNavigationDestination(
                        icon: Icon(LucideIcons.home, size: 24),
                        label: 'Home',
                      ),
                      VNavigationDestination(
                        icon: const Icon(LucideIcons.bell, size: 24),
                        label: 'Alerts',
                        badge: hasBadges
                            ? const VBadge(
                                showDot: true, child: SizedBox.shrink())
                            : null,
                      ),
                      VNavigationDestination(
                        icon: const Icon(LucideIcons.messageSquare, size: 24),
                        label: 'Chat',
                        badge: hasBadges
                            ? const VBadge(count: 3, child: SizedBox.shrink())
                            : null,
                      ),
                      const VNavigationDestination(
                        icon: Icon(LucideIcons.user, size: 24),
                        label: 'Me',
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // 2. Simulated Dynamic Island
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: const EdgeInsets.only(top: 8),
                width: 90,
                height: 22,
                decoration: BoxDecoration(
                  color: const Color(0xFF0F172A),
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Center(
                  child: Container(
                    width: 4,
                    height: 4,
                    decoration: const BoxDecoration(
                      color: Color(0xFF1E293B),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ),

            // 3. Simulated Home Indicator (only overlays at the absolute bottom)
            Align(
              alignment: Alignment.bottomCenter,
              child: IgnorePointer(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 6),
                  width: 100,
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0xFF64748B),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A thin labeled wrapper for a single demo bar.
class _DemoBar extends StatelessWidget {
  const _DemoBar({required this.label, required this.child});
  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return VFlex.vertical(
      gap: 4,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        VText(label, variant: VTextVariant.caption),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: VTheme.of(context).colors.border),
            borderRadius: BorderRadius.circular(12),
          ),
          child: child,
        ),
      ],
    );
  }
}

// docs-snippet:start navigation-bar-basic
// VNavigationBar(
//   shape: VNavigationBarShape.floating,
//   indicator: VNavigationBarIndicator.pill,
//   contentMode: VNavigationBarContentMode.labeled,
//   destinations: [
//     VNavigationDestination(
//       icon: Icon(LucideIcons.home),
//       label: 'Home',
//     ),
//     VNavigationDestination(
//       icon: Icon(LucideIcons.search),
//       label: 'Search',
//       badge: VBadge(count: 3, child: SizedBox.shrink()),
//     ),
//   ],
//   selectedIndex: _currentIndex,
//   onChanged: (i) => setState(() => _currentIndex = i),
// )
// docs-snippet:end navigation-bar-basic

// docs-snippet:start navigation-bar-center-fab
// VNavigationBar(
//   shape: VNavigationBarShape.floating,
//   destinations: [...],
//   selectedIndex: 0,
//   onChanged: (_) {},
//   centerDestination: VNavigationDestination(
//     icon: Icon(LucideIcons.plus),
//     label: 'Create',
//   ),
// )
// docs-snippet:end navigation-bar-center-fab
