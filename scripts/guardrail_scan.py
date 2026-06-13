#!/usr/bin/env python3
"""VidraUI guardrail scanner.

Run from a VidraUI repository root:
  python3 scripts/guardrail_scan.py --root .

This script is intentionally lightweight and dependency-free. It checks for
forbidden Flutter imports/APIs and obvious layer dependency violations.
"""

from __future__ import annotations

import argparse
import re
import sys
from dataclasses import dataclass
from pathlib import Path

FORBIDDEN_IMPORT_PATTERNS = [
    re.compile(r"package:flutter/material\.dart"),
    re.compile(r"package:flutter/cupertino\.dart"),
]

FORBIDDEN_API_PATTERNS = [
    "MaterialApp",
    "CupertinoApp",
    "MaterialPageRoute",
    "CupertinoPageRoute",
    "ScaffoldMessenger",
    "showDialog",
    "SnackBar",
    "InkWell",
    "ThemeData",
    "ElevatedButton",
    "TextButton",
    "OutlinedButton",
    "BottomSheet",
]

# Names that can produce false positives but should still be reviewed carefully.
REVIEW_API_PATTERNS = [
    "Scaffold",
    "AppBar",
    "TextField",
]

LAYER_DIRS = {
    "foundation": Path("lib/src/foundation"),
    "theme": Path("lib/src/theme"),
    "app": Path("lib/src/app"),
    "widgets": Path("lib/src/widgets"),
}

IMPORT_RE = re.compile(r"^\s*import\s+['\"]([^'\"]+)['\"]", re.MULTILINE)


@dataclass(frozen=True)
class Finding:
    level: str
    file: Path
    line: int
    message: str


def iter_dart_files(root: Path) -> list[Path]:
    lib = root / "lib"
    if not lib.exists():
        return []
    return sorted(p for p in lib.rglob("*.dart") if p.is_file())


def line_number(text: str, offset: int) -> int:
    return text.count("\n", 0, offset) + 1


def scan_forbidden(root: Path, files: list[Path]) -> list[Finding]:
    findings: list[Finding] = []
    for path in files:
        text = path.read_text(encoding="utf-8", errors="replace")
        rel = path.relative_to(root)
        for pattern in FORBIDDEN_IMPORT_PATTERNS:
            for match in pattern.finditer(text):
                findings.append(Finding("ERROR", rel, line_number(text, match.start()), f"forbidden import: {match.group(0)}"))
        for name in FORBIDDEN_API_PATTERNS:
            for match in re.finditer(rf"\b{re.escape(name)}\b", text):
                findings.append(Finding("ERROR", rel, line_number(text, match.start()), f"forbidden API: {name}"))
        for name in REVIEW_API_PATTERNS:
            for match in re.finditer(rf"\b{re.escape(name)}\b", text):
                findings.append(Finding("WARN", rel, line_number(text, match.start()), f"review possible forbidden API: {name}"))
    return findings


def layer_for(path: Path, root: Path) -> str | None:
    try:
        rel = path.relative_to(root)
    except ValueError:
        return None
    for layer, layer_path in LAYER_DIRS.items():
        try:
            rel.relative_to(layer_path)
            return layer
        except ValueError:
            continue
    return None


def imported_layer(import_target: str) -> str | None:
    normalized = import_target.replace("\\", "/")
    if normalized.startswith("package:vidraui/src/"):
        parts = normalized.split("/")
        if len(parts) >= 3:
            return parts[2]
    if normalized.startswith("../") or normalized.startswith("./"):
        # Relative imports are resolved in scan_layers.
        return None
    return None


def resolve_relative_import(path: Path, import_target: str) -> Path | None:
    if not (import_target.startswith(".") or import_target.startswith("..")):
        return None
    candidate = (path.parent / import_target).resolve()
    if candidate.suffix != ".dart":
        candidate = candidate.with_suffix(".dart")
    return candidate


def scan_layers(root: Path, files: list[Path]) -> list[Finding]:
    findings: list[Finding] = []
    allowed = {
        "foundation": {"foundation"},
        "theme": {"foundation", "theme"},
        "app": {"foundation", "theme", "app"},
        "widgets": {"foundation", "theme", "widgets"},
    }
    root_resolved = root.resolve()

    for path in files:
        source_layer = layer_for(path, root)
        if source_layer is None:
            continue
        text = path.read_text(encoding="utf-8", errors="replace")
        for match in IMPORT_RE.finditer(text):
            target = match.group(1)
            target_layer = imported_layer(target)
            if target_layer is None:
                resolved = resolve_relative_import(path.resolve(), target)
                if resolved is not None:
                    try:
                        target_layer = layer_for(resolved.relative_to(root_resolved), Path("."))
                    except ValueError:
                        target_layer = None
            if target_layer and target_layer not in allowed[source_layer]:
                findings.append(
                    Finding(
                        "ERROR",
                        path.relative_to(root),
                        line_number(text, match.start()),
                        f"layer violation: {source_layer} must not import {target_layer} ({target})",
                    )
                )
    return findings


