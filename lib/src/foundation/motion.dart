import 'package:flutter/animation.dart';
import 'package:flutter/foundation.dart';

/// Page transition types available to [VPageRoute].
enum VPageTransition {
  /// No transition animation.
  none,

  /// Fade in / fade out.
  fade,

  /// Slide from right to left.
  slide,

  /// Combined slide + fade (default).
  slideFade,

  /// Scale + fade transition.
  scaleFade,

  /// iOS-style depth slide with parallax, side-shadow and gesture support.
  iosDepthSlide,

  /// Shared axis X transition (horizontal slide + fade).
  sharedAxisX,

  /// Shared axis Y transition (vertical slide + fade).
  sharedAxisY,

  /// Shared axis Z transition (scale + fade).
  sharedAxisZ,

  /// Android-style zoom-up and reveal transition.
  zoomUpReveal,

  /// Premium 3D perspective flip transition.
  perspective3D,

  /// Platform-adaptive native transition choice.
  adaptive,
}

/// A reusable motion recipe for a single interaction or transition.
@immutable
class VMotionSpec with Diagnosticable {
  const VMotionSpec({
    required this.duration,
    required this.curve,
    this.reverseDuration,
    this.reverseCurve,
  });

  /// Duration used when animating toward the visible or active state.
  final Duration duration;

  /// Curve used when animating toward the visible or active state.
  final Curve curve;

  /// Optional duration used when reversing the transition.
  final Duration? reverseDuration;

  /// Optional curve used when reversing the transition.
  final Curve? reverseCurve;

  /// Reverse duration, falling back to [duration].
  Duration get effectiveReverseDuration => reverseDuration ?? duration;

  /// Reverse curve, falling back to [curve].
  Curve get effectiveReverseCurve => reverseCurve ?? curve;

  /// Creates a copy with selected fields replaced.
  VMotionSpec copyWith({
    Duration? duration,
    Curve? curve,
    Duration? reverseDuration,
    Curve? reverseCurve,
  }) {
    return VMotionSpec(
      duration: duration ?? this.duration,
      curve: curve ?? this.curve,
      reverseDuration: reverseDuration ?? this.reverseDuration,
      reverseCurve: reverseCurve ?? this.reverseCurve,
    );
  }

  /// Interpolates between two motion specs.
  static VMotionSpec lerp(VMotionSpec a, VMotionSpec b, double t) {
    return VMotionSpec(
      duration: _lerpDuration(a.duration, b.duration, t),
      curve: t < 0.5 ? a.curve : b.curve,
      reverseDuration: _lerpNullableDuration(
        a.reverseDuration,
        b.reverseDuration,
        t,
      ),
      reverseCurve: t < 0.5 ? a.reverseCurve : b.reverseCurve,
    );
  }

  static Duration _lerpDuration(Duration a, Duration b, double t) {
    return Duration(
      microseconds:
          (a.inMicroseconds + (b.inMicroseconds - a.inMicroseconds) * t)
              .round(),
    );
  }

  static Duration? _lerpNullableDuration(
    Duration? a,
    Duration? b,
    double t,
  ) {
    if (a == null && b == null) return null;
    return _lerpDuration(a ?? b!, b ?? a!, t);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is VMotionSpec &&
        other.duration == duration &&
        other.curve == curve &&
        other.reverseDuration == reverseDuration &&
        other.reverseCurve == reverseCurve;
  }

  @override
  int get hashCode => Object.hash(
        duration,
        curve,
        reverseDuration,
        reverseCurve,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<Duration>('duration', duration))
      ..add(DiagnosticsProperty<Curve>('curve', curve))
      ..add(DiagnosticsProperty<Duration>('reverseDuration', reverseDuration))
      ..add(DiagnosticsProperty<Curve>('reverseCurve', reverseCurve));
  }
}

