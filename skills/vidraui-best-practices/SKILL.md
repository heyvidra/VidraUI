---
name: vidraui-best-practices
description: Build Flutter apps with VidraUI correctly. Use when an agent needs to create, edit, review, or explain app UI that uses the VidraUI design system, including component selection, theme/tokens, overlays, accessibility, example coverage, avoiding Material/Cupertino APIs, and documenting component gaps when VidraUI is not a fit.
---

# VidraUI Best Practices

Use this skill when writing app code with `package:vidraui/vidraui.dart` or when modifying VidraUI examples/docs.

## Start Here

- Import `package:vidraui/vidraui.dart`.
- Use `VidraApp.navigator` or `VidraApp.router` as the app shell.
- Do not use `MaterialApp`, `CupertinoApp`, Material components, Cupertino components, `showDialog`, `ScaffoldMessenger`, or `SnackBar`.
- Prefer `package:flutter/widgets.dart` and other non-Material Flutter libraries.
- Build screens from VidraUI primitives: `VScaffold`, `VSurface`, `VText`, `VSelectableText`, `VButton`, `VBox`, `VFlex`, `VForm`, `VTextField`, `VAutoSuggestBox`, `VSelect`, `VMenuAnchor`, `VScrollArea`, `VSegmentedControl`, `VCollapsible`, `VAccordion`, `VNavigationBar`, `VEmptyState`, and overlay APIs.

## Component Choices

- **Maturity**: prefer Stable components for production-critical flows. Stable includes core controls/layout (`VButton`, `VText`, `VSurface`, `VBox`, `VFlex`, `VScaffold`, `VTextField`) and overlay primitives. Beta includes form controls, `VTable`, date/time pickers, and feedback primitives. Experimental includes carousel, animated helpers, swipe actions, resizable surfaces, and appearance hooks.
- **Application shell**: use `VidraApp` with `VThemeData.light()` and `VThemeData.dark()`.
- **Page layout**: use `VScaffold` for header/body/footer structure and pushed bottom sheet regions.
- **Spacing layout**: use `VFlex` or `VBox` when a gap/padding token makes repeated layout clearer.
- **Containers**: use `VSurface` variants instead of raw decorated boxes for product surfaces.
- **Background overrides**: use `VBackground.color` or `VBackground.gradient` only for one-off page/container/overlay surfaces such as `VSurface`, `VScaffold`, `VToast`, `VDialog.surfaceBackground`, `VSheet.surfaceBackground`, and `VPopover.surfaceBackground`; prefer tokens/appearance for reusable styling.
- **Text**: use `VText` variants before custom `TextStyle`; use `VSelectableText` for read-only copy that users need to select or copy.
- **Actions**: use `VButton`; pass `semanticLabel` for icon-only buttons.
- **Forms**: use `VTextField`, `VAutoSuggestBox`, `VSelect`, `VCheckbox`, `VRadio`, `VSwitch`, `VSlider`, and `VForm`.
- **Segmented controls**: use `VSegmentedControl<T>` for horizontal option selectors with a smooth sliding active pill. Supports keyboard arrow-key cycling and accessibility semantics.
- **Collapsible/Accordion**: use `VCollapsible` for a single expandable section with animated height transition and rotating chevron indicator. Use `VAccordion` to group multiple `VCollapsible` children with optional exclusive single-expand mode (`multiple: false`).
- **Motion**: use `VMotionScope`, `VAnimatedBox`, `VAnimatedVisibility`, `VAnimatedScaleFade`, `VAnimatedSlideFade`, `VStagger`. Prefer tokenized helpers.
- **Scrollable areas**: use `VScrollArea` to give any `Widget` subtree a scroll container with an integrated token-driven scrollbar. Prefer `VScrollArea` over bare `SingleChildScrollView` + custom `Scrollbar`.
- **Menus**: use `VMenuAnchor` for anchored action menus and lightweight single/multiple selection menus. Use `VSelect` instead when the control is a form field with a persistent selected-value label.
- **Autocomplete / Combobox**: use `VAutoSuggestBox` for a combined text input and suggestion dropdown. It supports synchronous and asynchronous search sources (with built-in debouncing), Arrow Up/Down keyboard navigation, Enter selection, Escape closure, and match substring highlighting.
- **Overlays**: use `VToast.show`, `VDialog.show` (with `VAlertDialog` or `VDialogSurface`), `VSheet.show`, and `VMenuAnchor`. For bottom sheets, use `VSheet.show(edge: VSheetEdge.bottom, ...)`. Close dialogs/sheets with their scope callbacks.
- **Navigation affordances**: use `VAppBar`, `VTabBar`, `VTabs`, and custom `VButton` actions.
- **Bottom Navigation**: use `VNavigationBar` for top-level bottom-bar navigation. It supports `flat` (edge-to-edge), `floating`, and `capsule` shapes, pill/dot/topLine selection indicators, and optional center raised FAB with custom notch cutouts. It also fully manages and adapts safe area paddings and margins for notched/heterogeneous screens.
- **Page transitions**: use `VPageRoute` with `VPageTransition` variants. Set `VMotion.pageTransition` for app-wide defaults; use `VMotionScope` to override for a subtree. `iosDepthSlide` and `adaptive` automatically enable `VBackGestureDetector` (swipe-to-back from left 20 px edge).
- **Feedback/loading**: use `VProgressBar`, `VSpinner`, `VSkeletonBox`, `VSkeletonCircle`, `VShimmer`, and `VBadge`.

