import '../component/valdi_component.dart';
import 'yoga_node.dart';
import 'yoga_style.dart';

class BoxConstraints {
  final double maxWidth;
  final double maxHeight;

  const BoxConstraints({
    this.maxWidth = double.infinity,
    this.maxHeight = double.infinity,
  });
}

typedef ResponsiveWidgetBuilder = ValdiComponent Function(BoxConstraints constraints);

/// LayoutBuilder widget passing box constraints to builder callback.
class LayoutBuilder extends ValdiComponent {
  final ResponsiveWidgetBuilder builder;

  LayoutBuilder({
    super.key,
    required this.builder,
    YogaStyle? style,
  }) : super(style: style);

  @override
  ValdiComponent build() {
    return builder(const BoxConstraints(maxWidth: 375, maxHeight: 812));
  }

  @override
  YogaNode toYogaNode() => build().toYogaNode();
}

/// Responsive layout switcher based on screen breakpoints (Mobile / Tablet / Desktop).
class ResponsiveLayout extends ValdiComponent {
  final ValdiComponent mobile;
  final ValdiComponent? tablet;
  final ValdiComponent? desktop;

  ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  @override
  ValdiComponent build() => mobile;

  @override
  YogaNode toYogaNode() => mobile.toYogaNode();
}
