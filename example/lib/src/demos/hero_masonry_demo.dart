part of '../../main.dart';

class _HeroMasonryDemo extends StatefulWidget {
  const _HeroMasonryDemo();

  @override
  State<_HeroMasonryDemo> createState() => _HeroMasonryDemoState();
}

class _HeroMasonryDemoState extends State<_HeroMasonryDemo> {
  final List<_MasonryCardData> _cards = [
    _MasonryCardData(
      id: 1,
      title: 'Neon Horizon',
      category: 'Digital Art',
      height: 180,
      gradient: [const Color(0xFF8B5CF6), const Color(0xFFEC4899)],
      icon: LucideIcons.palette,
      description: 'A study in high-contrast synthwave gradients and digital landscapes inspired by late 80s nostalgia.',
    ),
    _MasonryCardData(
      id: 2,
      title: 'Deep Cyan',
      category: 'Minimalism',
      height: 240,
      gradient: [const Color(0xFF06B6D4), const Color(0xFF3B82F6)],
      icon: LucideIcons.compass,
      description: 'Abstract calming representation of aquatic deep-sea currents utilizing smooth linear steps and soft shadows.',
    ),
    _MasonryCardData(
      id: 3,
      title: 'Amber Flame',
      category: 'Vector Craft',
      height: 150,
      gradient: [const Color(0xFFF59E0B), const Color(0xFFEF4444)],
      icon: LucideIcons.flame,
      description: 'An organic hot visual layout of blazing curves and warm transitions, ideal for modern dynamic apps.',
    ),
    _MasonryCardData(
      id: 4,
      title: 'Emerald Fields',
      category: 'Generative',
      height: 220,
      gradient: [const Color(0xFF10B981), const Color(0xFF059669)],
      icon: LucideIcons.sprout,
      description: 'Math-driven procedural forest patterns and leaf structure algorithms compiled in high resolution.',
    ),
    _MasonryCardData(
      id: 5,
      title: 'Cosmic Nebula',
      category: 'Space Exploration',
      height: 200,
      gradient: [const Color(0xFF6366F1), const Color(0xFFD946EF)],
      icon: LucideIcons.orbit,
      description: 'A high-fidelity render of deep space cluster formations, starry dust, and interstellar gaseous clouds.',
    ),
    _MasonryCardData(
      id: 6,
      title: 'Dusk Shadows',
      category: 'Photography',
      height: 160,
      gradient: [const Color(0xFF4B5563), const Color(0xFF1F2937)],
      icon: LucideIcons.camera,
      description: 'Capturing the precise twilight moment when shadows lengthen and the city light transitions to artificial lamps.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);

    return VFlex.vertical(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      gap: 16,
      children: [
        VFlex.vertical(
          gap: 4,
          children: [
            const VText('Hero Masonry Gallery', variant: VTextVariant.heading),
            VText(
              'Click any card to launch a smooth Hero animation transition',
              variant: VTextVariant.caption,
              color: theme.colors.textMuted,
            ),
          ],
        ),
        
        SizedBox(
          height: 640,
          child: VScrollableGrid<_MasonryCardData>(
            items: _cards,
            layout: VGridLayout.masonry,
            crossAxisCount: 2,
            spacing: 16,
            runSpacing: 16,
            padding: const EdgeInsets.all(4),
            itemBuilder: (context, card, index) {
              final heroTag = 'hero-masonry-card-${card.id}';
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    VPageRoute<void>(
                      settings: RouteSettings(name: '/hero-detail/${card.id}'),
                      builder: (ctx) => _HeroDetailScreen(card: card, heroTag: heroTag),
                      motion: theme.motion,
                    ),
                  );
                },
                child: Hero(
                  tag: heroTag,
                  flightShuttleBuilder: (flightContext, animation, flightDirection, fromHeroContext, toHeroContext) {
                    final isPush = flightDirection == HeroFlightDirection.push;
                    // Pre-compute constant values outside the per-frame builder
                    // to avoid allocating LinearGradient/BoxDecoration each tick.
                    final gradient = LinearGradient(
                      colors: card.gradient,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    );
                    final startRadius = theme.radii.md;
                    final endRadius = isPush ? 0.0 : theme.radii.md;
                    return AnimatedBuilder(
                      animation: animation,
                      child: Center(
                        child: VIcon(
                          card.icon,
                          size: 32,
                          color: const Color(0xFFFFFFFF),
                        ),
                      ),
                      builder: (context, iconChild) {
                        final t = animation.value;
                        final radius = startRadius + (endRadius - startRadius) * t;
                        return DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: gradient,
                            borderRadius: BorderRadius.circular(radius),
                          ),
                          child: Transform.scale(
                            scale: 1.0 + (t * 0.5),
                            child: iconChild,
                          ),
                        );
                      },
                    );
                  },
                  child: VSurface(
                    variant: VSurfaceVariant.elevated,
                    child: SizedBox(
                      height: card.height.toDouble(),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(theme.radii.md),
                        child: VFlex.vertical(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: card.gradient,
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                ),
                                child: Center(
                                  child: VIcon(
                                    card.icon,
                                    size: 28,
                                    color: const Color(0xFFFFFFFF),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: VFlex.vertical(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                gap: 2,
                                children: [
                                  VText(
                                    card.category.toUpperCase(),
                                    variant: VTextVariant.caption,
                                    color: theme.colors.textMuted,
                                  ),
                                  VText(
                                    card.title,
                                    variant: VTextVariant.label,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _MasonryCardData {
  _MasonryCardData({
    required this.id,
    required this.title,
    required this.category,
    required this.height,
    required this.gradient,
    required this.icon,
    required this.description,
  });

  final int id;
  final String title;
  final String category;
  final int height;
  final List<Color> gradient;
  final IconData icon;
  final String description;
}

class _HeroDetailScreen extends StatelessWidget {
  const _HeroDetailScreen({
    required this.card,
    required this.heroTag,
  });

  final _MasonryCardData card;
  final String heroTag;

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);

    return VScaffold(
      body: CustomScrollView(
        slivers: [
          // Banner Area using Hero
          SliverToBoxAdapter(
            child: Hero(
              tag: heroTag,
              child: Container(
                height: 280,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: card.gradient,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: SafeArea(
                  bottom: false,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 16,
                        left: 16,
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xFF000000).withValues(alpha: 0.35),
                              shape: BoxShape.circle,
                            ),
                            child: const VIcon(
                              LucideIcons.arrowLeft,
                              color: Color(0xFFFFFFFF),
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: VIcon(
                          card.icon,
                          size: 64,
                          color: const Color(0xFFFFFFFF),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          
          // Staggered Information entrance
          SliverPadding(
            padding: const EdgeInsets.all(24),
            sliver: SliverToBoxAdapter(
              child: VStagger(
                delay: const Duration(milliseconds: 100),
                children: [
                  VFlex.vertical(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    gap: 6,
                    children: [
                      VText(
                        card.category.toUpperCase(),
                        variant: VTextVariant.caption,
                        color: theme.colors.textMuted,
                      ),
                      VText(
                        card.title,
                        variant: VTextVariant.heading,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  VDivider(),
                  const SizedBox(height: 16),
                  VText(
                    card.description,
                    variant: VTextVariant.body,
                  ),
                  const SizedBox(height: 24),
                  VSurface(
                    variant: VSurfaceVariant.panel,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: VFlex.vertical(
                        gap: 12,
                        children: [
                          const VText('Technical Details', variant: VTextVariant.title),
                          _buildDetailRow(theme, 'Render Engine', 'VidraCore V1.0'),
                          _buildDetailRow(theme, 'Color Space', 'P3 Harmonious HSL'),
                          _buildDetailRow(theme, 'Original Height', '${card.height}px'),
                          _buildDetailRow(theme, 'Animation Profile', 'Optimized Hero flight'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  VButton(
                    onPressed: () => Navigator.of(context).pop(),
                    variant: VButtonVariant.primary,
                    child: const VText('Back to Grid', variant: VTextVariant.label),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(VThemeData theme, String label, String value) {
    return VFlex.horizontal(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        VText(label, variant: VTextVariant.body, color: theme.colors.textMuted),
        VText(value, variant: VTextVariant.label),
      ],
    );
  }
}