Notes:
- Use `VTimeOfDay`; the legacy `TimeOfDay` compatibility alias has been completely removed.
- `VTable` is a tokenized sortable table, not a full data-grid with cell-level keyboard navigation.
- `VTimePicker` is currently 24-hour only and has no AM/PM period column.
- `VSheet` supports `top`, `right`, `bottom`, and `left` modal edge sheets. `VScaffold.bottomSheet` is for pushed layout that participates in scaffold sizing.
- `VMenuAnchor` uses VidraUI overlay primitives and supports actions, disabled items, separators, destructive items, keyboard navigation, and single/multiple selection. Do not use Flutter Material `MenuAnchor`.
- Strong stateful controls such as `VButton`, `VTextField`, `VSelect`, `VMenuAnchor`, `VTable`, `VDatePicker`, and `VTimePicker` intentionally do not expose direct background props; keep stateful visuals in component tokens.

For component-by-component guidance, read `references/component-map.md`.

## Page Transitions

Available `VPageTransition` values:

| Value | Description |
|---|---|
| `iosDepthSlide` | iOS-style full-width slide with 30% parallax on outgoing page and drop shadow. Enables swipe-to-back. |
| `sharedAxisX` | Horizontal shared-axis slide + fade (Material shared axis). |
| `sharedAxisY` | Vertical shared-axis slide + fade. |
| `sharedAxisZ` | Depth shared-axis scale + fade. |
| `zoomUpReveal` | Android zoom-up: scale from 92% + fade + 8% vertical slide. |
| `perspective3D` | Y-axis 3D flip with Matrix4 perspective. Use sparingly for emphasis. |
| `fade` | Simple cross-fade. |
| `adaptive` | `iosDepthSlide` on iOS/macOS, `zoomUpReveal` on other platforms. |
| `none` | Instant replacement — no animation. |

### Setting the app-wide default

```dart
VidraApp.navigator(
  theme: VThemeData.light().copyWith(
    motion: VThemeData.light().motion.copyWith(
      pageTransition: VPageTransition.iosDepthSlide,
    ),
  ),
  home: const HomePage(),
);
```

### Pushing with app-wide motion

```dart
Navigator.of(context).push(
  VPageRoute<void>(
    motion: VTheme.of(context).motion,
    builder: (_) => const DetailPage(),
  ),
);
```

### Overriding for one subtree

```dart
VMotionScope(
  motion: VTheme.of(context).motion.copyWith(
    pageTransition: VPageTransition.sharedAxisX,
  ),
  child: Builder(
    builder: (ctx) => VButton(
      onPressed: () => Navigator.of(ctx).push(
        VPageRoute<void>(
          motion: VMotionResolver.of(ctx),
          builder: (_) => const DetailPage(),
        ),
      ),
      child: const VText('Go', variant: VTextVariant.label),
    ),
  ),
)
```

### Swipe-to-back (VBackGestureDetector)

`VBackGestureDetector` is activated automatically inside `VPageRoute` when the transition is `iosDepthSlide` or `adaptive` (on Apple platforms). No extra code is needed in the caller.

