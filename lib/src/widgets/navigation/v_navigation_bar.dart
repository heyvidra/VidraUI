import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../theme/theme.dart';
import '../basic/v_text.dart';
import '../interaction/v_interactive.dart';

part 'v_navigation_bar_indicators.dart';
part 'v_navigation_bar_items.dart';
part 'v_navigation_bar_notch.dart';
part 'v_navigation_bar_state.dart';

// ---------------------------------------------------------------------------
// Enums
// ---------------------------------------------------------------------------

/// The visual shape of a [VNavigationBar].
enum VNavigationBarShape {
  /// Attached to the screen edge with a top border, no rounding or margin.
  flat,

  /// Floats above the screen edge with margin, rounded corners, and shadow.
  floating,

  /// A fully-rounded capsule shape, floating with generous margin.
  capsule,
}

/// The selection indicator style for [VNavigationBar].
enum VNavigationBarIndicator {
  /// A rounded pill that wraps the selected item.
  pill,

  /// A small dot centered below the icon (or label when [contentMode] is [labelsOnly]).
  dot,

  /// A thin horizontal line across the top of the selected item.
  topLine,

  /// No visual indicator — selection is communicated via color alone.
  none,
}

/// Controls which content is displayed inside each destination.
enum VNavigationBarContentMode {
  /// Icon above label (default).
  labeled,

  /// Icons only — labels are hidden and the bar is shorter.
  iconsOnly,

  /// Labels only — icons are hidden.
  labelsOnly;
}

/// The transition animation style when switching selected destinations.
enum VNavigationBarAnimation {
  /// A bouncy scale animation on the selected icon.
  scale,

  /// The selected icon translates upwards while its label slides and fades in.
  shift,

  /// Simple instantaneous/color-only transition.
  none,
}

// ---------------------------------------------------------------------------
// VNavigationDestination
// ---------------------------------------------------------------------------

/// A single destination item inside a [VNavigationBar].
///
/// Each destination has an icon, a label, and an optional badge.
/// When [selectedIcon] is provided, it replaces [icon] for the
/// currently selected destination.
@immutable
class VNavigationDestination {
  /// Creates a navigation destination.
  ///
  /// The [icon] and [label] are required. If [selectedIcon] is omitted,
  /// the same [icon] is used in both states (tinted appropriately).
  const VNavigationDestination({
    required this.icon,
    this.selectedIcon,
    required this.label,
    this.badge,
    this.enabled = true,
  });

  /// The icon shown when this destination is not selected.
  final Widget icon;

  /// An alternate icon shown when this destination is selected.
  ///
  /// When `null`, [icon] is used for both states.
  final Widget? selectedIcon;

  /// The text label displayed below the icon.
  final String label;

  /// An optional badge widget (e.g. [VBadge]) shown above the icon.
  final Widget? badge;

  /// Whether this destination can be tapped or navigated to via keyboard.
  final bool enabled;
}

// ---------------------------------------------------------------------------
// VNavigationBar
// ---------------------------------------------------------------------------

/// A bottom navigation bar for top-level app navigation.
///
/// Supports multiple shapes ([VNavigationBarShape]), indicator styles
/// ([VNavigationBarIndicator]), content modes ([VNavigationBarContentMode]),
/// and an optional center FAB with a notched cutout.
///
/// ## Integration with [VScaffold]
///
/// Pass a [VNavigationBar] directly to [VScaffold.footer]:
///
/// ```dart
/// VScaffold(
///   body: bodyContent,
///   footer: VNavigationBar(
///     destinations: [
///       VNavigationDestination(icon: VIcon(...), label: 'Home'),
///       VNavigationDestination(icon: VIcon(...), label: 'Search'),
///     ],
///     selectedIndex: _currentIndex,
///     onChanged: (i) => setState(() => _currentIndex = i),
///   ),
/// )
/// ```
class VNavigationBar extends StatefulWidget {
  /// Creates a bottom navigation bar.
  ///
  /// [destinations] must contain at least 2 items.
  /// [selectedIndex] must be within the bounds of [destinations].
  const VNavigationBar({
    super.key,
    required this.destinations,
    required this.selectedIndex,
    required this.onChanged,
    this.shape = VNavigationBarShape.flat,
    this.indicator = VNavigationBarIndicator.pill,
    this.contentMode = VNavigationBarContentMode.labeled,
    this.animation = VNavigationBarAnimation.scale,
    this.centerDestination,
    this.enabled = true,
    this.semanticLabel,
  }) : assert(
          destinations.length >= 2,
          'VNavigationBar requires at least 2 destinations.',
        );

  /// The list of navigation destinations (2 or more).
  final List<VNavigationDestination> destinations;

  /// The index of the currently selected destination.
  final int selectedIndex;

  /// Called when the user taps or activates a destination.
  final ValueChanged<int> onChanged;

  /// The visual shape of the bar.
  final VNavigationBarShape shape;

  /// The selection indicator style.
  final VNavigationBarIndicator indicator;

  /// Controls icon and label visibility.
  final VNavigationBarContentMode contentMode;

  /// The transition animation style when switching selected destinations.
  final VNavigationBarAnimation animation;

  /// An optional center destination rendered as a raised circular FAB
  /// with a notched cutout in the bar.
  final VNavigationDestination? centerDestination;

  /// Whether the entire bar is interactive.
  ///
  /// When `false`, all destinations are non-interactive.
  final bool enabled;

  /// An optional semantic label for the navigation bar.
  ///
  /// Defaults to “Navigation” when not provided.
  final String? semanticLabel;

  @override
  State<VNavigationBar> createState() => _VNavigationBarState();
}
