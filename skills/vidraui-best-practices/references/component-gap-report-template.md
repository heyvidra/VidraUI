# VidraUI Component Gap Report Template

Copy this template when a VidraUI component cannot meet a real UI requirement. Save the filled report in the **consumer app** at:

```txt
docs/vidraui-gaps/<YYYY-MM-DD>-<short-slug>.md
```

Use kebab-case for `<short-slug>` (e.g. `smart-home-device-tree`, `table-inline-edit`).

If the gap was found while changing VidraUI itself, also add a one-line pointer in the PR or commit message linking to the report.

---

## Report: <title>

| Field | Value |
| --- | --- |
| Date | YYYY-MM-DD |
| App / feature | e.g. `ui/desktop` — Smart home device list |
| Reporter | agent or human handle |
| Severity | `blocker` \| `major` \| `minor` |
| VidraUI version | from `pubspec.lock` or git ref |

### 1. UI need

What the screen or interaction must do, in product terms (1–3 sentences).

### 2. VidraUI options considered

List widgets/APIs you tried or evaluated:

| Candidate | Why not sufficient |
| --- | --- |
| e.g. `VTable` | … |
| e.g. `VMenuAnchor` | … |

### 3. Gap summary

Concrete limitations (check all that apply and explain):

- [ ] Missing widget or variant
- [ ] API too narrow (props, callbacks, composition)
- [ ] Token / theme cannot express required visual state
- [ ] Accessibility or keyboard behavior insufficient
- [ ] Performance / scale (large lists, virtualization, etc.)
- [ ] Maturity too low for this production path (Beta/Experimental)
- [ ] Platform or desktop-specific behavior (window chrome, drag-drop, etc.)
- [ ] Other: …

### 4. Current workaround

What ships today without VidraUI (or with a partial VidraUI + custom glue):

```dart
// Minimal excerpt — no Material/Cupertino unless explicitly approved
```

- Files touched:
- Constraints still respected? (no `material.dart` / `cupertino.dart` in `lib/` unless approved)

### 5. Risks of the workaround

- Maintenance, a11y regressions, theme drift, duplicate patterns, etc.

### 6. Recommendations for VidraUI

Actionable upgrade proposals for maintainers:

**Suggested API (sketch)**

```dart
// e.g. new props, new widget, or extension to existing component
```

**Token / theme**

- New or extended component tokens? Which semantic roles?

**Docs & examples**

- What to add to `example/lib/main.dart` and docs catalog?

**Tests**

- Widget tests, a11y checks, goldens?

**Maturity target**

- Promote existing widget to Stable vs. new Experimental widget?

### 7. Acceptance criteria

How we know VidraUI support is “done” for this need:

1. …
2. …

### 8. References

- App code: `path/to/file.dart:line`
- VidraUI source: `lib/src/widgets/...`
- Screenshots / recordings (optional)
- Related issues or PRs (if any)
