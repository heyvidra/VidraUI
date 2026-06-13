part of '../../main.dart';

class _TypographyDemo extends StatelessWidget {
  const _TypographyDemo();

  @override
  Widget build(BuildContext context) {
    return VFlex.vertical(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        gap: 16,
        children: [
          const VText('Typography', variant: VTextVariant.heading),
          VSurface(
            variant: VSurfaceVariant.card,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: VFlex.vertical(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  gap: 8,
                  children: [
                    VText('Typography', variant: VTextVariant.title),
                    VText('Heading', variant: VTextVariant.heading),
                    VText('Title', variant: VTextVariant.title),
                    VText('Subtitle', variant: VTextVariant.subtitle),
                    VText(
                      'Body text that wraps naturally to show line height.',
                      variant: VTextVariant.body,
                    ),
                    VText('Label', variant: VTextVariant.label),
                    VText('Caption', variant: VTextVariant.caption),
                    VText(
                      'Label with one-off weight and spacing',
                      variant: VTextVariant.label,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.4,
                      ),
                    ),
                  ]),
            ),
          ),
          VSurface(
            variant: VSurfaceVariant.card,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: VFlex.vertical(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                gap: 8,
                children: const [
                  VText('Selectable text', variant: VTextVariant.title),
                  VSelectableText(
                    'Long press or drag across this paragraph to select and copy text.',
                    variant: VTextVariant.body,
                  ),
                ],
              ),
            ),
          ),
        ]);
  }
}

// docs-snippet:start typography-basic
// VFlex.vertical(
// crossAxisAlignment: CrossAxisAlignment.stretch,
//   gap: 8,
//   children: const [
//     VText('Heading', variant: VTextVariant.heading),
//     VText('Body copy', variant: VTextVariant.body),
//     VText('Caption', variant: VTextVariant.caption),
//   ],
// )
// docs-snippet:end typography-basic
