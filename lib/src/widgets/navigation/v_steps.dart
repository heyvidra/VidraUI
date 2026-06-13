import 'package:flutter/widgets.dart';

import '../../theme/theme.dart';
import '../basic/v_text.dart';

// ---------------------------------------------------------------------------
// Enums
// ---------------------------------------------------------------------------

/// Step indicator style.
enum VStepsMode { dot, number }

// ---------------------------------------------------------------------------
// VStep
// ---------------------------------------------------------------------------

/// A single entry in a [VSteps] widget.
class VStep {
  const VStep({
    required this.title,
    this.description,
  });

  final Widget title;
  final Widget? description;
}

// ---------------------------------------------------------------------------
// VSteps
// ---------------------------------------------------------------------------

/// A step-by-step progress indicator.
///
/// ```dart
/// VSteps(
///   steps: [
///     VStep(title: Text('Login')),
///     VStep(title: Text('Verify')),
///     VStep(title: Text('Done')),
///   ],
///   current: 1,
/// )
/// ```
class VSteps extends StatelessWidget {
  const VSteps({
    super.key,
    required this.steps,
    required this.current,
    this.mode = VStepsMode.number,
    this.direction = Axis.horizontal,
    this.activeColor,
    this.inactiveColor,
  });

  final List<VStep> steps;
  final int current;
  final VStepsMode mode;
  final Axis direction;
  final Color? activeColor;
  final Color? inactiveColor;

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);
    final tokens = VStepsTheme.of(context) ?? theme.components.steps;
    final active = activeColor ?? tokens.activeColor;
    final inactive = inactiveColor ?? tokens.inactiveColor;

    if (direction == Axis.horizontal) {
      return _buildHorizontal(context, theme, tokens, active, inactive);
    }
    return _buildVertical(context, theme, tokens, active, inactive);
  }

  // ── Horizontal ─────────────────────────────────────────────────

  Widget _buildHorizontal(
      BuildContext context, VThemeData theme, VStepsTokens tokens, Color active, Color inactive) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(steps.length, (i) {
            final status = _status(i);
            final isLast = i == steps.length - 1;
            return Expanded(
              child: Row(
                children: [
                  _buildIndicator(
                      context, i, status, theme, tokens, active, inactive, tokens.surface),
                  if (!isLast)
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: tokens.lineMargin),
                        height: tokens.lineHeight,
                        color: status == VStepStatus.completed
                            ? active
                            : inactive,
                      ),
                    ),
                ],
              ),
            );
          }),
        ),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(steps.length, (i) {
            return Expanded(child: _buildContent(i, _status(i)));
          }),
        ),
      ],
    );
  }

  // ── Vertical ───────────────────────────────────────────────────

  Widget _buildVertical(
      BuildContext context, VThemeData theme, VStepsTokens tokens, Color active, Color inactive) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(steps.length, (i) {
        final status = _status(i);
        final isLast = i == steps.length - 1;
        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Node + line
              SizedBox(
                width: tokens.indicatorSize,
                child: Column(
                  children: [
                    _buildIndicator(
                        context, i, status, theme, tokens, active, inactive, tokens.surface),
                    if (!isLast)
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(
                            top: tokens.lineMargin / 2,
                            bottom: tokens.lineMargin / 2,
                          ),
                          width: tokens.lineHeight,
                          color: status == VStepStatus.completed
                              ? active
                              : inactive,
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              // Content
              Expanded(
                child: Padding(
                  padding:
                      EdgeInsets.only(bottom: isLast ? 0 : theme.spacing.lg),
                  child: _buildContent(i, status),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  // ── Indicator ──────────────────────────────────────────────────

  Widget _buildIndicator(
      BuildContext context,
      int i,
      VStepStatus status,
      VThemeData theme,
      VStepsTokens tokens,
      Color active,
      Color inactive,
      Color surface,
  ) {
    final color = status == VStepStatus.pending ? inactive : active;
    final fg =
        status == VStepStatus.pending ? tokens.inactiveText : tokens.activeText;

    if (mode == VStepsMode.dot) {
      return Container(
        width: tokens.indicatorSize / 3,
        height: tokens.indicatorSize / 3,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      );
    }

    // Number mode
    return Container(
      width: tokens.indicatorSize,
      height: tokens.indicatorSize,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: status == VStepStatus.pending ? surface : color,
        shape: BoxShape.circle,
        border: status == VStepStatus.pending
            ? Border.all(color: inactive, width: 1.5)
            : null,
      ),
      child: status == VStepStatus.completed
          ? Text('✓',
              style: theme.typography.label.copyWith(
                  color: fg,
                  fontSize: tokens.indicatorSize * 0.5,
                  fontWeight: theme.typography.label.fontWeight,
                  height: 1.0))
          : VText('${i + 1}',
              variant: VTextVariant.label,
              color: fg,
              style: TextStyle(
                  fontSize: tokens.indicatorSize * 0.5,
                  fontWeight: theme.typography.body.fontWeight,
                  height: 1.0)),
    );
  }

  // ── Content ────────────────────────────────────────────────────

  Widget _buildContent(int i, VStepStatus status) {
    final step = steps[i];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        step.title,
        if (step.description != null) ...[
          const SizedBox(height: 2),
          step.description!,
        ],
      ],
    );
  }

  VStepStatus _status(int i) {
    if (i < current) return VStepStatus.completed;
    if (i == current) return VStepStatus.active;
    return VStepStatus.pending;
  }
}

enum VStepStatus { completed, active, pending }
