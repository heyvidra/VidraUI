import 'dart:math' as math;

import 'package:flutter/widgets.dart';

import '../../foundation/foundation.dart';
import '../../theme/v_theme.dart';
import '../basic/v_flex.dart';
import '../basic/v_text.dart';
import '../buttons/v_button.dart';

/// A single item in the pagination model.
///
/// Use pattern matching to handle each case:
/// ```dart
/// switch (item) {
///   VPageNumber(:final page, :final isCurrent) => ...,
///   VPageEllipsis() => ...,
/// }
/// ```
sealed class VPageItem {
  const VPageItem();
}

/// A clickable page number.
class VPageNumber extends VPageItem {
  const VPageNumber({required this.page, required this.isCurrent});
  final int page;
  final bool isCurrent;
}

/// An ellipsis placeholder between non-consecutive page ranges.
class VPageEllipsis extends VPageItem {
  const VPageEllipsis();
}

// ---------------------------------------------------------------------------
// Algorithm
// ---------------------------------------------------------------------------

/// Generates the page-item list for a pagination control.
///
/// Uses the standard **boundaryCount + siblingCount** sliding-window
/// algorithm (MUI / shadcn / PrimeReact consensus):
///
/// - [boundaryCount] pages are always visible at the start and end.
/// - [siblingCount] pages are visible on each side of [currentPage].
/// - [totalPages] determines how many slots are available — when
///   `totalPages ≤ totalSlots` every page is shown without ellipsis.
/// - Otherwise the component renders at most `totalSlots` items (excluding
///   arrows) so the control never shifts layout across navigation.
List<VPageItem> buildPageItems({
  required int totalPages,
  required int currentPage,
  int boundaryCount = 1,
  int siblingCount = 1,
}) {
  if (totalPages <= 0) return [];
  final totalSlots = boundaryCount * 2 + siblingCount * 2 + 3;
  if (totalPages <= totalSlots) {
    return List.generate(
      totalPages,
      (i) => VPageNumber(page: i + 1, isCurrent: i + 1 == currentPage),
    );
  }

  final items = <VPageItem>[];

  // MUI-style sliding-window:
  // 1. Calculate the sibling window clamped to avoid overlapping boundaries.
  // 2. Insert ellipsis where gaps exist; otherwise fill with actual pages.
  final leftSibling = math.max(currentPage - siblingCount, boundaryCount + 1);
  final rightSibling =
      math.min(currentPage + siblingCount, totalPages - boundaryCount);
  final showLeftEllipsis = leftSibling > boundaryCount + 2;
  final showRightEllipsis = rightSibling < totalPages - boundaryCount - 1;

  // Start boundary.
  for (var i = 1; i <= boundaryCount; i++) {
    items.add(VPageNumber(page: i, isCurrent: i == currentPage));
  }

  // Left gap.
  if (showLeftEllipsis) {
    items.add(const VPageEllipsis());
  } else {
    for (var i = boundaryCount + 1; i < leftSibling; i++) {
      items.add(VPageNumber(page: i, isCurrent: i == currentPage));
    }
  }

  // Sibling window (always includes current).
  for (var i = leftSibling; i <= rightSibling; i++) {
    items.add(VPageNumber(page: i, isCurrent: i == currentPage));
  }

  // Right gap.
  if (showRightEllipsis) {
    items.add(const VPageEllipsis());
  } else {
    for (var i = rightSibling + 1; i <= totalPages - boundaryCount; i++) {
      items.add(VPageNumber(page: i, isCurrent: i == currentPage));
    }
  }

  // End boundary.
  for (var i = totalPages - boundaryCount + 1; i <= totalPages; i++) {
    if (i > boundaryCount) {
      items.add(VPageNumber(page: i, isCurrent: i == currentPage));
    }
  }

  return items;
}

// ---------------------------------------------------------------------------
// VPagination
// ---------------------------------------------------------------------------

