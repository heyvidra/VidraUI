part of '../../main.dart';

class _NumberBoxDemo extends StatefulWidget {
  const _NumberBoxDemo();
  @override
  State<_NumberBoxDemo> createState() => _NumberBoxDemoState();
}

class _NumberBoxDemoState extends State<_NumberBoxDemo> {
  int _qty = 1;
  int _score = 50;
  bool _enabled = true;

  @override
  Widget build(BuildContext context) {
    return VFlex.vertical(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      gap: 16,
      children: [
        const VText('Number Box', variant: VTextVariant.heading),
        const VText(
          'Stepper with tap, long-press acceleration, haptic feedback, and keyboard support.',
          variant: VTextVariant.caption,
        ),

        // Basic
        VSurface(
          variant: VSurfaceVariant.card,
          child: VFlex.horizontal(
            gap: 24,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const VText('Quantity', variant: VTextVariant.body),
              const Spacer(),
              VNumberBox(
                value: _qty,
                onChanged: (v) => setState(() => _qty = v),
                min: 1,
                max: 10,
              ),
            ],
          ),
        ),

        // Large range
        VSurface(
          variant: VSurfaceVariant.card,
          child: VFlex.horizontal(
            gap: 24,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              VText('Score: $_score', variant: VTextVariant.body),
              const Spacer(),
              VNumberBox(
                value: _score,
                onChanged: (v) => setState(() => _score = v),
                min: 0,
                max: 100,
                step: 5,
              ),
            ],
          ),
        ),

        // Sizes
        VSurface(
          variant: VSurfaceVariant.card,
          child: VFlex.horizontal(
            gap: 24,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const VText('Sizes', variant: VTextVariant.body),
              const Spacer(),
              VFlex.horizontal(
                gap: 16,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  for (final sz in VControlSize.values)
                    VNumberBox(
                      value: _qty,
                      onChanged: (v) => setState(() => _qty = v),
                      min: 1,
                      max: 10,
                      size: sz,
                    ),
                ],
              ),
            ],
          ),
        ),

        // Disabled
        VSurface(
          variant: VSurfaceVariant.card,
          child: VFlex.horizontal(
            gap: 24,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const VText('Disabled', variant: VTextVariant.body),
              const Spacer(),
              VFlex.horizontal(
                gap: 12,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  VNumberBox(
                    value: _qty,
                    onChanged: (v) => setState(() => _qty = v),
                    enabled: _enabled,
                  ),
                  VButton(
                    variant: VButtonVariant.secondary,
                    size: VControlSize.sm,
                    onPressed: () => setState(() => _enabled = !_enabled),
                    child: VText(
                      _enabled ? 'Disable' : 'Enable',
                      variant: VTextVariant.caption,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