/// Motion tokens — durations and curves used across the design system.
///
/// New code should prefer named [VMotionSpec] values such as [control],
/// [overlay], [page], and [emphasized]. Legacy duration and curve getters are
/// retained for existing widgets and route code.
@immutable
class VMotion with Diagnosticable {
  const VMotion({
    VMotionSpec? none,
    VMotionSpec? instant,
    VMotionSpec? fast,
    VMotionSpec? normal,
    VMotionSpec? slow,
    VMotionSpec? control,
    VMotionSpec? overlay,
    VMotionSpec? page,
    VMotionSpec? emphasized,
    this.reducedMotion = false,
    this.pageTransition = VPageTransition.slideFade,
  })  : none = none ?? _defaultNone,
        instant = instant ?? _defaultInstant,
        fast = fast ?? _defaultFast,
        normal = normal ?? _defaultNormal,
        slow = slow ?? _defaultSlow,
        control = control ?? _defaultControl,
        overlay = overlay ?? _defaultOverlay,
        page = page ?? _defaultPage,
        emphasized = emphasized ?? _defaultEmphasized;

  /// Default VidraUI motion tokens.
  factory VMotion.defaults() => const VMotion();

  /// Backwards-compatible alias for [defaults].
  @Deprecated('Use VMotion.defaults() instead')
  factory VMotion.defaultMotion() => VMotion.defaults();

  static const Duration _zeroDuration = Duration.zero;

  /// Default hover wait delay for tooltips.
  static const Duration tooltipWait = Duration(milliseconds: 500);

  /// Default auto-hide duration for touch-triggered tooltips.
  static const Duration tooltipShow = Duration(seconds: 2);

  static const Duration _defaultControlDuration = Duration(milliseconds: 120);
  static const Duration _defaultFastDuration = Duration(milliseconds: 160);
  static const Duration _defaultNormalDuration = Duration(milliseconds: 220);
  static const Duration _defaultSlowDuration = Duration(milliseconds: 300);
  static const Duration _defaultOverlayDuration = Duration(milliseconds: 220);
  static const Duration _defaultOverlayReverseDuration =
      Duration(milliseconds: 160);
  static const Duration _defaultPageDuration = Duration(milliseconds: 280);
  static const Duration _defaultPageReverseDuration =
      Duration(milliseconds: 220);
  static const Duration _defaultEmphasizedDuration =
      Duration(milliseconds: 340);
  static const Duration _defaultEmphasizedReverseDuration =
      Duration(milliseconds: 240);

  static const VMotionSpec _defaultNone = VMotionSpec(
    duration: _zeroDuration,
    curve: Curves.linear,
    reverseDuration: _zeroDuration,
    reverseCurve: Curves.linear,
  );
  static const VMotionSpec _defaultInstant = _defaultNone;
  static const VMotionSpec _defaultFast = VMotionSpec(
    duration: _defaultFastDuration,
    curve: Curves.easeOut,
  );
  static const VMotionSpec _defaultSlow = VMotionSpec(
    duration: _defaultSlowDuration,
    curve: Curves.easeInOut,
  );
  static const VMotionSpec _defaultOverlay = VMotionSpec(
    duration: _defaultOverlayDuration,
    curve: Curves.easeOutCubic,
    reverseDuration: _defaultOverlayReverseDuration,
    reverseCurve: Curves.easeInCubic,
  );
  static const VMotionSpec _defaultEmphasized = VMotionSpec(
    duration: _defaultEmphasizedDuration,
    curve: Curves.easeOutCubic,
    reverseDuration: _defaultEmphasizedReverseDuration,
    reverseCurve: Curves.easeInCubic,
  );

  static const VMotionSpec _defaultNormal = VMotionSpec(
    duration: _defaultNormalDuration,
    curve: Curves.easeInOut,
  );

  static const VMotionSpec _defaultControl = VMotionSpec(
    duration: _defaultControlDuration,
    curve: Curves.easeOut,
  );

  static const VMotionSpec _defaultPage = VMotionSpec(
    duration: _defaultPageDuration,
    curve: Curves.easeOutCubic,
    reverseDuration: _defaultPageReverseDuration,
    reverseCurve: Curves.easeInCubic,
  );

  /// No animation.
  final VMotionSpec none;

  /// Immediate visual state changes.
  final VMotionSpec instant;

