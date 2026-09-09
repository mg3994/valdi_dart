import '../component/valdi_component.dart';
import '../layout/yoga_node.dart';
import '../layout/yoga_style.dart';

typedef GestureTapCallback = void Function();
typedef GesturePanUpdateCallback = void Function(double dx, double dy);

/// Tap Gesture Recognizer.
class TapGestureRecognizer {
  final GestureTapCallback? onTap;
  TapGestureRecognizer({this.onTap});

  void handleTap() => onTap?.call();
}

/// Pan / Drag Gesture Recognizer.
class PanGestureRecognizer {
  final GesturePanUpdateCallback? onPanUpdate;
  PanGestureRecognizer({this.onPanUpdate});

  void handlePan(double dx, double dy) => onPanUpdate?.call(dx, dy);
}

/// GestureDetector Widget wrapping child with tap, double tap, and pan gesture recognizers.
class GestureDetector extends ValdiComponent {
  final ValdiComponent child;
  final GestureTapCallback? onTap;
  final GestureTapCallback? onDoubleTap;
  final GesturePanUpdateCallback? onPanUpdate;

  GestureDetector({
    super.key,
    required this.child,
    this.onTap,
    this.onDoubleTap,
    this.onPanUpdate,
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
