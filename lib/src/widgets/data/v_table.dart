import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../theme/component_tokens.dart';
import '../../theme/v_component_themes.g.dart';
import '../../theme/v_theme.dart';
import '../basic/v_text.dart';
import '../interaction/v_interactive.dart';

/// A column definition for [VTable].
class VTableColumn {
  const VTableColumn({
    required this.header,
    this.width,
    this.alignment = Alignment.centerLeft,
  });

  final String header;
  final double? width;
  final Alignment alignment;
}

/// A simple data table with sortable columns.
///
/// [columns] define the headers. [rows] is a list of rows, each a list of
/// cell strings matching the column count.
class VTable extends StatefulWidget {
  const VTable({
    super.key,
    required this.columns,
    required this.rows,
    this.sortColumnIndex,
    this.sortAscending = true,
    this.rowHeight = 44,
    this.maxBodyHeight = 360,
  });

  final List<VTableColumn> columns;
  final List<List<String>> rows;
  final int? sortColumnIndex;
  final bool sortAscending;
  final double rowHeight;
  final double maxBodyHeight;

  @override
  State<VTable> createState() => _VTableState();
}

class _VTableState extends State<VTable> {
  late List<List<String>> _rows;
  int? _sortIndex;
  bool _asc = true;

  @override
  void initState() {
    super.initState();
    _sortIndex = widget.sortColumnIndex;
    _asc = widget.sortAscending;
    _syncRows();
  }

