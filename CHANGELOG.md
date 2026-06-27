# Changelog

All notable changes to VidraUI are documented here. The format follows
[Keep a Changelog](https://keepachangelog.com/en/1.1.0/) and this project
adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.0.1] - 2026-06-27

Initial pre-release. The public API is not yet stable; breaking changes may
land in any `0.0.x` release until `1.0.0`.

### Added
- `WidgetsApp`-based app shell (`VidraApp`) with pluggable routing adapters
  (`VRouteAdapter`) for Navigator 1.0 and Router 2.0, plus custom page
  transitions.
- Design token system: primitive → semantic → component, with code generation
  for 7 foundation token classes and 27 component token classes.
- Theme infrastructure: `VThemeData` with `copyWith`/`lerp`, `VAnimatedTheme`,
  scoped overrides (`VTheme.override`, `VTokenTheme<T>`, typed component theme
  wrappers).
- Overlay system: toast, dialog, sheet, popover, tooltip, teaching tip, and
  context menu via `VOverlayHost`.
- Widget library across layout, forms, buttons, data display, navigation,
  animation, media, feedback, selection, scrolling, and interaction categories.
- Appearance system (`VAppearance` / `VAppearanceScope`) and tokenized motion
  (`VMotionSpec` / `VMotionScope`).
- Example app doubling as the interactive documentation site.

### Notes
- Zero Material/Cupertino imports in `lib/` (enforced by
  `test/architecture_guard_test.dart`).

[Unreleased]: https://github.com/heyvidra/VidraUI/compare/v0.0.1...HEAD
[0.0.1]: https://github.com/heyvidra/VidraUI/releases/tag/v0.0.1
