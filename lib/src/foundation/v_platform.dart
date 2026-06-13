import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

/// Defines adaptive strategy interface for multi-platform UI/UX behavior in VidraUI.
@immutable
abstract class VPlatformBehavior {
  const VPlatformBehavior();

  /// Resolves the appropriate platform behavior from the given target platform.
  factory VPlatformBehavior.resolve(TargetPlatform platform) => switch (platform) {
        TargetPlatform.iOS => const _VMobileBehavior(isApplePlatform: true),
        TargetPlatform.android || TargetPlatform.fuchsia =>
          const _VMobileBehavior(isApplePlatform: false),
        TargetPlatform.macOS => const _VDesktopBehavior(isApplePlatform: true),
        TargetPlatform.windows || TargetPlatform.linux =>
          const _VDesktopBehavior(isApplePlatform: false),
      };

  /// Factory for mobile behavior.
  factory VPlatformBehavior.mobile({required bool isApple}) =>
      _VMobileBehavior(isApplePlatform: isApple);

  /// Factory for desktop behavior.
  factory VPlatformBehavior.desktop({required bool isApple}) =>
      _VDesktopBehavior(isApplePlatform: isApple);

  /// Returns true if the strategy mimics desktop behavior (e.g. keyboard navigation, hovered states).
  bool get isDesktop;

  /// Returns true if the platform supports hover pointer input (mouse/trackpad).
  ///
  /// When false, widgets should omit [MouseRegion] subtrees from the render tree
  /// entirely to avoid idle pointer-event routing overhead on touch-only devices.
  bool get hasHoverCapability;

  /// Returns true if the platform supports physical haptic feedback (vibration motor).
  ///
  /// When true, interactive widgets should trigger [HapticFeedback.lightImpact]
  /// on confirmed tap gestures to provide tactile confirmation.
  bool get hasHapticFeedback;

  /// Returns true if the strategy mimics Apple platforms (iOS, macOS) behavior (e.g. spring transitions, command shortcut symbol).
  bool get isApple;

  /// Height of an item in the selection menu.
  double get selectionMenuItemHeight;

  /// Border radius of the selection menu popup/bubble.
  double get selectionMenuRadius;

  /// Keyboard modifier symbol for shortcuts (e.g. '⌘' or 'Ctrl+').
  String get shortcutModifier;
}

class _VMobileBehavior extends VPlatformBehavior {
  const _VMobileBehavior({required this.isApplePlatform});

  final bool isApplePlatform;

  @override
  bool get isDesktop => false;

  @override
  bool get hasHoverCapability => false;

  @override
  bool get hasHapticFeedback => true;

  @override
  bool get isApple => isApplePlatform;

  @override
  double get selectionMenuItemHeight => 44.0;

  @override
  double get selectionMenuRadius => 22.0;

  @override
  String get shortcutModifier => isApplePlatform ? '⌘' : 'Ctrl+';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is _VMobileBehavior &&
        isApplePlatform == other.isApplePlatform;
  }

  @override
  int get hashCode => Object.hash(isDesktop, isApplePlatform);
}

class _VDesktopBehavior extends VPlatformBehavior {
  const _VDesktopBehavior({required this.isApplePlatform});

  final bool isApplePlatform;

  @override
  bool get isDesktop => true;

  @override
  bool get hasHoverCapability => true;

  @override
  bool get hasHapticFeedback => false;

  @override
  bool get isApple => isApplePlatform;

  @override
  double get selectionMenuItemHeight => 36.0;

  @override
  double get selectionMenuRadius => 8.0;

  @override
  String get shortcutModifier => isApplePlatform ? '⌘' : 'Ctrl+';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is _VDesktopBehavior &&
        isApplePlatform == other.isApplePlatform;
  }

  @override
  int get hashCode => Object.hash(isDesktop, isApplePlatform);
}

/// An [InheritedWidget] that provides the active [VPlatformBehavior] to the widget tree.
class VPlatformScope extends InheritedWidget {
  const VPlatformScope({
    super.key,
    required this.behavior,
    required super.child,
  });

  /// The active platform strategy behavior.
  final VPlatformBehavior behavior;

  /// Looks up the nearest [VPlatformBehavior] in the ancestor tree.
  /// If not found, falls back to the behavior resolved from [defaultTargetPlatform].
  static VPlatformBehavior of(BuildContext context) {
    final VPlatformScope? scope =
        context.dependOnInheritedWidgetOfExactType<VPlatformScope>();
    if (scope != null) {
      return scope.behavior;
    }
    // Fallback: resolve behavior from the current system target platform
    return VPlatformBehavior.resolve(defaultTargetPlatform);
  }

  @override
  bool updateShouldNotify(VPlatformScope oldWidget) =>
      behavior != oldWidget.behavior;
}
