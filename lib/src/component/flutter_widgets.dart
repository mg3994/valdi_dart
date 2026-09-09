import 'valdi_component.dart';
import '../layout/yoga_node.dart';
import '../layout/yoga_style.dart';

/// Row Widget layout laying out children horizontally.
class Row extends ValdiComponent {
  final List<ValdiComponent> children;
  final JustifyContent justifyContent;
  final AlignItems alignItems;

  Row({
    super.key,
    this.children = const [],
    this.justifyContent = JustifyContent.flexStart,
    this.alignItems = AlignItems.center,
    YogaStyle? style,
  }) : super(
          style: (style ?? YogaStyle())..flexDirection = FlexDirection.row
          ..justifyContent = justifyContent
          ..alignItems = alignItems,
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

/// Column Widget layout laying out children vertically.
class Column extends ValdiComponent {
  final List<ValdiComponent> children;
  final JustifyContent justifyContent;
  final AlignItems alignItems;

  Column({
    super.key,
    this.children = const [],
    this.justifyContent = JustifyContent.flexStart,
    this.alignItems = AlignItems.stretch,
    YogaStyle? style,
  }) : super(
          style: (style ?? YogaStyle())..flexDirection = FlexDirection.column
          ..justifyContent = justifyContent
          ..alignItems = alignItems,
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

/// Stack Widget for overlapping children positioning.
class Stack extends ValdiComponent {
  final List<ValdiComponent> children;

  Stack({
    super.key,
    this.children = const [],
    YogaStyle? style,
  }) : super(style: style);

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

/// Positioned Widget for absolute child positioning inside Stack.
class Positioned extends ValdiComponent {
  final ValdiComponent child;
  final double? left;
  final double? top;
  final double? right;
  final double? bottom;
  final double? width;
  final double? height;

  Positioned({
    super.key,
    required this.child,
    this.left,
    this.top,
    this.right,
    this.bottom,
    this.width,
    this.height,
  }) : super(
          style: YogaStyle(
            positionType: PositionType.absolute,
            width: width,
            height: height,
            position: EdgeValues(
              left: left ?? 0.0,
              top: top ?? 0.0,
              right: right ?? 0.0,
              bottom: bottom ?? 0.0,
            ),
          ),
        );

  @override
  ValdiComponent build() => child;

  @override
  YogaNode toYogaNode() {
    final node = YogaNode(style: style);
    node.addChild(child.toYogaNode());
    return node;
  }
}

/// Expanded Widget to flex-grow child in Row or Column.
class Expanded extends ValdiComponent {
  final ValdiComponent child;
  final int flex;

  Expanded({
    super.key,
    required this.child,
    this.flex = 1,
  }) : super(style: YogaStyle(flexGrow: flex.toDouble()));

  @override
  ValdiComponent build() => child;

  @override
  YogaNode toYogaNode() {
    final node = YogaNode(style: style);
    node.addChild(child.toYogaNode());
    return node;
  }
}

/// SizedBox Widget for fixed size bounds or whitespace gaps.
class SizedBox extends ValdiComponent {
  final double? width;
  final double? height;
  final ValdiComponent? child;

  SizedBox({
    super.key,
    this.width,
    this.height,
    this.child,
  }) : super(style: YogaStyle(width: width, height: height));

  @override
  ValdiComponent build() => child ?? View();

  @override
  YogaNode toYogaNode() {
    final node = YogaNode(style: style);
    if (child != null) {
      node.addChild(child!.toYogaNode());
    }
    return node;
  }
}

/// Container Widget combining layout, padding, margin, and decoration background.
class Container extends ValdiComponent {
  final ValdiComponent? child;
  final double? width;
  final double? height;
  final EdgeValues padding;
  final EdgeValues margin;
  final String? color;

  Container({
    super.key,
    this.child,
    this.width,
    this.height,
    this.padding = const EdgeValues(),
    this.margin = const EdgeValues(),
    this.color,
  }) : super(
          style: YogaStyle(
            width: width,
            height: height,
            padding: padding,
            margin: margin,
          ),
        );

  @override
  ValdiComponent build() {
    return View(
      style: style,
      backgroundColor: color,
      children: child != null ? [child!] : [],
    );
  }

  @override
  YogaNode toYogaNode() => build().toYogaNode();
}

/// Padding Widget adding padding around child.
class Padding extends ValdiComponent {
  final EdgeValues padding;
  final ValdiComponent child;

  Padding({
    super.key,
    required this.padding,
    required this.child,
  }) : super(style: YogaStyle(padding: padding));

  @override
  ValdiComponent build() => child;

  @override
  YogaNode toYogaNode() {
    final node = YogaNode(style: style);
    node.addChild(child.toYogaNode());
    return node;
  }
}
