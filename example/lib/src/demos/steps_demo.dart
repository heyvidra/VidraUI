part of '../../main.dart';

class _StepsDemo extends StatefulWidget {
  const _StepsDemo();
  @override
  State<_StepsDemo> createState() => _StepsDemoState();
}

class _StepsDemoState extends State<_StepsDemo> {
  int _current = 1;

  @override
  Widget build(BuildContext context) {
    return VFlex.vertical(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      gap: 16,
      children: [
        const VText('Steps', variant: VTextVariant.heading),
        const VText(
          'Step-by-step progress indicator with dot/number modes and horizontal/vertical layouts.',
          variant: VTextVariant.caption,
        ),

        // Horizontal number
        VSurface(
          variant: VSurfaceVariant.card,
          child: VFlex.vertical(
            gap: 16,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const VText('Horizontal · Number', variant: VTextVariant.label),
              VSteps(
                steps: const [
                  VStep(title: _T('Select'), description: _D('Choose plan')),
                  VStep(title: _T('Pay'), description: _D('Complete payment')),
                  VStep(title: _T('Activate'), description: _D('Start using')),
                  VStep(title: _T('Done')),
                ],
                current: _current,
              ),
              VFlex.horizontal(
                gap: 8,
                children: [
                  VButton(
                    variant: VButtonVariant.secondary,
                    size: VControlSize.sm,
                    onPressed:
                        _current > 0 ? () => setState(() => _current--) : null,
                    child: const VText('← Back', variant: VTextVariant.caption),
                  ),
                  VButton(
                    variant: VButtonVariant.primary,
                    size: VControlSize.sm,
                    onPressed:
                        _current < 3 ? () => setState(() => _current++) : null,
                    child: const VText('Next →', variant: VTextVariant.caption),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Vertical dot
        VSurface(
          variant: VSurfaceVariant.card,
          child: VSteps(
            mode: VStepsMode.dot,
            direction: Axis.vertical,
            current: 2,
            steps: const [
              VStep(title: _T('Order placed'), description: _D('2024-06-01')),
              VStep(title: _T('Shipped'), description: _D('2024-06-02')),
              VStep(
                  title: _T('Out for delivery'),
                  description: _D('Expected today')),
              VStep(title: _T('Delivered')),
            ],
          ),
        ),

        // Vertical number
        VSurface(
          variant: VSurfaceVariant.card,
          child: VSteps(
            mode: VStepsMode.number,
            direction: Axis.vertical,
            current: 1,
            steps: const [
              VStep(
                  title: _T('Install VidraUI'),
                  description: _D('flutter pub add vidraui')),
              VStep(
                  title: _T('Wrap with VidraApp'),
                  description: _D('Replace MaterialApp')),
              VStep(
                  title: _T('Build UI'),
                  description: _D('Use VSurface, VButton, VText...')),
              VStep(title: _T('Ship')),
            ],
          ),
        ),
      ],
    );
  }
}

class _T extends StatelessWidget {
  const _T(this.text);
  final String text;
  @override
  Widget build(BuildContext context) =>
      VText(text, variant: VTextVariant.label);
}

class _D extends StatelessWidget {
  const _D(this.text);
  final String text;
  @override
  Widget build(BuildContext context) => VText(text,
      variant: VTextVariant.caption,
      color: VTheme.of(context).colors.textMuted);
}
