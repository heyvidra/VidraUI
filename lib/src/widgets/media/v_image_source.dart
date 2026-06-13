import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

/// An abstraction over image loading that resolves to a Flutter [ImageProvider].
///
/// Users may subclass [VImageSource] to implement custom caching, auth headers,
/// or CDN strategies without modifying VidraUI core.
///
/// Built-in sources:
/// - [VNetworkImageSource] — network URL, optional cache control
/// - [VAssetImageSource] — asset bundle image
/// - [VMemoryImageSource] — raw bytes in memory
abstract class VImageSource {
  const VImageSource();

  /// Returns a Flutter [ImageProvider] for this source.
  ///
  /// [context] is provided so implementations may read theme or inherited
  /// configuration if needed.
  ImageProvider<Object> resolve(BuildContext context);
}

// ---------------------------------------------------------------------------
// Built-in sources
// ---------------------------------------------------------------------------

/// Loads an image from a network URL.
///
/// When [cache] is true (default), the image is cached in Flutter's in-memory
/// [ImageCache]. [cacheKey] may be used to override the cache identity while
/// still loading from [url].
///
/// When [cache] is false, a unique cache key is used for each resolve and the
/// resolved image is evicted from Flutter's [ImageCache] after its first frame.
class VNetworkImageSource extends VImageSource {
  const VNetworkImageSource(
    this.url, {
    this.headers,
    this.cache = true,
    this.cacheKey,
  });

  /// The remote URL.
  final String url;

  /// Optional HTTP headers.
  final Map<String, String>? headers;

  /// Whether to use Flutter's default memory cache.
  final bool cache;

  /// Optional stable cache identity separate from [url].
  final String? cacheKey;

  @override
  ImageProvider<Object> resolve(BuildContext context) {
    final provider = NetworkImage(url, headers: headers);
    if (cache && cacheKey == null) return provider;

    return _VNetworkImageProvider(
      provider: provider,
      cache: cache,
      cacheKey: cacheKey ?? url,
      headers: headers,
    );
  }
}

class _VNetworkImageProvider extends ImageProvider<_VNetworkImageKey> {
  _VNetworkImageProvider({
    required this.provider,
    required this.cache,
    required this.cacheKey,
    required this.headers,
  }) : _nonce = cache ? null : Object();

  final NetworkImage provider;
  final bool cache;
  final String cacheKey;
  final Map<String, String>? headers;
  final Object? _nonce;

  @override
  Future<_VNetworkImageKey> obtainKey(ImageConfiguration configuration) {
    return SynchronousFuture<_VNetworkImageKey>(
      _VNetworkImageKey(
        provider: provider,
        cache: cache,
        cacheKey: cacheKey,
        headers: headers,
        nonce: _nonce,
      ),
    );
  }

  @override
  ImageStreamCompleter loadImage(
    _VNetworkImageKey key,
    ImageDecoderCallback decode,
  ) {
    final completer = key.provider.loadImage(key.provider, decode);
    if (!key.cache) {
      late final ImageStreamListener listener;
      listener = ImageStreamListener(
        (image, synchronousCall) {
          scheduleMicrotask(() {
            completer.removeListener(listener);
            PaintingBinding.instance.imageCache.evict(key);
          });
        },
        onError: (error, stackTrace) {
          scheduleMicrotask(() {
            completer.removeListener(listener);
            PaintingBinding.instance.imageCache.evict(key);
          });
        },
      );
      completer.addListener(listener);
    }
    return completer;
  }

  @override
  String toString() =>
      'VNetworkImage("$cacheKey", url: ${provider.url}, cache: $cache)';
}

@immutable
class _VNetworkImageKey {
  const _VNetworkImageKey({
    required this.provider,
    required this.cache,
    required this.cacheKey,
    required this.headers,
    required this.nonce,
  });

  final NetworkImage provider;
  final bool cache;
  final String cacheKey;
  final Map<String, String>? headers;
  final Object? nonce;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is _VNetworkImageKey &&
            other.cache == cache &&
            other.cacheKey == cacheKey &&
            other.provider.scale == provider.scale &&
            mapEquals(other.headers, headers) &&
            other.nonce == nonce;
  }

  @override
  int get hashCode => Object.hash(
      cache,
      cacheKey,
      provider.scale,
      _headersHash(headers),
      nonce,
    );

  static int _headersHash(Map<String, String>? headers) {
    if (headers == null || headers.isEmpty) return 0;
    final entries = headers.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));
    return Object.hashAll(
      entries.map((entry) => Object.hash(entry.key, entry.value)),
    );
  }
}

/// Loads an image from an asset bundle.
class VAssetImageSource extends VImageSource {
  const VAssetImageSource(
    this.name, {
    this.bundle,
    this.package,
  });

  final String name;
  final AssetBundle? bundle;
  final String? package;

  @override
  ImageProvider<Object> resolve(BuildContext context) {
    return AssetImage(name, bundle: bundle, package: package);
  }
}

/// Loads an image from raw bytes in memory.
class VMemoryImageSource extends VImageSource {
  const VMemoryImageSource(this.bytes);

  final Uint8List bytes;

  @override
  ImageProvider<Object> resolve(BuildContext context) {
    return MemoryImage(bytes);
  }
}
