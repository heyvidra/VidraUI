part of 'v_navigation_bar.dart';

class _VNavigationBarState extends State<VNavigationBar> {
  final FocusNode _focusNode = FocusNode(debugLabel: 'VNavigationBar');

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _select(int index) {
    if (!widget.enabled) return;
    if (!widget.destinations[index].enabled) return;
    if (index == widget.selectedIndex) return;
    widget.onChanged(index);
  }

  void _handleArrowKey(bool forward) {
    if (!widget.enabled) return;
    final len = widget.destinations.length;
    int index = widget.selectedIndex;
    for (int i = 0; i < len; i++) {
      index = (index + (forward ? 1 : -1)) % len;
      if (widget.destinations[index].enabled) {
        _select(index);
        break;
      }
    }
  }

  double get _effectiveHeight {
    final tokens =
        VNavigationBarTheme.of(context) ?? _theme.components.navigationBar;
    return switch (widget.contentMode) {
      VNavigationBarContentMode.labeled => tokens.height,
      VNavigationBarContentMode.iconsOnly => tokens.iconsOnlyHeight,
      VNavigationBarContentMode.labelsOnly => tokens.labelsOnlyHeight,
    };
  }

  VThemeData get _theme => VTheme.of(context);

  VNavigationBarTokens _tokens() {
    return VNavigationBarTheme.of(context) ?? _theme.components.navigationBar;
  }

  EdgeInsets _shapeMargin(VNavigationBarTokens tokens) {
    final safeArea = MediaQuery.paddingOf(context);
    return switch (widget.shape) {
      VNavigationBarShape.flat => EdgeInsets.zero,
      VNavigationBarShape.floating => EdgeInsets.fromLTRB(
          (tokens.horizontalMargin > 0 ? tokens.horizontalMargin : 16.0) +
              safeArea.left,
          0,
          (tokens.horizontalMargin > 0 ? tokens.horizontalMargin : 16.0) +
              safeArea.right,
          (tokens.bottomMargin > 0 ? tokens.bottomMargin : 8.0) +
              safeArea.bottom,
        ),
      VNavigationBarShape.capsule => EdgeInsets.fromLTRB(
          (tokens.horizontalMargin > 0 ? tokens.horizontalMargin : 24.0) +
              safeArea.left,
          0,
          (tokens.horizontalMargin > 0 ? tokens.horizontalMargin : 24.0) +
              safeArea.right,
          (tokens.bottomMargin > 0 ? tokens.bottomMargin : 8.0) +
              safeArea.bottom,
        ),
    };
  }

  double _shapeRadius(VNavigationBarTokens tokens) {
    return switch (widget.shape) {
      VNavigationBarShape.flat => tokens.borderRadius,
      VNavigationBarShape.floating =>
        tokens.borderRadius > 0 ? tokens.borderRadius : 16,
      VNavigationBarShape.capsule =>
        tokens.borderRadius > 0 ? tokens.borderRadius : _effectiveHeight / 2,
    };
  }

  Widget _buildIndicator(
    VNavigationBarTokens tokens,
    double itemWidth,
    double height,
  ) {
    if (widget.indicator == VNavigationBarIndicator.none) {
      return const SizedBox.shrink();
    }

    final showLabels =
        widget.contentMode != VNavigationBarContentMode.iconsOnly;
    final duration = _theme.motion.control.duration;
    final curve = _theme.motion.control.curve;

    final states = <WidgetState>{
      WidgetState.selected,
      if (!widget.enabled) WidgetState.disabled,
    };
    final color = tokens.indicatorBackground.resolve(states);

    final hasCenterFab = widget.centerDestination != null &&
        widget.shape != VNavigationBarShape.capsule;
    final gapWidth =
        hasCenterFab ? (tokens.centerFabSize + 2 * tokens.notchMargin) : 0.0;
    final itemCount = widget.destinations.length;
    final leftCount = itemCount ~/ 2;

    final double selectedLeft;
    if (hasCenterFab) {
      if (widget.selectedIndex < leftCount) {
        selectedLeft = widget.selectedIndex * itemWidth;
      } else {
        selectedLeft = widget.selectedIndex * itemWidth + gapWidth;
      }
    } else {
      selectedLeft = widget.selectedIndex * itemWidth;
    }

    final pillVerticalInset = (height * 0.12).clamp(6.0, 12.0);

    return switch (widget.indicator) {
      VNavigationBarIndicator.pill => _PillIndicator(
          left: selectedLeft + tokens.indicatorHorizontalInset,
          topOffset: pillVerticalInset,
          width: itemWidth - 2 * tokens.indicatorHorizontalInset,
          height: height - 2 * pillVerticalInset,
          color: color,
          radius: tokens.indicatorRadius,
          duration: duration,
          curve: curve,
        ),
      VNavigationBarIndicator.dot => _DotIndicator(
          left: selectedLeft + (itemWidth - tokens.indicatorDotSize) / 2,
          barHeight: height,
          dotSize: tokens.indicatorDotSize,
          color: color,
          duration: duration,
          curve: curve,
          showLabels: showLabels,
        ),
      VNavigationBarIndicator.topLine => _TopLineIndicator(
          left: selectedLeft + tokens.indicatorHorizontalInset,
          width: itemWidth - 2 * tokens.indicatorHorizontalInset,
          lineHeight: tokens.indicatorTopLineHeight,
          color: color,
          duration: duration,
          curve: curve,
        ),
      VNavigationBarIndicator.none => const SizedBox.shrink(),
    };
  }

