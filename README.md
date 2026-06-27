# VidraUI

A comprehensive Flutter design system and widget library built entirely on `WidgetsApp` — zero Material or Cupertino dependencies.

VidraUI provides a complete suite of design tokens, theme infrastructure, routing adapters, overlay management, and **129 widget implementations** across 14 categories — all framework-native and accessibility-first.

**Key Stats:**
- 🎨 **129 widgets** across 14 categories
- 🎯 **27 component token classes** + 7 foundation tokens
- 📦 **265+ public API symbols**
- 🚫 **Zero Material/Cupertino** dependencies in lib/
- 📝 **32,500+ lines** of implementation code
- ✅ **11,000+ lines** of test code (46 test files)
- 🌍 **Bilingual docs** with live interactive demos

## Features

- **Design tokens**: Primitive → Semantic → Component token system with code generation
- **Theme**: `VThemeData` with `copyWith` and `lerp` for animated transitions, plus 27 component token classes
- **Routing**: Pluggable `VRouteAdapter` — Navigator 1.0 and Router 2.0 support with custom page transitions
- **Overlay**: Toast, dialog, sheets, popovers, tooltips, teaching tips, and context menus via `VOverlayHost`
- **Layout**: `VScaffold`, `VAppBar`, `VBox`, `VFlex`, `VListTile`, `VAccordion`, `VTabs`, `VResizable`, `VStickyHeader`
- **Forms**: `VTextField`, `VSelect`, `VCheckbox`, `VRadio`, `VSwitch`, `VSlider`, `VDatePicker`, `VTimePicker`, `VNumberBox`, `VAutoSuggestBox`, `VForm`
- **Data display**: `VTable`, `VScrollableList`, `VScrollableGrid`, `VCarousel`, `VTimeLine`, `VSteps`, `VPagination`
- **Navigation**: `VNavigationBar`, `VListNavigator` with multi-level support
- **Animation**: `VAnimatedBox`, `VAnimatedList`, `VAnimatedSwitcher`, `VStagger`, `VAnimatedText` with 9 effects
- **Media**: `VImage` with caching, `VAvatar` with size variants
- **Feedback**: `VProgressBar`, `VSpinner`, `VSkeletonBox`, `VShimmer`, `VEmptyState`, `VBadge`
- **Text & Selection**: `VText`, `VRichText`, `VSelectableText` with custom selection menu
- **Scroll**: `VScrollArea` (scroll container with integrated custom scrollbar), `VScrollbar` (token-driven)
- **Interaction**: `VButton` (4 variants), `VChip`, `VSwipeActions`, gesture detection
- **Framework-native**: Uses `WidgetsApp`; no Material/Cupertino imports in lib/
- **Appearance system**: Generic hooks (`wrap`, `innerShadows`, `gradient`, `background`, `foreground`) with subtree scoping via `VAppearanceScope`

## Widget Catalog

VidraUI ships **129 widget implementations** organized into 14 categories:

### Core & Layout (23 widgets)
- **Basic**: `VBox`, `VFlex`, `VSurface`, `VText`, `VRichText`, `VIcon`, `VDivider`, `VGestureDetector`, `VAvatar`, `VBadge`
- **Layout**: `VScaffold`, `VAppBar`, `VSliverAppBar`, `VListTile`, `VAccordion`, `VCollapsible`, `VTabs`, `VTabBar`, `VResizable`, `VStickyHeader`
- **Responsive**: `VResponsive`, `VBreakpoint`, grid layouts

### Forms & Input (19 widgets)
`VTextField`, `VSelect`, `VAutoSuggestBox`, `VCheckbox`, `VRadio`, `VRadioGroup`, `VSwitch`, `VSlider`, `VSegmentedControl`, `VDatePicker`, `VTimePicker`, `VNumberBox`, `VForm`, `VFormField`, `VControlRow`

### Buttons & Chips (3 widgets)
`VButton` (primary, secondary, outlined, danger variants), `VChip`, `VChevronIcon`

### Overlays (15 widgets)
`VToast`, `VDialog`, `VAlertDialog`, `VSheet`, `VPopover`, `VTooltip`, `VTeachingTip`, `VMenuAnchor`, `VContextMenu`, `VOverlayHost`

