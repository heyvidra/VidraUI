import 'package:flutter_test/flutter_test.dart';
import 'package:vidraui/src/widgets/navigation/v_pagination.dart';

void main() {
  List<String> labels(List<VPageItem> items) => items
      .map((i) => i is VPageNumber
          ? '${i.page}${i.isCurrent ? "*" : ""}'
          : '...')
      .toList();

  test('no ellipsis when total ≤ slots', () {
    final items = buildPageItems(totalPages: 5, currentPage: 3);
    expect(labels(items), ['1', '2', '3*', '4', '5']);
  });

  test('both ellipsis in middle', () {
    final items = buildPageItems(totalPages: 20, currentPage: 7);
    expect(labels(items), ['1', '...', '6', '7*', '8', '...', '20']);
  });

  test('near start — trailing ellipsis only', () {
    final items = buildPageItems(totalPages: 20, currentPage: 2);
    expect(labels(items), ['1', '2*', '3', '...', '20']);
  });

  test('near end — leading ellipsis only', () {
    final items = buildPageItems(totalPages: 20, currentPage: 19);
    expect(labels(items), ['1', '...', '18', '19*', '20']);
  });

  test('first page', () {
    final items = buildPageItems(totalPages: 20, currentPage: 1);
    expect(labels(items), ['1*', '2', '...', '20']);
  });

  test('last page', () {
    final items = buildPageItems(totalPages: 20, currentPage: 20);
    expect(labels(items), ['1', '...', '19', '20*']);
  });

  test('exact slot count — no ellipsis', () {
    final items = buildPageItems(totalPages: 7, currentPage: 4);
    expect(labels(items), ['1', '2', '3', '4*', '5', '6', '7']);
  });

  test('single page', () {
    final items = buildPageItems(totalPages: 1, currentPage: 1);
    expect(labels(items), ['1*']);
  });

  test('boundary=2 sibling=2', () {
    final items = buildPageItems(
      totalPages: 30,
      currentPage: 15,
      boundaryCount: 2,
      siblingCount: 2,
    );
    expect(labels(items), [
      '1', '2', '...', '13', '14', '15*', '16', '17', '...', '29', '30',
    ]);
  });
}
