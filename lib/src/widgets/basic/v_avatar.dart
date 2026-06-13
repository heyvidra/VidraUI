import 'package:flutter/widgets.dart';

import '../../foundation/foundation.dart';
import '../../theme/v_appearance_box.dart';
import '../../theme/v_appearance_scope.dart';
import '../../theme/v_theme.dart';
import 'v_text.dart';

/// A circular avatar showing initials or a fallback icon.
class VAvatar extends StatelessWidget {
  const VAvatar({
    super.key,
    this.name,
    this.size = 40,
    this.avatarSize,
    this.backgroundColor,
    this.foregroundColor,
  });

  final String? name;
  final double size;

  /// Token-based size; when set, overrides [size].
  final VControlSize? avatarSize;

  final Color? backgroundColor;
  final Color? foregroundColor;

  String get _initials {
    if (name == null || name!.isEmpty) return '?';
    final parts = name!.trim().split(RegExp(r'\s+'));
    if (parts.length >= 2) {
      return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
    }
    return parts.first[0].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);
    final bg = backgroundColor ?? theme.colors.actionPrimary;
    final fg = foregroundColor ?? theme.colors.actionPrimaryText;

    final effectiveSize = avatarSize != null
        ? switch (avatarSize!) {
            VControlSize.sm => theme.sizes.avatarSm,
            VControlSize.md => theme.sizes.avatarMd,
            VControlSize.lg => theme.sizes.avatarLg,
          }
        : size;

    final appearance = VAppearanceScope.of(context);
    final resolvedBg = appearance?.background(bg, const {}) ?? bg;

    return Semantics(
        label: name ?? 'Avatar',
        child: VVisualBox(
            appearance: appearance,
            states: const {},
            background: resolvedBg,
            borderRadius: BorderRadius.circular(effectiveSize / 2),
            child: Container(
              width: effectiveSize,
              height: effectiveSize,
              decoration: BoxDecoration(
                color: resolvedBg,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: VText(
                  _initials,
                  variant: VTextVariant.body,
                  color: fg,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: effectiveSize * 0.4,
                    fontWeight: FontWeight.w600,
                    height: 1.0,
                  ),
                ),
              ),
            )));
  }
}
