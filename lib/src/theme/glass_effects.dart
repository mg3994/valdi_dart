import '../component/valdi_component.dart';
import '../component/flutter_widgets.dart';
import 'material.dart';
import '../layout/yoga_node.dart';
import '../layout/yoga_style.dart';

/// Fluid Glass Merge Effect combining adjacent LiquidGlass components (DartNative Liquid Glass tutorial).
class LiquidGlassMerge extends ValdiComponent {
  final List<LiquidGlass> glassNodes;

  LiquidGlassMerge({
    super.key,
    required this.glassNodes,
    YogaStyle? style,
  }) : super(style: style);

  @override
  ValdiComponent build() {
    return Column(
      style: style,
      children: glassNodes,
    );
  }

  @override
  YogaNode toYogaNode() => build().toYogaNode();
}

/// iOS 26 Clear Large Title Navigation Bar widget placed over LiquidGlass.
class ClearTitleBar extends ValdiComponent {
  final String title;
  final ValdiComponent? leading;
  final List<ValdiComponent> actions;

  ClearTitleBar({
    super.key,
    required this.title,
    this.leading,
    this.actions = const [],
    YogaStyle? style,
  }) : super(style: style);

  @override
  ValdiComponent build() {
    return Container(
      padding: const EdgeValues.symmetric(horizontal: 16, vertical: 12),
      color: '#00000000', // Clear background
      child: Row(
        children: [
          if (leading != null) leading!,
          Expanded(
            child: Text(
              title,
              fontSize: 28,
              fontWeight: 'bold',
            ),
          ),
          ...actions,
        ],
      ),
    );
  }

  @override
  YogaNode toYogaNode() => build().toYogaNode();
}
