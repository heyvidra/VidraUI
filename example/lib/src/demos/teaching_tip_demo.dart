part of '../../main.dart';

class _TeachingTipDemo extends StatefulWidget {
  const _TeachingTipDemo();

  @override
  State<_TeachingTipDemo> createState() => _TeachingTipDemoState();
}

class _TeachingTipDemoState extends State<_TeachingTipDemo> {
  // Basic controller
  final VPopoverController _basicController = VPopoverController();

  // Illustration controller
  final VPopoverController _illustrationController = VPopoverController();

  // Multi-step Tour state
  int _tourStep = 0; // 0 = not started, 1 = step 1, 2 = step 2, 3 = step 3
  final VPopoverController _tourController1 = VPopoverController();
  final VPopoverController _tourController2 = VPopoverController();
  final VPopoverController _tourController3 = VPopoverController();

  // Directional placement controllers
  final VPopoverController _upController = VPopoverController();
  final VPopoverController _downController = VPopoverController();
  final VPopoverController _leftController = VPopoverController();
  final VPopoverController _rightController = VPopoverController();

  void _startTour() {
    setState(() {
      _tourStep = 1;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _tourController1.open();
    });
  }

  void _nextTourStep() {
    if (_tourStep == 1) {
      _tourController1.close();
      setState(() {
        _tourStep = 2;
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _tourController2.open();
      });
    } else if (_tourStep == 2) {
      _tourController2.close();
      setState(() {
        _tourStep = 3;
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _tourController3.open();
      });
    } else if (_tourStep == 3) {
      _tourController3.close();
      setState(() {
        _tourStep = 0;
      });
    }
  }

