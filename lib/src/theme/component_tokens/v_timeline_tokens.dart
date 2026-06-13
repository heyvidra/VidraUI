import 'package:flutter/widgets.dart';

import '../../foundation/semantic_tokens.dart';
import 'component_token_utils.dart';

/// Component-level tokens for timeline indicators.
@immutable
class VTimeLineTokens {
  factory VTimeLineTokens.fromColors(VColors colors) {
    return VTimeLineTokens(
      pendingLineColor: colors.border,
      activeLineColor: colors.actionPrimary,
      completedLineColor: colors.success,
      errorLineColor: colors.danger,
      pendingNodeColor: colors.surface,
      activeNodeColor: colors.actionPrimary,
      completedNodeColor: colors.success,
      errorNodeColor: colors.danger,
      pendingNodeFg: colors.border,
      activeNodeFg: colors.actionPrimaryText,
      completedNodeFg: colors.actionPrimaryText,
      errorNodeFg: colors.actionPrimaryText,
      nodeSize: 12.0,
      lineWidth: 2.0,
    );
  }

  const VTimeLineTokens({
    required this.pendingLineColor,
    required this.activeLineColor,
    required this.completedLineColor,
    required this.errorLineColor,
    required this.pendingNodeColor,
    required this.activeNodeColor,
    required this.completedNodeColor,
    required this.errorNodeColor,
    required this.pendingNodeFg,
    required this.activeNodeFg,
    required this.completedNodeFg,
    required this.errorNodeFg,
    required this.nodeSize,
    required this.lineWidth,
  });

  final Color pendingLineColor;
  final Color activeLineColor;
  final Color completedLineColor;
  final Color errorLineColor;
  final Color pendingNodeColor;
  final Color activeNodeColor;
  final Color completedNodeColor;
  final Color errorNodeColor;
  final Color pendingNodeFg;
  final Color activeNodeFg;
  final Color completedNodeFg;
  final Color errorNodeFg;
  final double nodeSize;
  final double lineWidth;

  static VTimeLineTokens lerp(VTimeLineTokens a, VTimeLineTokens b, double t) {
    return VTimeLineTokens(
      pendingLineColor: lerpComponentTokenColor(a.pendingLineColor, b.pendingLineColor, t),
      activeLineColor: lerpComponentTokenColor(a.activeLineColor, b.activeLineColor, t),
      completedLineColor: lerpComponentTokenColor(a.completedLineColor, b.completedLineColor, t),
      errorLineColor: lerpComponentTokenColor(a.errorLineColor, b.errorLineColor, t),
      pendingNodeColor: lerpComponentTokenColor(a.pendingNodeColor, b.pendingNodeColor, t),
      activeNodeColor: lerpComponentTokenColor(a.activeNodeColor, b.activeNodeColor, t),
      completedNodeColor: lerpComponentTokenColor(a.completedNodeColor, b.completedNodeColor, t),
      errorNodeColor: lerpComponentTokenColor(a.errorNodeColor, b.errorNodeColor, t),
      pendingNodeFg: lerpComponentTokenColor(a.pendingNodeFg, b.pendingNodeFg, t),
      activeNodeFg: lerpComponentTokenColor(a.activeNodeFg, b.activeNodeFg, t),
      completedNodeFg: lerpComponentTokenColor(a.completedNodeFg, b.completedNodeFg, t),
      errorNodeFg: lerpComponentTokenColor(a.errorNodeFg, b.errorNodeFg, t),
      nodeSize: lerpComponentTokenDouble(a.nodeSize, b.nodeSize, t),
      lineWidth: lerpComponentTokenDouble(a.lineWidth, b.lineWidth, t),
    );
  }

  VTimeLineTokens copyWith({
    Color? pendingLineColor,
    Color? activeLineColor,
    Color? completedLineColor,
    Color? errorLineColor,
    Color? pendingNodeColor,
    Color? activeNodeColor,
    Color? completedNodeColor,
    Color? errorNodeColor,
    Color? pendingNodeFg,
    Color? activeNodeFg,
    Color? completedNodeFg,
    Color? errorNodeFg,
    double? nodeSize,
    double? lineWidth,
  }) {
    return VTimeLineTokens(
      pendingLineColor: pendingLineColor ?? this.pendingLineColor,
      activeLineColor: activeLineColor ?? this.activeLineColor,
      completedLineColor: completedLineColor ?? this.completedLineColor,
      errorLineColor: errorLineColor ?? this.errorLineColor,
      pendingNodeColor: pendingNodeColor ?? this.pendingNodeColor,
      activeNodeColor: activeNodeColor ?? this.activeNodeColor,
      completedNodeColor: completedNodeColor ?? this.completedNodeColor,
      errorNodeColor: errorNodeColor ?? this.errorNodeColor,
      pendingNodeFg: pendingNodeFg ?? this.pendingNodeFg,
      activeNodeFg: activeNodeFg ?? this.activeNodeFg,
      completedNodeFg: completedNodeFg ?? this.completedNodeFg,
      errorNodeFg: errorNodeFg ?? this.errorNodeFg,
      nodeSize: nodeSize ?? this.nodeSize,
      lineWidth: lineWidth ?? this.lineWidth,
    );
  }
}
