part of '../../main.dart';

class _StickyHeaderDemo extends StatefulWidget {
  const _StickyHeaderDemo();

  @override
  State<_StickyHeaderDemo> createState() => _StickyHeaderDemoState();
}

class _StickyHeaderDemoState extends State<_StickyHeaderDemo> {
  bool _pinned = true;
  bool _floating = false;
  int _demoIndex = 0; // 0 = Fixed Grouping, 1 = Dynamic Header

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
            const VText('Sticky Header', variant: VTextVariant.heading),
            VText(
              'A sliver header that sticks to the top of the viewport when scrolled.',
              variant: VTextVariant.caption,
              color: theme.colors.textMuted,
            ),
          ],
        ),

        // Controls
        VSurface(
          variant: VSurfaceVariant.panel,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Wrap(
              spacing: 12,
              runSpacing: 8,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                VButton(
                  onPressed: () => setState(() => _demoIndex = 0),
                  variant: _demoIndex == 0 ? VButtonVariant.primary : VButtonVariant.secondary,
                  size: VControlSize.sm,
                  child: const VText('Fixed Grouping', variant: VTextVariant.label),
                ),
                VButton(
                  onPressed: () => setState(() => _demoIndex = 1),
                  variant: _demoIndex == 1 ? VButtonVariant.primary : VButtonVariant.secondary,
                  size: VControlSize.sm,
                  child: const VText('Dynamic Shrinking', variant: VTextVariant.label),
                ),
                VDivider(
                  color: theme.colors.border,
                ),
                VFlex.horizontal(
                  mainAxisSize: MainAxisSize.min,
                  gap: 6,
                  children: [
                    VSwitch(
                      checked: _pinned,
                      onChanged: (val) => setState(() => _pinned = val),
                    ),
                    const VText('Pinned', variant: VTextVariant.body),
                  ],
                ),
                VFlex.horizontal(
                  mainAxisSize: MainAxisSize.min,
                  gap: 6,
                  children: [
                    VSwitch(
                      checked: _floating,
                      onChanged: (val) => setState(() => _floating = val),
                    ),
                    const VText('Floating', variant: VTextVariant.body),
                  ],
                ),
              ],
            ),
          ),
        ),

        // Scroll Container
        SizedBox(
          height: 480,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(theme.radii.md),
            child: _demoIndex == 0
                ? _buildFixedGroupingDemo(theme)
                : _buildDynamicHeaderDemo(theme),
          ),
        ),
      ],
    );
  }

  Widget _buildFixedGroupingDemo(VThemeData theme) {
    final Map<String, List<String>> contacts = {
      'Favorites': ['Alice Smith', 'Bob Johnson', 'Charlie Brown'],
      'A': ['Aaron Carter', 'Abigail Adams', 'Albert Einstein', 'Alex Ferguson'],
      'B': ['Bailey Cooper', 'Barack Obama', 'Benjamin Franklin', 'Bruce Wayne'],
      'C': ['Clara Barton', 'Claude Monet', 'Colin Powell', 'Cris Evans'],
    };

    return CustomScrollView(
      slivers: [
        ...contacts.entries.map((entry) {
          final category = entry.key;
          final names = entry.value;

          return SliverMainAxisGroup(
            slivers: [
              // Sticky Category Header
              VStickyHeader(
                height: 40.0,
                pinned: _pinned,
                floating: _floating,
                builder: (context, shrinkOffset, overlapsContent) {
                  return Container(
                    decoration: BoxDecoration(
                      color: overlapsContent
                          ? theme.colors.surfaceElevated.withValues(alpha: 0.95)
                          : theme.colors.surface.withValues(alpha: 0.85),
                      border: Border(
                        bottom: BorderSide(
                          color: overlapsContent
                              ? theme.colors.border
                              : const Color(0x00000000),
                        ),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    alignment: Alignment.centerLeft,
                    child: VText(
                      category,
                      variant: VTextVariant.label,
                      color: overlapsContent
                          ? theme.colors.actionPrimary
                          : theme.colors.text,
                    ),
                  );
                },
              ),
              // Category Items
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final name = names[index];
                    return Container(
                      color: theme.colors.surface,
                      child: VListTile(
                        leading: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: theme.colors.actionPrimary.withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: VText(
                              name[0],
                              variant: VTextVariant.label,
                              color: theme.colors.actionPrimary,
                            ),
                          ),
                        ),
                        title: name,
                        subtitle: 'Mobile • Active now',
                      ),
                    );
                  },
                  childCount: names.length,
                ),
              ),
            ],
          );
        }),
      ],
    );
  }

  Widget _buildDynamicHeaderDemo(VThemeData theme) {
    const double minHeight = 54.0;
    const double maxHeight = 130.0;

    return CustomScrollView(
      slivers: [
        // Shrinking Dynamic Sticky Header
        VStickyHeader(
          minHeight: minHeight,
          maxHeight: maxHeight,
          pinned: _pinned,
          floating: _floating,
          builder: (context, shrinkOffset, overlapsContent) {
            // progress: 0.0 (fully expanded) to 1.0 (fully collapsed)
            final double progress = (shrinkOffset / (maxHeight - minHeight)).clamp(0.0, 1.0);
            
            // Interpolated values for fluid micro-animations
            final double titleSize = 24.0 - (progress * 8.0); // 24px down to 16px
            final double iconScale = 1.0 - progress; // 1.0 down to 0.0
            final double horizontalPadding = 20.0 + (progress * 16.0); // Shift indent on shrink
            final double titleVerticalOffset = 12.0 * (1.0 - progress);

            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    theme.colors.actionPrimary,
                    theme.colors.actionPrimary.withValues(alpha: 0.85),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: overlapsContent
                    ? [
                        BoxShadow(
                          color: const Color(0xFF000000).withValues(alpha: 0.15),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ]
                    : null,
              ),
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Stack(
                children: [
                  // Floating Back layer icon that disappears
                  if (iconScale > 0.05)
                    Positioned(
                      right: 20,
                      bottom: 12,
                      child: Transform.scale(
                        scale: iconScale,
                        child: Opacity(
                          opacity: iconScale,
                          child: const VIcon(
                            LucideIcons.sparkles,
                            color: Color(0xFFFFFFFF),
                            size: 40,
                          ),
                        ),
                      ),
                    ),
                  
                  // Dynamically shifting text group
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(top: titleVerticalOffset),
                      child: VFlex.vertical(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          VText(
                            'Generative Engine',
                            style: theme.typography.title.copyWith(
                              fontSize: titleSize,
                              color: const Color(0xFFFFFFFF),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (progress < 0.4)
                            Opacity(
                              opacity: 1.0 - (progress * 2.5),
                              child: const VText(
                                'Dynamic persistent content pipeline',
                                variant: VTextVariant.caption,
                                color: Color(0xFFE2E8F0),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),

        // Scrollable content list
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Container(
                color: theme.colors.surface,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: VFlex.vertical(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  gap: 8,
                  children: [
                    VText('Activity Feed #$index', variant: VTextVariant.title),
                    VText(
                      'This is mock summary text representing items within our sticky viewport context. Scrolling dynamically changes the top header bounds.',
                      variant: VTextVariant.body,
                      color: theme.colors.textMuted,
                    ),
                    const SizedBox(height: 8),
                    VDivider(),
                  ],
                ),
              );
            },
            childCount: 15,
          ),
        ),
      ],
    );
  }
}

// docs-snippet:start sticky-header-basic
// VStickyHeader(
//   height: 48.0,
//   pinned: true,
//   builder: (context, shrinkOffset, overlapsContent) => VSurface(
//     variant: VSurfaceVariant.panel,
//     child: Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: Align(
//         alignment: Alignment.centerLeft,
//         child: VText('Section Title'),
//       ),
//     ),
//   ),
// )
// docs-snippet:end sticky-header-basic
