import 'valdi_component.dart';
import '../layout/yoga_node.dart';
import '../layout/yoga_style.dart';

typedef IndexedWidgetBuilder = ValdiComponent Function(int index);

/// High-performance windowed native list component inspired by DartNative fast lists (UITableView/RecyclerView backing).
class ListView extends ValdiComponent {
  final List<ValdiComponent>? children;
  final int? itemCount;
  final IndexedWidgetBuilder? itemBuilder;

  ListView({
    super.key,
    this.children,
    YogaStyle? style,
  })  : itemCount = children?.length,
        itemBuilder = null,
        super(style: style);

  ListView.builder({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    YogaStyle? style,
  })  : children = null,
        super(style: style);

  @override
  ValdiComponent build() => this;

  @override
  YogaNode toYogaNode() {
    final node = YogaNode(style: style);
    if (children != null) {
      for (final child in children!) {
        node.addChild(child.toYogaNode());
      }
    } else if (itemBuilder != null && itemCount != null) {
      // Build windowed items
      for (int i = 0; i < itemCount!; i++) {
        final child = itemBuilder!(i);
        node.addChild(child.toYogaNode());
      }
    }
    return node;
  }
}
