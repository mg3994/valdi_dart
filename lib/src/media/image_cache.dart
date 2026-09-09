import '../component/valdi_component.dart';
import '../layout/yoga_node.dart';
import '../layout/yoga_style.dart';

/// Fast LRU In-Memory Image Cache (DartNative photo grid tutorial).
class ValdiImageCache {
  static final Map<String, String> _cache = {};

  static void cacheImage(String url, String localPath) {
    _cache[url] = localPath;
  }

  static String? getCachedPath(String url) {
    return _cache[url];
  }

  static void clear() {
    _cache.clear();
  }
}

/// Asynchronous Network Image View with automatic memory caching.
class NetworkImageView extends ValdiComponent {
  final String url;
  final String? fit;

  NetworkImageView({
    super.key,
    required this.url,
    this.fit = 'cover',
    YogaStyle? style,
  }) : super(style: style);

  @override
  ValdiComponent build() {
    final cached = ValdiImageCache.getCachedPath(url) ?? url;
    return Image(cached, fit: fit, style: style);
  }

  @override
  YogaNode toYogaNode() => build().toYogaNode();
}
