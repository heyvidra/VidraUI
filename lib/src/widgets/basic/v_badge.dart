import 'package:flutter/widgets.dart';

import '../../theme/v_theme.dart';
import 'v_text.dart';

/// A notification badge positioned on top of a child widget.
class VBadge extends StatelessWidget {
  const VBadge({
    super.key,
    required this.child,
    this.count,
    this.showDot = false,
    this.backgroundColor,
    this.foregroundColor,
  });

  final Widget child;
  final int? count;
  final bool showDot;
  final Color? backgroundColor;
  final Color? foregroundColor;

  String get _label {
    if (showDot) return '';
    if (count == null) return '';
    return count! > 99 ? '99+' : count.toString();
  }

  double get _size {
    if (showDot) return 8;
    if (_label.length <= 1) return 18;
    return 24;
  }

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);
    final bg = backgroundColor ?? theme.colors.danger;
    final fg = foregroundColor ?? theme.colors.actionPrimaryText;

    return Semantics(
        label: count != null ? '$count notifications' : 'New notification',
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            child,
            Positioned(
              right: -4,
              top: -4,
              child: Container(
                width: _size,
                height: _size,
                decoration: BoxDecoration(
                  color: bg,
                  shape: BoxShape.circle,
                  border: Border.all(color: theme.colors.surface, width: 2),
                ),
                child: _label.isNotEmpty
                    ? Center(
                        child: VText(
                          _label,
                          variant: VTextVariant.caption,
                          color: fg,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                      )
                    : null,
              ),
            ),
          ],
        ));
  }
}
