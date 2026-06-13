part of 'v_auto_suggest_box.dart';

class _SuggestionPanel extends StatelessWidget {
  const _SuggestionPanel({
    required this.suggestions,
    required this.query,
    required this.highlightIndex,
    required this.tokens,
    required this.highlightMatch,
    required this.width,
    required this.maxHeight,
    required this.onSelected,
    required this.onHover,
  });

  final List<VAutoSuggestItem> suggestions;
  final String query;
  final ValueListenable<int> highlightIndex;
  final VAutoSuggestTokens tokens;
  final bool highlightMatch;
  final double? width;
  final double maxHeight;
  final ValueChanged<VAutoSuggestItem> onSelected;
  final ValueChanged<int> onHover;

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);
    final hasHover = VPlatformScope.of(context).hasHoverCapability;

    var totalHeight = 0.0;
    for (final item in suggestions) {
      totalHeight += item.subtitle != null ? tokens.itemSubtitleHeight : tokens.itemHeight;
    }
    final menuHeight = totalHeight < maxHeight ? totalHeight : maxHeight;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: tokens.panelBackground,
        borderRadius: BorderRadius.circular(tokens.panelRadius),
        border: Border.all(color: tokens.panelBorder),
        boxShadow: [theme.shadows.dropdown],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(tokens.panelRadius),
        child: SizedBox(
          height: menuHeight,
          width: width,
          child: ValueListenableBuilder<int>(
            valueListenable: highlightIndex,
            builder: (context, highlighted, _) {
              return ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: suggestions.length,
                itemBuilder: (context, index) {
                  final item = suggestions[index];
                  final isHighlighted = index == highlighted;
                  return _SuggestionItem(
                    item: item,
                    query: query,
                    tokens: tokens,
                    isHighlighted: isHighlighted,
                    highlightMatch: highlightMatch,
                    hasHover: hasHover,
                    onTap: () => onSelected(item),
                    onHover: () => onHover(index),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class _SuggestionItem extends StatelessWidget {
  const _SuggestionItem({
    required this.item,
    required this.query,
    required this.tokens,
    required this.isHighlighted,
    required this.highlightMatch,
    required this.hasHover,
    required this.onTap,
    required this.onHover,
  });

  final VAutoSuggestItem item;
  final String query;
  final VAutoSuggestTokens tokens;
  final bool isHighlighted;
  final bool highlightMatch;
  final bool hasHover;
  final VoidCallback onTap;
  final VoidCallback onHover;

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);
    final bg = isHighlighted ? tokens.itemHover : null;
    final fg = item.enabled ? tokens.itemText : tokens.itemDisabledText;
    final height = item.subtitle != null ? tokens.itemSubtitleHeight : tokens.itemHeight;

    final titleWidget = highlightMatch && query.isNotEmpty
        ? _HighlightedLabel(
            text: item.label,
            query: query,
            normalStyle: theme.typography.body.copyWith(color: fg),
            highlightStyle: theme.typography.body.copyWith(
              color: tokens.matchHighlight,
              fontWeight: FontWeight.w600,
            ),
          )
        : VText(
            item.label,
            variant: VTextVariant.body,
            color: fg,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          );

    Widget row = SizedBox(
      height: height,
      child: Semantics(
        button: true,
        enabled: item.enabled,
        label: item.label,
        child: DecoratedBox(
          decoration: BoxDecoration(color: bg),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: tokens.itemPaddingHorizontal,
              vertical: tokens.itemPaddingVertical,
            ),
            child: Row(
              children: [
                if (item.leading != null) ...[
                  item.leading!,
                  SizedBox(width: theme.spacing.sm),
                ],
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      titleWidget,
                      if (item.subtitle != null)
                        VText(
                          item.subtitle!,
                          variant: VTextVariant.caption,
                          color: theme.colors.textMuted,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    if (hasHover) {
      row = MouseRegion(
        onEnter: (_) {
          if (item.enabled) onHover();
        },
        cursor: item.enabled
            ? SystemMouseCursors.click
            : SystemMouseCursors.forbidden,
        child: row,
      );
    }

    return GestureDetector(
      onTap: item.enabled ? onTap : null,
      child: row,
    );
  }
}

class _HighlightedLabel extends StatelessWidget {
  const _HighlightedLabel({
    required this.text,
    required this.query,
    required this.normalStyle,
    required this.highlightStyle,
  });

  final String text;
  final String query;
  final TextStyle normalStyle;
  final TextStyle highlightStyle;

  @override
  Widget build(BuildContext context) {
    final lower = text.toLowerCase();
    final q = query.toLowerCase();
    final spans = <TextSpan>[];

    var start = 0;
    var idx = lower.indexOf(q);
    while (idx != -1) {
      if (idx > start) {
        spans.add(TextSpan(
          text: text.substring(start, idx),
          style: normalStyle,
        ));
      }
      spans.add(TextSpan(
        text: text.substring(idx, idx + q.length),
        style: highlightStyle,
      ));
      start = idx + q.length;
      idx = lower.indexOf(q, start);
    }
    if (start < text.length) {
      spans.add(TextSpan(text: text.substring(start), style: normalStyle));
    }

    return Text.rich(
      TextSpan(children: spans),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}