### Data Display (12 widgets)
`VTable`, `VScrollableList`, `VScrollableGrid`, `VCarousel`, `VTimeLine`, `VSteps`, `VPagination`, `VListNavigator`

### Navigation (4 widgets)
`VNavigationBar`, `VNavigationDestination`, `VListNavigator`, `VPagination`

### Scrolling (3 widgets)
`VScrollArea`, `VScrollbar`, scroll indicators

### Selection (4 widgets)
`VSelectableText`, `VTextSelectionControls`, `VTextSelectionMenu`, custom text selection

### Animation (13 widgets)
`VAnimatedBox`, `VAnimatedVisibility`, `VAnimatedScaleFade`, `VAnimatedSlideFade`, `VAnimatedSwitcher`, `VAnimatedList`, `VStagger`, `VAnimatedText` (with 9 effects: typewriter, fade, scale, bounce, wavy, reveal, scramble, flicker)

### Feedback (9 widgets)
`VProgressBar`, `VSpinner`, `VLoadingDots`, `VSkeletonBox`, `VSkeletonCircle`, `VShimmer`, `VEmptyState`, `VBadge`, `VTimeLine`

### Media (3 widgets)
`VImage`, `VAvatar`, image caching

### Interaction (3 widgets)
`VSwipeActions`, `VGestureDetector`, `VInteractive` (internal)

### Theme & Appearance (15+ classes)
`VTheme`, `VAnimatedTheme`, `VAppearance`, `VAppearanceScope`, `VMotion`, `VMotionScope`, `VIconTheme`, component theme wrappers (VButtonTheme, VSelectTheme, VInputTheme, VTableTheme, etc.)

### Foundation Tokens (7 classes)
`VColors`, `VTypography`, `VSpacing`, `VRadii`, `VShadows`, `VSizes`, `VMotion`

## Component Maturity

| Status | Components | Count |
| --- | --- | --- |
| **Stable** | Core layout, buttons, text, forms, overlays, scrolling | ~50 |
| **Beta** | Data display, navigation, pickers, advanced forms | ~45 |
| **Experimental** | Animation effects, appearance presets, advanced interactions | ~34 |

All components are:
- ✅ Token-driven (27 component token classes)
- ✅ Accessibility-compliant (semantics, keyboard, focus)
- ✅ Theme-animatable (lerp support)
- ✅ Documented with live examples
- ✅ Free of Material/Cupertino dependencies

## API/demo website

The `example/` app is the VidraUI documentation site with:
- **Bilingual navigation** (English/Chinese)
- **Live interactive demos** for all 129 widgets
- **Searchable component catalog** with API tables
- **Extracted code snippets** from source
- **Usage notes and best practices**
- **Appearance system examples** (Glassmorphism, Neumorphism presets in example-only code)

```bash
cd example
flutter run -d chrome
```

## Project Statistics

- **129 widget implementations** across 14 categories
- **27 component token classes** with auto-generated `fromColors`, `lerp`, and `copyWith`
- **7 foundation token classes** (colors, typography, spacing, radii, shadows, sizes, breakpoints)
- **265+ public API symbols** (classes, enums, functions)
- **Zero Material/Cupertino dependencies** in production code
- **100% framework-native Flutter** (WidgetsApp-based)
- **Comprehensive test coverage** with widget tests, golden tests, and accessibility tests
- **Fully documented** with inline docs and live examples for every component

## Package Structure

