part of 'v_navigation_bar.dart';

class _LabeledItem extends StatelessWidget {
  const _LabeledItem({
    required this.dest,
    required this.isSelected,
    required this.foregroundColor,
    required this.iconSize,
    required this.iconLabelSpacing,
    required this.animation,
  });

  final VNavigationDestination dest;
  final bool isSelected;
  final Color foregroundColor;
  final double iconSize;
  final double iconLabelSpacing;
  final VNavigationBarAnimation animation;

  @override
  Widget build(BuildContext context) {
    final double labelOpacity =
        (animation == VNavigationBarAnimation.shift && !isSelected) ? 0.0 : 1.0;
    final double labelTranslationY =
        (animation == VNavigationBarAnimation.shift && !isSelected) ? 8.0 : 0.0;
    final theme = VTheme.of(context);
    final motion = theme.motion;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _IconWithBadge(
            dest: dest,
            isSelected: isSelected,
            foregroundColor: foregroundColor,
            iconSize: iconSize,
            animation: animation,
          ),
          SizedBox(height: iconLabelSpacing),
          AnimatedOpacity(
            opacity: labelOpacity,
            duration: motion.normal.duration,
            curve: Curves.easeOut,
            child: AnimatedContainer(
              duration: motion.normal.duration,
              curve: Curves.easeOut,
              transform: Matrix4.translationValues(0.0, labelTranslationY, 0.0),
              child: VText(
                dest.label,
                variant: VTextVariant.caption,
                color: foregroundColor,
                style: TextStyle(
                  fontWeight: isSelected
                      ? theme.typography.label.fontWeight
                      : theme.typography.caption.fontWeight,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _IconsOnlyItem extends StatelessWidget {
  const _IconsOnlyItem({
    required this.dest,
    required this.isSelected,
    required this.foregroundColor,
    required this.iconSize,
    required this.animation,
  });

  final VNavigationDestination dest;
  final bool isSelected;
  final Color foregroundColor;
  final double iconSize;
  final VNavigationBarAnimation animation;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _IconWithBadge(
        dest: dest,
        isSelected: isSelected,
        foregroundColor: foregroundColor,
        iconSize: iconSize,
        animation: animation,
      ),
    );
  }
}

class _LabelsOnlyItem extends StatelessWidget {
  const _LabelsOnlyItem({
    required this.dest,
    required this.isSelected,
    required this.foregroundColor,
    required this.animation,
  });

  final VNavigationDestination dest;
  final bool isSelected;
  final Color foregroundColor;
  final VNavigationBarAnimation animation;

  @override
  Widget build(BuildContext context) {
    final double scale =
        (animation == VNavigationBarAnimation.scale && isSelected) ? 1.15 : 1.0;
    final double translateY =
        (animation == VNavigationBarAnimation.shift && isSelected) ? -2.0 : 0.0;

    final theme = VTheme.of(context);
    final motion = theme.motion;
    return Center(
      child: AnimatedContainer(
        duration: motion.normal.duration,
        curve: Curves.easeOut,
        transform: Matrix4.translationValues(0.0, translateY, 0.0),
        child: AnimatedScale(
          scale: scale,
          duration: motion.slow.duration,
          curve: Curves.easeOutBack,
          child: VText(
            dest.label,
            variant: VTextVariant.label,
            color: foregroundColor,
            style: TextStyle(
              fontWeight: isSelected
                  ? theme.typography.label.fontWeight
                  : theme.typography.body.fontWeight,
            ),
          ),
        ),
      ),
    );
  }
}

class _IconWithBadge extends StatelessWidget {
  const _IconWithBadge({
    required this.dest,
    required this.isSelected,
    required this.foregroundColor,
    required this.iconSize,
    required this.animation,
  });

  final VNavigationDestination dest;
  final bool isSelected;
  final Color foregroundColor;
  final double iconSize;
  final VNavigationBarAnimation animation;

  @override
  Widget build(BuildContext context) {
    final double scale =
        (animation == VNavigationBarAnimation.scale && isSelected) ? 1.18 : 1.0;
    final double translateY =
        (animation == VNavigationBarAnimation.shift && isSelected) ? -4.0 : 0.0;

    final motion = VTheme.of(context).motion;
    return AnimatedContainer(
      duration: motion.normal.duration,
      curve: Curves.easeOut,
      transform: Matrix4.translationValues(0.0, translateY, 0.0),
      child: AnimatedScale(
        scale: scale,
        duration: motion.slow.duration,
        curve: Curves.easeOutBack,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            VIconTheme(
              data: VIconThemeData(
                color: foregroundColor,
                size: iconSize,
              ),
              child: (isSelected && dest.selectedIcon != null)
                  ? dest.selectedIcon!
                  : dest.icon,
            ),
            if (dest.badge != null)
              Positioned(
                right: -(iconSize / 4),
                top: -(iconSize / 4),
                child: dest.badge!,
              ),
          ],
        ),
      ),
    );
  }
}
