import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vidraui/vidraui.dart';

Widget _wrap(Widget child) {
  return Directionality(
    textDirection: TextDirection.ltr,
    child: VTheme(
      data: VThemeData.light().copyWith(
        motion: const VMotion(reducedMotion: true),
      ),
      child: Overlay(
        initialEntries: [
          OverlayEntry(
            builder: (context) => child,
          ),
        ],
      ),
    ),
  );
}

void main() {
  testWidgets('VContextMenu renders child and opens menu on long press',
      (tester) async {
    bool didTapCopy = false;
    final actions = [
      VContextMenuItem(
        label: 'Copy Action',
        onTap: () => didTapCopy = true,
      ),
      const VContextMenuItem(
        label: 'Delete Action',
        isDestructive: true,
      ),
    ];
    await tester.pumpWidget(_wrap(
      Center(
        child: VContextMenu(
          actions: actions,
          child: const Text('Trigger Target'),
        ),
      ),
    ));
    expect(find.text('Trigger Target'), findsOneWidget);
    expect(find.text('Copy Action'), findsNothing);
    final targetFinder = find.text('Trigger Target');
    await tester.startGesture(tester.getCenter(targetFinder));
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();
    expect(find.text('Copy Action'), findsOneWidget);
    expect(find.text('Delete Action'), findsOneWidget);
    await tester.tap(find.text('Copy Action'));
    await tester.pumpAndSettle();
    expect(didTapCopy, isTrue);
    expect(find.text('Copy Action'), findsNothing);
  });

  testWidgets('VContextMenu does not open menu on short tap (only long press)',
      (tester) async {
    const actions = [VContextMenuItem(label: 'Action')];
    await tester.pumpWidget(_wrap(
      const Center(
        child: VContextMenu(
          actions: actions,
          child: Text('Target'),
        ),
      ),
    ));

    // Short tap should NOT open the menu
    await tester.tap(find.text('Target'));
    await tester.pumpAndSettle();
    expect(find.text('Action'), findsNothing);

    // Long press SHOULD open the menu
    await tester.longPress(find.text('Target'));
    await tester.pumpAndSettle();
    expect(find.text('Action'), findsOneWidget);
  });

  testWidgets('VContextMenu closes when tapping backdrop', (tester) async {
    final actions = [
      const VContextMenuItem(label: 'Action'),
    ];
    await tester.pumpWidget(_wrap(
      Center(
        child: VContextMenu(
          actions: actions,
          child: const Text('Target'),
        ),
      ),
    ));
    await tester.startGesture(tester.getCenter(find.text('Target')));
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();
    expect(find.text('Action'), findsOneWidget);
    await tester.tapAt(const Offset(10, 10));
    await tester.pumpAndSettle();
    expect(find.text('Action'), findsNothing);
  });

  testWidgets('VContextMenuStyle.modern renders no VDividers', (tester) async {
    final actions = [
      const VContextMenuItem(label: 'Action 1'),
      const VContextMenuItem(label: 'Action 2'),
    ];
    await tester.pumpWidget(_wrap(
      Center(
        child: VContextMenu(
          style: VContextMenuStyle.modern,
          actions: actions,
          child: const Text('Target'),
        ),
      ),
    ));
    await tester.startGesture(tester.getCenter(find.text('Target')));
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();
    expect(find.text('Action 1'), findsOneWidget);
    expect(find.text('Action 2'), findsOneWidget);
    expect(find.byType(BackdropFilter), findsOneWidget);
    final opacityWidget = tester.widget<Opacity>(
      find
          .ancestor(
            of: find.text('Target'),
            matching: find.byType(Opacity),
          )
          .first,
    );
    expect(opacityWidget.opacity, 0.0);
    expect(find.byType(VDivider), findsNothing);
  });

  testWidgets('VContextMenuStyle.ios renders VDividers', (tester) async {
    final actions = [
      const VContextMenuItem(label: 'Action 1'),
      const VContextMenuItem(label: 'Action 2'),
    ];
    await tester.pumpWidget(_wrap(
      Center(
        child: VContextMenu(
          style: VContextMenuStyle.ios,
          actions: actions,
          child: const Text('Target'),
        ),
      ),
    ));
    await tester.startGesture(tester.getCenter(find.text('Target')));
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();
    expect(find.text('Action 1'), findsOneWidget);
    expect(find.text('Action 2'), findsOneWidget);
    expect(find.byType(BackdropFilter), findsOneWidget);
    expect(find.byType(VDivider), findsOneWidget);
  });
}
