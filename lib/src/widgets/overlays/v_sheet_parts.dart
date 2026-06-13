part of 'v_sheet.dart';

class _VSheetLayoutScope extends InheritedWidget {
  const _VSheetLayoutScope({
    required this.edge,
    required super.child,
  });

  final VSheetEdge edge;

  static VSheetEdge edgeOf(BuildContext context) {
    return context
            .dependOnInheritedWidgetOfExactType<_VSheetLayoutScope>()
            ?.edge ??
        VSheetEdge.bottom;
  }

  @override
  bool updateShouldNotify(_VSheetLayoutScope oldWidget) =>
      edge != oldWidget.edge;
}

class _VSheetDragHandle extends StatelessWidget {
  const _VSheetDragHandle({required this.edge});

  final VSheetEdge edge;

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);
    final horizontal = edge == VSheetEdge.top || edge == VSheetEdge.bottom;
    final margin = switch (edge) {
      VSheetEdge.top => EdgeInsets.only(bottom: theme.spacing.sm),
      VSheetEdge.right => EdgeInsets.only(left: theme.spacing.sm),
      VSheetEdge.bottom => EdgeInsets.only(top: theme.spacing.sm),
      VSheetEdge.left => EdgeInsets.only(right: theme.spacing.sm),
    };

    return Center(
      child: Container(
        margin: margin,
        width: horizontal ? 32 : 4,
        height: horizontal ? 4 : 32,
        decoration: BoxDecoration(
          color: theme.colors.border,
          borderRadius: BorderRadius.circular(theme.radii.xs),
        ),
      ),
    );
  }
}
