import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../theme/v_theme.dart';

/// A slider for selecting a value in a range.
///
/// Supports horizontal or vertical orientation via [axis], and discrete
/// step snapping via [step].
class VSlider extends StatefulWidget {
  const VSlider({
    super.key,
    required this.value,
    required this.onChanged,
    this.valueNotifier,
    this.onDragEnd,
    this.min = 0,
    this.max = 1,
    this.step,
    this.axis = Axis.horizontal,
    this.enabled = true,
    this.semanticLabel,
    this.autofocus = false,
    this.focusNode,
  }) : assert(max > min, 'VSlider.max must be greater than VSlider.min.');

  final double value;
  final ValueNotifier<double>? valueNotifier;
  final ValueChanged<double>? onDragEnd;
  final ValueChanged<double> onChanged;
  final double min;
  final double max;
  final double? step;
  final Axis axis;
  final bool enabled;
  final String? semanticLabel;
  final bool autofocus;
  final FocusNode? focusNode;

  @override
  State<VSlider> createState() => _VSliderState();
}

class _VSliderState extends State<VSlider> {
  late final ValueNotifier<double> _localValueNotifier;

  @override
  void initState() {
    super.initState();
    _localValueNotifier =
        widget.valueNotifier ?? ValueNotifier<double>(widget.value);
  }