  @override
  void didUpdateWidget(VTable oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.rows != oldWidget.rows ||
        widget.sortColumnIndex != oldWidget.sortColumnIndex ||
        widget.sortAscending != oldWidget.sortAscending) {
      _sortIndex = widget.sortColumnIndex;
      _asc = widget.sortAscending;
      _syncRows();
    }
  }

  void _syncRows() {
    _rows = widget.rows.map((row) => List<String>.from(row)).toList();
    _sortRows();
  }

  void _sortRows() {
    if (_sortIndex == null) return;
    final sortIndex = _sortIndex!;
    _rows.sort((a, b) {
      if (sortIndex >= a.length || sortIndex >= b.length) return 0;
      final cmp = a[sortIndex].compareTo(b[sortIndex]);
      return _asc ? cmp : -cmp;
    });
  }

  void _toggleSort(int i) {
    setState(() {
      if (_sortIndex == i) {
        _asc = !_asc;
      } else {
        _sortIndex = i;
        _asc = true;
      }
      _sortRows();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);
    final tokens = VTableTheme.of(context) ?? theme.components.table;
    final tableWidth = widget.columns.fold<double>(
      0,
      (total, column) => total + (column.width ?? 120),
    );
    final bodyHeight = (_rows.length * widget.rowHeight)
        .clamp(0.0, widget.maxBodyHeight)
        .toDouble();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row
          Container(
            width: tableWidth,
            decoration: BoxDecoration(
              color: tokens.headerBackground,
              border: Border(
                bottom: BorderSide(
                  color: tokens.borderColor,
                  width: tokens.headerDividerWidth,
                ),
              ),
            ),
            child: Row(
              children: List.generate(widget.columns.length, (i) {
                final col = widget.columns[i];
                final isSorted = _sortIndex == i;
                return _VTableHeaderCell(
                  column: col,
                  tokens: tokens,
                  isSorted: isSorted,
                  ascending: _asc,
                  onSort: () => _toggleSort(i),
                );
              }),
            ),
          ),
          // Data rows
          if (_rows.isEmpty)
            Semantics(
              label: 'No data',
              child: ExcludeSemantics(
                child: Container(
                  width: tableWidth,
                  padding: EdgeInsets.symmetric(
                    horizontal: tokens.emptyPaddingHorizontal,
                    vertical: tokens.emptyPaddingVertical,
                  ),
                  decoration: BoxDecoration(
                    color: tokens.rowBackground,
                    border: Border(
                      bottom: BorderSide(
                        color: tokens.dividerColor,
                        width: tokens.rowDividerWidth,
                      ),
                    ),
                  ),
                  child: VText(
                    'No data',
                    variant: VTextVariant.body,
                    color: tokens.emptyForeground,
                    style: TextStyle(fontSize: tokens.emptyTextSize),
                  ),
                ),
              ),
            )
          else
            SizedBox(
              width: tableWidth,
              height: bodyHeight,
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemExtent: widget.rowHeight,
                itemCount: _rows.length,
                itemBuilder: (context, rowIndex) {
                  final row = _rows[rowIndex];
                  return Container(
                    decoration: BoxDecoration(
                      color: rowIndex.isOdd
                          ? tokens.alternateRowBackground
                          : tokens.rowBackground,
                      border: Border(
                        bottom: BorderSide(
                          color: tokens.dividerColor,
                          width: tokens.rowDividerWidth,
                        ),
                      ),
                    ),
                    child: Row(
                      children: List.generate(widget.columns.length, (i) {
                        final col = widget.columns[i];
                        final cell = i < row.length ? row[i] : '';
                        return Container(
                          width: col.width ?? 120,
                          alignment: col.alignment,
                          padding: EdgeInsets.symmetric(
                            horizontal: tokens.cellPaddingHorizontal,
                            vertical: tokens.cellPaddingVertical,
                          ),
                          child: VText(
                            cell,
                            variant: VTextVariant.body,
                            color: tokens.bodyForeground,
                          ),
                        );
                      }),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

class _VTableHeaderCell extends StatelessWidget {
  const _VTableHeaderCell({
    required this.column,
    required this.tokens,
    required this.isSorted,
    required this.ascending,
    required this.onSort,
  });

  final VTableColumn column;
  final VTableTokens tokens;
  final bool isSorted;
  final bool ascending;
  final VoidCallback onSort;

  @override
  Widget build(BuildContext context) {
    final tokens = this.tokens;

    return Actions(
      actions: <Type, Action<Intent>>{
        ActivateIntent: CallbackAction<ActivateIntent>(
          onInvoke: (ActivateIntent intent) {
            onSort();
            return null;
          },
        ),
      },
      child: Shortcuts(
        shortcuts: const <ShortcutActivator, Intent>{
          SingleActivator(LogicalKeyboardKey.enter): ActivateIntent(),
          SingleActivator(LogicalKeyboardKey.space): ActivateIntent(),
        },
        child: VInteractive(
          enabled: true,
          onTap: onSort,
          builder: (context, states) {
            final isHovered = states.contains(WidgetState.hovered);
            final isFocused = states.contains(WidgetState.focused);
            final background = isHovered
                ? tokens.headerHoverBackground
                : tokens.headerBackground;

            return Semantics(
              button: true,
              label: _headerSemanticsLabel(
                column.header,
                isSorted,
                ascending,
              ),
              hint: _headerSemanticsHint(isSorted, ascending),
              onTap: onSort,
              child: Container(
                width: column.width ?? 120,
                decoration: BoxDecoration(
                  color: background,
                  border: isFocused
                      ? Border.all(
                          color: tokens.headerFocusOutlineColor,
                          width: tokens.headerFocusOutlineWidth,
                        )
                      : null,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: tokens.headerPaddingHorizontal,
                  vertical: tokens.headerPaddingVertical,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: ExcludeSemantics(
                        child: VText(
                          column.header,
                          variant: VTextVariant.label,
                          color: tokens.headerForeground,
                        ),
                      ),
                    ),
                    if (isSorted) ...[
                      SizedBox(width: tokens.sortIndicatorSpacing),
                      ExcludeSemantics(
                        child: Text(
                          ascending ? '▲' : '▼',
                          style: TextStyle(
                            color: tokens.sortIndicatorActiveColor,
                            fontSize: tokens.sortIndicatorSize,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  String _headerSemanticsLabel(
    String header,
    bool isSorted,
    bool ascending,
  ) {
    if (!isSorted) return header;
    return '$header, sorted ${ascending ? 'ascending' : 'descending'}';
  }

  String _headerSemanticsHint(bool isSorted, bool ascending) {
    if (!isSorted) return 'Sort ascending';
    return ascending ? 'Sort descending' : 'Sort ascending';
  }
}
