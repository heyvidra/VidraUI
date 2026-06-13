import 'package:flutter/widgets.dart';

/// A Row or Column with a tokenized gap.
///
/// Wraps Flutter's [Row] and [Column] so that gap values come from
/// [VSpacing] tokens rather than hard-coded [SizedBox] widgets.
///
/// Use [VFlex.horizontal] for a row, [VFlex.vertical] for a column.
class VFlex extends StatelessWidget {
  const VFlex({
    super.key,
    required this.children,
    required this.direction,
    this.gap = 0,
    this.padding,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisSize = MainAxisSize.max,
  });

  factory VFlex.horizontal({
    Key? key,
    required List<Widget> children,
    double gap = 0,
    EdgeInsetsGeometry? padding,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    MainAxisSize mainAxisSize = MainAxisSize.max,
  }) {
    return VFlex(
      key: key,
      direction: Axis.horizontal,
      gap: gap,
      padding: padding,
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      children: children,
    );
  }

  factory VFlex.vertical({
    Key? key,
    required List<Widget> children,
    double gap = 0,
    EdgeInsetsGeometry? padding,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    MainAxisSize mainAxisSize = MainAxisSize.max,
  }) {
    return VFlex(
      key: key,
      direction: Axis.vertical,
      gap: gap,
      padding: padding,
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      children: children,
    );
  }

  final List<Widget> children;
  final Axis direction;
  final double gap;
  final EdgeInsetsGeometry? padding;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisSize mainAxisSize;

  @override
  Widget build(BuildContext context) {
    Widget flex = Flex(
      direction: direction,
      spacing: gap,
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      children: children,
    );

    if (padding != null) {
      flex = Padding(padding: padding!, child: flex);
    }

    return flex;
  }
}