Key behavior:
- Responds to drag starting within the left **20 px** edge.
- Calls `navigator.didStartUserGesture()` on start, drives `routeController.value` directly during drag.
- **Does not call `navigator.pop()` eagerly** — this avoids mid-drag gesture cancellation.
- Commits pop only after `animateBack(0.0)` completes if drag > 35% width or velocity > 200 px/s.
- Disabled on the first route in the stack.



## When VidraUI Is Not A Fit (Gap Reports)

If a real UI requirement cannot be met with existing VidraUI widgets (or only with a fragile hack), **do not silently fall back to Material/Cupertino** and **do not leave the gap undocumented**.

### Write a gap report first

Before adopting a long-term non-VidraUI pattern (custom `widgets.dart` control, raw platform view, third-party widget, or an approved Material escape hatch), create a markdown report in the **consumer app**:

```txt
docs/vidraui-gaps/<YYYY-MM-DD>-<short-slug>.md
```

Use the template in `references/component-gap-report-template.md`. One report per distinct gap (merge updates into the same file if the same feature is iterated).

### Report must include

1. **UI need** — what the product screen must do.
2. **Candidates tried** — which VidraUI APIs were considered and why they fail.
3. **Gap** — missing API, token, a11y, performance, maturity, or platform behavior.
4. **Workaround** — what ships today (code paths, files); note whether VidraUI rules are still respected.
5. **Risks** — theme drift, a11y, duplication, maintenance.
6. **Recommendations for VidraUI** — concrete upgrade ideas: API sketch, tokens, example demo, tests, target maturity.
7. **Acceptance criteria** — how to know VidraUI support is complete later.

### Agent workflow

```txt
Evaluate VidraUI component map
  → fits? use VidraUI
  → unclear? read references/component-map.md + example demos
  → still blocked?
       → write docs/vidraui-gaps/...md (template)
       → implement minimal workaround (prefer widgets.dart + tokens)
       → mention report path in PR / handoff summary
```

### Severity

| Level | When |
| --- | --- |
| `blocker` | Cannot ship the feature without non-VidraUI UI or unsafe hack |
| `major` | Ships with workaround but poor a11y, tokens, or maintainability |
| `minor` | Nice-to-have API polish; workaround is acceptable short-term |

### Do not use gap reports to justify

- Importing `material.dart` / `cupertino.dart` in `lib/` without explicit approval.
- One-off hard-coded colors when tokens exist.
- Skipping accessibility because a custom control is faster.

Gap reports are for **honest inventory and VidraUI roadmap input**, not for bypassing AGENTS.md constraints.

### Feeding back into VidraUI

When the gap is recurring or blocks multiple apps, summarize recommendations from the report when opening a VidraUI issue or PR: link the app report, paste the API sketch, and call out required example demo + tests per AGENTS.md.

## Tokens And Theme

- Follow the flow `Primitive -> Semantic -> Component -> Widget`.
- App widgets should read semantic or component tokens from `VTheme.of(context)`.
- Do not hard-code colors, radii, shadows, durations, or text styles when VidraUI tokens already express the role.
- Prefer `VTheme.override` for scoped semantic token changes that should flow through all component tokens.
- Use `VStateProperty.states(...)` for concise stateful component token values.
- Use component theme wrappers such as `VButtonTheme.override`, `VSurfaceTheme.override`, `VInputTheme.override`, `VSelectTheme.override`, `VMenuTheme.override`, `VTableTheme.override`, `VDialogTheme.override`, `VToastTheme.override`, `VCheckboxTheme.override`, `VRadioTheme.override`, `VSwitchTheme.override`, and `VChipTheme.override` when only one component family should change.
- Component theme wrappers are typed aliases over `VTokenTheme<T>`. Use `VTokenTheme<T>` directly only for advanced scopes or when adding a new token scope before a named wrapper exists.
- Segmented control and accordion theme overrides: use `VSegmentedControlTheme.override` and `VAccordionTheme.override` for scoped token changes.
- Use `VAppearanceScope` for subtree-wide visual treatment. Keep trend-specific appearance presets in app/example code, not VidraUI core.

## Platform Adaptation

