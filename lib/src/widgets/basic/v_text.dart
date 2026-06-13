import 'package:flutter/widgets.dart';

import '../../theme/v_theme.dart';
import '../../theme/v_theme_data.dart';

/// Variants for [VText].
enum VTextVariant {
  heading,
  title,
  subtitle,
  body,
  label,
  caption,
}

/// Resolves the [TextStyle] for [variant] from [theme]'s typography.
///
/// Shared between [VText] and [VAnimatedText] so new variants only need
/// to be added in one place.
TextStyle resolveVariantStyle(VThemeData theme, VTextVariant variant) =>
    switch (variant) {
      VTextVariant.heading => theme.typography.heading,
      VTextVariant.title => theme.typography.title,
      VTextVariant.subtitle => theme.typography.subtitle,
      VTextVariant.body => theme.typography.body,
      VTextVariant.label => theme.typography.label,
      VTextVariant.caption => theme.typography.caption,
    };

/// A themed text widget.
///
/// Selects a [TextStyle] from the current [VTypography] based on [variant].
/// Applies [style] as a one-off override on top of the selected variant.
/// Supports all standard [Text] properties via passthrough.
class VText extends StatelessWidget {
  const VText(
    this.data, {
    super.key,
    this.variant = VTextVariant.body,
    this.color,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap = true,
  });

  final String data;
  final VTextVariant variant;
  final Color? color;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool softWrap;

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);
    final baseStyle = resolveVariantStyle(theme, variant);

    var effectiveStyle =
        baseStyle.copyWith(color: theme.colors.text).merge(style);
    if (color != null) {
      effectiveStyle = effectiveStyle.copyWith(color: color);
    }

    Widget text = Text(
      data,
      style: effectiveStyle,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
    );

    if (variant == VTextVariant.heading || variant == VTextVariant.title) {
      text = Semantics(header: true, child: text);
    }

    return text;
  }
}
