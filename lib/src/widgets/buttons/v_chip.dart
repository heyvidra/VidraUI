import 'package:flutter/widgets.dart';

import '../../foundation/foundation.dart';
import '../../theme/v_appearance_box.dart';
import '../../theme/v_component_themes.g.dart';
import '../../theme/v_icon_theme.dart';
import '../../theme/v_icon_theme_data.dart';
import '../../theme/v_theme.dart';
import '../interaction/v_interactive.dart';
import 'v_button.dart';

enum VChipVariant { filled, soft, outlined }

class VChip extends StatelessWidget {
  const VChip({
    super.key,
    required this.label,
    this.leading,
    this.trailing,
    this.onPressed,
    this.onDeleted,
    this.selected = false,
    this.enabled = true,
    this.variant = VChipVariant.soft,
    this.size = VControlSize.md,
    this.semanticLabel,
    this.autofocus = false,
    this.focusNode,
  });

  final Widget label;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onPressed;
  final VoidCallback? onDeleted;
  final bool selected;

  /// When false, the chip is non-interactive and visually disabled.
  final bool enabled;
  final VChipVariant variant;
  final VControlSize size;
  final String? semanticLabel;
  final bool autofocus;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);
    final tokens = VChipTheme.of(context) ?? theme.components.chip;

    final h = switch (size) {
      VControlSize.sm => tokens.heightSm,
      VControlSize.md => tokens.heightMd,
      VControlSize.lg => tokens.heightLg,
    };
    final px = switch (size) {
      VControlSize.sm => tokens.paddingHorizontalSm,
      VControlSize.md => tokens.paddingHorizontalMd,
      VControlSize.lg => tokens.paddingHorizontalLg,
    };
    final iconSz = switch (size) {
      VControlSize.sm => tokens.iconSizeSm,
      VControlSize.md => tokens.iconSizeMd,
      VControlSize.lg => tokens.iconSizeLg,
    };
    final labelStyle = switch (size) {
      VControlSize.sm => theme.typography.caption,
      VControlSize.md || VControlSize.lg => theme.typography.label,
    };

    final interactive = (onPressed != null || onDeleted != null) && enabled;

    return Semantics(
      button: interactive || selected,
      enabled: enabled,
      label: semanticLabel,
      child: VInteractive(
        enabled: interactive,
        onTap: onPressed != null && enabled ? onPressed : null,
        autofocus: autofocus,
        focusNode: focusNode,
        builder: (context, states) {
          var s = states;
          if (selected) s = {...s, WidgetState.selected};
          if (!enabled) s = {...s, WidgetState.disabled};

          final bg = tokens.background.resolve(s);
          final fg = tokens.foreground.resolve(s);
          final bd = tokens.border.resolve(s);
          final focused = s.contains(WidgetState.focused);

          final effectiveBorder = switch (variant) {
            VChipVariant.outlined => Border.all(color: bd),
            VChipVariant.filled ||
            VChipVariant.soft =>
              (bd != const Color(0x00000000) ? Border.all(color: bd) : null),
          };

          final effectiveBg = switch (variant) {
            VChipVariant.filled => bg,
            VChipVariant.soft => selected ? bg : bg.withValues(alpha: 0.6),
            VChipVariant.outlined =>
              selected ? bg.withValues(alpha: 0.15) : const Color(0x00000000),
          };

          final chipShadows = focused
              ? [
                  BoxShadow(
                    color: tokens.focusRing.withValues(alpha: 0.4),
                    blurRadius: 0,
                    spreadRadius: 2,
                  ),
                ]
              : <BoxShadow>[];

          return AnimatedContainer(
            duration: theme.motion.control.duration,
            curve: theme.motion.control.curve,
            height: h,
            padding: EdgeInsets.symmetric(horizontal: px),
            decoration: BoxDecoration(
              color: effectiveBg,
              borderRadius: BorderRadius.circular(tokens.radius),
              border: effectiveBorder,
              boxShadow: chipShadows,
            ),
            child: VVisualBox(
              appearance: null,
              states: s,
              background: effectiveBg,
              borderRadius: BorderRadius.circular(tokens.radius),
              child: VIconTheme(
                data: VIconThemeData(color: fg, size: iconSz),
                child: DefaultTextStyle(
                  style: labelStyle.copyWith(color: fg),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (leading != null) ...[
                        leading!,
                        SizedBox(width: tokens.gap),
                      ],
                      Flexible(child: label),
                      if (trailing != null) ...[
                        SizedBox(width: tokens.gap),
                        trailing!,
                      ] else if (onDeleted != null && enabled) ...[
                        SizedBox(width: tokens.gap),
                        VButton(
                          key: const Key('v_chip_delete_button'),
                          shape: VButtonShape.none,
                          semanticLabel: 'Remove',
                          onPressed: onDeleted,
                          child: _CloseIcon(size: iconSz, color: fg),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Draws a small × icon using [CustomPaint].
class _CloseIcon extends StatelessWidget {
  const _CloseIcon({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) => CustomPaint(
        size: Size.square(size),
        painter: _CloseIconPainter(color: color),
      );
}

class _CloseIconPainter extends CustomPainter {
  const _CloseIconPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final inset = size.width * 0.25;
    canvas
      ..drawLine(Offset(inset, inset),
          Offset(size.width - inset, size.height - inset), paint)
      ..drawLine(Offset(size.width - inset, inset),
          Offset(inset, size.height - inset), paint);
  }

  @override
  bool shouldRepaint(_CloseIconPainter oldDelegate) =>
      color != oldDelegate.color;
}
