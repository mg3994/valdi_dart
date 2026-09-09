import 'valdi_component.dart';
import 'builder.dart';
import '../layout/yoga_node.dart';
import '../layout/yoga_style.dart';

/// Masonry Grid View Component backed by UICollectionView / RecyclerView for infinite photo grids (DartNative photo grid tutorial).
class MasonryGridView extends ValdiComponent {
  final int crossAxisCount;
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;

  MasonryGridView({
    super.key,
    this.crossAxisCount = 2,
    required this.itemCount,
    required this.itemBuilder,
    YogaStyle? style,
  }) : super(style: style);

  @override
  ValdiComponent build() => this;

  @override
  YogaNode toYogaNode() {
    final node = YogaNode(style: style);
    for (int i = 0; i < itemCount; i++) {
      final child = itemBuilder(i);
      node.addChild(child.toYogaNode());
    }
    return node;
  }
}

/// Windowed Sliver List for virtualized scrolling.
class SliverList extends ValdiComponent {
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;

  SliverList({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    YogaStyle? style,
  }) : super(style: style);

  @override
  ValdiComponent build() => this;

  @override
  YogaNode toYogaNode() {
    final node = YogaNode(style: style);
    for (int i = 0; i < itemCount; i++) {
      final child = itemBuilder(i);
      node.addChild(child.toYogaNode());
    }
    return node;
  }
}
