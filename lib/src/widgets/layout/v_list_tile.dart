import 'package:flutter/widgets.dart';

import '../../theme/v_appearance_box.dart';
import '../../theme/v_appearance_scope.dart';
import '../../theme/v_theme.dart';
import '../basic/v_divider.dart';
import '../basic/v_text.dart';
import '../interaction/v_interactive.dart';

/// A single row in a list.
///
/// Provide either [title] (a plain string) or [titleWidget] (a custom widget)
/// to display the primary content. If both are provided, [titleWidget] takes
/// precedence.
class VListTile extends StatelessWidget {
  const VListTile({
    super.key,
    this.leading,
    this.title,
    this.titleWidget,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.enabled = true,
    this.dense = false,
    this.selected = false,
    this.showDivider = false,
  }) : assert(
          title != null || titleWidget != null,
          'Either title or titleWidget must be provided.',
        );

  final Widget? leading;

  /// Plain-text title. Ignored when [titleWidget] is provided.
  final String? title;

  /// Custom widget displayed in the title slot.
  /// Takes precedence over [title].
  final Widget? titleWidget;

  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool enabled;
  final bool dense;
  final bool selected;

  /// When true, a [VDivider] is rendered below the tile.
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);
    final appearance = VAppearanceScope.of(context);
    final interactive = onTap != null && enabled;

    final effectiveLabel = title ?? '';

    final tile = Semantics(
      button: onTap != null,
      enabled: enabled,
      label: effectiveLabel,
      child: VInteractive(
        enabled: interactive,
        onTap: enabled ? onTap : null,
        requestFocusOnTap: false,
        builder: (context, states) {
          var s = states;
          if (selected) s = {...s, WidgetState.selected};
          if (!enabled) s = {...s, WidgetState.disabled};

          // Resolve background color based on interaction state
          final Color baseBg;
          if (selected || s.contains(WidgetState.selected)) {
            baseBg = theme.colors.surfaceHover;
          } else if (s.contains(WidgetState.hovered) ||
              s.contains(WidgetState.pressed)) {
            baseBg = theme.colors.surfaceHover;
          } else {
            baseBg = theme.colors.surface;
          }

          final resolvedBg = appearance?.background(baseBg, s) ?? baseBg;
          final showBackground = selected ||
              s.contains(WidgetState.selected) ||
              s.contains(WidgetState.hovered) ||
              s.contains(WidgetState.pressed);

          // Build the title content
          final Widget titleContent = titleWidget ??
              VText(
                title!,
                variant: VTextVariant.body,
                color: enabled ? theme.colors.text : theme.colors.textDisabled,
              );

          return VVisualBox(
            appearance: appearance,
            states: s,
            background: resolvedBg,
            borderRadius: BorderRadius.zero,
            child: AnimatedContainer(
              duration: theme.motion.control.duration,
              curve: theme.motion.control.curve,
              decoration: BoxDecoration(
                color: showBackground
                    ? resolvedBg
                    : resolvedBg.withValues(alpha: 0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: theme.spacing.lg,
                  vertical: dense ? theme.spacing.sm : theme.spacing.md,
                ),
                child: Row(
                  children: [
                    if (leading != null) ...[
                      leading!,
                      SizedBox(width: theme.spacing.md),
                    ],
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          titleContent,
                          if (subtitle != null)
                            VText(
                              subtitle!,
                              variant: VTextVariant.caption,
                              color: theme.colors.textMuted,
                            ),
                        ],
                      ),
                    ),
                    if (trailing != null) ...[
                      SizedBox(width: theme.spacing.sm),
                      IntrinsicWidth(child: trailing!),
                    ],
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );

    if (!showDivider) return tile;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        tile,
        VDivider(indent: theme.spacing.lg, endIndent: theme.spacing.lg),
      ],
    );
  }
}
