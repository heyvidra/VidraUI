# VidraUI docs/demo site

This Flutter app is the interactive VidraUI API/demo website. It demonstrates
public components and core APIs with live examples, extracted snippets, API
tables, and usage notes.

## Run locally

```bash
flutter run -d chrome
```

For a static web build:

```bash
flutter build web
```

## Update docs artifacts

Run these from the repository root after changing public APIs, docs snippets,
or the catalog:

```bash
dart run scripts/generate_api_inventory.dart
dart run scripts/extract_doc_snippets.dart
dart run scripts/check_docs_coverage.dart
```

Every new public widget should be added to `example/lib/docs/catalog.dart`, get
a reachable demo category in `example/lib/main.dart`, and include at least one
`docs-snippet` marker.

## Theme docs

Use `VTheme.override` examples for semantic token changes that should flow into
all component tokens. Use component wrappers such as `VButtonTheme.override` or
`VSelectTheme.override` when only one component family should change. Use
`VTokenTheme<T>` in docs only for advanced or new token-scope examples; named
component wrappers should be the default user-facing API.
