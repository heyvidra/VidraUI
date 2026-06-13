import 'dart:io';

/// Extracts the constructor argument lines from formatted source code and
/// compares them between the hand-written and generated files.
void main() {
  final hw = File('lib/src/theme/component_tokens/v_component_tokens.dart')
      .readAsStringSync();
  final gen = File('lib/src/theme/component_tokens/v_component_tokens.g.dart')
      .readAsStringSync();

  // Extract argument lists from inside VComponentTokens(...) for each method
  _compareMethod(hw, gen, 'fromColors', 'factory VComponentTokens.fromColors');
  _compareMethod(hw, gen, 'lerp', 'static VComponentTokens lerp');
  _compareCopyWith(hw, gen);

  stdout.writeln('\nAll three method bodies match semantically.');
}

/// Extracts the key-value lines inside the VComponentTokens(...) call from
/// both files, normalizes whitespace, and compares.
void _compareMethod(
  String hw,
  String gen,
  String name,
  String hwPattern,
) {
  // Find the "VComponentTokens(" call inside the method
  final hwLines = _extractArgList(hw, hwPattern);
  final genLines = _extractArgList(gen, '_\\\$$name');

  _assertEq(name, hwLines, genLines);
}

/// For copyWith, compare the body argument list.
/// Hand-written uses `this.${name}`, generated uses `self.${name}` —
/// normalize both to `this.${name}` before comparing.
void _compareCopyWith(String hw, String gen) {
  // Find the "return VComponentTokens(" after copyWith signature
  final hwSig = RegExp('VComponentTokens copyWith').firstMatch(hw);
  final genSig = RegExp('_\\\$copyWith').firstMatch(gen);

  final hwBodyStart = hw.indexOf('return VComponentTokens(', hwSig!.end);
  final genBodyStart = gen.indexOf('return VComponentTokens(', genSig!.end);

  var hwLines = _linesBetween(hw, hwBodyStart);
  var genLines = _linesBetween(gen, genBodyStart);

  // Normalize: hand-written uses `this.`, generated uses `self.`
  genLines = genLines.map((l) => l.replaceFirst('self.', 'this.')).toList();

  _assertEq('copyWith', hwLines, genLines);
}

List<String> _extractArgList(String src, String pattern) {
  final match = RegExp(pattern).firstMatch(src);
  if (match == null) {
    stderr.writeln('ERROR: pattern "$pattern" not found');
    exit(1);
  }
  // Find the FIRST "VComponentTokens(" after the match position
  const vct = 'VComponentTokens(';
  final idx = src.indexOf(vct, match.end);
  if (idx < 0) {
    stderr.writeln('ERROR: no VComponentTokens( found after "$pattern"');
    exit(1);
  }
  return _linesBetween(src, idx);
}

/// From the position of "VComponentTokens(", extract the lines inside the
/// parentheses (the key-value argument pairs).
List<String> _linesBetween(String src, int vctPos) {
  // Find opening paren
  final openIdx = src.indexOf('(', vctPos);
  // Find matching closing paren
  var depth = 0;
  var i = openIdx;
  while (i < src.length) {
    if (src[i] == '(') depth++;
    if (src[i] == ')') depth--;
    if (depth == 0) break;
    i++;
  }
  if (depth != 0) {
    stderr.writeln('ERROR: unmatched parens at offset $vctPos');
    exit(1);
  }
  // Skip past ");"
  i++; // ')'
  if (i < src.length && src[i] == ';') i++;
  if (i < src.length && src[i] == '\n') i++;

  final body = src.substring(openIdx, i);
  // Split into lines, trim, filter empty
  return body
      .split('\n')
      .map((l) => l.trim())
      .where((l) => l.isNotEmpty)
      .toList();
}

void _assertEq(String name, List<String> hwLines, List<String> genLines) {
  if (hwLines.length != genLines.length) {
    stderr.writeln(
      '$name: line count mismatch (hw=${hwLines.length} gen=${genLines.length})',
    );
    _printDiff(hwLines, genLines);
    exit(1);
  }
  for (var i = 0; i < hwLines.length; i++) {
    if (hwLines[i] != genLines[i]) {
      stderr.writeln('$name: line ${i + 1} differs:');
      stderr.writeln('  HW: ${hwLines[i]}');
      stderr.writeln('  GN: ${genLines[i]}');
      exit(1);
    }
  }
  stdout.writeln('$name: OK (${hwLines.length} lines match)');
}

void _printDiff(List<String> hw, List<String> gen) {
  final maxLen = hw.length > gen.length ? hw.length : gen.length;
  for (var i = 0; i < maxLen; i++) {
    final h = i < hw.length ? hw[i] : '(missing)';
    final g = i < gen.length ? gen[i] : '(missing)';
    final mark = h == g ? ' ' : 'X';
    stdout.writeln('  $mark HW: $h');
    stdout.writeln('  $mark GN: $g');
  }
}
