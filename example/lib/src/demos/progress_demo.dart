part of '../../main.dart';

class _ProgressDemo extends StatelessWidget {
  const _ProgressDemo();

  @override
  Widget build(BuildContext context) {
    return VFlex.vertical(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        gap: 16,
        children: [
          const VText('Progress & Spinner', variant: VTextVariant.heading),
          VSurface(
            variant: VSurfaceVariant.card,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: VFlex.vertical(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  gap: 16,
                  children: [
                    const VText('Determinate', variant: VTextVariant.title),
                    const VProgressBar(value: 0.7),
                    const VText('Indeterminate', variant: VTextVariant.title),
                    const VProgressBar(value: null),
                    const VText('Spinner', variant: VTextVariant.title),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: VSpinner(),
                    ),
                  ]),
            ),
          ),
        ]);
  }
}

