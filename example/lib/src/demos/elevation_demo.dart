part of '../../main.dart';

class _ElevationDemo extends StatelessWidget {
  const _ElevationDemo();

  @override
  Widget build(BuildContext context) {
    return VFlex.vertical(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      gap: 16,
      children: [
        const VText('Elevation Levels', variant: VTextVariant.heading),
        for (final elevation in VElevation.values)
          VSurface(
            elevation: elevation,
            padding: const EdgeInsets.all(16),
            child: Text('Level ${elevation.index}'),
          ),
      ],
    );
  }
}
