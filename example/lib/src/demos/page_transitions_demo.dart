part of '../../main.dart';

class _PageTransitionsDemo extends StatefulWidget {
  const _PageTransitionsDemo();

  @override
  State<_PageTransitionsDemo> createState() => _PageTransitionsDemoState();
}

class _PageTransitionsDemoState extends State<_PageTransitionsDemo> {
  VPageTransition _selected = VPageTransition.iosDepthSlide;
  final _navigatorKey = GlobalKey<NavigatorState>();

  static const _transitions = <(String label, String zhLabel, VPageTransition value)>[
    ('iOS Depth Slide', 'iOS 深度滑动', VPageTransition.iosDepthSlide),
    ('Shared Axis X', '共享轴 X', VPageTransition.sharedAxisX),
    ('Shared Axis Y', '共享轴 Y', VPageTransition.sharedAxisY),
    ('Shared Axis Z', '共享轴 Z', VPageTransition.sharedAxisZ),
    ('Zoom Up Reveal', '缩放弹出', VPageTransition.zoomUpReveal),
    ('3D Perspective', '3D 透视', VPageTransition.perspective3D),
    ('Fade', '淡入淡出', VPageTransition.fade),
    ('Adaptive', '自适应', VPageTransition.adaptive),
    ('None', '无动效', VPageTransition.none),
  ];

  void _push() {
    _navigatorKey.currentState?.pushNamed('/detail');
  }

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);
    return VFlex.vertical(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      gap: 16,
      children: [
        const VText('Page Transitions', variant: VTextVariant.heading),

        // Transition selector
        VSurface(
          variant: VSurfaceVariant.card,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: VFlex.vertical(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              gap: 12,
              children: [
                const VText('Select transition', variant: VTextVariant.title),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _transitions.map((t) {
                    final (label, _, value) = t;
                    final isSelected = _selected == value;
                    return VButton(
                      variant: isSelected
                          ? VButtonVariant.primary
                          : VButtonVariant.secondary,
                      onPressed: () => setState(() => _selected = value),
                      child: VText(label, variant: VTextVariant.label),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),

        // Live mini Navigator preview
        VSurface(
          variant: VSurfaceVariant.card,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: VFlex.vertical(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              gap: 12,
              children: [
                Row(children: [
                  Expanded(
                    child: VFlex.vertical(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      gap: 2,
                      children: [
                        const VText('Live preview', variant: VTextVariant.title),
                        VText(
                          'Tap "Push" → see transition → tap Back or swipe from left edge',
                          variant: VTextVariant.caption,
                          color: theme.colors.textMuted,
                        ),
                      ],
                    ),
                  ),
                  VButton(
                    onPressed: _push,
                    child: const VText('Push →', variant: VTextVariant.label),
                  ),
                ]),
                ClipRRect(
                  borderRadius: BorderRadius.circular(theme.radii.lg),
                  child: SizedBox(
                    height: 320,
                    child: _TransitionPreviewNavigator(
                      navigatorKey: _navigatorKey,
                      transition: _selected,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Description card
        VSurface(
          variant: VSurfaceVariant.panel,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: VFlex.vertical(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              gap: 8,
              children: [
                const VText('Usage', variant: VTextVariant.title),
                const VText(
                  'Set VMotion.pageTransition to configure the app-wide default. '
                  'Use VMotionScope for per-route overrides.',
                  variant: VTextVariant.body,
                ),
                const VText(
                  'iosDepthSlide and adaptive (on iOS/macOS) automatically enable '
                  'swipe-to-back from the left 20 px edge.',
                  variant: VTextVariant.body,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _TransitionPreviewNavigator extends StatelessWidget {
  const _TransitionPreviewNavigator({
    required this.navigatorKey,
    required this.transition,
  });

  final GlobalKey<NavigatorState> navigatorKey;
  final VPageTransition transition;

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);
    final motion = theme.motion.copyWith(pageTransition: transition);

    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (settings) {
        if (settings.name == '/detail') {
          return VPageRoute<void>(
            settings: settings,
            motion: motion,
            builder: (ctx) => _PreviewPage(
              title: 'Detail Page',
              zhTitle: '详情页',
              subtitle: transition.name,
              color: theme.colors.actionPrimary,
              onBack: () => Navigator.of(ctx).pop(),
            ),
          );
        }
        return VPageRoute<void>(
          settings: settings,
          motion: motion,
          builder: (ctx) => _PreviewPage(
            title: 'Home Page',
            zhTitle: '首页',
            subtitle: 'Tap Push above',
            color: theme.colors.surfaceElevated,
            onBack: null,
          ),
        );
      },
    );
  }
}

class _PreviewPage extends StatelessWidget {
  const _PreviewPage({
    required this.title,
    required this.zhTitle,
    required this.subtitle,
    required this.color,
    required this.onBack,
  });

  final String title;
  final String zhTitle;
  final String subtitle;
  final Color color;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(color: theme.colors.background),
      child: VFlex.vertical(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Mini app bar
          DecoratedBox(
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              border: Border(
                bottom: BorderSide(
                  color: theme.colors.border,
                  width: 0.5,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                children: [
                  if (onBack != null) ...[
                    VButton(
                      variant: VButtonVariant.secondary,
                      onPressed: onBack,
                      semanticLabel: 'Back',
                      child: const VText('← Back', variant: VTextVariant.label),
                    ),
                    const SizedBox(width: 8),
                  ],
                  VText(title, variant: VTextVariant.title),
                  const SizedBox(width: 6),
                  VText(zhTitle,
                      variant: VTextVariant.caption,
                      color: theme.colors.textMuted),
                ],
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: VFlex.vertical(
                gap: 8,
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.15),
                      borderRadius:
                          BorderRadius.circular(theme.radii.lg),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(theme.spacing.xl),
                      child: VText(
                        subtitle,
                        variant: VTextVariant.heading,
                        color: color,
                      ),
                    ),
                  ),
                  if (onBack != null)
                    VText(
                      'Swipe left edge or tap Back to pop',
                      variant: VTextVariant.caption,
                      color: theme.colors.textMuted,
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


// docs-snippet:start page-transitions-basic
// VidraApp.navigator(
//   title: 'Example',
//   theme: VThemeData.light().copyWith(
//     motion: VThemeData.light().motion.copyWith(
//       pageTransition: VPageTransition.iosDepthSlide,
//     ),
//   ),
//   home: const HomePage(),
// );
//
// // Push a page with the app-wide transition:
// Navigator.of(context).push(
//   VPageRoute<void>(
//     motion: VTheme.of(context).motion,
//     builder: (_) => const DetailPage(),
//   ),
// );
//
// // Override the transition for one route:
// VMotionScope(
//   motion: VTheme.of(context).motion.copyWith(
//     pageTransition: VPageTransition.sharedAxisX,
//   ),
//   child: Builder(
//     builder: (ctx) => VButton(
//       onPressed: () => Navigator.of(ctx).push(
//         VPageRoute<void>(
//           motion: VMotionResolver.of(ctx),
//           builder: (_) => const DetailPage(),
//         ),
//       ),
//       child: const VText('Go', variant: VTextVariant.label),
//     ),
//   ),
// )
// docs-snippet:end page-transitions-basic

