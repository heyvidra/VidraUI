part of 'v_text_selection_menu.dart';

class _VTextSelectionMobileItem extends StatelessWidget {
  const _VTextSelectionMobileItem({
    required this.label,
    required this.enabled,
    required this.onTap,
    required this.height,
  });

  final String label;
  final bool enabled;
  final VoidCallback onTap;
  final double height;

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);

    return VInteractive(
      enabled: enabled,
      onTap: onTap,
      requestFocusOnTap: false,
      builder: (context, states) {
        final isHovered = states.contains(WidgetState.hovered);
        final isPressed = states.contains(WidgetState.pressed);

        return ColoredBox(
          color: isPressed
              ? theme.colors.surfaceHover.withValues(alpha: 0.15)
              : isHovered
                  ? theme.colors.surfaceHover
                  : const Color(0x00000000),
          child: SizedBox(
            height: height,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Center(
                child: Text(
                  label,
                  style: theme.typography.body.copyWith(
                    color:
                        enabled ? theme.colors.text : theme.colors.textDisabled,
                    fontWeight: theme.typography.subtitle.fontWeight,
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

class _VTextSelectionMenuRow extends StatelessWidget {
  const _VTextSelectionMenuRow({
    required this.label,
    this.shortcut,
    required this.enabled,
    required this.onTap,
    required this.height,
  });

  final String label;
  final String? shortcut;
  final bool enabled;
  final VoidCallback onTap;
  final double height;

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);

    return VInteractive(
      enabled: enabled,
      onTap: onTap,
      requestFocusOnTap: false,
      builder: (context, states) {
        final isHovered = states.contains(WidgetState.hovered);

        return ColoredBox(
          color:
              isHovered ? theme.colors.surfaceHover : const Color(0x00000000),
          child: SizedBox(
            height: height,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  Expanded(
                    child: VText(
                      label,
                      variant: VTextVariant.body,
                      color: enabled
                          ? theme.colors.text
                          : theme.colors.textDisabled,
                    ),
                  ),
                  if (shortcut != null) ...[  
                    const SizedBox(width: 24),
                    VText(
                      shortcut!,
                      variant: VTextVariant.caption,
                      color: theme.colors.textMuted,
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
