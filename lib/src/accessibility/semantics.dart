import '../component/valdi_component.dart';
import '../layout/yoga_node.dart';
import '../layout/yoga_style.dart';

/// Semantic node representation for VoiceOver / TalkBack accessibility services.
class SemanticNode {
  final String? label;
  final String? hint;
  final bool isButton;

  SemanticNode({
    this.label,
    this.hint,
    this.isButton = false,
  });
}

/// Semantics Widget wrapping child and producing accessibility nodes.
class Semantics extends ValdiComponent {
  final String? label;
  final String? hint;
  final bool button;
  final ValdiComponent child;

  Semantics({
    super.key,
    this.label,
    this.hint,
    this.button = false,
    required this.child,
    YogaStyle? style,
  }) : super(style: style);

  @override
  ValdiComponent build() => child;

  @override
  YogaNode toYogaNode() {
    final node = YogaNode(style: style);
    node.addChild(child.toYogaNode());
    return node;
  }
}
