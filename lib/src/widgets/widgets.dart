// VidraUI Widgets Library
//
// Organized by functional category for easier navigation and maintenance.

// Animation widgets
export 'animation/animation.dart';
// Basic widgets
export 'basic/basic.dart';
// Button widgets
export 'buttons/buttons.dart';
// Data display widgets
export 'data/data.dart';
// Feedback widgets
export 'feedback/feedback.dart';
// Selective exports with show/hide
export 'feedback/v_progress.dart' hide VLoadingDots;
// Form widgets
export 'forms/forms.dart';
// Interaction widgets
export 'interaction/interaction.dart';
// Layout widgets
export 'layout/layout.dart';
// Media widgets
export 'media/media.dart';
// Navigation widgets
export 'navigation/navigation.dart';
// Overlay widgets
export 'overlays/overlays.dart';
export 'overlays/v_anchored_overlay.dart' show VAnchoredOverlayPlacement;
// Scrolling widgets
export 'scrolling/scrolling.dart';
// Text selection widgets
export 'selection/selection.dart';

// VInteractive is intentionally NOT exported — it is an internal primitive.
