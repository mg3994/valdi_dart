import '../component/valdi_component.dart';
import '../layout/yoga_node.dart';
import '../layout/yoga_style.dart';

class MaterialTheme {
  final String primaryColor;
  final String surfaceColor;
  final String onPrimaryColor;

  const MaterialTheme({
    this.primaryColor = '#6750A4',
    this.surfaceColor = '#FEF7FF',
    this.onPrimaryColor = '#FFFFFF',
  });
}

/// Liquid Glass Widget representing iOS / Material translucent blurred glass material (DartNative Liquid Glass tutorial).
class LiquidGlass extends ValdiComponent {
  final ValdiComponent child;
  final double blurRadius;
  final String tintColor;

  LiquidGlass({
    super.key,
    required this.child,
    this.blurRadius = 20.0,
    this.tintColor = '#ffffff33',
    YogaStyle? style,
  }) : super(style: style);

  @override
  ValdiComponent build() {
    return View(
      style: style,
      backgroundColor: tintColor,
      children: [child],
    );
  }

  @override
  YogaNode toYogaNode() => build().toYogaNode();
}

/// Material 3 Badge widget for tabs and actions.
class M3Badge extends ValdiComponent {
  final String? label;
  final ValdiComponent child;

  M3Badge({
    super.key,
    this.label,
    required this.child,
    YogaStyle? style,
  }) : super(style: style);

  @override
  ValdiComponent build() {
    return View(
      style: style,
      children: [
        child,
        if (label != null)
          Text(
            label!,
            fontSize: 10,
            color: '#B3261E',
          ),
      ],
    );
  }

  @override
  YogaNode toYogaNode() => build().toYogaNode();
}
