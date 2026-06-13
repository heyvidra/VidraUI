import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vidraui/vidraui.dart';

Widget _wrap(Widget child) {
  return Directionality(
    textDirection: TextDirection.ltr,
    child: VTheme(
      data: VThemeData.light(),
      child: child,
    ),
  );
}

void main() {
  group('VScrollableGrid', () {
    testWidgets('renders basic fixed grid and lazily builds items', (tester) async {
      final built = <int>{};
      await tester.pumpWidget(_wrap(
        SizedBox(
          height: 300,
          child: VScrollableGrid<int>(
            items: List.generate(100, (i) => i),
            layout: VGridLayout.fixed,
            crossAxisCount: 2,
            childAspectRatio: 1.0,
            itemBuilder: (context, item, index) {
              built.add(index);
              return SizedBox(
                height: 100,
                child: Text('Item $item'),
              );
            },
          ),
        ),
      ));

      expect(find.text('Item 0'), findsOneWidget);
      expect(find.text('Item 1'), findsOneWidget);
      // It shouldn't build all 100 items immediately due to lazy SliverGrid layout
      expect(built.length, lessThan(50));
    });

    testWidgets('renders masonry grid', (tester) async {
      await tester.pumpWidget(_wrap(
        SizedBox(
          height: 300,
          child: VScrollableGrid<int>(
            items: const [1, 2, 3, 4],
            layout: VGridLayout.masonry,
            crossAxisCount: 2,
            itemBuilder: (context, item, index) {
              return SizedBox(
                height: (index.isEven ? 80 : 120).toDouble(),
                child: Text('Masonry $item'),
              );
            },
          ),
        ),
      ));

      expect(find.text('Masonry 1'), findsOneWidget);
      expect(find.text('Masonry 4'), findsOneWidget);
    });

    testWidgets('triggers pull to refresh callback', (tester) async {
      var refreshed = false;
      await tester.pumpWidget(_wrap(
        SizedBox(
          height: 300,
          child: VScrollableGrid<int>(
            items: const [1, 2],
            onRefresh: () async {
              refreshed = true;
            },
            itemBuilder: (context, item, index) {
              return Text('Item $item');
            },
          ),
        ),
      ));

      // Scroll view type VScrollableGrid, let's drag down
      await tester.drag(find.byType(CustomScrollView), const Offset(0, 150));
      await tester.pump();
      await tester.pumpAndSettle();

      expect(refreshed, isTrue);
    });

    testWidgets('triggers load more at threshold', (tester) async {
      final completer = Completer<void>();
      var loadMoreCalled = 0;

      await tester.pumpWidget(_wrap(
        SizedBox(
          height: 200,
          child: VScrollableGrid<int>(
            items: List.generate(20, (i) => i),
            hasMore: true,
            loadMoreThreshold: 100,
            childAspectRatio: 4.0,
            onLoadMore: () {
              loadMoreCalled++;
              return completer.future;
            },
            itemBuilder: (context, item, index) {
              return SizedBox(
                height: 80,
                child: Text('Item $item'),
              );
            },
          ),
        ),
      ));

      // Drag up to scroll towards the bottom
      await tester.drag(find.byType(CustomScrollView), const Offset(0, -1000));
      await tester.pump();
      await tester.drag(find.byType(CustomScrollView), const Offset(0, -1000));
      await tester.pump();
      
      // Should have triggered load more
      expect(loadMoreCalled, 1);
      completer.complete();
      await tester.pumpAndSettle();
    });

    testWidgets('renders empty state when items list is empty', (tester) async {
      await tester.pumpWidget(_wrap(
        SizedBox(
          height: 300,
          child: VScrollableGrid<int>(
            items: const [],
            itemBuilder: (context, item, index) => Text('Item $item'),
          ),
        ),
      ));

      expect(find.text('No items'), findsOneWidget);
    });

    testWidgets('renders error state when items empty and error exists', (tester) async {
      await tester.pumpWidget(_wrap(
        SizedBox(
          height: 300,
          child: VScrollableGrid<int>(
            items: const [],
            error: 'Database connection failed',
            itemBuilder: (context, item, index) => Text('Item $item'),
          ),
        ),
      ));

      expect(find.text('Failed to load data'), findsOneWidget);
      expect(find.text('Database connection failed'), findsOneWidget);
    });

    testWidgets('renders bottom error when items exist and error exists', (tester) async {
      await tester.pumpWidget(_wrap(
        SizedBox(
          height: 300,
          child: VScrollableGrid<int>(
            items: const [1, 2],
            error: 'Failed to load more pages',
            itemBuilder: (context, item, index) => SizedBox(height: 50, child: Text('Item $item')),
          ),
        ),
      ));

      expect(find.text('Item 1'), findsOneWidget);
      expect(find.text('Error loading more: Failed to load more pages'), findsOneWidget);
    });

    testWidgets('renders custom empty and error builders', (tester) async {
      await tester.pumpWidget(_wrap(
        SizedBox(
          height: 300,
          child: VScrollableGrid<int>(
            items: const [],
            emptyBuilder: (context) => const Text('Custom Empty'),
            itemBuilder: (context, item, index) => Text('Item $item'),
          ),
        ),
      ));

      expect(find.text('Custom Empty'), findsOneWidget);

      await tester.pumpWidget(_wrap(
        SizedBox(
          height: 300,
          child: VScrollableGrid<int>(
            items: const [],
            error: 'Sample Error',
            errorBuilder: (context, err) => Text('Custom Error: $err'),
            itemBuilder: (context, item, index) => Text('Item $item'),
          ),
        ),
      ));

      expect(find.text('Custom Error: Sample Error'), findsOneWidget);
    });
  });
}