- Do not hard-code checks for `defaultTargetPlatform` inside reusable widget files to determine desktop/mobile layout or keyboard behaviors.
- Read platform configurations and adaptive design constants from the nearest `VPlatformScope.of(context)`.
- Available parameters on `VPlatformBehavior`:
  - `isDesktop`: True for macOS/Windows/Linux. Governs cursor selection item heights, keyboard navigation support, and hovered states.
  - `isApple`: True for macOS/iOS. Governs Apple-specific transition behaviors (depth slide, spring curves) and command shortcut symbols.
  - `selectionMenuItemHeight`: `44.0` for mobile/touch targets, `36.0` for desktop precise targets.
  - `selectionMenuRadius`: `22.0` for mobile bubble popups, `8.0` for desktop context menus.
  - `shortcutModifier`: `⌘` for Apple systems, `Ctrl+` for other systems.
- Use `VPlatformScope` to override strategies for subtrees (e.g. `VPlatformScope(behavior: VPlatformBehavior.desktop(isApple: false), child: ...)`), which is highly valuable for isolated responsive testing.

## Scroll

- Prefer `VScrollArea` over raw `SingleChildScrollView`. It manages its own controller, removes platform glow/stretch via `VScrollBehavior`, and shows a token-driven scrollbar at the correct edge.
- `showScrollbar: false` — suppress the scrollbar entirely (e.g. full-page scroll).
- `interactiveScrollbar: false` — make the scrollbar non-draggable (read-only indicator).
- `thumbVisibility: true` — always-on thumb (useful for desktop or tables).
- The `.scrollable()` extension is a fluent shortcut; it is equivalent to wrapping with `VScrollArea` and accepts the same named parameters.

```dart
// Declarative
VScrollArea(
  scrollDirection: Axis.vertical,
  showScrollbar: true,
  thumbVisibility: true,
  child: VFlex.vertical(gap: 8, children: items),
)

// Fluent shortcut
VFlex.vertical(gap: 8, children: items).scrollable(thumbVisibility: true)
```

- For horizontal scroll (e.g. code blocks, wide tables): set `scrollDirection: Axis.horizontal`. The scrollbar auto-places at `bottom`.
- Use `VScrollbarTheme.override` to change thumb/track color for one subtree without touching global tokens.
- Do not use Flutter's built-in `Scrollbar` widget; it has Material dependencies. Use `VScrollbar` (wraps `RawScrollbar`).

## Unified Size Tokens

- All interactive widgets now use the shared `VControlSize { sm, md, lg }` enum from `package:vidraui/vidraui.dart`.
- Widgets that previously had their own size enums (`VButtonSize`, `VChipSize`, `VAvatarSize`, `VNumberBoxSize`, `VSegmentedControlSize`) now all accept `VControlSize` on their `size` parameter.
- Migration: replace `VButtonSize.sm` → `VControlSize.sm`, etc.

```dart
// Before (deprecated — removed)
VButton(onPressed: save, size: VButtonSize.sm, child: ...)
// After
VButton(onPressed: save, size: VControlSize.sm, child: ...)
```

## New Public APIs

### VChevronIcon
An animated chevron arrow that rotates 180° when expanded. Use as a dropdown/expand indicator:
```dart
VChevronIcon(isOpen: isExpanded, color: theme.colors.text, size: 16)
```

### VAnchoredOverlayPlacement (used directly)
`VMenuAnchor.placement` and `VSelect.menuPlacement` now accept `VAnchoredOverlayPlacement` directly (the intermediate `VMenuPlacement` and `VSelectMenuPlacement` enums have been removed). Values: `auto`, `down`, `up`, `left`, `right`, `autoHorizontal`.

### Overlay focus utilities
```dart
final previousFocus = saveOverlayFocus();  // before showing overlay
// ... show overlay ...
restoreOverlayFocus(previousFocus);        // on dismiss
```

### resolveOverlayTheme
Available from `package:vidraui/vidraui.dart`. Merges scoped component tokens into the base theme for overlay presentations:
```dart
final theme = resolveOverlayTheme(context, VDialogTheme.of, (c, t) => c.copyWith(dialog: t));
```

## Accessibility

- Buttons need a visible label or `semanticLabel`; icon-only buttons must use `semanticLabel`.
- Interactive widgets should preserve focus outlines and keyboard activation.
- Text fields need clear `label`, `hint`, `errorText`, and semantic labels where the visual label is insufficient.
- Dialogs should use `VDialogSurface` and close through `VDialogScope.of<T>(context)`.
- Modal edge sheets should use `VSheetSurface` and close through `VSheetScope.of<T>(context)`; use `VSheetScope.of<T>(context)`.
- Do not replace VidraUI controls with gesture-only custom controls unless you also provide semantics, focus, and keyboard behavior.