```
lib/
  vidraui.dart                    # Main export
  src/
    foundation/                   # Design tokens (7 token classes)
      primitive_tokens.dart
      semantic_tokens.dart
      spacing.dart, radii.dart, typography.dart, shadows.dart, sizes.dart
      motion.dart, state.dart, responsive.dart
    theme/                        # Theme infrastructure (27 component tokens)
      v_theme_data.dart
      v_theme.dart, v_animated_theme.dart
      component_tokens/           # 27 component token classes
    app/                          # App shell & routing
      vidra_app.dart
      v_overlay_host.dart, v_page_route.dart
      v_route_adapter.dart, v_navigator_adapter.dart, v_router_config_adapter.dart
    widgets/                      # 129 widget implementations
      animation/                  # 13 animation widgets
      basic/                      # 11 basic widgets
      buttons/                    # 3 button widgets
      data/                       # 12 data display widgets
      feedback/                   # 9 feedback widgets
      forms/                      # 19 form widgets
      interaction/                # 3 interaction widgets
      layout/                     # 13 layout widgets
      media/                      # 3 media widgets
      navigation/                 # 4 navigation widgets
      overlays/                   # 15 overlay widgets
      scrolling/                  # 3 scrolling widgets
      selection/                  # 4 selection widgets

example/                          # Documentation site & demos
  lib/
    docs/                         # Generated API inventory & snippets
    src/
      demos/                      # 40+ demo pages
      shell/                      # App navigation shell
  
test/                             # Widget tests, golden tests, accessibility tests
scripts/                          # Code generation & verification scripts
```

## Code Generation & Verification

VidraUI uses code generation for foundation tokens, component tokens, and component theme wrappers to maintain consistency and reduce boilerplate.

### Generate all artifacts

```bash
# Foundation tokens (7 .g.dart files: colors, typography, spacing, radii, shadows, sizes, breakpoints)
dart run scripts/generate_foundation_tokens.dart

# Component tokens (fromColors/lerp/copyWith for 27 token classes)
dart run scripts/generate_component_tokens.dart

# Component themes (InheritedWidget wrappers for scoped token overrides)
dart run scripts/generate_component_themes.dart

# Docs infrastructure
dart run scripts/generate_api_inventory.dart
dart run scripts/extract_doc_snippets.dart
dart run scripts/check_docs_coverage.dart
dart run scripts/check_api_inventory.dart

# Full verification pipeline (analyze + import guards + tests)
dart run scripts/verify.dart
```

### Before every release

```bash
# Run the complete verification suite
dart run scripts/verify.dart

# This runs:
# 1. flutter analyze (must have 0 errors)
# 2. Import guard checks (no material.dart/cupertino.dart in lib/)
# 3. flutter test (all tests must pass)
# 4. API inventory check (detects accidental public API changes)
```

### Golden tests

Golden tests live under `test/goldens/` and use Flutter's built-in golden testing. Update baselines only after reviewing intentional visual changes:

```bash
flutter test --update-goldens
```

## Theme overrides

Prefer scoped semantic token overrides when a subtree should adopt a different
role color. `VTheme.override` derives component tokens from the resolved colors,
so buttons, chips, selects, and other tokenized components stay consistent.

```dart
VTheme.override(
  colors: (colors) => colors.copyWith(
    actionPrimary: colors.success,
    actionPrimaryHover: colors.successHover,
    actionPrimaryPressed: colors.successHover,
  ),
  child: child,
)
```

Use component theme wrappers when only one component family should change.
Wrappers such as `VButtonTheme`, `VSelectTheme`, `VInputTheme`, `VTableTheme`,
`VDialogTheme`, and `VToastTheme` are thin typed aliases over the generic
`VTokenTheme<T>` scope.

```dart
VButtonTheme.override(
  data: (theme, button) => button.copyWith(
    primaryBackground: VStateProperty.states(
      normal: theme.colors.success,
      hovered: theme.colors.successHover,
    ),
  ),
  child: child,
)
```

Use `VTokenTheme<T>` directly when adding or experimenting with token scopes
that do not need a named component wrapper.

## Appearance

VidraUI provides a generic appearance system. Implement `VAppearance` subclasses to create custom visual styles without per-component changes.

```dart
class MyAppearance extends VAppearance {
  @override Color background(Color base, Set<WidgetState> states) => base.withValues(alpha: 0.5);
  @override Widget wrap(BuildContext ctx, Widget child, {required BorderRadiusGeometry borderRadius, required Set<WidgetState> states}) =>
      ClipRRect(borderRadius: borderRadius, child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18), child: child));
}

VAppearanceScope(
  appearance: const MyAppearance(),
  child: YourWidgetTree(),
);
```

Example-only presets for Glassmorphism and Neumorphism are available in the example app.

## Motion

