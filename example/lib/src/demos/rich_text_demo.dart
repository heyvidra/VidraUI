part of '../../main.dart';

class _RichTextDemo extends StatelessWidget {
  const _RichTextDemo();

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);

    return VFlex.vertical(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        gap: 16,
        children: [
          const VText('Rich Text', variant: VTextVariant.heading),
          VSurface(
            variant: VSurfaceVariant.card,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: VFlex.vertical(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  gap: 12,
                  children: [
                    VRichText(spans: [
                      VTextSpan('Hello ', bold: true),
                      VTextSpan('World', color: Color(0xFF2563EB), bold: true),
                    ]),
                    VRichText(spans: [
                      VTextSpan('This is '),
                      VTextSpan('bold', bold: true),
                      VTextSpan(', '),
                      VTextSpan('italic', italic: true),
                      VTextSpan(', '),
                      VTextSpan('underlined', underline: true),
                      VTextSpan(', and '),
                      VTextSpan('colored', color: Color(0xFFDC2626)),
                    ]),
                    VDivider(),
                    VText('Markdown-like parsing:',
                        variant: VTextVariant.caption),
                    VRichText(
                      spans: parseSimpleMarkdown(
                        'Hello **bold** and *italic* with `code`.',
                        codeColor: theme.colors.actionPrimary,
                      ),
                    ),
                  ]),
            ),
          ),
        ]);
  }
}