  void _cancelTour() {
    _tourController1.close();
    _tourController2.close();
    _tourController3.close();
    setState(() {
      _tourStep = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);

    return VFlex.vertical(
      gap: theme.spacing.lg,
      children: [
        VText('Teaching Tip',
            variant: VTextVariant.heading,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        VText(
          'Teaching Tip is a premium anchored prompt pointing to specific UI elements. Perfect for onboarding guides, highlighting new features, or multi-step walkthroughs.',
          variant: VTextVariant.body,
          style: TextStyle(color: theme.colors.textMuted),
        ),

        // Section 1: Basic & Illustration
        VSurface(
          variant: VSurfaceVariant.card,
          child: VFlex.vertical(
            gap: theme.spacing.md,
            children: [
              const VText('Basic & Rich Content', variant: VTextVariant.title),
              VText(
                  'Tapping the buttons will trigger anchored contextual tips pointing directly to them.',
                  variant: VTextVariant.caption,
                  color: theme.colors.textMuted),
              const SizedBox(height: 8),
              Row(
                children: [
                  VTeachingTip(
                    controller: _basicController,
                    title: 'New Workspace Layout',
                    subtitle:
                        'Create folders, sort projects, and configure templates dynamically.',
                    placement: VAnchoredOverlayPlacement.up,
                    primaryButton: VButton(
                      onPressed: _basicController.close,
                      child: const VText('Got it'),
                    ),
                    child: VButton(
                      onPressed: _basicController.toggle,
                      child: const VText('Toggle Basic Tip'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  VTeachingTip(
                    controller: _illustrationController,
                    title: 'Unlock Pro Features',
                    subtitle:
                        'Gain access to unlimited cloud transcript storage, direct voice models, and instant offline exports.',
                    placement: VAnchoredOverlayPlacement.auto,
                    illustration: Container(
                      height: 120,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF3B82F6), Color(0xFF6366F1)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: const Center(
                        child: VIcon(
                          LucideIcons.sparkles,
                          size: 40,
                          color: Color(0xFFFFFFFF),
                        ),
                      ),
                    ),
                    primaryButton: VButton(
                      onPressed: _illustrationController.close,
                      child: const VText('Upgrade Now'),
                    ),
                    secondaryButton: VButton(
                      variant: VButtonVariant.secondary,
                      onPressed: _illustrationController.close,
                      child: const VText('Later'),
                    ),
                    child: VButton(
                      onPressed: _illustrationController.toggle,
                      child: const VText('Toggle Rich Tip'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Section 2: Arrow Placement Angles
        VSurface(
          variant: VSurfaceVariant.card,
          child: VFlex.vertical(
            gap: theme.spacing.md,
            children: [
              const VText('Arrow Placement Angles',
                  variant: VTextVariant.title),
              VText(
                  'Supports Up, Down, Left, and Right alignments. The arrow dynamically flips or continuous with the bubble contour.',
                  variant: VTextVariant.caption,
                  color: theme.colors.textMuted),
              const SizedBox(height: 16),
              Center(
                child: Container(
                  width: 380,
                  height: 180,
                  alignment: Alignment.center,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: VTeachingTip(
                          controller: _upController,
                          title: 'Top Tip',
                          subtitle: 'Opened pointing upwards.',
                          placement: VAnchoredOverlayPlacement.up,
                          showCloseButton: false,
                          child: VButton(
                            onPressed: _upController.toggle,
                            child: const VText('Tip Up'),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: VTeachingTip(
                          controller: _downController,
                          title: 'Bottom Tip',
                          subtitle: 'Opened pointing downwards.',
                          placement: VAnchoredOverlayPlacement.down,
                          showCloseButton: false,
                          child: VButton(
                            onPressed: _downController.toggle,
                            child: const VText('Tip Down'),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: VTeachingTip(
                          controller: _leftController,
                          title: 'Left Tip',
                          subtitle: 'Opened pointing to the left.',
                          placement: VAnchoredOverlayPlacement.left,
                          showCloseButton: false,
                          child: VButton(
                            onPressed: _leftController.toggle,
                            child: const VText('Tip Left'),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: VTeachingTip(
                          controller: _rightController,
                          title: 'Right Tip',
                          subtitle: 'Opened pointing to the right.',
                          placement: VAnchoredOverlayPlacement.right,
                          showCloseButton: false,
                          child: VButton(
                            onPressed: _rightController.toggle,
                            child: const VText('Tip Right'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        // Section 3: Onboarding Multi-step Tour
        VSurface(
          variant: VSurfaceVariant.card,
          child: VFlex.vertical(
            gap: theme.spacing.md,
            children: [
              const VText('Interactive Guided Onboarding Tour',
                  variant: VTextVariant.title),
              VText(
                  'Chain multiple teaching tips together to create interactive walkthroughs. Steps are controlled programmatically.',
                  variant: VTextVariant.caption,
                  color: theme.colors.textMuted),
              const SizedBox(height: 8),
              if (_tourStep == 0)
                VButton(
                  onPressed: _startTour,
                  child: const VText('Start 3-Step Guided Tour'),
                )
              else
                VButton(
                  variant: VButtonVariant.danger,
                  onPressed: _cancelTour,
                  child: VText('Tour Active (Step $_tourStep/3) - Cancel'),
                ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Step 1 target
                  VTeachingTip(
                    controller: _tourController1,
                    title: 'Step 1: Save Content',
                    subtitle:
                        'Store your meeting minutes locally or export them instantly.',
                    placement: VAnchoredOverlayPlacement.up,
                    onClose: _cancelTour,
                    primaryButton: VButton(
                      onPressed: _nextTourStep,
                      child: const VText('Next Step'),
                    ),
                    secondaryButton: VButton(
                      variant: VButtonVariant.secondary,
                      onPressed: _cancelTour,
                      child: const VText('Skip'),
                    ),
                    child: Opacity(
                      opacity: _tourStep == 1 ? 1.0 : 0.6,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: theme.colors.surfaceElevated,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: _tourStep == 1
                                ? theme.colors.actionPrimary
                                : theme.colors.border,
                            width: _tourStep == 1 ? 2 : 1,
                          ),
                        ),
                        child: const Column(
                          children: [
                            VIcon(LucideIcons.save, size: 24),
                            SizedBox(height: 8),
                            VText('1. Save Minutes'),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Step 2 target
                  VTeachingTip(
                    controller: _tourController2,
                    title: 'Step 2: Generate Insights',
                    subtitle:
                        'Extract action items, AI summaries, and meeting agendas in one click.',
                    placement: VAnchoredOverlayPlacement.up,
                    onClose: _cancelTour,
                    primaryButton: VButton(
                      onPressed: _nextTourStep,
                      child: const VText('Next Step'),
                    ),
                    secondaryButton: VButton(
                      variant: VButtonVariant.secondary,
                      onPressed: _cancelTour,
                      child: const VText('Skip'),
                    ),
                    child: Opacity(
                      opacity: _tourStep == 2 ? 1.0 : 0.6,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: theme.colors.surfaceElevated,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: _tourStep == 2
                                ? theme.colors.actionPrimary
                                : theme.colors.border,
                            width: _tourStep == 2 ? 2 : 1,
                          ),
                        ),
                        child: const Column(
                          children: [
                            VIcon(LucideIcons.brainCircuit, size: 24),
                            SizedBox(height: 8),
                            VText('2. AI Summary'),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Step 3 target
                  VTeachingTip(
                    controller: _tourController3,
                    title: 'Step 3: Share Instantly',
                    subtitle:
                        'Send transcripts or speaker profiles to collaborative workspaces.',
                    placement: VAnchoredOverlayPlacement.up,
                    onClose: _cancelTour,
                    primaryButton: VButton(
                      onPressed: _nextTourStep,
                      child: const VText('Finish Tour'),
                    ),
                    secondaryButton: VButton(
                      variant: VButtonVariant.secondary,
                      onPressed: () {
                        _tourController3.close();
                        setState(() {
                          _tourStep = 2;
                        });
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          _tourController2.open();
                        });
                      },
                      child: const VText('Back'),
                    ),
                    child: Opacity(
                      opacity: _tourStep == 3 ? 1.0 : 0.6,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: theme.colors.surfaceElevated,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: _tourStep == 3
                                ? theme.colors.actionPrimary
                                : theme.colors.border,
                            width: _tourStep == 3 ? 2 : 1,
                          ),
                        ),
                        child: const Column(
                          children: [
                            VIcon(LucideIcons.share2, size: 24),
                            SizedBox(height: 8),
                            VText('3. Share Output'),
                          ],
                        ),
                      ),
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

// docs-snippet:start teaching-tip-basic
// VTeachingTip(
//   controller: controller,
//   title: 'New Workspace Layout',
//   subtitle: 'Create folders, sort projects, and configure templates dynamically.',
//   placement: VAnchoredOverlayPlacement.up,
//   primaryButton: VButton(
//     onPressed: controller.close,
//     child: const VText('Got it'),
//   ),
//   child: VButton(
//     onPressed: controller.toggle,
//     child: const VText('Toggle Basic Tip'),
//   ),
// )
// docs-snippet:end teaching-tip-basic
