import 'valdi_component.dart';
import 'flutter_widgets.dart';
import '../layout/yoga_node.dart';
import '../layout/yoga_style.dart';

/// Shimmer loading placeholder for infinite photo grid Masonry tiles (DartNative Photo Grid tutorial).
class ShimmerPlaceholder extends ValdiComponent {
  final double width;
  final double height;
  final String highlightColor;

  ShimmerPlaceholder({
    super.key,
    required this.width,
    required this.height,
    this.highlightColor = '#E0E0E0',
    YogaStyle? style,
  }) : super(
          style: (style ?? YogaStyle())
            ..width = width
            ..height = height,
        );

  @override
  ValdiComponent build() {
    return Container(
      width: width,
      height: height,
      color: highlightColor,
    );
  }

  @override
  YogaNode toYogaNode() => build().toYogaNode();
}

/// Shimmer Masonry Tile wrapper.
class ShimmerMasonryTile extends ValdiComponent {
  final bool isLoading;
  final ValdiComponent child;
  final double placeholderHeight;

  ShimmerMasonryTile({
    super.key,
    required this.isLoading,
    required this.child,
    this.placeholderHeight = 160.0,
  });

  @override
  ValdiComponent build() {
    if (isLoading) {
      return ShimmerPlaceholder(
        width: 150.0,
        height: placeholderHeight,
      );
    }
    return child;
  }

  @override
  YogaNode toYogaNode() => build().toYogaNode();
}
