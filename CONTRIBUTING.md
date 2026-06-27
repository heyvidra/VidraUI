# Contributing to VidraUI

Thanks for your interest in VidraUI. This guide covers the rules that keep the
library framework-native and internally consistent. They are enforced by tests
and CI, so following them up front saves a review round-trip.

## Before you start

```bash
flutter pub get
dart run scripts/verify.dart   # analyze + test + docs/API checks; must pass
```

`verify.dart` runs the same gate CI runs: `flutter analyze`, `flutter test`,
the example app analyze, docs-coverage, and the public-API inventory diff.

## Hard constraints

These are non-negotiable and checked automatically:

1. **No Material or Cupertino.** Never import `package:flutter/material.dart` or
   `package:flutter/cupertino.dart` anywhere under `lib/`. If a symbol is only
   reachable through those libraries, don't use it. Enforced by
   `test/architecture_guard_test.dart`.

   Allowed Flutter imports: `dart:async`, `dart:ui`, and
   `package:flutter/{foundation,gestures,painting,rendering,services,widgets}.dart`.

2. **Dependency direction is one-way.** `widgets → theme → foundation` and
   `app → theme → foundation`. `foundation` depends on nothing else;
   `theme` must not import from `widgets/` or `app/`. No circular imports.

3. **Token flow.** Styling flows primitive → semantic → component → widget.
   Don't hardcode colors, sizes, or radii in widgets — derive them from tokens.

4. **`V` prefix** on every public class (`VButton`, `VThemeData`, …).

5. **Public API is curated.** Changing the exported surface trips the API
   inventory check. If the change is intentional, regenerate the inventory
   (`dart run scripts/generate_api_inventory.dart`) and include it in your PR.

## Adding a new widget

Every new public widget needs three things in the same PR:

1. **Implementation** under the right `lib/src/widgets/<category>/` folder,
   token-driven and accessible (semantics, keyboard, focus).
2. **Tests** — widget tests, plus golden and/or accessibility tests where it
   makes sense.
3. **An example demo** in `example/lib/src/demos/` wired into the docs shell.

Token-backed components also need their component token class and (if scoped
overrides apply) a generated component theme wrapper — see the generators in
`scripts/`.

## Pull requests

- Keep changes focused; one logical change per PR.
- Run `dart run scripts/verify.dart` and make sure it's green before opening.
- Update docs/examples for any user-facing change.
- Describe what changed and why; link any related issue.

## Reporting bugs

Open an issue at https://github.com/heyvidra/VidraUI/issues with a minimal
repro, expected vs. actual behavior, and your Flutter/Dart versions
(`flutter --version`).
