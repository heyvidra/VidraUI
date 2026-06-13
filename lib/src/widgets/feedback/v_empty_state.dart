import 'package:flutter/widgets.dart';

import '../../theme/v_theme.dart';
import '../basic/v_icon.dart';
import '../basic/v_text.dart';

/// A placeholder displayed when a list, collection, or search has no results.
///
/// Hallmark Discipline: Rejects the centered-generic template. Uses an
/// asymmetric “Workbench” layout with left-biased alignment and deliberate
/// negative space. All typography is roman; doc comments use curly quotes.
class VEmptyState extends StatelessWidget {
  const VEmptyState({
    super.key,
    this.icon,
    this.title,
    this.description,
    this.action,
    this.maxWidth = 400,
  });

  /// An optional icon displayed above the title.
  final IconData? icon;

  /// A short heading (e.g. “No items yet”).
  final String? title;

  /// A longer description providing additional context.
  final String? description;

  /// An optional action widget rendered below the description.
  ///
  /// Typically a [VButton]. When provided, it replaces any default empty-state
  /// illustration and gives the user a clear next step.
  final Widget? action;

  /// Maximum width of the content column. Defaults to 400.
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);

    return Align(
      alignment: Alignment.center,
      child: Container(
        constraints: BoxConstraints(maxWidth: maxWidth),
        padding: EdgeInsets.symmetric(
          horizontal: theme.spacing.xl,
          vertical: theme.spacing.x2l,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (icon != null) ...[
              VIcon(
                icon!,
                size: 32,
                color: theme.colors.textDisabled,
              ),
              SizedBox(height: theme.spacing.md),
            ],
            if (title != null)
              VText(
                title!,
                variant: VTextVariant.title,
              ),
            if (description != null) ...[
              SizedBox(height: theme.spacing.sm),
              VText(
                description!,
                variant: VTextVariant.body,
                color: theme.colors.textMuted,
              ),
            ],
            if (action != null) ...[
              SizedBox(height: theme.spacing.lg),
              action!,
            ],
          ],
        ),
      ),
    );
  }
}
