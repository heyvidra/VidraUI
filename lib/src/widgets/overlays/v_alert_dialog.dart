import 'package:flutter/widgets.dart';

import '../../foundation/foundation.dart';
import '../../theme/v_theme.dart';
import '../buttons/v_button.dart';
import 'v_dialog.dart';

/// A convenience dialog with a preset title / body / actions layout.
///
/// Composes [VDialogSurface] internally so it can be returned directly from
/// a [VDialog.show] builder without manually composing the column and spacings.
///
/// When [closable] is true, a close (×) button appears at the trailing edge of
/// the title row, and [onClose] **must** be provided — typically
/// `() => VDialogScope.of<T>(ctx)(null)`.
class VAlertDialog extends StatelessWidget {
  const VAlertDialog({
    super.key,
    this.title,
    this.body,
    this.bodyWidget,
    this.actions,
    this.closable = false,
    this.onClose,
    this.width,
    this.maxHeight,
    this.surfaceBackground,
  }) : assert(body != null || bodyWidget != null,
            'body or bodyWidget must be provided');

  final String? title;

  /// Body text rendered with the theme body text style.
  ///
  /// Takes priority over [bodyWidget].
  final String? body;

  /// Body widget rendered when [body] is null.
  final Widget? bodyWidget;

  final List<Widget>? actions;
  final bool closable;
  final VoidCallback? onClose;

  /// Dialog width. When null, uses the token default.
  final double? width;

  /// Maximum dialog height. If content exceeds this, it scrolls.
  final double? maxHeight;

  /// One-off background override for the dialog surface.
  ///
  /// This only affects the panel surface, not the modal barrier.
  final VBackground? surfaceBackground;

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);

    return VDialogSurface(
      width: width,
      maxHeight: maxHeight,
      surfaceBackground: surfaceBackground,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (title != null)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    title!,
                    style: theme.typography.title.copyWith(
                      color: theme.colors.text,
                    ),
                  ),
                ),
                if (closable)
                  VButton(
                    shape: VButtonShape.none,
                    variant: VButtonVariant.secondary,
                    size: VControlSize.sm,
                    semanticLabel: 'Close',
                    onPressed: onClose,
                    child: Text(
                      '×',
                      style: theme.typography.label.copyWith(
                        color: theme.colors.textMuted,
                      ),
                    ),
                  ),
              ],
            ),
          if (title != null && (body != null || bodyWidget != null))
            SizedBox(height: theme.spacing.md),
          if (body != null)
            Text(
              body!,
              style: theme.typography.body.copyWith(
                color: theme.colors.text,
              ),
            )
          else if (bodyWidget != null)
            bodyWidget!,
          if (actions != null && actions!.isNotEmpty) ...[
            SizedBox(height: theme.spacing.md),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                for (var i = 0; i < actions!.length; i++) ...[
                  if (i > 0) SizedBox(width: theme.spacing.sm),
                  actions![i],
                ],
              ],
            ),
          ],
        ],
      ),
    );
  }
}
