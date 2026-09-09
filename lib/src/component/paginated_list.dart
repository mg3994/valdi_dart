import '../component/valdi_component.dart';
import '../component/builder.dart';
import '../component/list_view.dart';
import '../layout/yoga_node.dart';
import '../layout/yoga_style.dart';

typedef RefreshCallback = Future<void> Function();
typedef LoadMoreCallback = Future<void> Function();

/// Native Pull-To-Refresh Indicator widget container.
class RefreshIndicator extends ValdiComponent {
  final RefreshCallback onRefresh;
  final ValdiComponent child;

  RefreshIndicator({
    super.key,
    required this.onRefresh,
    required this.child,
    YogaStyle? style,
  }) : super(style: style);

  @override
  ValdiComponent build() => child;

  @override
  YogaNode toYogaNode() => child.toYogaNode();
}

/// Paginated Infinite List with native scroll load-more and pull-to-refresh (DartNative fast lists tutorial).
class PaginatedListView extends ValdiComponent {
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final LoadMoreCallback? onLoadMore;
  final RefreshCallback? onRefresh;

  PaginatedListView({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.onLoadMore,
    this.onRefresh,
    YogaStyle? style,
  }) : super(style: style);

  @override
  ValdiComponent build() {
    final listView = ListView.builder(
      itemCount: itemCount,
      itemBuilder: itemBuilder,
      style: style,
    );

    if (onRefresh != null) {
      return RefreshIndicator(
        onRefresh: onRefresh!,
        child: listView,
      );
    }

    return listView;
  }

  @override
  YogaNode toYogaNode() => build().toYogaNode();
}
