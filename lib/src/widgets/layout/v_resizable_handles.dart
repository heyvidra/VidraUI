part of 'v_resizable.dart';

class _FixedAxis {
  const _FixedAxis(this.leading, this.trailing);

  final double leading;
  final double trailing;
}

class _HandleVisual extends StatelessWidget {
  const _HandleVisual({
    required this.width,
    required this.height,
    required this.active,
    required this.theme,
  });

  final double width;
  final double height;
  final bool active;
  final VThemeData theme;

  @override
  Widget build(BuildContext context) {
    final c = active ? theme.colors.actionPrimary : theme.colors.border;
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: c,
        borderRadius: BorderRadius.circular(theme.radii.sm),
      ),
    );
  }
}
