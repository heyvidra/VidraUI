import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../theme/theme.dart';
import '../interaction/v_interactive.dart';

/// A standalone collapsible container with smooth height animation and header controls.
class VCollapsible extends StatefulWidget {
  const VCollapsible({
    super.key,
    required this.header,
    required this.child,
    this.expanded,
    this.onChanged,
    this.initiallyExpanded = false,
    this.indicatorAtStart = true,
    this.indicatorColor,
  });

  /// The header widget that acts as the toggle button.
  final Widget header;

  /// The body content to expand/collapse.
  final Widget child;

  /// Controlled expansion state. If null, the widget manages its own state internally.
  final bool? expanded;

  /// Called when the collapse state changes.
  final ValueChanged<bool>? onChanged;

  /// The initial expand state for uncontrolled usage.
  final bool initiallyExpanded;

  /// Whether the indicator appears at the start (true) or end (false) of the header.
  final bool indicatorAtStart;

  /// Optional custom color for the indicator. Falls back to header foreground token.
  final Color? indicatorColor;

  @override
  State<VCollapsible> createState() => _VCollapsibleState();
}

class _VCollapsibleState extends State<VCollapsible> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;
  late bool _internalExpanded;
  final FocusNode _focusNode = FocusNode();

  bool get _isExpanded => widget.expanded ?? _internalExpanded;

  @override
  void initState() {
    super.initState();
    _internalExpanded = widget.initiallyExpanded;
    _controller = AnimationController(
      vsync: this,
    );
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.dismissed || status == AnimationStatus.completed) {
        if (mounted) setState(() {});
      }
    });
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut, // Curve is overridden dynamically in didChangeDependencies
    );

    if (_isExpanded) {
      _controller.value = 1.0;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final theme = VTheme.of(context);
    _controller.duration = theme.motion.normal.duration;
  }

  @override
  void didUpdateWidget(VCollapsible oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.expanded != null && widget.expanded != oldWidget.expanded) {
      _animateToState(_isExpanded);
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _animateToState(bool expanded) {
    final theme = VTheme.of(context);
    final curve = theme.motion.normal.curve;
    if (expanded) {
      _controller.animateTo(1.0, curve: curve);
    } else {
      _controller.animateBack(0.0, curve: curve);
    }
  }

  void _toggle() {
    final nextState = !_isExpanded;
    if (widget.expanded == null) {
      setState(() {
        _internalExpanded = nextState;
      });
      _animateToState(nextState);
    }
    widget.onChanged?.call(nextState);
  }

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);
    final tokens = VAccordionTheme.of(context) ?? theme.components.accordion;

    // Track active interactions
    final isExpanded = _isExpanded;

    return Shortcuts(
      shortcuts: const <ShortcutActivator, Intent>{
        SingleActivator(LogicalKeyboardKey.enter): ActivateIntent(),
        SingleActivator(LogicalKeyboardKey.space): ActivateIntent(),
      },
      child: Actions(
        actions: <Type, Action<Intent>>{
          ActivateIntent: CallbackAction<ActivateIntent>(
            onInvoke: (_) {
              _toggle();
              return null;
            },
          ),
        },
        child: Semantics(
        expanded: isExpanded,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header click trigger
            VInteractive(
              enabled: true,
              onTap: _toggle,
              focusNode: _focusNode,
              requestFocusOnTap: false,
              builder: (context, states) {
                final focused = states.contains(WidgetState.focused);
                final headerBg = tokens.headerBackground.resolve(states);
                final headerFg = tokens.headerForeground.resolve(states);
                final headerBorderColor = tokens.headerBorder.resolve(states);

                final focusShadow = focused
                    ? [
                        BoxShadow(
                          color: tokens.focusRing.withValues(alpha: 0.45),
                          blurRadius: 0,
                          spreadRadius: 2,
                        ),
                      ]
                    : <BoxShadow>[];

                return Container(
                  padding: tokens.headerPadding,
                  decoration: BoxDecoration(
                    color: headerBg,
                    border: Border(
                      bottom: BorderSide(color: headerBorderColor),
                    ),
                    boxShadow: focusShadow,
                  ),
                  child: Row(
                    children: [
                      // Smooth rotating arrow indicator
                      if (widget.indicatorAtStart) ...[
                        AnimatedRotation(
                          turns: isExpanded ? 0.25 : 0.0,
                          duration: theme.motion.normal.duration,
                          curve: theme.motion.normal.curve,
                          child: VIconTheme(
                            data: VIconThemeData(
                              color: widget.indicatorColor ?? headerFg,
                              size: 14,
                            ),
                            child: const Text('▶', style: TextStyle(fontSize: 10, height: 1)),
                          ),
                        ),
                        const SizedBox(width: 8),
                      ],
                      Expanded(
                        child: DefaultTextStyle(
                          style: theme.typography.body.copyWith(
                            color: headerFg,
                            fontWeight: theme.typography.label.fontWeight,
                          ),
                          child: widget.header,
                        ),
                      ),
                      if (!widget.indicatorAtStart) ...[
                        const SizedBox(width: 8),
                        AnimatedRotation(
                          turns: isExpanded ? 0.25 : 0.0,
                          duration: theme.motion.normal.duration,
                          curve: theme.motion.normal.curve,
                          child: VIconTheme(
                            data: VIconThemeData(
                              color: widget.indicatorColor ?? headerFg,
                              size: 14,
                            ),
                            child: const Text('▶', style: TextStyle(fontSize: 10, height: 1)),
                          ),
                        ),
                      ],
                    ],
                  ),
                );
              },
            ),

            // Performance height clip size transition
            SizeTransition(
              sizeFactor: _animation,
              axis: Axis.vertical,
              alignment: Alignment.topCenter,
              child: ClipRect(
                child: Container(
                  height: (isExpanded || !_animation.isDismissed) ? null : 0,
                  padding: tokens.bodyPadding,
                  color: tokens.bodyBackground,
                  child: widget.child,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
}

/// An individual accordion item model inside [VAccordion].
class VAccordionItem {
  const VAccordionItem({
    required this.header,
    required this.child,
    this.initiallyExpanded = false,
    this.indicatorAtStart = true,
    this.indicatorColor,
  });

  final Widget header;
  final Widget child;
  final bool initiallyExpanded;
  /// Controls indicator placement; true for start, false for end.
  final bool indicatorAtStart;
  /// Custom indicator color.
  final Color? indicatorColor;
}

/// A structured panel of collapsible items.
///
/// Supports exclusive expand mode where opening one section auto-collapses others smoothly.
class VAccordion extends StatefulWidget {
  const VAccordion({
    super.key,
    required this.items,
    this.multiple = false,
    this.initialIndex,
  });

  /// The accordion items.
  final List<VAccordionItem> items;

  /// When true, allows expanding multiple items at once.
  /// When false, acts as exclusive single expansion.
  final bool multiple;

  /// Pre-selected active item index on init (only applies when [multiple] is false).
  final int? initialIndex;

  @override
  State<VAccordion> createState() => _VAccordionState();
}

class _VAccordionState extends State<VAccordion> {
  // Keeps track of active indexes
  late final List<bool> _expandedStates;

  @override
  void initState() {
    super.initState();
    _expandedStates = List.generate(widget.items.length, (i) {
      if (widget.multiple) {
        return widget.items[i].initiallyExpanded;
      } else {
        return widget.initialIndex == i || widget.items[i].initiallyExpanded;
      }
    });

    // Enforce exclusivity on init
    if (!widget.multiple) {
      final activeIdx = _expandedStates.indexOf(true);
      if (activeIdx >= 0) {
        for (int i = 0; i < _expandedStates.length; i++) {
          if (i != activeIdx) {
            _expandedStates[i] = false;
          }
        }
      }
    }
  }

  void _handleChanged(int index, bool nextState) {
    setState(() {
      if (widget.multiple) {
        _expandedStates[index] = nextState;
      } else {
        if (nextState) {
          // Collapse all others
          for (int i = 0; i < _expandedStates.length; i++) {
            _expandedStates[i] = (i == index);
          }
        } else {
          _expandedStates[index] = false;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);
    final tokens = VAccordionTheme.of(context) ?? theme.components.accordion;

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(tokens.radius),
        border: Border.all(color: theme.colors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: List.generate(widget.items.length, (i) {
          final item = widget.items[i];
            return VCollapsible(
              key: ValueKey(i),
              header: item.header,
              expanded: _expandedStates[i],
              onChanged: (expanded) => _handleChanged(i, expanded),
              indicatorAtStart: item.indicatorAtStart,
              indicatorColor: item.indicatorColor,
              child: item.child,
            );
        }),
      ),
    );
  }
}