/// A page-navigation control with automatic ellipsis.
///
/// ```dart
/// VPagination(
///   totalPages: 20,
///   currentPage: 7,
///   onPageChanged: (page) => print('Go to $page'),
/// )
/// ```
class VPagination extends StatelessWidget {
  const VPagination({
    super.key,
    required this.totalPages,
    required this.currentPage,
    required this.onPageChanged,
    this.boundaryCount = 1,
    this.siblingCount = 1,
    this.showArrows = true,
    this.enabled = true,
  });

  /// Total number of pages.
  final int totalPages;

  /// Currently active page (1-based).
  final int currentPage;

  /// Called when the user taps a different page.
  final ValueChanged<int> onPageChanged;

  /// Pages always visible at the start / end.  Default `1`.
  final int boundaryCount;

  /// Pages visible on each side of [currentPage].  Default `1`.
  final int siblingCount;

  /// Whether to show previous / next arrow buttons.  Default `true`.
  final bool showArrows;

  /// Whether the entire control is enabled.
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final items = buildPageItems(
      totalPages: totalPages,
      currentPage: currentPage,
      boundaryCount: boundaryCount,
      siblingCount: siblingCount,
    );

    return VFlex.horizontal(
      gap: 4,
      children: [
        if (showArrows)
          _PageArrow(
            isBack: true,
            enabled: enabled && currentPage > 1,
            onTap: () => onPageChanged(currentPage - 1),
          ),
        for (final item in items) _buildItem(context, item),
        if (showArrows)
          _PageArrow(
            isBack: false,
            enabled: enabled && currentPage < totalPages,
            onTap: () => onPageChanged(currentPage + 1),
          ),
      ],
    );
  }

  Widget _buildItem(BuildContext context, VPageItem item) =>
      switch (item) {
        VPageNumber(:final page, :final isCurrent) => _PageButton(
            page: page,
            isCurrent: isCurrent,
            enabled: enabled,
            onTap: enabled ? () => onPageChanged(page) : null,
          ),
        VPageEllipsis() => const _PageEllipsis(),
      };
}

// ---------------------------------------------------------------------------
// Internal building blocks
// ---------------------------------------------------------------------------

/// Minimum touch target for a page button.
const double _kPageButtonSize = 32;

class _PageButton extends StatelessWidget {
  const _PageButton({
    required this.page,
    required this.isCurrent,
    required this.enabled,
    this.onTap,
  });

  final int page;
  final bool isCurrent;
  final bool enabled;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _kPageButtonSize,
      height: _kPageButtonSize,
      child: VButton(
        shape: VButtonShape.rounded,
        variant: isCurrent ? VButtonVariant.primary : VButtonVariant.secondary,
        size: VControlSize.sm,
        semanticLabel: 'Page $page',
        onPressed: enabled ? onTap : null,
        child: VText(
          page.toString(),
          variant: VTextVariant.label,
        ),
      ),
    );
  }
}

class _PageEllipsis extends StatelessWidget {
  const _PageEllipsis();

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);
    return SizedBox(
      width: _kPageButtonSize,
      height: _kPageButtonSize,
      child: Center(
        child: VText('…', variant: VTextVariant.label, color: theme.colors.textMuted),
      ),
    );
  }
}

class _PageArrow extends StatelessWidget {
  const _PageArrow({
    required this.isBack,
    required this.enabled,
    required this.onTap,
  });

  final bool isBack;
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _kPageButtonSize,
      height: _kPageButtonSize,
      child: VButton(
        shape: VButtonShape.rounded,
        variant: VButtonVariant.secondary,
        size: VControlSize.sm,
        semanticLabel: isBack ? 'Previous page' : 'Next page',
        onPressed: enabled ? onTap : null,
        child: VText(
          isBack ? '‹' : '›',
          variant: VTextVariant.label,
        ),
      ),
    );
  }
}
