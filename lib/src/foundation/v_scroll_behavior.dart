import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

/// A [ScrollBehavior] for VidraUI that removes Material overscroll glow
/// and uses platform-appropriate scroll physics.
///
/// - iOS / macOS: [BouncingScrollPhysics] (natural spring feel).
/// - Android / Fuchsia / Windows / Linux: [ClampingScrollPhysics].
/// - Desktop platforms retain native scrollbar rendering.
/// - All platforms suppress the stretch/glow overscroll indicator.
class VScrollBehavior extends ScrollBehavior {
  const VScrollBehavior();

  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) =>
      child;

  /// Suppress system scrollbar on all platforms.
  ///
  /// VidraUI provides its own scrollbar implementation ([VScrollbar] /
  /// [VScrollArea]). Delegating to the system scrollbar on desktop would
  /// produce a second, overlapping scrollbar.
  @override
  Widget buildScrollbar(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) =>
      child;

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) =>
      switch (defaultTargetPlatform) {
        TargetPlatform.iOS || TargetPlatform.macOS =>
          const BouncingScrollPhysics(),
        _ => const ClampingScrollPhysics(),
      };
}
