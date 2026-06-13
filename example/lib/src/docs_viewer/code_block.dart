part of '../../main.dart';

class _CodeBlock extends StatefulWidget {
  const _CodeBlock(this.snippet);

  final VDocCodeSnippet snippet;

  @override
  State<_CodeBlock> createState() => _CodeBlockState();
}

class _CodeBlockState extends State<_CodeBlock> {
  bool _copied = false;
  Timer? _resetTimer;

  @override
  void dispose() {
    _resetTimer?.cancel();
    super.dispose();
  }

  Future<void> _copyCode() async {
    await Clipboard.setData(ClipboardData(text: widget.snippet.source));
    _resetTimer?.cancel();
    if (!mounted) return;
    setState(() => _copied = true);
    _resetTimer = Timer(const Duration(seconds: 2), () {
      if (mounted) setState(() => _copied = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.colors.surfaceElevated,
        borderRadius: BorderRadius.circular(theme.radii.md),
        border: Border.all(color: theme.colors.border),
      ),
      child: SizedBox(
        width: double.infinity,
        child: VFlex.vertical(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                theme.spacing.md,
                theme.spacing.sm,
                theme.spacing.sm,
                0,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: VText(
                      widget.snippet.id,
                      variant: VTextVariant.caption,
                      color: theme.colors.textMuted,
                    ),
                  ),
                  VButton(
                    onPressed: _copyCode,
                    variant: VButtonVariant.secondary,
                    size: VControlSize.sm,
                    leadingIcon: VIcon(
                      _copied ? LucideIcons.check : LucideIcons.copy,
                      size: 14,
                    ),
                    semanticLabel: _copied ? 'Code copied' : 'Copy code',
                    child: VText(
                      _copied ? 'Copied' : 'Copy',
                      variant: VTextVariant.caption,
                    ),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.all(theme.spacing.md),
              child: Text(
                widget.snippet.source,
                style: theme.typography.caption.copyWith(
                  color: theme.colors.text,
                  fontFamily: 'monospace',
                  height: 1.45,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

