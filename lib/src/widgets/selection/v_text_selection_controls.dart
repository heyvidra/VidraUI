import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import '../../theme/v_theme.dart';

/// A custom [TextSelectionControls] implementation for VidraUI widgets.
///
/// Draws rounded selection handles using theme tokens, with no Material or
/// Cupertino dependency. Custom toolbars are handled via [contextMenuBuilder].
class VTextSelectionControls extends TextSelectionControls
    with TextSelectionHandleControls {
  VTextSelectionControls();

  @override
  Size getHandleSize(double textLineHeight) => Size(16, textLineHeight);

  @override
  Offset getHandleAnchor(TextSelectionHandleType type, double textLineHeight) {
    return switch (type) {
      TextSelectionHandleType.left => const Offset(8, 0),
      TextSelectionHandleType.right => const Offset(-8, 0),
      TextSelectionHandleType.collapsed => Offset.zero,
    };
  }

  @override
  Widget buildHandle(
    BuildContext context,
    TextSelectionHandleType type,
    double textLineHeight, [
    VoidCallback? onTap,
    double? startGlyphHeight,
    double? endGlyphHeight,
  ]) {
    final theme = VTheme.of(context);
    final size = Size(16, startGlyphHeight ?? textLineHeight);

    return SizedBox.fromSize(
      size: size,
      child: CustomPaint(
        painter: _VTextSelectionHandlePainter(
          color: theme.colors.actionPrimary,
          radius: theme.radii.sm,
        ),
      ),
    );
  }

  @override
  Widget buildToolbar(
    BuildContext context,
    Rect globalEditableRegion,
    double textLineHeight,
    Offset selectionMidpoint,
    List<TextSelectionPoint> endpoints,
    TextSelectionDelegate delegate,
    ValueListenable<ClipboardStatus>? clipboardStatus,
    Offset? lastSecondaryTapDownPosition,
  ) {
    // Toolbar is handled by contextMenuBuilder.
    return const SizedBox.shrink();
  }
}

class _VTextSelectionHandlePainter extends CustomPainter {
  const _VTextSelectionHandlePainter({required this.color, required this.radius});

  final Color color;
  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final r = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 2, size.width, size.height - 4),
      Radius.circular(radius),
    );
    canvas.drawRRect(r, paint);
  }

  @override
  bool shouldRepaint(_VTextSelectionHandlePainter old) =>
      color != old.color || radius != old.radius;
}
