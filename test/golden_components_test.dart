import 'dart:io' show Platform;

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vidraui/vidraui.dart';

const _goldenKey = ValueKey('golden-root');

// Golden baselines are generated on macOS. Cross-platform font anti-aliasing
// produces sub-2% pixel diffs that fail on Linux/Windows CI without being real
// regressions, so the goldens run only on the baseline platform. Run
// `flutter test` (or `flutter test --update-goldens`) on macOS to verify them.
final bool _runGoldens = Platform.isMacOS;

void main() {
  group('component goldens', () {
    testWidgets('buttons in light theme', (tester) async {
      await _pumpGolden(
        tester,
        theme: VThemeData.light(),
        width: 520,
        child: VFlex.vertical(
          gap: 12,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const VText('Buttons', variant: VTextVariant.title),
            VFlex.horizontal(
              gap: 8,
              children: [
                VButton(
                  onPressed: () {},
                  child: const VText('Primary', variant: VTextVariant.label),
                ),
                VButton(
                  onPressed: () {},
                  variant: VButtonVariant.secondary,
                  child: const VText('Secondary', variant: VTextVariant.label),
                ),
                VButton(
                  onPressed: () {},
                  variant: VButtonVariant.danger,
                  child: const VText('Danger', variant: VTextVariant.label),
                ),
              ],
            ),
            const VButton(
              onPressed: null,
              child: VText('Disabled', variant: VTextVariant.label),
            ),
          ],
        ),
      );

      await expectLater(
        find.byKey(_goldenKey),
        matchesGoldenFile('goldens/buttons_light.png'),
      );
    });

    testWidgets('form controls in dark theme', (tester) async {
      final controller = TextEditingController(text: 'alice@example.com');
      addTearDown(controller.dispose);

      await _pumpGolden(
        tester,
        theme: VThemeData.dark(),
        child: VFlex.vertical(
          gap: 16,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const VText('Inputs', variant: VTextVariant.title),
            VTextField(
              controller: controller,
              label: 'Email',
              hint: 'you@example.com',
            ),
            const VTextField(
              label: 'Password',
              hint: 'Required',
              errorText: 'Password is required',
              obscureText: true,
            ),
            const VSelect<String>(
              label: 'Role',
              value: 'editor',
              options: [
                VSelectOption(value: 'admin', label: 'Admin'),
                VSelectOption(value: 'editor', label: 'Editor'),
                VSelectOption(value: 'viewer', label: 'Viewer'),
              ],
            ),
          ],
        ),
      );

      await expectLater(
        find.byKey(_goldenKey),
        matchesGoldenFile('goldens/form_controls_dark.png'),
      );
    });

    testWidgets('surface, table, and date picker in light theme',
        (tester) async {
      await _pumpGolden(
        tester,
        theme: VThemeData.light(),
        width: 560,
        height: 680,
        child: VFlex.vertical(
          gap: 16,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            VSurface(
              variant: VSurfaceVariant.card,
              padding: const EdgeInsets.all(16),
              child: VFlex.vertical(
                gap: 8,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: const [
                  VText('Team', variant: VTextVariant.title),
                  VTable(
                    sortColumnIndex: 0,
                    columns: [
                      VTableColumn(header: 'Name', width: 160),
                      VTableColumn(header: 'Role', width: 120),
                      VTableColumn(header: 'Status', width: 120),
                    ],
                    rows: [
                      ['Alice Chen', 'Admin', 'Active'],
                      ['Bob Smith', 'Editor', 'Active'],
                      ['Carol Wu', 'Viewer', 'Inactive'],
                    ],
                  ),
                ],
              ),
            ),
            VSurface(
              variant: VSurfaceVariant.panel,
              padding: const EdgeInsets.all(16),
              child: VDatePicker(
                selected: DateTime(2026, 1, 15),
                firstDate: DateTime(2026, 1, 1),
                lastDate: DateTime(2026, 1, 31),
              ),
            ),
          ],
        ),
      );

      await expectLater(
        find.byKey(_goldenKey),
        matchesGoldenFile('goldens/data_date_light.png'),
      );
    });

    testWidgets('overlay surfaces in light theme', (tester) async {
      BuildContext? toastContext;

      await _pumpOverlayGolden(
        tester,
        theme: VThemeData.light(),
        width: 560,
        height: 360,
        child: Builder(
          builder: (context) {
            toastContext = context;
            return Center(
              child: VDialogSurface(
                semanticLabel: 'Confirm changes',
                child: VFlex.vertical(
                  gap: 12,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const VText(
                      'Publish changes?',
                      variant: VTextVariant.title,
                    ),
                    const VText(
                      'This static surface is rendered without dialog motion.',
                    ),
                    VFlex.horizontal(
                      gap: 8,
                      children: [
                        const VButton(
                          onPressed: null,
                          variant: VButtonVariant.secondary,
                          child: VText('Cancel'),
                        ),
                        VButton(
                          onPressed: () {},
                          child: const VText('Publish'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );

      VToast.show(
        toastContext!,
        message: 'Saved successfully',
        variant: VToastVariant.success,
        position: VToastPosition.top,
        duration: const Duration(hours: 1),
      );
      await tester.pump(const Duration(milliseconds: 250));

      await expectLater(
        find.byKey(_goldenKey),
        matchesGoldenFile('goldens/overlay_surfaces_light.png'),
      );
    });

    testWidgets('opened select menu in light theme', (tester) async {
      await _pumpOverlayGolden(
        tester,
        theme: VThemeData.light(),
        width: 360,
        height: 300,
        child: const Align(
          alignment: Alignment.topLeft,
          child: SizedBox(
            width: 240,
            child: VSelect<String>(
              label: 'Role',
              value: 'editor',
              menuPlacement: VAnchoredOverlayPlacement.down,
              options: [
                VSelectOption(value: 'admin', label: 'Admin'),
                VSelectOption(value: 'editor', label: 'Editor'),
                VSelectOption(value: 'viewer', label: 'Viewer'),
                VSelectOption(
                  value: 'disabled',
                  label: 'Disabled',
                  enabled: false,
                ),
              ],
            ),
          ),
        ),
      );

      await tester.tap(find.byType(VSelect<String>));
      await tester.pumpAndSettle();

      await expectLater(
        find.byKey(_goldenKey),
        matchesGoldenFile('goldens/select_menu_light.png'),
      );
    });
  }, skip: _runGoldens ? false : 'Golden baselines run on macOS only');
}

Future<void> _pumpGolden(
  WidgetTester tester, {
  required VThemeData theme,
  required Widget child,
  double width = 420,
  double height = 360,
}) async {
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = Size(width, height);
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);

  await tester.pumpWidget(
    Directionality(
      textDirection: TextDirection.ltr,
      child: VTheme(
        data: theme,
        child: RepaintBoundary(
          key: _goldenKey,
          child: SizedBox(
            width: width,
            height: height,
            child: ColoredBox(
              color: theme.colors.background,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: child,
              ),
            ),
          ),
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

Future<void> _pumpOverlayGolden(
  WidgetTester tester, {
  required VThemeData theme,
  required Widget child,
  double width = 420,
  double height = 360,
}) async {
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = Size(width, height);
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);

  await tester.pumpWidget(
    Directionality(
      textDirection: TextDirection.ltr,
      child: VTheme(
        data: theme,
        child: RepaintBoundary(
          key: _goldenKey,
          child: SizedBox(
            width: width,
            height: height,
            child: ColoredBox(
              color: theme.colors.background,
              child: VOverlayHost(
                textDirection: TextDirection.ltr,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: child,
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
}