def scan_exports(root: Path) -> list[Finding]:
    findings: list[Finding] = []
    widgets_barrel = root / "lib/src/widgets/widgets.dart"
    if widgets_barrel.exists():
        text = widgets_barrel.read_text(encoding="utf-8", errors="replace")
        for match in re.finditer(r"v_interactive\.dart", text):
            findings.append(Finding("ERROR", widgets_barrel.relative_to(root), line_number(text, match.start()), "VInteractive must not be exported"))
    return findings


def scan_token_violations(root: Path, files: list[Path]) -> list[Finding]:
    """Warn on hard-coded visual values that should use theme/tokens."""
    findings: list[Finding] = []
    skip_patterns = [
        re.compile(r"primitive_tokens\.dart"),
        re.compile(r"semantic_tokens\.dart"),
        re.compile(r"component_tokens\.dart"),
        re.compile(r"v_appearance\.dart"),
    ]
    # Hard-coded colors (exclude transparent, white, black)
    color_re = re.compile(
        r"\bconst\s+Color\(\s*0x(?!0{8}|f{8}|00000000)[0-9a-fA-F]{8}\s*\)"
        r"|\bColor\(\s*0x(?!0{8}|f{8}|00000000)[0-9a-fA-F]{8}\s*\)"
    )
    # Raw EdgeInsets with literal numbers
    insets_re = re.compile(
        r"EdgeInsets\.(all|symmetric|only)\(\s*[^)]*?\b\d+\b"
    )
    # Raw BorderRadius with literal numbers
    radius_re = re.compile(
        r"BorderRadius\.circular\(\s*\d+\s*\)|Radius\.circular\(\s*\d+\s*\)"
    )
    # Raw Duration with literal milliseconds
    duration_re = re.compile(
        r"Duration\(\s*milliseconds:\s*\d+\s*\)"
        r"|Duration\(\s*seconds:\s*\d+\s*\)"
    )

    for path in files:
        rel = path.relative_to(root)
        rel_str = str(rel)
        # Only scan widgets and app layers
        if not (rel_str.startswith("lib/src/widgets") or rel_str.startswith("lib/src/app")):
            continue
        # Skip token/theme files
        if any(p.search(rel_str) for p in skip_patterns):
            continue
        # Skip test files
        if "test/" in rel_str:
            continue

        text = path.read_text(encoding="utf-8", errors="replace")

        for match in color_re.finditer(text):
            findings.append(
                Finding("WARN", rel, line_number(text, match.start()),
                        f"hard-coded color: {match.group(0).strip()}")
            )
        for match in insets_re.finditer(text):
            findings.append(
                Finding("WARN", rel, line_number(text, match.start()),
                        f"raw EdgeInsets (consider VSpacing): {match.group(0).strip()}...")
            )
        for match in radius_re.finditer(text):
            findings.append(
                Finding("WARN", rel, line_number(text, match.start()),
                        f"raw radius (consider VRadii): {match.group(0).strip()}")
            )
        for match in duration_re.finditer(text):
            findings.append(
                Finding("WARN", rel, line_number(text, match.start()),
                        f"raw duration (consider VMotion): {match.group(0).strip()}")
            )
    return findings


def main() -> int:
    parser = argparse.ArgumentParser(description="Scan VidraUI guardrails.")
    parser.add_argument("--root", default=".", help="Repository root to scan")
    parser.add_argument("--strict-warnings", action="store_true", help="Treat warnings as errors")
    args = parser.parse_args()

    root = Path(args.root).resolve()
    files = iter_dart_files(root)
    findings = []
    findings.extend(scan_forbidden(root, files))
    findings.extend(scan_layers(root, files))
    findings.extend(scan_exports(root))
    findings.extend(scan_token_violations(root, files))

    errors = [f for f in findings if f.level == "ERROR"]
    warnings = [f for f in findings if f.level == "WARN"]

    for finding in findings:
        print(f"{finding.level}: {finding.file}:{finding.line}: {finding.message}")

    print(f"Scanned {len(files)} Dart files: {len(errors)} error(s), {len(warnings)} warning(s).")

    if errors or (args.strict_warnings and warnings):
        return 1
    return 0


if __name__ == "__main__":
    sys.exit(main())