## App Scaffold Example

```dart
import 'package:flutter/widgets.dart';
import 'package:vidraui/vidraui.dart';

void main() {
  runApp(
    VidraApp.navigator(
      title: 'Example',
      theme: VThemeData.light(),
      darkTheme: VThemeData.dark(),
      home: const HomePage(),
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);
    return VScaffold(
      header: const VAppBar(title: VText('Example')),
      body: VFlex.vertical(
        padding: EdgeInsets.all(theme.spacing.lg),
        gap: theme.spacing.md,
        children: [
          const VText('Dashboard', variant: VTextVariant.heading),
          VSurface(
            variant: VSurfaceVariant.card,
            child: Padding(
              padding: EdgeInsets.all(theme.spacing.md),
              child: VButton(
                onPressed: () => VToast.show(
                  context,
                  message: 'Saved',
                  variant: VToastVariant.success,
                ),
                child: const VText('Save', variant: VTextVariant.label),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
```

## Avoid

```dart
// Do not do this in VidraUI apps.
MaterialApp(home: Scaffold(body: TextButton(onPressed: save, child: Text('Save'))));
showDialog(context: context, builder: (_) => AlertDialog(...));
ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Saved')));
```

## When Modifying VidraUI Itself

- Add or update the example docs page for every new public widget.
- Add or update docs snippets in `example/lib/main.dart` with `docs-snippet:start` / `docs-snippet:end` markers.
- Keep the docs maturity overview and README component maturity matrix aligned when component status changes.
- When adding a new component token scope, wire it through `VTokenTheme<T>`, provide a named `V<Component>Theme` wrapper, export it from `src/theme/theme.dart`, add it to docs catalog symbols, and include focused tests.
- Add focused widget tests for behavior/a11y changes. Use Flutter's built-in golden tests for stable, token-heavy visual surfaces; golden baselines live in `test/goldens/`.
- Do not read `VTheme.of(context)` or any inherited widget from `initState`; create controllers there, then configure inherited-widget-dependent animation/state in `didChangeDependencies` or `build`.
- Do not synchronously call user callbacks that may `setState` while a widget is building or updating. For scroll pagination, threshold checks may happen during notifications or widget updates, but invoking `onLoadMore` should be queued with `WidgetsBinding.instance.addPostFrameCallback` and guarded against duplicate calls.
- Large list components should use lazy builders (`SliverList`, `ListView.builder`, or equivalent delegates), not `SingleChildScrollView + Column + children`, and tests should assert they do not build every row.
- When using `VInteractive`, manage keyboard shortcuts and key activations (such as Enter/Space sorting or selecting) by wrapping it in `Actions` and `Shortcuts` with `ActivateIntent` mapped to key codes, aligning perfectly with stateless widget rendering.
- To prevent click-focus conflicts with autofocusing overlays (like `VSheet`, `VDialog`, and `VMenuAnchor`) opened from tap handlers, set `requestFocusOnTap: false` on the trigger widget's underlying `VInteractive`.
- Decouple gesture state from full widget parent rebuilds during continuous high-frequency drag actions by storing dragging metrics inside a localized `ValueNotifier` and rendering position offsets through `ValueListenableBuilder`.
- When implementing autocomplete dropdown overlays (like `VAutoSuggestBox`):
  - **Dynamic Height**: If dropdown items support subtitles, calculate dynamic total popover height (e.g., 40.0 for standard, 56.0 for two-line double-height items with subtitle) and set this explicit height on each item container (`SizedBox`) to completely avoid bottom overflows. Do not set a fixed `itemExtent` on the `ListView.builder`.
  - **Trigger Width Alignment**: To prevent the popover from stretching wider than the input field, assign a `GlobalKey` to the trigger widget (e.g., `VTextField`), measure its actual rendered width dynamically at runtime, and set that width on the overlay content container (`SizedBox`).
- Regenerate docs metadata:
  - `dart run scripts/generate_api_inventory.dart`
  - `dart run scripts/extract_doc_snippets.dart`
- Update intentional golden baseline changes with:
  - `flutter test --update-goldens`
  - Run:
  - `dart run scripts/verify.dart`