  Widget _buildCenterFab(VNavigationBarTokens tokens) {
    final dest = widget.centerDestination!;
    final fabSize = tokens.centerFabSize;
    final destEnabled = widget.enabled && dest.enabled;
    final scrim = _theme.colors.scrim;

    return Semantics(
      button: true,
      label: dest.label,
      enabled: destEnabled,
      child: VInteractive(
        enabled: destEnabled,
        onTap: destEnabled ? () => widget.onChanged(-1) : null,
        requestFocusOnTap: false,
        builder: (context, states) {
          final double opacity = states.contains(WidgetState.pressed)
              ? 0.85
              : states.contains(WidgetState.hovered)
                  ? 0.95
                  : 1.0;

          return Opacity(
            opacity: opacity,
            child: Container(
              width: fabSize,
              height: fabSize,
              decoration: BoxDecoration(
                color: tokens.centerFabBackground,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: scrim.withValues(alpha: 0.2),
                    blurRadius: tokens.centerFabElevation,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: VIconTheme(
                  data: VIconThemeData(
                    color: tokens.centerFabForeground,
                    size: fabSize * 0.45,
                  ),
                  child: dest.icon,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDestination(
    VNavigationBarTokens tokens,
    int index,
    double itemWidth,
    double barHeight,
  ) {
    final dest = widget.destinations[index];
    final isSelected = index == widget.selectedIndex;
    final destEnabled = widget.enabled && dest.enabled;

    return SizedBox(
      width: itemWidth,
      child: Semantics(
        button: true,
        selected: isSelected,
        enabled: destEnabled,
        label: dest.label,
        child: VInteractive(
          enabled: destEnabled,
          onTap: destEnabled ? () => _select(index) : null,
          requestFocusOnTap: false,
          builder: (context, states) {
            final combinedStates = {
              ...states,
              if (isSelected) WidgetState.selected,
              if (!destEnabled) WidgetState.disabled,
            };

            final foregroundColor = tokens.foreground.resolve(combinedStates);

            return SizedBox(
              height: barHeight,
              child: _buildItemContent(tokens, dest, isSelected, foregroundColor),
            );
          },
        ),
      ),
    );
  }

  Widget _buildItemContent(
    VNavigationBarTokens tokens,
    VNavigationDestination dest,
    bool isSelected,
    Color foregroundColor,
  ) {
    return switch (widget.contentMode) {
      VNavigationBarContentMode.labeled => _LabeledItem(
          dest: dest,
          isSelected: isSelected,
          foregroundColor: foregroundColor,
          iconSize: tokens.iconSize,
          iconLabelSpacing: tokens.iconLabelSpacing,
          animation: widget.animation,
        ),
      VNavigationBarContentMode.iconsOnly => _IconsOnlyItem(
          dest: dest,
          isSelected: isSelected,
          foregroundColor: foregroundColor,
          iconSize: tokens.iconSize,
          animation: widget.animation,
        ),
      VNavigationBarContentMode.labelsOnly => _LabelsOnlyItem(
          dest: dest,
          isSelected: isSelected,
          foregroundColor: foregroundColor,
          animation: widget.animation,
        ),
    };
  }

  @override
  Widget build(BuildContext context) {
    final tokens = _tokens();
    final finalEnabled = widget.enabled;
    final barHeight = _effectiveHeight;
    final shapeRadius = _shapeRadius(tokens);
    final margin = _shapeMargin(tokens);

    final safeArea = MediaQuery.paddingOf(context);
    final safeAreaBottom = safeArea.bottom;
    final safeAreaLeft = safeArea.left;
    final safeAreaRight = safeArea.right;

    final hasCenterFab = widget.centerDestination != null &&
        widget.shape != VNavigationBarShape.capsule;
    final hasShadow =
        widget.shape != VNavigationBarShape.flat && tokens.shadow.isNotEmpty;

    final borderSide = BorderSide(color: tokens.border);

    final totalHeight = barHeight +
        (widget.shape == VNavigationBarShape.flat ? safeAreaBottom : 0.0);
    final containerPadding = EdgeInsets.only(
      left: tokens.horizontalPadding +
          (widget.shape == VNavigationBarShape.flat ? safeAreaLeft : 0.0),
      right: tokens.horizontalPadding +
          (widget.shape == VNavigationBarShape.flat ? safeAreaRight : 0.0),
      bottom: widget.shape == VNavigationBarShape.flat ? safeAreaBottom : 0.0,
    );

    Widget bar = Container(
      height: totalHeight,
      padding: containerPadding,
      decoration: hasCenterFab
          ? null
          : BoxDecoration(
              color: tokens.background,
              border: widget.shape == VNavigationBarShape.flat
                  ? Border(top: borderSide)
                  : null,
              boxShadow: hasShadow ? tokens.shadow : null,
            ),
      child: FocusableActionDetector(
        focusNode: _focusNode,
        enabled: finalEnabled,
        shortcuts: const <ShortcutActivator, Intent>{
          SingleActivator(LogicalKeyboardKey.arrowLeft):
              DirectionalFocusIntent(TraversalDirection.left),
          SingleActivator(LogicalKeyboardKey.arrowRight):
              DirectionalFocusIntent(TraversalDirection.right),
        },
        actions: <Type, Action<Intent>>{
          DirectionalFocusIntent: CallbackAction<DirectionalFocusIntent>(
            onInvoke: (intent) {
              final left = intent.direction == TraversalDirection.left;
              _handleArrowKey(!left);
              return null;
            },
          ),
        },
        child: LayoutBuilder(
          builder: (context, constraints) {
            final itemCount = widget.destinations.length;
            final gapWidth = hasCenterFab
                ? (tokens.centerFabSize + 2 * tokens.notchMargin)
                : 0.0;
            final itemWidth = (constraints.maxWidth - gapWidth) / itemCount;

            final leftCount = hasCenterFab ? (itemCount ~/ 2) : itemCount;
            final rightCount = itemCount - leftCount;

            final leftItems = List.generate(
              leftCount,
              (i) => _buildDestination(tokens, i, itemWidth, barHeight),
            );
            final rightItems = List.generate(
              rightCount,
              (i) => _buildDestination(
                tokens,
                leftCount + i,
                itemWidth,
                barHeight,
              ),
            );

            return Stack(
              children: [
                _buildIndicator(tokens, itemWidth, barHeight),
                Row(
                  children: [
                    ...leftItems,
                    if (hasCenterFab) SizedBox(width: gapWidth),
                    ...rightItems,
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );

    if (hasCenterFab) {
      final fabRadius = tokens.centerFabSize / 2;
      bar = ClipPath(
        clipper: _NotchClipper(
          fabRadius: fabRadius,
          notchMargin: tokens.notchMargin,
          borderRadius: shapeRadius,
        ),
        child: bar,
      );

      bar = CustomPaint(
        painter: _NotchPainter(
          fabRadius: fabRadius,
          notchMargin: tokens.notchMargin,
          borderRadius: shapeRadius,
          backgroundColor: tokens.background,
          borderColor: tokens.border,
          borderWidth: borderSide.width,
          shadows: hasShadow ? tokens.shadow : null,
          shape: widget.shape,
        ),
        child: bar,
      );
    }

    if (shapeRadius > 0 && !hasCenterFab) {
      bar = ClipRRect(
        borderRadius: BorderRadius.circular(shapeRadius),
        child: bar,
      );
    }

    if (hasCenterFab) {
      final fabSize = tokens.centerFabSize;
      bar = Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          bar,
          Transform.translate(
            offset: Offset(0, -fabSize / 2),
            child: _buildCenterFab(tokens),
          ),
        ],
      );
    }

    if (margin != EdgeInsets.zero) {
      bar = Padding(padding: margin, child: bar);
    }

    return Semantics(
      label: widget.semanticLabel ?? 'Navigation',
      container: true,
      child: bar,
    );
  }
}
