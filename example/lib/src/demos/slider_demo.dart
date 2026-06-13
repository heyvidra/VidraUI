part of '../../main.dart';

class _SliderDemo extends StatefulWidget {
  const _SliderDemo();
  @override
  State<_SliderDemo> createState() => _SliderDemoState();
}

class _SliderDemoState extends State<_SliderDemo> {
  double _value = 0.5;

  @override
  Widget build(BuildContext context) {
    return VFlex.vertical(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        gap: 16,
        children: [
          const VText('Slider', variant: VTextVariant.heading),
          VSurface(
            variant: VSurfaceVariant.card,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: VFlex.vertical(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  gap: 12,
                  children: [
                    VText(
                      'Value: ${(_value * 100).round()}%',
                      variant: VTextVariant.title,
                    ),
                    VSlider(
                      value: _value,
                      onChanged: (v) => setState(() => _value = v),
                    ),
                    const VText('Disabled', variant: VTextVariant.title),
                    VSlider(
                      value: 0.3,
                      onChanged: (v) {},
                      enabled: false,
                    ),
                  ]),
            ),
          ),
        ]);
  }
}


// docs-snippet:start slider-basic
// VSlider(
//   value: value,
//   onChanged: (next) => setState(() => value = next),
// )
// docs-snippet:end slider-basic

