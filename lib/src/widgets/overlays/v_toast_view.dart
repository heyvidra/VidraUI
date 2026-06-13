part of 'v_toast.dart';

class _VToastView extends StatefulWidget {
  const _VToastView({
    required this.message,
    required this.variant,
    required this.duration,
    this.icon,
    this.action,
    this.background,
    required this.onDismissed,
  });

  final String message;
  final VToastVariant variant;
  final Duration duration;
  final Widget? icon;
  final VToastActionBuilder? action;
  final VBackground? background;
  final VoidCallback onDismissed;

  @override
  State<_VToastView> createState() => _VToastViewState();
}

class _VToastViewState extends State<_VToastView> {
  // Captured from VOverlayAnimation builder.
  AnimationController? _animationController;

  // Shared CurvedAnimation reused for both opacity and slide.
  // Only recreated when spec or controller changes, never in build.
  CurvedAnimation? _curved;
  VMotionSpec? _curvedSpec;
  AnimationController? _curvedController;

  Timer? _timer;
  bool _dismissing = false;

  @override
  void initState() {
    super.initState();
    _timer = Timer(widget.duration, _dismiss);
  }

  void _dismiss() {
    if (_dismissing) return;
    _dismissing = true;
    _timer?.cancel();
    _animationController?.reverse();
  }

  /// Returns the existing [CurvedAnimation] or creates a new one only when
  /// [controller] or [spec] has changed. Safe to call from build.
  CurvedAnimation _resolveCurved(
    AnimationController controller,
    VMotionSpec spec,
    BuildContext ctx,
  ) {
    if (_curved == null ||
        controller != _curvedController ||
        spec != _curvedSpec) {
      _curvedSpec = spec;
      _curvedController = controller;
      final old = _curved;
      _curved = CurvedAnimation(
        parent: controller,
        curve: VMotionResolver.curve(ctx, spec),
        reverseCurve: VMotionResolver.reverseCurve(ctx, spec),
      );
      old?.dispose();
    }
    return _curved!;
  }

  @override
  void dispose() {
    _timer?.cancel();
    _curved?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);
    final tokens = theme.components.toast;
    final spec = VMotionScope.of(context).overlay;

    final (Color tokenBackground, Color foreground) = switch (widget.variant) {
      VToastVariant.info => (
          tokens.infoBackground,
          tokens.infoForeground,
        ),
      VToastVariant.success => (
          tokens.successBackground,
          tokens.successForeground,
        ),
      VToastVariant.warning => (
          tokens.warningBackground,
          tokens.warningForeground,
        ),
      VToastVariant.error => (
          tokens.errorBackground,
          tokens.errorForeground,
        ),
    };
    final background = widget.background ?? VBackground.color(tokenBackground);
    final resolvedIcon = widget.icon ??
        _VToastIcon(
          variant: widget.variant,
          color: foreground,
          size: tokens.iconSize,
        );
    final action = widget.action?.call(context, _dismiss);

    return VOverlayAnimation(
      motionSpec: spec,
      onReverseComplete: widget.onDismissed,
      builder: (animationContext, controller) {
        _animationController = controller;

        final curved = _resolveCurved(controller, spec, animationContext);

        final slideAnim = Tween<Offset>(
          begin: Offset(0, tokens.slideOffsetY),
          end: Offset.zero,
        ).animate(curved);

        return Semantics(
          liveRegion: true,
          label: widget.message,
          child: FadeTransition(
            opacity: curved,
            child: SlideTransition(
              position: slideAnim,
              child: Dismissible(
                key: UniqueKey(),
                direction: DismissDirection.horizontal,
                onDismissed: (_) {
                  if (!_dismissing) {
                    _dismissing = true;
                    _timer?.cancel();
                    widget.onDismissed();
                  }
                },
                child: _DismissibleToastSurface(
                  onTap: action == null ? _dismiss : null,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: background.gradient == null
                          ? background.color
                          : null,
                      gradient: background.gradient,
                      borderRadius:
                          BorderRadius.circular(tokens.radius),
                      border: tokens.borderWidth > 0
                          ? Border.all(
                              color: tokens.borderColor,
                              width: tokens.borderWidth,
                            )
                          : null,
                      boxShadow: tokens.shadow != null
                          ? [tokens.shadow!]
                          : null,
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: tokens.paddingHorizontal,
                        vertical: tokens.paddingVertical,
                      ),
                      child: Row(
                        children: [
                          resolvedIcon,
                          SizedBox(width: tokens.spacing),
                          Expanded(
                            child: Text(
                              widget.message,
                              style: theme.typography.body.copyWith(
                                color: foreground,
                                fontSize: tokens.textSize,
                              ),
                            ),
                          ),
                          if (action != null) ...[
                            SizedBox(width: tokens.spacing),
                            DefaultTextStyle(
                              style: theme.typography.label.copyWith(
                                color: foreground,
                              ),
                              child: action,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _DismissibleToastSurface extends StatelessWidget {
  const _DismissibleToastSurface({
    required this.child,
    this.onTap,
  });

  final Widget child;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    if (onTap == null) return child;

    return GestureDetector(
      onTap: onTap,
      child: child,
    );
  }
}