  /// Short transitions that should still be visible.
  final VMotionSpec fast;

  /// Standard component transitions.
  final VMotionSpec normal;

  /// Slower transitions for content changes.
  final VMotionSpec slow;

  /// Micro-interactions such as hover, press, and focus.
  final VMotionSpec control;

  /// Overlay transitions such as dialogs, menus, toasts, and tooltips.
  final VMotionSpec overlay;

  /// Page route transitions.
  final VMotionSpec page;

  /// Expressive transitions such as bottom sheets.
  final VMotionSpec emphasized;

  /// Whether animations should resolve to no motion.
  final bool reducedMotion;

  /// Page transition style.
  final VPageTransition pageTransition;



  /// Creates a copy with selected fields replaced.
  VMotion copyWith({
    VMotionSpec? none,
    VMotionSpec? instant,
    VMotionSpec? fast,
    VMotionSpec? normal,
    VMotionSpec? slow,
    VMotionSpec? control,
    VMotionSpec? overlay,
    VMotionSpec? page,
    VMotionSpec? emphasized,
    bool? reducedMotion,
    VPageTransition? pageTransition,
  }) {
    return VMotion(
      none: none ?? this.none,
      instant: instant ?? this.instant,
      fast: fast ?? this.fast,
      normal: normal ?? this.normal,
      slow: slow ?? this.slow,
      control: control ?? this.control,
      overlay: overlay ?? this.overlay,
      page: page ?? this.page,
      emphasized: emphasized ?? this.emphasized,
      reducedMotion: reducedMotion ?? this.reducedMotion,
      pageTransition: pageTransition ?? this.pageTransition,
    );
  }

  /// Interpolates between two motion token sets.
  static VMotion lerp(VMotion a, VMotion b, double t) {
    return VMotion(
      none: VMotionSpec.lerp(a.none, b.none, t),
      instant: VMotionSpec.lerp(a.instant, b.instant, t),
      fast: VMotionSpec.lerp(a.fast, b.fast, t),
      normal: VMotionSpec.lerp(a.normal, b.normal, t),
      slow: VMotionSpec.lerp(a.slow, b.slow, t),
      control: VMotionSpec.lerp(a.control, b.control, t),
      overlay: VMotionSpec.lerp(a.overlay, b.overlay, t),
      page: VMotionSpec.lerp(a.page, b.page, t),
      emphasized: VMotionSpec.lerp(a.emphasized, b.emphasized, t),
      reducedMotion: t < 0.5 ? a.reducedMotion : b.reducedMotion,
      pageTransition: t < 0.5 ? a.pageTransition : b.pageTransition,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is VMotion &&
        other.none == none &&
        other.instant == instant &&
        other.fast == fast &&
        other.normal == normal &&
        other.slow == slow &&
        other.control == control &&
        other.overlay == overlay &&
        other.page == page &&
        other.emphasized == emphasized &&
        other.reducedMotion == reducedMotion &&
        other.pageTransition == pageTransition;
  }

  @override
  int get hashCode => Object.hash(
        none,
        instant,
        fast,
        normal,
        slow,
        control,
        overlay,
        page,
        emphasized,
        reducedMotion,
        pageTransition,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<VMotionSpec>('none', none))
      ..add(DiagnosticsProperty<VMotionSpec>('instant', instant))
      ..add(DiagnosticsProperty<VMotionSpec>('fast', fast))
      ..add(DiagnosticsProperty<VMotionSpec>('normal', normal))
      ..add(DiagnosticsProperty<VMotionSpec>('slow', slow))
      ..add(DiagnosticsProperty<VMotionSpec>('control', control))
      ..add(DiagnosticsProperty<VMotionSpec>('overlay', overlay))
      ..add(DiagnosticsProperty<VMotionSpec>('page', page))
      ..add(DiagnosticsProperty<VMotionSpec>('emphasized', emphasized))
      ..add(FlagProperty('reducedMotion',
          value: reducedMotion, ifTrue: 'reduced'))
      ..add(EnumProperty<VPageTransition>('pageTransition', pageTransition));
  }
}
