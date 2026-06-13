// Not exported from widgets.dart — internal to scrollable list/grid.

import 'package:flutter/widgets.dart';

import '../../theme/v_theme.dart';
import '../basic/v_text.dart';
import '../feedback/v_progress.dart';

/// Shared loading-more indicator used by both [VScrollableList] and
/// [VScrollableGrid].
class DefaultLoadMoreIndicator extends StatelessWidget {
  const DefaultLoadMoreIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);
    return Padding(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const VSpinner(size: 16),
            SizedBox(width: theme.spacing.sm),
            const VText('Loading more', variant: VTextVariant.caption),
          ],
        ),
      ),
    );
  }
}

/// Simple same-instance cache for item builders.
class CachedWidget {
  const CachedWidget({
    required this.child,
    required this.result,
  });

  final Widget child;
  final Widget result;
}
