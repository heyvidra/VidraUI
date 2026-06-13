part of '../../main.dart';

class _DynamicLoadingDemo extends StatefulWidget {
  const _DynamicLoadingDemo();

  @override
  State<_DynamicLoadingDemo> createState() => _DynamicLoadingDemoState();
}

class _DynamicLoadingDemoState extends State<_DynamicLoadingDemo> {
  bool _isLoading = true;
  int _refreshCounter = 0;

  @override
  void initState() {
    super.initState();
    _startSimulatedLoading();
  }

  void _startSimulatedLoading() {
    setState(() {
      _isLoading = true;
    });
    // Simulate content fetch
    Future<void>.delayed(const Duration(milliseconds: 1600), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  void _triggerReload() {
    setState(() {
      _refreshCounter++;
    });
    _startSimulatedLoading();
  }

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);

    return VFlex.vertical(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      gap: 16,
      children: [
        VFlex.horizontal(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            VFlex.vertical(
              gap: 4,
              children: [
                VAnimatedText(
                  'Staggered Dashboard',
                  key: ValueKey('typewriter-title-$_refreshCounter'),
                  variant: VTextVariant.heading,
                  effect: VTextAnimationEffect.typewriter,
                ),
                VText(
                  'Micro-animations demonstrating dynamic content loading',
                  variant: VTextVariant.caption,
                  color: theme.colors.textMuted,
                ),
              ],
            ),
            VButton(
              onPressed: _triggerReload,
              variant: VButtonVariant.secondary,
              size: VControlSize.sm,
              child: VFlex.horizontal(
                mainAxisSize: MainAxisSize.min,
                gap: 6,
                children: [
                  VIcon(
                    LucideIcons.refreshCw,
                    size: 14,
                  ),
                  const VText('Replay', variant: VTextVariant.label),
                ],
              ),
            ),
          ],
        ),
        
        if (_isLoading)
          _buildSkeletons(theme)
        else
          _buildLoadedContent(theme),
      ],
    );
  }

  Widget _buildSkeletons(VThemeData theme) {
    return VStagger(
      key: ValueKey('skeletons-$_refreshCounter'),
      delay: const Duration(milliseconds: 100),
      children: [
        // Metric cards skeleton row
        VFlex.horizontal(
          gap: 16,
          children: List.generate(3, (i) => Expanded(
            child: VSurface(
              variant: VSurfaceVariant.card,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: VFlex.vertical(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  gap: 12,
                  children: [
                    VSkeletonBox(width: 60, height: 12, borderRadius: theme.radii.xs),
                    VSkeletonBox(width: 90, height: 28, borderRadius: theme.radii.sm),
                    VSkeletonBox(width: 40, height: 10, borderRadius: theme.radii.xs),
                  ],
                ),
              ),
            ),
          )),
        ),
        const SizedBox(height: 16),
        // Main chart card skeleton
        VSurface(
          variant: VSurfaceVariant.card,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: VFlex.vertical(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              gap: 16,
              children: [
                VSkeletonBox(width: 140, height: 16, borderRadius: theme.radii.xs),
                VSkeletonBox(width: double.infinity, height: 180, borderRadius: theme.radii.md),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        // Activity list items skeleton
        VSurface(
          variant: VSurfaceVariant.card,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: VFlex.vertical(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              gap: 16,
              children: [
                VSkeletonBox(width: 100, height: 14, borderRadius: theme.radii.xs),
                ...List.generate(3, (i) => VFlex.horizontal(
                  gap: 12,
                  children: [
                    const VSkeletonCircle(size: 36),
                    Expanded(
                      child: VFlex.vertical(
                        gap: 6,
                        children: [
                          VSkeletonBox(width: double.infinity, height: 12, borderRadius: theme.radii.xs),
                          VSkeletonBox(width: 150, height: 10, borderRadius: theme.radii.xs),
                        ],
                      ),
                    ),
                  ],
                )),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoadedContent(VThemeData theme) {
    return VStagger(
      key: ValueKey('content-$_refreshCounter'),
      delay: const Duration(milliseconds: 120),
      children: [
        // Metric cards loaded row
        VFlex.horizontal(
          gap: 16,
          children: [
            _buildMetricCard(
              theme,
              title: 'TOTAL REVENUE',
              value: r'$48,259.00',
              trend: '+12.5%',
              trendColor: theme.colors.success,
              bgGradient: const [Color(0xFF6366F1), Color(0xFF4F46E5)],
            ),
            _buildMetricCard(
              theme,
              title: 'ACTIVE SESSIONS',
              value: '1,482',
              trend: '+4.2%',
              trendColor: theme.colors.success,
              bgGradient: const [Color(0xFFEC4899), Color(0xFFDB2777)],
            ),
            _buildMetricCard(
              theme,
              title: 'SERVER LOAD',
              value: '38.4%',
              trend: '-2.1%',
              trendColor: theme.colors.success,
              bgGradient: const [Color(0xFF14B8A6), Color(0xFF0D9488)],
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Main chart card loaded
        VSurface(
          variant: VSurfaceVariant.card,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: VFlex.vertical(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              gap: 16,
              children: [
                VFlex.horizontal(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const VText('Analytics Activity Overview', variant: VTextVariant.title),
                    VText('Live', variant: VTextVariant.caption, color: theme.colors.success),
                  ],
                ),
                // Simulated Chart using customizable graphics
                SizedBox(
                  height: 180,
                  child: CustomPaint(
                    painter: _SimulatedChartPainter(
                      color: theme.colors.actionPrimary,
                      gridColor: theme.colors.textMuted.withValues(alpha: 0.12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        // Activity list items loaded
        VSurface(
          variant: VSurfaceVariant.card,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: VFlex.vertical(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              gap: 16,
              children: [
                const VText('Recent Activities', variant: VTextVariant.title),
                _buildActivityItem(
                  theme,
                  initials: 'JD',
                  title: 'John Doe upgraded plan to Pro Plus',
                  time: '2 minutes ago',
                  icon: LucideIcons.arrowUpRight,
                  color: const Color(0xFF6366F1),
                ),
                _buildActivityItem(
                  theme,
                  initials: 'AS',
                  title: 'Alice Smith requested billing review',
                  time: '15 minutes ago',
                  icon: LucideIcons.messageSquare,
                  color: const Color(0xFFEC4899),
                ),
                _buildActivityItem(
                  theme,
                  initials: 'SK',
                  title: 'System kernel CPU spiked above 95%',
                  time: '1 hour ago',
                  icon: LucideIcons.alertTriangle,
                  color: theme.colors.danger,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMetricCard(
    VThemeData theme, {
    required String title,
    required String value,
    required String trend,
    required Color trendColor,
    required List<Color> bgGradient,
  }) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: bgGradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(theme.radii.md),
          boxShadow: [
            BoxShadow(
              color: bgGradient[1].withValues(alpha: 0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: VFlex.vertical(
            crossAxisAlignment: CrossAxisAlignment.start,
            gap: 8,
            children: [
              VText(
                title,
                variant: VTextVariant.caption,
                color: const Color(0xFFE2E8F0),
              ),
              VText(
                value,
                variant: VTextVariant.title,
                color: const Color(0xFFFFFFFF),
              ),
              VFlex.horizontal(
                gap: 4,
                children: [
                  VText(
                    trend,
                    variant: VTextVariant.caption,
                    color: const Color(0xFFBBF7D0),
                  ),
                  const VText(
                    'vs last week',
                    variant: VTextVariant.caption,
                    color: Color(0xFFCBD5E1),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActivityItem(
    VThemeData theme, {
    required String initials,
    required String title,
    required String time,
    required IconData icon,
    required Color color,
  }) {
    return VFlex.horizontal(
      gap: 12,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: VIcon(
              icon,
              size: 16,
              color: color,
            ),
          ),
        ),
        Expanded(
          child: VFlex.vertical(
            gap: 2,
            children: [
              VText(
                title,
                variant: VTextVariant.body,
              ),
              VText(
                time,
                variant: VTextVariant.caption,
                color: theme.colors.textMuted,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SimulatedChartPainter extends CustomPainter {
  _SimulatedChartPainter({required this.color, required this.gridColor});

  final Color color;
  final Color gridColor;

  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = gridColor
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    final double gridSpacing = size.height / 4;
    for (int i = 0; i <= 4; i++) {
      final y = i * gridSpacing;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    final double colSpacing = size.width / 5;
    for (int i = 0; i <= 5; i++) {
      final x = i * colSpacing;
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }

    final path = Path();
    final gradientPath = Path();

    final List<Offset> points = [
      Offset(0, size.height * 0.8),
      Offset(size.width * 0.2, size.height * 0.6),
      Offset(size.width * 0.4, size.height * 0.75),
      Offset(size.width * 0.6, size.height * 0.35),
      Offset(size.width * 0.8, size.height * 0.45),
      Offset(size.width, size.height * 0.15),
    ];

    path.moveTo(points[0].dx, points[0].dy);
    gradientPath.moveTo(points[0].dx, size.height);
    gradientPath.lineTo(points[0].dx, points[0].dy);

    for (int i = 1; i < points.length; i++) {
      final pPrev = points[i - 1];
      final pCurr = points[i];
      final cp1 = Offset(pPrev.dx + (pCurr.dx - pPrev.dx) / 2, pPrev.dy);
      final cp2 = Offset(pPrev.dx + (pCurr.dx - pPrev.dx) / 2, pCurr.dy);
      path.cubicTo(cp1.dx, cp1.dy, cp2.dx, cp2.dy, pCurr.dx, pCurr.dy);
      gradientPath.cubicTo(cp1.dx, cp1.dy, cp2.dx, cp2.dy, pCurr.dx, pCurr.dy);
    }

    gradientPath.lineTo(size.width, size.height);
    gradientPath.close();

    final fillPaint = Paint()
      ..shader = LinearGradient(
        colors: [color.withValues(alpha: 0.3), color.withValues(alpha: 0.0)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    canvas.drawPath(gradientPath, fillPaint);

    final linePaint = Paint()
      ..color = color
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawPath(path, linePaint);

    final pointPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    final innerPaint = Paint()
      ..color = const Color(0xFFFFFFFF)
      ..style = PaintingStyle.fill;

    for (final p in points) {
      canvas.drawCircle(p, 5.0, pointPaint);
      canvas.drawCircle(p, 2.5, innerPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _SimulatedChartPainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.gridColor != gridColor;
}
