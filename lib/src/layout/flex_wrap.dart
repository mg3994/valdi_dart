import '../component/valdi_component.dart';
import 'yoga_node.dart';
import 'yoga_style.dart';

/// Wrap Widget supporting multi-line flexbox wrapping.
class Wrap extends ValdiComponent {
  final List<ValdiComponent> children;
  final FlexDirection direction;
  final JustifyContent alignment;

  Wrap({
    super.key,
    required this.children,
    this.direction = FlexDirection.row,
    this.alignment = JustifyContent.flexStart,
    YogaStyle? style,
  }) : super(
          style: (style ?? YogaStyle())
            ..flexDirection = direction
            ..justifyContent = alignment
            ..flexWrap = FlexWrap.wrap,
        );

  @override
  ValdiComponent build() => this;

  @override
  YogaNode toYogaNode() {
    final node = YogaNode(style: style);
    for (final child in children) {
      node.addChild(child.toYogaNode());
    }
    return node;
  }
}
