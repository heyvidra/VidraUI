part of '../../main.dart';

class _SelectableTextDemo extends StatelessWidget {
  const _SelectableTextDemo();

  @override
  Widget build(BuildContext context) {
    return VFlex.vertical(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      gap: 16,
      children: [
        const VText('Selectable Text', variant: VTextVariant.heading),
        
        // Basic usage
        VSurface(
          variant: VSurfaceVariant.card,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: VFlex.vertical(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              gap: 12,
              children: const [
                VText('Basic', variant: VTextVariant.title),
                VSelectableText(
                  'This text can be selected. Try these gestures:\n'
                  '• Single tap: Place cursor\n'
                  '• Double tap: Select word\n'
                  '• Long press: Select word (works on all devices!)\n'
                  '• Drag: Extend selection',
                  variant: VTextVariant.body,
                ),
              ],
            ),
          ),
        ),

        // Variants
        VSurface(
          variant: VSurfaceVariant.card,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: VFlex.vertical(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              gap: 12,
              children: const [
                VText('Text Variants', variant: VTextVariant.title),
                VSelectableText(
                  'Selectable heading text',
                  variant: VTextVariant.heading,
                ),
                VSelectableText(
                  'Selectable title text',
                  variant: VTextVariant.title,
                ),
                VSelectableText(
                  'Selectable body text - the default variant for most content.',
                  variant: VTextVariant.body,
                ),
                VSelectableText(
                  'Selectable caption text (smaller)',
                  variant: VTextVariant.caption,
                ),
              ],
            ),
          ),
        ),

        // Alignment
        VSurface(
          variant: VSurfaceVariant.card,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: VFlex.vertical(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              gap: 12,
              children: const [
                VText('Text Alignment', variant: VTextVariant.title),
                VSelectableText(
                  'Left aligned text (default)',
                  textAlign: TextAlign.start,
                ),
                VSelectableText(
                  'Center aligned text',
                  textAlign: TextAlign.center,
                ),
                VSelectableText(
                  'Right aligned text',
                  textAlign: TextAlign.end,
                ),
              ],
            ),
          ),
        ),

        // Overflow handling
        VSurface(
          variant: VSurfaceVariant.card,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: VFlex.vertical(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              gap: 12,
              children: const [
                VText('Overflow Handling', variant: VTextVariant.title),
                VSelectableText(
                  'This is a very long text that will be truncated with an ellipsis when it exceeds the maximum number of lines...',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                VSelectableText(
                  'This text fades out gradually when it reaches the maximum line limit which creates a smooth visual effect...',
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                ),
              ],
            ),
          ),
        ),

        // Long press feature highlight
        VSurface(
          variant: VSurfaceVariant.elevated,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: VFlex.vertical(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              gap: 12,
              children: const [
                VText('✨ Long Press Selection', variant: VTextVariant.title),
                VText(
                  'Feature Highlight',
                  variant: VTextVariant.caption,
                ),
                VSelectableText(
                  'VSelectableText supports long press selection on ALL pointer devices - '
                  'not just touch screens! Try long-pressing with your mouse or trackpad. '
                  'The component uses a dual gesture detector architecture that works '
                  'across touch, mouse, and trackpad inputs. You can also double-tap to '
                  'select a word, or drag to extend your selection.',
                  variant: VTextVariant.body,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
