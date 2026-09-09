import '../layout/yoga_node.dart';
import '../layout/yoga_style.dart';

/// Base class for all declarative UI components in Valdi framework.
abstract class ValdiComponent {
  final String? key;
  final YogaStyle style;

  ValdiComponent({this.key, YogaStyle? style}) : style = style ?? YogaStyle();

  /// Build method returns the subcomponent tree.
  ValdiComponent build();

  /// Returns underlying YogaNode representation.
  YogaNode toYogaNode() {
    final built = build();
    if (built != this) {
      return built.toYogaNode();
    }
    return YogaNode(style: style);
  }
}

/// Abstract stateful component with state management capabilities.
abstract class StatefulComponent extends ValdiComponent {
  StatefulComponent({super.key, super.style});

  void setState(Function() fn) {
    fn();
    notifyStateChanged();
  }

  void Function()? onStateChanged;

  void notifyStateChanged() {
    onStateChanged?.call();
  }

  @override
  YogaNode toYogaNode() {
    return build().toYogaNode();
  }
}

/// Primitive Container View Component.
class View extends ValdiComponent {
  final List<ValdiComponent> children;
  final String? backgroundColor;
  final void Function()? onTap;

  View({
    super.key,
    super.style,
    this.children = const [],
    this.backgroundColor,
    this.onTap,
  });

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

/// Text Component.
class Text extends ValdiComponent {
  final String content;
  final double fontSize;
  final String? color;
  final String? fontWeight;

  Text(
    this.content, {
    super.key,
    super.style,
    this.fontSize = 14.0,
    this.color,
    this.fontWeight,
  });

  @override
  ValdiComponent build() => this;

  @override
  YogaNode toYogaNode() {
    return YogaNode(style: style);
  }
}

/// Image Component.
class Image extends ValdiComponent {
  final String source;
  final String? fit;

  Image(
    this.source, {
    super.key,
    super.style,
    this.fit = 'cover',
  });

  @override
  ValdiComponent build() => this;

  @override
  YogaNode toYogaNode() {
    return YogaNode(style: style);
  }
}

/// Button Component.
class Button extends ValdiComponent {
  final String label;
  final void Function()? onPressed;
  final String? backgroundColor;
  final String? textColor;

  Button({
    required this.label,
    required this.onPressed,
    super.key,
    super.style,
    this.backgroundColor,
    this.textColor,
  });

  @override
  ValdiComponent build() {
    return View(
      style: style,
      backgroundColor: backgroundColor ?? '#007AFF',
      onTap: onPressed,
      children: [
        Text(
          label,
          color: textColor ?? '#FFFFFF',
          fontSize: 16.0,
        )
      ],
    );
  }

  @override
  YogaNode toYogaNode() {
    return build().toYogaNode();
  }
}

/// ScrollView Component.
class ScrollView extends ValdiComponent {
  final String scrollDirection; // 'vertical' or 'horizontal'
  final List<ValdiComponent> children;

  ScrollView({
    super.key,
    super.style,
    this.scrollDirection = 'vertical',
    this.children = const [],
  });

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
