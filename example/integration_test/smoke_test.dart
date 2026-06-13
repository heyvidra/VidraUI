import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:vidraui_example/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('VidraUI Cross-Platform Component Verification', (tester) async {
    app.main();
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    // The app starts on 'Buttons' category by default.
    // Let's verify 'Buttons' heading is present.
    expect(find.text('Buttons'), findsWidgets);

    // Helper to select a category from the sidebar/menu
    Future<void> selectCategory(String categoryName) async {
      // If menu button exists (narrow layout), tap it
      final menuBtn = find.text('☰');
      if (menuBtn.evaluate().isNotEmpty) {
        await tester.tap(menuBtn);
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 500));
      }

      // Scroll the sidebar to find the category
      final sidebarScrollable = find.descendant(
        of: find.byType(SingleChildScrollView),
        matching: find.byType(Scrollable),
      ).first;
      
      final categoryItem = find.text(categoryName);
      
      await tester.dragUntilVisible(
        categoryItem,
        sidebarScrollable,
        const Offset(0, -50),
      );
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      await tester.tap(categoryItem);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));
    }

    // 1. Verify Typography
    await selectCategory('Typography');
    expect(find.text('Typography'), findsWidgets);

    // 2. Verify Text Field
    await selectCategory('Text Field');
    expect(find.text('Text Field'), findsWidgets);
    
    // 3. Verify Overlay (Toast & Dialog)
    await selectCategory('Overlay');
    expect(find.text('Overlay'), findsWidgets);
    
    // Test Toast
    final toastBtn = find.text('Show Toast');
    await tester.ensureVisible(toastBtn);
    await tester.pumpAndSettle();
    await tester.tap(toastBtn);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100)); // allow animation
    expect(find.text('Item saved successfully'), findsWidgets);
    await tester.pump();
    await tester.pump(const Duration(seconds: 4)); // wait for toast to disappear
    
    // Test Dialog
    final dialogBtn = find.text('Show Dialog');
    await tester.ensureVisible(dialogBtn);
    await tester.pumpAndSettle();
    await tester.tap(dialogBtn);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
    expect(find.text('Delete item?'), findsWidgets);
    // Dismiss Dialog
    await tester.tap(find.text('Cancel'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
    expect(find.text('Delete item?'), findsNothing);

    // 4. Test Theme Toggle
    final themeToggleBtn = find.text('Light'); // Assuming we started in dark or it says Light/Dark
    if (themeToggleBtn.evaluate().isNotEmpty) {
      await tester.tap(themeToggleBtn);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));
    } else {
      final darkToggleBtn = find.text('Dark');
      if (darkToggleBtn.evaluate().isNotEmpty) {
        await tester.tap(darkToggleBtn);
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 500));
      }
    }
  });
}
