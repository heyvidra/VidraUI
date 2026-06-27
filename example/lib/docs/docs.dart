import 'package:flutter/widgets.dart';

/// A public API symbol rendered by the docs/demo site.
class VDocApiSymbol {
  const VDocApiSymbol({
    required this.name,
    required this.kind,
    required this.library,
    required this.members,
  });

  final String name;
  final String kind;
  final String library;
  final List<VDocApiMember> members;
}

/// A public API member rendered by the docs/demo site.
class VDocApiMember {
  const VDocApiMember({
    required this.name,
    required this.kind,
    required this.signature,
  });

  final String name;
  final String kind;
  final String signature;
}

/// A curated docs page entry.
class VDocPageMetadata {
  const VDocPageMetadata({
    required this.slug,
    required this.category,
    required this.title,
    required this.zhTitle,
    required this.summary,
    required this.symbols,
    required this.snippetIds,
    required this.usageNotes,
  });

  final String slug;
  final String category;
  final String title;
  final String zhTitle;
  final String summary;
  final List<String> symbols;
  final List<String> snippetIds;
  final List<String> usageNotes;

  String get navLabel => '$title / $zhTitle';

  bool matches(String query) {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return true;
    return slug.contains(q) ||
        category.toLowerCase().contains(q) ||
        title.toLowerCase().contains(q) ||
        zhTitle.toLowerCase().contains(q) ||
        summary.toLowerCase().contains(q) ||
        symbols.any((symbol) => symbol.toLowerCase().contains(q));
  }
}

/// A source snippet extracted from marked demo code.
class VDocCodeSnippet {
  const VDocCodeSnippet({
    required this.id,
    required this.source,
  });

  final String id;
  final String source;
}

typedef VDocDemoBuilder = Widget Function(BuildContext context);
