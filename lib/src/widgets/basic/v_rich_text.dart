import 'package:flutter/widgets.dart';

import '../../theme/v_theme.dart';

/// A styled span within [VRichText].
class VTextSpan {
  const VTextSpan(
    this.text, {
    this.bold = false,
    this.color,
    this.size,
    this.underline = false,
    this.italic = false,
  });

  final String text;
  final bool bold;
  final Color? color;
  final double? size;
  final bool underline;
  final bool italic;
}

/// Renders multiple [VTextSpan]s as a single rich text widget.
///
/// Supports bold, color, size, underline, and italic per span.
class VRichText extends StatelessWidget {
  const VRichText({
    super.key,
    required this.spans,
    this.alignment = TextAlign.start,
    this.maxLines,
    this.overflow = TextOverflow.clip,
  });

  final List<VTextSpan> spans;
  final TextAlign alignment;
  final int? maxLines;
  final TextOverflow overflow;

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);
    final baseStyle = theme.typography.body;

    return Text.rich(
      TextSpan(
        children: spans.map((span) {
          return TextSpan(
            text: span.text,
            style: baseStyle.copyWith(
              color: span.color ?? theme.colors.text,
              fontWeight: span.bold ? FontWeight.w700 : baseStyle.fontWeight,
              fontSize: span.size ?? baseStyle.fontSize,
              decoration: span.underline ? TextDecoration.underline : null,
              fontStyle: span.italic ? FontStyle.italic : null,
            ),
          );
        }).toList(),
      ),
      textAlign: alignment,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}

// ---------------------------------------------------------------------------
// Simple markdown-like helper
// ---------------------------------------------------------------------------

/// Parses a simple text with `**bold**`, `*italic*`, and `` `code` `` markers
/// into a list of [VTextSpan]s.
///
/// Does not support nesting.
List<VTextSpan> parseSimpleMarkdown(String text, {Color? codeColor}) {
  final spans = <VTextSpan>[];
  final pattern = RegExp(r'(\*\*(.+?)\*\*|\*(.+?)\*|`(.+?)`)');
  int lastEnd = 0;

  for (final match in pattern.allMatches(text)) {
    if (match.start > lastEnd) {
      spans.add(VTextSpan(text.substring(lastEnd, match.start)));
    }
    if (match.group(2) != null) {
      spans.add(VTextSpan(match.group(2)!, bold: true));
    } else if (match.group(3) != null) {
      spans.add(VTextSpan(match.group(3)!, italic: true));
    } else if (match.group(4) != null) {
      spans.add(VTextSpan(match.group(4)!, color: codeColor));
    }
    lastEnd = match.end;
  }

  if (lastEnd < text.length) {
    spans.add(VTextSpan(text.substring(lastEnd)));
  }

  return spans;
}