VidraUI motion is tokenized with `VMotionSpec` and `VMotion`. Themes provide
named specs such as `control`, `overlay`, `page`, and `emphasized`, while
`VMotionScope` can override motion for a subtree. Dialogs and sheets use these
tokens for their overlay transitions.

```dart
VMotionScope(
  motion: VTheme.of(context).motion.copyWith(
    reducedMotion: true,
  ),
  child: const MyPanel(),
)
```

Use `VAnimatedBox`, `VAnimatedVisibility`, `VAnimatedScaleFade`, and
`VAnimatedSlideFade` for motion-aware component transitions.

`VTypewriterText` provides two motion-token-aware text reveal modes:

```dart
// Letter-by-letter typing with optional blinking cursor
VTypewriterText(
  'Hello, world!',
  mode: VTypewriterMode.typewriter,
  showCursor: true,
  speed: const Duration(milliseconds: 35),
)

// Soft opacity reveal driven by VMotion.control tokens
VTypewriterText(
  'Fades in on change.',
  mode: VTypewriterMode.reveal,
)

// Streaming-optimised: appending to text continues typing from the suffix
// instead of restarting — ideal for LLM token streaming.
VTypewriterText(streamingBuffer, mode: VTypewriterMode.typewriter)
```

## Background overrides

`VBackground` is the shared primitive for local background overrides. It
supports a solid color or a gradient. Prefer theme/component tokens and
`VAppearanceScope` for reusable styling; use `background` or
`surfaceBackground` only as a one-off escape hatch for container, page, and
overlay surfaces.

Current direct background overrides are limited to `VSurface`, `VScaffold`,
`VToast`, `VDialog`, `VSheet`, and `VPopover`. Strong stateful
controls such as `VButton`, `VTextField`, `VSelect`, `VTable`, `VDatePicker`,
and `VTimePicker` intentionally do not expose direct background props; their
visual states should stay grouped in component tokens.

```dart
final theme = VTheme.of(context);

VSurface(
  background: VBackground.color(theme.colors.surfaceElevated),
  child: const VText('One-off color'),
)

VSurface(
  background: VBackground.gradient(
    LinearGradient(
      colors: [theme.colors.actionPrimary, theme.colors.surfaceElevated],
    ),
  ),
  child: const VText('One-off gradient'),
)

VScaffold(
  background: VBackground.gradient(
    LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [theme.colors.background, theme.colors.surfaceElevated],
    ),
  ),
  body: const VText('Page content'),
)
```

## Getting started

```dart
import 'package:vidraui/vidraui.dart';

void main() {
  runApp(
    VidraApp.navigator(
      title: 'My App',
      theme: VThemeData.light(),
      darkTheme: VThemeData.dark(),
      home: const MyHomePage(),
    ),
  );
}
```

See `example/` for the complete docs/demo site.

## Current Status

**Version**: 0.0.1 (Pre-release)  
**Flutter**: >=3.27.0  
**Dart**: ^3.6.0

VidraUI is feature-complete and production-ready for evaluation. The library is currently in pre-release (0.0.1) as we gather feedback and finalize the public API before 1.0.

### What's Working
✅ All 129 widgets implemented and tested  
✅ Complete theme system with animation support  
✅ Full accessibility compliance  
✅ Zero Material/Cupertino dependencies  
✅ Documentation site with live examples  
✅ Code generation pipeline  
✅ Comprehensive test suite

### Pre-1.0 Work
- API stabilization based on community feedback
- Additional golden test coverage
- Performance profiling and optimization
- Migration guide from Material/Cupertino
- Publishing to pub.dev

### Roadmap
- Additional animation presets and effects
- Advanced data table features (cell editing, filtering, pagination)
- Chart and visualization widgets
- Drag-and-drop utilities
- Advanced gesture recognizers
- Performance monitoring tools
- Figma token sync (optional plugin)

## Contributing

Contributions are welcome! See [CONTRIBUTING.md](CONTRIBUTING.md) for the full
guide. In short:
1. No Material/Cupertino imports in `lib/`
2. Respect the `widgets → theme → foundation` dependency direction
3. Add tests (and a demo) for new widgets
4. Update documentation and examples
5. Run `dart run scripts/verify.dart` before submitting a PR

## License

See `LICENSE` file for details.

