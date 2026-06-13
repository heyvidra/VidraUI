# VidraUI Component Map

Use this reference when choosing VidraUI components for app code.

| Need | Prefer | Notes |
| --- | --- | --- |
| App shell | `VidraApp.navigator`, `VidraApp.router` | Never use `MaterialApp` or `CupertinoApp`. |
| Page frame | `VScaffold` | Header, body, footer, and pushed bottom sheet regions. |
| Surface/card/panel | `VSurface` | Pick variants by semantic role. |
| Layout — spacing | `VFlex`, `VBox` | Gap and padding tokens; prefer over raw `Column`/`Row` when spacing matters. |
| Scrollable container | `VScrollArea` | Wraps content in `SingleChildScrollView` + `VScrollbar`. Auto-positions scrollbar. Use `showScrollbar: false` to suppress. Call `.scrollable()` on any widget as a fluent shortcut. |
| Custom scrollbar | `VScrollbar` | Reads `VScrollbarTokens`. Use when you need a bare scrollbar detached from `VScrollArea`. Pass `scrollbarOrientation` explicitly in nested layouts. |
| Text | `VText`, `VSelectableText`, `VRichText` | Prefer `VTextVariant` over ad hoc styles; use selectable text for copyable read-only content. |
| Primary action | `VButton` | Use `VButtonVariant.primary`; pass `semanticLabel` for icon-only. |
| Secondary/destructive action | `VButton` | Use `secondary` or `danger` variants. |
| Form text input | `VTextField` | Uses `EditableText`; do not use Material `TextField`. |
| Select input | `VSelect`, `VSelectOption` | Use `.multiple` for `Set<T>` selections. |
| Anchored menu | `VMenuAnchor`, `VMenuItem` | Use for action menus, disabled/destructive items, separators, and lightweight single/multiple selection menus; do not use Material `MenuAnchor`. |
| Boolean input | `VCheckbox`, `VSwitch` | Keep state in parent. |
| Exclusive choice | `VRadio`, `VRadioGroup` | Keep selected value in parent. |
| Numeric range | `VSlider` | Use normalized values unless UI explains another scale. |
| Segmented selector | `VSegmentedControl<T>` | Horizontal option pill with smooth sliding active indicator. Keyboard arrow-key cycling and accessibility semantics built in. |
| Collapsible section | `VCollapsible` | Single expandable section with animated `SizeTransition` height and rotating chevron indicator. Supports controlled and uncontrolled state. |
| Accordion group | `VAccordion` | Groups `VCollapsible` children. `multiple: false` for exclusive single-expand mode; `multiple: true` for independent sections. |
| Date/time | `VDatePicker`, `VTimePicker` | Store selected values in parent. |
| Tabs | `VTabs`, `VTabBar` | Keep labels short. |
| Bottom navigation | `VNavigationBar` | Top-level bottom navigation with flat, floating, or capsule shapes, center FAB notches, and full safe area padding/margins for heterogeneous screens. |
| App header | `VAppBar`, `VAppBar.sliver` | Use sliver variant inside `CustomScrollView`. |
| List rows | `VListTile`, `VDivider` | Compose with `VSwipeActions` for row actions. |
| Tables | `VTable`, `VTableColumn` | Good for compact simple data. |
| Toast | `VToast.show` | Requires context under `VidraApp`/`VOverlayHost`. |
| Dialog | `VDialog.show`, `VDialogSurface` | Close with `VDialogScope.of<T>(ctx)(result)`. |
| Alert Dialog | `VAlertDialog` | Convenience dialog wrapper with preset title, body, actions, and close layout inside `VDialog.show`. |
| Edge sheet | `VSheet.show`, `VSheetSurface` | Supports `top`, `right`, `bottom`, and `left` modal sheets. Close with `VSheetScope.of<T>(ctx)(result)`. |
| Tooltip | `VTooltip` | Wrap the target control. |
| Motion | `VMotionScope`, `VAnimatedBox`, `VAnimatedVisibility`, `VAnimatedScaleFade`, `VAnimatedSlideFade`, `VStagger` | Prefer tokenized helpers. |
| Loading | `VProgressBar`, `VSpinner`, `VSkeletonBox`, `VSkeletonCircle`, `VShimmer` | Use null progress for indeterminate. |
| Empty State | `VEmptyState` | Placeholder displayed when a list, collection, or search has no results. Shows centered icon, title, description, and an optional action. |
| Media | `VIcon`, `VImage`, `VAvatar` | Provide semantic labels for meaningful media. |
| Theming | `VTheme`, `VThemeData`, component theme widgets | Override locally with inherited component themes. Includes `VSegmentedControlTheme`, `VAccordionTheme`. |
| Appearance | `VAppearanceScope` | Keep app-specific styles outside VidraUI core. |

## Common Misuse

- Do not wrap VidraUI screens in Material `Scaffold`.
- Do not import `package:flutter/material.dart` to get buttons, text fields, snack bars, dialogs, or app bars.
- Do not hard-code component colors when `VTheme.of(context).colors` or component tokens provide the semantic role.
- Do not add per-component style flags such as `glass: true`; use `VAppearanceScope`.

## No Matching Component?

If nothing in this map satisfies the requirement, follow **When VidraUI Is Not A Fit** in `SKILL.md` and file a gap report using `component-gap-report-template.md` under the app’s `docs/vidraui-gaps/`.
