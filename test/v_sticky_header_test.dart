import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vidraui/vidraui.dart';

void main() {
  testWidgets('VStickyHeader test - fixed height and scroll pinning', (WidgetTester tester) async {
    final controller = ScrollController();
    
    await tester.pumpWidget(
      VidraApp.navigator(
        home: VScaffold(
          body: CustomScrollView(
            controller: controller,
            slivers: [
              VStickyHeader(
                height: 50,
                pinned: true,
                builder: (context, shrinkOffset, overlapsContent) {
                  return SizedBox(
                    key: const ValueKey('sticky-header'),
                    height: 50,
                    child: Center(
                      child: VText(
                        'Header Offset: ${shrinkOffset.toInt()}, Overlap: $overlapsContent',
                        variant: VTextVariant.body,
                      ),
                    ),
                  );
                },
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return SizedBox(
                      height: 100,
                      child: VText('Item $index'),
                    );
                  },
                  childCount: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );

    // Initial state: offset should be 0, overlap should be false
    expect(find.text('Header Offset: 0, Overlap: false'), findsOneWidget);
    
    // Verify initial positioning at top of screen (y = 0)
    final initialHeaderPosition = tester.getTopLeft(find.byKey(const ValueKey('sticky-header')));
    expect(initialHeaderPosition.dy, 0.0);

    // Scroll down by 150px
    controller.jumpTo(150);
    await tester.pump();

    // Verify pinned header stays exactly at top of screen (y = 0)
    final scrolledHeaderPosition = tester.getTopLeft(find.byKey(const ValueKey('sticky-header')));
    expect(scrolledHeaderPosition.dy, 0.0);

    // shrinkOffset is clamped to maxExtent (50) in standard SliverPersistentHeader.
    expect(find.text('Header Offset: 50, Overlap: false'), findsOneWidget);
  });

  testWidgets('VStickyHeader test - unpinned header scrolls off screen', (WidgetTester tester) async {
    final controller = ScrollController();
    
    await tester.pumpWidget(
      VidraApp.navigator(
        home: VScaffold(
          body: CustomScrollView(
            controller: controller,
            slivers: [
              VStickyHeader(
                height: 50,
                pinned: false, // Not pinned
                builder: (context, shrinkOffset, overlapsContent) {
                  return const SizedBox(
                    key: ValueKey('sticky-header-unpinned'),
                    height: 50,
                    child: VText('Unpinned Header'),
                  );
                },
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return const SizedBox(
                      height: 100,
                      child: VText('Item'),
                    );
                  },
                  childCount: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );

    expect(find.text('Unpinned Header'), findsOneWidget);
    
    // Scroll down by 100px (greater than header height of 50px)
    controller.jumpTo(100);
    await tester.pump();

    // The header should have scrolled off screen completely
    expect(find.text('Unpinned Header'), findsNothing);
  });

  testWidgets('VStickyHeader test - dynamic height and shrinkOffset update', (WidgetTester tester) async {
    final controller = ScrollController();
    
    await tester.pumpWidget(
      VidraApp.navigator(
        home: VScaffold(
          body: CustomScrollView(
            controller: controller,
            slivers: [
              VStickyHeader(
                minHeight: 50,
                maxHeight: 120,
                pinned: true,
                builder: (context, shrinkOffset, overlapsContent) {
                  return SizedBox(
                    key: const ValueKey('dynamic-header'),
                    child: VText('Shrink: ${shrinkOffset.toInt()}'),
                  );
                },
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return const SizedBox(
                      height: 100,
                      child: VText('Item'),
                    );
                  },
                  childCount: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );

    // Initial state: fully expanded, shrinkOffset should be 0
    expect(find.text('Shrink: 0'), findsOneWidget);

    // Scroll down by 40px (halfway between max and min height)
    controller.jumpTo(40);
    await tester.pump();

    // shrinkOffset should match the scroll offset
    expect(find.text('Shrink: 40'), findsOneWidget);

    // Scroll down past the full shrink threshold (e.g. 100px)
    controller.jumpTo(100);
    await tester.pump();

    // shrinkOffset reflects scroll offset directly (100)
    expect(find.text('Shrink: 100'), findsOneWidget);
  });
}