  @override
  void didUpdateWidget(VSlider oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      _localValueNotifier.value = widget.value;
    }
  }

  @override
  void dispose() {
    if (widget.valueNotifier == null) {
      _localValueNotifier.dispose();
    }
    super.dispose();
  }

  double _snap(double v) {
    if (widget.step == null || widget.step! <= 0) return v;
    final steps = ((v - widget.min) / widget.step!).round();
    final snapped = widget.min + steps * widget.step!;
    return snapped.clamp(widget.min, widget.max);
  }

  bool get _isHorizontal => widget.axis == Axis.horizontal;

  double get _keyboardStep {
    final range = widget.max - widget.min;
    return widget.step != null && widget.step! > 0 ? widget.step! : range / 20;
  }

  void _setValue(double value) {
    if (!widget.enabled) return;
    final snapped = _snap(value).clamp(widget.min, widget.max);
    _localValueNotifier.value = snapped;
    widget.onChanged(snapped);
  }

  void _increment([int multiplier = 1]) {
    _setValue(_localValueNotifier.value + _keyboardStep * multiplier);
  }

  void _decrement([int multiplier = 1]) {
    _setValue(_localValueNotifier.value - _keyboardStep * multiplier);
  }

  KeyEventResult _handleKey(FocusNode node, KeyEvent event) {
    if (!widget.enabled || event is! KeyDownEvent) {
      return KeyEventResult.ignored;
    }
    final key = event.logicalKey;
    if (key == LogicalKeyboardKey.arrowRight ||
        key == LogicalKeyboardKey.arrowUp) {
      _increment();
      return KeyEventResult.handled;
    }
    if (key == LogicalKeyboardKey.arrowLeft ||
        key == LogicalKeyboardKey.arrowDown) {
      _decrement();
      return KeyEventResult.handled;
    }
    if (key == LogicalKeyboardKey.pageUp) {
      _increment(10);
      return KeyEventResult.handled;
    }
    if (key == LogicalKeyboardKey.pageDown) {
      _decrement(10);
      return KeyEventResult.handled;
    }
    if (key == LogicalKeyboardKey.home) {
      _setValue(widget.min);
      return KeyEventResult.handled;
    }
    if (key == LogicalKeyboardKey.end) {
      _setValue(widget.max);
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  void _onDragUpdate(Offset local, double trackLength) {
    if (!widget.enabled) return;
    final ratio = (_isHorizontal
            ? (local.dx / trackLength)
            : 1.0 - (local.dy / trackLength))
        .clamp(0.0, 1.0);
    final raw = widget.min + ratio * (widget.max - widget.min);
    final snapped = _snap(raw);
    _localValueNotifier.value = snapped;
    widget.onChanged(snapped);
  }

  void _handleDragEnd() {
    if (widget.enabled && widget.onDragEnd != null) {
      widget.onDragEnd!(_localValueNotifier.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);
    final range = widget.max - widget.min;
    final ratio = ((widget.value - widget.min) / (range == 0 ? 1 : range))
        .clamp(0.0, 1.0);

    final states = <WidgetState>{
      if (!widget.enabled) WidgetState.disabled,
    };
    final tokens = theme.components.slider;
    final trackColor = tokens.trackBackground.resolve(states);
    final activeColor = tokens.trackActive.resolve(states);
    final thumbColor = tokens.thumbBackground.resolve(states);

    final pct = (ratio * 100).round();
    final nextPct =
        ((_snap(widget.value + _keyboardStep) - widget.min) / range * 100)
            .clamp(0, 100)
            .round();
    final previousPct =
        ((_snap(widget.value - _keyboardStep) - widget.min) / range * 100)
            .clamp(0, 100)
            .round();
    return Semantics(
      label: widget.semanticLabel ?? 'Slider at $pct%',
      value: '$pct%',
      increasedValue: '$nextPct%',
      decreasedValue: '$previousPct%',
      enabled: widget.enabled,
      onIncrease: widget.enabled ? _increment : null,
      onDecrease: widget.enabled ? _decrement : null,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final total =
              _isHorizontal ? constraints.maxWidth : constraints.maxHeight;
          final trackLength = total - theme.sizes.sliderThumb;

          return Focus(
            autofocus: widget.autofocus,
            focusNode: widget.focusNode,
            canRequestFocus: widget.enabled,
            onKeyEvent: _handleKey,
            child: SizedBox(
              width: _isHorizontal ? total : theme.sizes.sliderThumb + 4,
              height: _isHorizontal ? theme.sizes.sliderThumb + 4 : total,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTapDown: widget.enabled
                    ? (d) => _onDragUpdate(
                          d.localPosition,
                          trackLength,
                        )
                    : null,
                onPanUpdate: widget.enabled
                    ? (d) => _onDragUpdate(d.localPosition, trackLength)
                    : null,
                onPanEnd: widget.enabled ? (_) => _handleDragEnd() : null,
                onTapUp: widget.enabled ? (_) => _handleDragEnd() : null,
                child: ValueListenableBuilder<double>(
                  valueListenable: _localValueNotifier,
                  builder: (context, currentValue, child) {
                    final currentRatio =
                        ((currentValue - widget.min) / (range == 0 ? 1 : range))
                            .clamp(0.0, 1.0);
                    final thumbPos = currentRatio * trackLength;

                    return Stack(
                      children: [
                        if (_isHorizontal) ...[
                          Positioned(
                            left: theme.sizes.sliderThumb / 2,
                            right: theme.sizes.sliderThumb / 2,
                            top: (theme.sizes.sliderThumb +
                                    4 -
                                    theme.sizes.sliderTrack) /
                                2,
                            child: _Track(
                              thickness: theme.sizes.sliderTrack,
                              color: trackColor,
                            ),
                          ),
                          Positioned(
                            left: theme.sizes.sliderThumb / 2,
                            top: (theme.sizes.sliderThumb +
                                    4 -
                                    theme.sizes.sliderTrack) /
                                2,
                            width: thumbPos + theme.sizes.sliderThumb / 2,
                            child: _Track(
                              thickness: theme.sizes.sliderTrack,
                              color: activeColor,
                            ),
                          ),
                        ] else ...[
                          Positioned(
                            top: theme.sizes.sliderThumb / 2,
                            bottom: theme.sizes.sliderThumb / 2,
                            left: (theme.sizes.sliderThumb +
                                    4 -
                                    theme.sizes.sliderTrack) /
                                2,
                            child: _Track(
                              thickness: theme.sizes.sliderTrack,
                              color: trackColor,
                              isVertical: true,
                            ),
                          ),
                          Positioned(
                            bottom: theme.sizes.sliderThumb / 2,
                            left: (theme.sizes.sliderThumb +
                                    4 -
                                    theme.sizes.sliderTrack) /
                                2,
                            height: thumbPos + theme.sizes.sliderThumb / 2,
                            child: _Track(
                              thickness: theme.sizes.sliderTrack,
                              color: activeColor,
                              isVertical: true,
                            ),
                          ),
                        ],
                        if (_isHorizontal)
                          Positioned(
                            left: thumbPos,
                            top: 2,
                            child: _Thumb(
                              size: theme.sizes.sliderThumb,
                              color: thumbColor,
                              shadow: theme.shadows.card,
                            ),
                          )
                        else
                          Positioned(
                            bottom: thumbPos,
                            left: 2,
                            child: _Thumb(
                              size: theme.sizes.sliderThumb,
                              color: thumbColor,
                              shadow: theme.shadows.card,
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _Track extends StatelessWidget {
  const _Track({
    required this.thickness,
    required this.color,
    this.isVertical = false,
  });

  final double thickness;
  final Color color;
  final bool isVertical;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(thickness / 2),
      ),
      child: SizedBox(
        width: isVertical ? thickness : null,
        height: isVertical ? null : thickness,
      ),
    );
  }
}

class _Thumb extends StatelessWidget {
  const _Thumb({
    required this.size,
    required this.color,
    required this.shadow,
  });

  final double size;
  final Color color;
  final BoxShadow shadow;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [shadow],
      ),
    );
  }
}
