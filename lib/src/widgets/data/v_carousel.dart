import 'dart:async';

import 'package:flutter/widgets.dart';

import '../../theme/v_theme.dart';

/// An auto-playing carousel / banner with dot indicators.
///
/// Each [children] widget is shown as a full-width page. Dots below
/// indicate the current index. Auto-play advances every [interval].
class VCarousel extends StatefulWidget {
  const VCarousel({
    super.key,
    required this.children,
    this.height = 200,
    this.autoPlay = true,
    this.interval = const Duration(seconds: 4),
    this.showDots = true,
    this.onPageChanged,
  });

  final List<Widget> children;
  final double height;
  final bool autoPlay;
  final Duration interval;
  final bool showDots;
  final ValueChanged<int>? onPageChanged;

  @override
  State<VCarousel> createState() => _VCarouselState();
}

class _VCarouselState extends State<VCarousel> {
  late final PageController _controller;
  Timer? _timer;
  int _current = 0;
  // Cached to avoid VTheme.of(context) inside timer callbacks,
  // which could fire after the widget's context is deactivated.
  late Duration _animDuration;
  Curve _animCurve = Curves.easeInOut;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
    if (widget.autoPlay && widget.children.length > 1) {
      _startTimer();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final spec = VTheme.of(context).motion.normal;
    _animDuration = spec.duration;
    _animCurve = spec.curve;
  }

  @override
  void didUpdateWidget(VCarousel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.children.length != oldWidget.children.length) {
      _current = widget.children.isEmpty
          ? 0
          : _current.clamp(0, widget.children.length - 1);
      if (_controller.hasClients && widget.children.isNotEmpty) {
        _controller.jumpToPage(_current);
      }
    }

    if (widget.autoPlay != oldWidget.autoPlay ||
        widget.interval != oldWidget.interval ||
        widget.children.length != oldWidget.children.length) {
      if (widget.autoPlay && widget.children.length > 1) {
        _startTimer();
      } else {
        _timer?.cancel();
        _timer = null;
      }
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(widget.interval, (_) {
      if (!mounted) return;
      if (!widget.autoPlay || widget.children.length <= 1) {
        _timer?.cancel();
        _timer = null;
        return;
      }
      final next = (_current + 1) % widget.children.length;
      _controller.animateToPage(
        next,
        duration: _animDuration,
        curve: _animCurve,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);

    if (widget.children.isEmpty) {
      return SizedBox(height: widget.height);
    }

    return Semantics(
        label: 'Page ${_current + 1} of ${widget.children.length}',
        child: RepaintBoundary(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: widget.height,
                child: PageView.builder(
                  controller: _controller,
                  itemCount: widget.children.length,
                  onPageChanged: (i) {
                    setState(() => _current = i);
                    widget.onPageChanged?.call(i);
                    if (widget.autoPlay) _startTimer();
                  },
                  itemBuilder: (context, i) {
                    return RepaintBoundary(
                      child: widget.children[i],
                    );
                  },
                ),
              ),
              if (widget.showDots && widget.children.length > 1)
                Padding(
                  padding: EdgeInsets.only(top: theme.spacing.sm),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(widget.children.length, (i) {
                      return AnimatedContainer(
                        duration: theme.motion.control.duration,
                        curve: theme.motion.control.curve,
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        width: i == _current ? 16 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: i == _current
                              ? theme.colors.actionPrimary
                              : theme.colors.border,
                          borderRadius: BorderRadius.circular(theme.radii.sm),
                        ),
                      );
                    }),
                  ),
                ),
            ],
          ),
        ));
  }
}
