import 'package:flutter/widgets.dart';

import '../../theme/theme.dart';

// ---------------------------------------------------------------------------
// Enums
// ---------------------------------------------------------------------------

/// Visual status for a timeline node.
enum VTimeLineStatus { pending, active, completed, error }

// ---------------------------------------------------------------------------
// VTimeLineItem
// ---------------------------------------------------------------------------

/// A single entry in a [VTimeLine].
class VTimeLineItem {
  const VTimeLineItem({
    this.title,
    this.subtitle,
    this.description,
    this.status = VTimeLineStatus.pending,
    this.leading,
    this.onTap,
  });

  final Widget? title;
  final Widget? subtitle;
  final Widget? description;
  final VTimeLineStatus status;
  final Widget? leading;
  final VoidCallback? onTap;
}

// ---------------------------------------------------------------------------
// VTimeLine
// ---------------------------------------------------------------------------

/// A vertical timeline showing a sequence of events.
///
/// ```dart
/// VTimeLine(
///   items: [
///     VTimeLineItem(title: Text('Step 1'), status: VTimeLineStatus.completed),
///     VTimeLineItem(title: Text('Step 2'), status: VTimeLineStatus.active),
///     VTimeLineItem(title: Text('Step 3')),
///   ],
/// )
/// ```
class VTimeLine extends StatelessWidget {
  const VTimeLine({
    super.key,
    required this.items,
    this.spacing = 24,
  });

  final List<VTimeLineItem> items;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(items.length, (i) {
        return _TimeLineRow(
          item: items[i],
          isLast: i == items.length - 1,
          spacing: spacing,
        );
      }),
    );
  }
}

// ---------------------------------------------------------------------------
// Internal row
// ---------------------------------------------------------------------------

class _TimeLineRow extends StatelessWidget {
  const _TimeLineRow({
    required this.item,
    required this.isLast,
    required this.spacing,
  });

  final VTimeLineItem item;
  final bool isLast;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);
    final tokens = VTimeLineTheme.of(context) ?? theme.components.timeline;

    final Color lineColor;
    final Color nodeColor;
    final Color? nodeFg;

    switch (item.status) {
      case VTimeLineStatus.pending:
        lineColor = tokens.pendingLineColor;
        nodeColor = tokens.pendingNodeColor;
        nodeFg = tokens.pendingNodeFg;
      case VTimeLineStatus.active:
        lineColor = tokens.activeLineColor;
        nodeColor = tokens.activeNodeColor;
        nodeFg = null;
      case VTimeLineStatus.completed:
        lineColor = tokens.completedLineColor;
        nodeColor = tokens.completedNodeColor;
        nodeFg = null;
      case VTimeLineStatus.error:
        lineColor = tokens.errorLineColor;
        nodeColor = tokens.errorNodeColor;
        nodeFg = null;
    }

    final content = item.onTap != null
        ? GestureDetector(
            onTap: item.onTap,
            child: _buildContent(context),
          )
        : _buildContent(context);

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Node + line column
          SizedBox(
            width: tokens.nodeSize + 8,
            child: Column(
              children: [
                // Node
                Container(
                  width: tokens.nodeSize,
                  height: tokens.nodeSize,
                  margin: const EdgeInsets.only(top: 4),
                  decoration: BoxDecoration(
                    color: nodeColor,
                    shape: BoxShape.circle,
                    border: nodeFg != null
                        ? Border.all(color: nodeFg, width: 2)
                        : null,
                  ),
                  child: item.leading ??
                      _nodeIcon(context, theme, item.status, nodeColor, tokens),
                ),
                // Line
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: tokens.lineWidth,
                      margin: const EdgeInsets.only(top: 6, bottom: 6),
                      color: lineColor,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // Content
          Expanded(child: content),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : spacing),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (item.title != null) item.title!,
          if (item.subtitle != null) ...[
            const SizedBox(height: 2),
            item.subtitle!,
          ],
          if (item.description != null) ...[
            const SizedBox(height: 4),
            item.description!,
          ],
        ],
      ),
    );
  }

  static Widget? _nodeIcon(
      BuildContext context,
      VThemeData theme,
      VTimeLineStatus status,
      Color color,
      VTimeLineTokens tokens,
  ) {
    if (status == VTimeLineStatus.completed) {
      return Center(
        child: Text('✓',
            style: theme.typography.label.copyWith(
                color: tokens.completedNodeFg,
                fontSize: tokens.nodeSize * 0.65,
                fontWeight: theme.typography.heading.fontWeight,
                height: 1.0)),
      );
    }
    if (status == VTimeLineStatus.error) {
      return Center(
        child: Text('✕',
            style: theme.typography.label.copyWith(
                color: tokens.errorNodeFg,
                fontSize: tokens.nodeSize * 0.65,
                fontWeight: theme.typography.heading.fontWeight,
                height: 1.0)),
      );
    }
    return null;
  }
}
