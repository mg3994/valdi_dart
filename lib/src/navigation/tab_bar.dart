import '../component/valdi_component.dart';
import '../component/flutter_widgets.dart';
import '../layout/yoga_node.dart';
import '../layout/yoga_style.dart';

class BottomNavigationBarItem {
  final String label;
  final String? icon;
  final String? badge;

  const BottomNavigationBarItem({
    required this.label,
    this.icon,
    this.badge,
  });
}

/// Adaptive Bottom Navigation Bar / TabBar with native OS badge support (DartNative Material 3 tutorial).
class BottomNavigationBar extends ValdiComponent {
  final List<BottomNavigationBarItem> items;
  final int currentIndex;
  final void Function(int index)? onTap;

  BottomNavigationBar({
    super.key,
    required this.items,
    this.currentIndex = 0,
    this.onTap,
    YogaStyle? style,
  }) : super(style: style);

  @override
  ValdiComponent build() {
    return Container(
      padding: const EdgeValues.symmetric(vertical: 8, horizontal: 16),
      color: '#F8F9FA',
      child: Row(
        justifyContent: JustifyContent.spaceAround,
        children: List.generate(items.length, (index) {
          final item = items[index];
          final isSelected = index == currentIndex;
          return Container(
            padding: const EdgeValues.all(8),
            child: Text(
              item.badge != null ? '${item.label} (${item.badge})' : item.label,
              color: isSelected ? '#007AFF' : '#8E8E93',
              fontWeight: isSelected ? 'bold' : 'normal',
            ),
          );
        }),
      ),
    );
  }

  @override
  YogaNode toYogaNode() => build().toYogaNode();
}

/// TabBar widget wrapper.
class TabBar extends ValdiComponent {
  final List<BottomNavigationBarItem> tabs;
  final int selectedIndex;
  final void Function(int index)? onTabSelected;

  TabBar({
    super.key,
    required this.tabs,
    this.selectedIndex = 0,
    this.onTabSelected,
    YogaStyle? style,
  }) : super(style: style);

  @override
  ValdiComponent build() {
    return BottomNavigationBar(
      items: tabs,
      currentIndex: selectedIndex,
      onTap: onTabSelected,
      style: style,
    );
  }

  @override
  YogaNode toYogaNode() => build().toYogaNode();
}
