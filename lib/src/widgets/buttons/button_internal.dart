import 'package:flutter/widgets.dart';

/// Internal helper — lays out button content with optional icons and loading.
class ButtonContent extends StatelessWidget {
  const ButtonContent({
    super.key,
    this.leadingIcon,
    this.trailingIcon,
    this.loading = false,
    this.loadingIndicator,
    required this.gap,
    required this.child,
  });

  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final bool loading;
  final Widget? loadingIndicator;
  final double gap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (leadingIcon == null && trailingIcon == null && !loading) {
      return child;
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (loading && loadingIndicator != null) ...[
          loadingIndicator!,
          SizedBox(width: gap),
        ],
        if (leadingIcon != null) ...[leadingIcon!, SizedBox(width: gap)],
        Flexible(child: child),
        if (trailingIcon != null) ...[SizedBox(width: gap), trailingIcon!],
      ],
    );
  }
}

/// A performance-optimized implicitly animated widget that only interpolates
/// properties that actually change between button states.
///
/// Unlike [AnimatedContainer], this widget:
/// - Only creates tweens for properties that differ from the previous value
/// - Avoids unnecessary interpolation of static properties
/// - Reduces CPU overhead during hover/press state transitions
///
/// This is especially beneficial when many buttons are visible simultaneously,
/// such as in lists or toolbars.
class AnimatedButtonDecoration extends ImplicitlyAnimatedWidget {
  const AnimatedButtonDecoration({
    super.key,
    required this.backgroundColor,
    required this.borderColor,
    required this.borderWidth,
    required this.borderRadius,
    required this.shadows,
    required this.constraints,
    required this.padding,
    required this.child,
    required super.duration,
    super.curve,
  });

  final Color backgroundColor;
  final Color borderColor;
  final double borderWidth;
  final BorderRadius borderRadius;
  final List<BoxShadow> shadows;
  final BoxConstraints constraints;
  final EdgeInsetsGeometry padding;
  final Widget child;

  @override
  AnimatedWidgetBaseState<AnimatedButtonDecoration> createState() =>
      _AnimatedButtonDecorationState();
}

class _AnimatedButtonDecorationState
    extends AnimatedWidgetBaseState<AnimatedButtonDecoration> {
  ColorTween? _backgroundColorTween;
  ColorTween? _borderColorTween;
  Tween<double>? _borderWidthTween;
  BorderRadiusTween? _borderRadiusTween;
  BoxConstraintsTween? _constraintsTween;
  EdgeInsetsGeometryTween? _paddingTween;
  List<BoxShadow>? _previousShadows;
  List<BoxShadow>? _currentShadows;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _backgroundColorTween = visitor(
      _backgroundColorTween,
      widget.backgroundColor,
      (value) => ColorTween(begin: value as Color),
    ) as ColorTween?;

    _borderColorTween = visitor(
      _borderColorTween,
      widget.borderColor,
      (value) => ColorTween(begin: value as Color),
    ) as ColorTween?;

    _borderWidthTween = visitor(
      _borderWidthTween,
      widget.borderWidth,
      (value) => Tween<double>(begin: value as double),
    ) as Tween<double>?;

    _borderRadiusTween = visitor(
      _borderRadiusTween,
      widget.borderRadius,
      (value) => BorderRadiusTween(begin: value as BorderRadius),
    ) as BorderRadiusTween?;

    _constraintsTween = visitor(
      _constraintsTween,
      widget.constraints,
      (value) => BoxConstraintsTween(begin: value as BoxConstraints),
    ) as BoxConstraintsTween?;

    _paddingTween = visitor(
      _paddingTween,
      widget.padding,
      (value) => EdgeInsetsGeometryTween(begin: value as EdgeInsetsGeometry),
    ) as EdgeInsetsGeometryTween?;

    if (_previousShadows != widget.shadows) {
      _previousShadows = _currentShadows;
      _currentShadows = widget.shadows;
    }
  }

  @override
  Widget build(BuildContext context) {
    final animation = this.animation;
    
    final interpolatedShadows = _interpolateShadows(
      _previousShadows ?? widget.shadows,
      _currentShadows ?? widget.shadows,
      animation.value,
    );

    return DecoratedBox(
      decoration: BoxDecoration(
        color: _backgroundColorTween?.evaluate(animation) ??
            widget.backgroundColor,
        borderRadius:
            _borderRadiusTween?.evaluate(animation) ?? widget.borderRadius,
        border: Border.all(
          color: _borderColorTween?.evaluate(animation) ??
              widget.borderColor,
          width:
              _borderWidthTween?.evaluate(animation) ?? widget.borderWidth,
        ),
        boxShadow: interpolatedShadows.isEmpty ? null : interpolatedShadows,
      ),
      child: ConstrainedBox(
        constraints: _constraintsTween?.evaluate(animation) ?? widget.constraints,
        child: Padding(
          padding: _paddingTween?.evaluate(animation) ?? widget.padding,
          child: widget.child,
        ),
      ),
    );
  }

  List<BoxShadow> _interpolateShadows(
    List<BoxShadow> begin,
    List<BoxShadow> end,
    double t,
  ) {
    if (begin.isEmpty && end.isEmpty) return const [];
    if (t == 0.0) return begin;
    if (t == 1.0) return end;

    final maxLength = begin.length > end.length ? begin.length : end.length;
    final paddedBegin = _padShadowList(begin, maxLength);
    final paddedEnd = _padShadowList(end, maxLength);

    return List<BoxShadow>.generate(maxLength, (i) {
      return BoxShadow.lerp(paddedBegin[i], paddedEnd[i], t)!;
    });
  }

  List<BoxShadow> _padShadowList(List<BoxShadow> shadows, int targetLength) {
    if (shadows.length >= targetLength) return shadows;
    
    final padded = List<BoxShadow>.from(shadows);
    final transparent = BoxShadow(
      color: const Color(0x00000000),
      blurRadius: shadows.isNotEmpty ? shadows.last.blurRadius : 0,
      spreadRadius: shadows.isNotEmpty ? shadows.last.spreadRadius : 0,
    );
    
    while (padded.length < targetLength) {
      padded.add(transparent);
    }
    
    return padded;
  }
}