part of '../../main.dart';

class _AccordionDemo extends StatelessWidget {
  const _AccordionDemo();

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);

    return VFlex.vertical(
      gap: theme.spacing.xl,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Title
        const VText(
          'VAccordion & VCollapsible',
          variant: VTextVariant.heading,
        ),
        const VText(
          'Custom high-performance collapsible headers and accordion groups featuring smooth height transition scaling, keyboard trigger focus, and standard accessibility.',
        ),

        // Standalone VCollapsible
        _DocsSection(
          title: 'Standalone Collapsible (VCollapsible)',
          child: VFlex.vertical(
            gap: theme.spacing.md,
            children: [
              VCollapsible(
                header: const VText('Click to read the meeting description'),
                child: VFlex.vertical(
                  gap: theme.spacing.xs,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    VText(
                      'Antigravity meeting assistant is running local balanced modes for speech-to-text transcriptions with full duplicate suppression and AEC filters.',
                      variant: VTextVariant.body,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

          // Exclusive Accordion wrapped in VSurface for contrast
          _DocsSection(
            title: 'Exclusive Accordion (VAccordion - single open)',
            child: VSurface(
              variant: VSurfaceVariant.elevated,
              child: VAccordion(
                multiple: false,
                initialIndex: 0,
                items: [
                  VAccordionItem(
                    header: const VText('Audio Devices Configuration'),
                    indicatorColor: const Color(0xFF000000),
                    child: VFlex.vertical(
                      gap: theme.spacing.xs,
                      children: const [
                        VText('Input: Default Microphone (Macbook Pro Mic)'),
                        VText('Output: Display Audio (HDMI audio codec)'),
                      ],
                    ),
                  ),
                  VAccordionItem(
                    header: const VText('ASR Inference Engines'),
                    indicatorColor: const Color(0xFF000000),
                    child: VFlex.vertical(
                      gap: theme.spacing.xs,
                      children: const [
                        VText('Primary Model: Local WhisperKit Balanced'),
                        VText('Offline Mode: Strictly active (0 cloud telemetry)'),
                      ],
                    ),
                  ),
                  VAccordionItem(
                    header: const VText('Speaker Profile Metadata'),
                    indicatorColor: const Color(0xFF000000),
                    child: VFlex.vertical(
                      gap: theme.spacing.xs,
                      children: const [
                        VText('Transient speaker embeddings are generated on-the-fly.'),
                        VText('Zero local database profiles saved for private v1 release.'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

        // Multiple Accordion
        _DocsSection(
          title: 'Multi-expand Accordion (VAccordion - multiple open)',
          child: VSurface(
            child: VAccordion(
              multiple: true,
              items: [
                VAccordionItem(
                  header: const VText('Active Meeting Logs'),
                  child: const VText('No logging entries yet. Speech activity endpoint is listening...'),
                ),
                VAccordionItem(
                  header: const VText('AEC Filters Quality Metrics'),
                  initiallyExpanded: true,
                  child: VFlex.vertical(
                    gap: theme.spacing.xs,
                    children: const [
                      VText('Echo suppression delay estimate: 12ms'),
                      VText('Audio buffer fill level: 12% (Stable)'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// docs-snippet:start accordion-collapsible
// VCollapsible(
//   header: const VText('Section title'),
//   child: VFlex.vertical(
//     gap: 8,
//     children: const [
//       VText('Expanded body content'),
//       VText('Can hold any widget tree.'),
//     ],
//   ),
// )
// docs-snippet:end accordion-collapsible

// docs-snippet:start accordion-exclusive
// VAccordion(
//   multiple: false,
//   items: [
//     VAccordionItem(
//       header: const VText('Device Configuration'),
//       child: const VText('Input: Built-in Microphone'),
//     ),
//     VAccordionItem(
//       header: const VText('ASR Engine'),
//       child: const VText('Model: Local Balanced'),
//     ),
//   ],
// )
// docs-snippet:end accordion-exclusive

// docs-snippet:start accordion-multi
// VAccordion(
//   multiple: true,
//   items: [
//     VAccordionItem(
//       header: const VText('Recent Logs'),
//       initiallyExpanded: true,
//       child: const VText('No entries yet'),
//     ),
//     VAccordionItem(
//       header: const VText('Quality Metrics'),
//       child: const VText('Echo delay: 12ms'),
//     ),
//   ],
// )
// docs-snippet:end accordion-multi
