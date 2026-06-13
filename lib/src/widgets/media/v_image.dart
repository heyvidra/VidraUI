import 'dart:typed_data';

import 'package:flutter/widgets.dart';

import '../../theme/v_theme.dart';
import 'v_image_source.dart';

/// A themed, accessible image widget with pluggable loading strategy.
///
/// Use [VImage] with a [VImageSource] for maximum flexibility, or the
/// convenience constructors [VImage.network], [VImage.asset], and
/// [VImage.memory].
///
/// Caching defaults to Flutter's built-in in-memory [ImageCache].
/// No disk cache is included. Users who need persistent caching should
/// implement a custom [VImageSource].
class VImage extends StatelessWidget {
  /// Creates an image from a [VImageSource].
  const VImage({
    super.key,
    required this.source,
    this.width,
    this.height,
    this.aspectRatio,
    this.fit = BoxFit.cover,
    this.alignment = Alignment.center,
    this.radius,
    this.semanticLabel,
    this.excludeFromSemantics = false,
    this.placeholder,
    this.errorBuilder,
    this.backgroundColor,
  });

  // ---------------------------------------------------------------
  // Convenience factories
  // ---------------------------------------------------------------

  /// Creates a network image with Flutter's default memory cache.
  ///
  /// ```dart
  /// VImage.network('https://example.com/photo.jpg', width: 200)
  /// ```
  factory VImage.network(
    String url, {
    Key? key,
    double? width,
    double? height,
    double? aspectRatio,
    BoxFit fit = BoxFit.cover,
    AlignmentGeometry alignment = Alignment.center,
    double? radius,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    Widget? placeholder,
    Widget Function(BuildContext, Object, StackTrace?)? errorBuilder,
    Color? backgroundColor,
    bool cache = true,
    String? cacheKey,
    Map<String, String>? headers,
  }) {
    return VImage(
      key: key,
      source: VNetworkImageSource(url,
          headers: headers, cache: cache, cacheKey: cacheKey),
      width: width,
      height: height,
      aspectRatio: aspectRatio,
      fit: fit,
      alignment: alignment,
      radius: radius,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      placeholder: placeholder,
      errorBuilder: errorBuilder,
      backgroundColor: backgroundColor,
    );
  }

  /// Creates an image from an asset bundle.
  factory VImage.asset(
    String name, {
    Key? key,
    double? width,
    double? height,
    double? aspectRatio,
    BoxFit fit = BoxFit.cover,
    AlignmentGeometry alignment = Alignment.center,
    double? radius,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    Widget? placeholder,
    Widget Function(BuildContext, Object, StackTrace?)? errorBuilder,
    Color? backgroundColor,
    AssetBundle? bundle,
    String? package,
  }) {
    return VImage(
      key: key,
      source: VAssetImageSource(name, bundle: bundle, package: package),
      width: width,
      height: height,
      aspectRatio: aspectRatio,
      fit: fit,
      alignment: alignment,
      radius: radius,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      placeholder: placeholder,
      errorBuilder: errorBuilder,
      backgroundColor: backgroundColor,
    );
  }

  /// Creates an image from raw bytes.
  factory VImage.memory(
    Uint8List bytes, {
    Key? key,
    double? width,
    double? height,
    double? aspectRatio,
    BoxFit fit = BoxFit.cover,
    AlignmentGeometry alignment = Alignment.center,
    double? radius,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    Widget? placeholder,
    Widget Function(BuildContext, Object, StackTrace?)? errorBuilder,
    Color? backgroundColor,
  }) {
    return VImage(
      key: key,
      source: VMemoryImageSource(bytes),
      width: width,
      height: height,
      aspectRatio: aspectRatio,
      fit: fit,
      alignment: alignment,
      radius: radius,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      placeholder: placeholder,
      errorBuilder: errorBuilder,
      backgroundColor: backgroundColor,
    );
  }

  // ---------------------------------------------------------------
  // Primary fields
  // ---------------------------------------------------------------

  /// The image source that resolves to a Flutter [ImageProvider].
  final VImageSource source;

  final double? width;
  final double? height;
  final double? aspectRatio;
  final BoxFit fit;
  final AlignmentGeometry alignment;
  final double? radius;
  final String? semanticLabel;
  final bool excludeFromSemantics;

  /// Shown while the image is loading.
  final Widget? placeholder;

  /// Called on load failure. Falls back to a themed error box if null.
  final Widget Function(BuildContext, Object, StackTrace?)? errorBuilder;

  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final theme = VTheme.of(context);
    final bg = backgroundColor ?? theme.colors.surfaceElevated;
    final provider = source.resolve(context);

    Widget result = Image(
      image: provider,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      errorBuilder: errorBuilder ??
          (context, error, stack) {
            return Container(
              color: bg,
              child: const Center(
                child: Text('⚠', style: TextStyle(fontSize: 24)),
              ),
            );
          },
      loadingBuilder: placeholder != null
          ? (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return placeholder!;
            }
          : null,
    );

    if (aspectRatio != null) {
      result = AspectRatio(aspectRatio: aspectRatio!, child: result);
    }

    if (radius != null && radius! > 0) {
      result = ClipRRect(
        borderRadius: BorderRadius.circular(radius!),
        child: result,
      );
    }

    if (bg != const Color(0x00000000)) {
      result = DecoratedBox(
        decoration: BoxDecoration(color: bg),
        child: result,
      );
    }

    return result;
  }
}

/// Optional helpers for precaching and evicting images.
///
/// Uses Flutter's built-in [ImageCache]. No disk or persistent cache.
class VImageCache {
  const VImageCache._();

  /// Pre-caches an image into Flutter's in-memory [ImageCache].
  ///
  /// Call in [State.didChangeDependencies] or before displaying an image
  /// that should appear instantly.
  static Future<void> precache(
    BuildContext context,
    VImageSource source,
  ) async {
    await precacheImage(source.resolve(context), context);
  }

  /// Attempts to evict an image from the in-memory [ImageCache].
  ///
  /// Returns true if the image was evicted, false if it wasn't found.
  static Future<bool> evict(BuildContext context, VImageSource source) async {
    return source.resolve(context).evict();
  }
}
