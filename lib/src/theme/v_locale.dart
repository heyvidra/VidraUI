import 'dart:ui';

/// Built-in locale strings for VidraUI widgets.
///
/// Applies to toast variants, dialog default labels, and other
/// text that the library renders without user input.
class VLocale {
  const VLocale._();

  static const en = VLocaleStrings(
    ok: 'OK',
    cancel: 'Cancel',
    confirm: 'Confirm',
    delete: 'Delete',
    close: 'Close',
    search: 'Search',
    noResults: 'No results',
    loading: 'Loading…',
  );

  static const zh = VLocaleStrings(
    ok: '确定',
    cancel: '取消',
    confirm: '确认',
    delete: '删除',
    close: '关闭',
    search: '搜索',
    noResults: '无结果',
    loading: '加载中…',
  );

  /// Resolves the locale strings for a given [locale].
  static VLocaleStrings of(Locale locale) {
    return switch (locale.languageCode) {
      'zh' => zh,
      _ => en,
    };
  }
}

/// A set of translated strings used by VidraUI widgets.
class VLocaleStrings {
  const VLocaleStrings({
    required this.ok,
    required this.cancel,
    required this.confirm,
    required this.delete,
    required this.close,
    required this.search,
    required this.noResults,
    required this.loading,
  });

  final String ok;
  final String cancel;
  final String confirm;
  final String delete;
  final String close;
  final String search;
  final String noResults;
  final String loading;
}
