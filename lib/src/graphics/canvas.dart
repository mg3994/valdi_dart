import '../component/valdi_component.dart';
import '../layout/yoga_node.dart';
import '../layout/yoga_style.dart';

class Color {
  final int value;
  const Color(this.value);

  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color red = Color(0xFFFF0000);
  static const Color blue = Color(0xFF0000FF);
  static const Color green = Color(0xFF00FF00);
}

class Paint {
  Color color;
  double strokeWidth;

  Paint({
    this.color = Color.black,
    this.strokeWidth = 1.0,
  });
}

class Path {
  final List<String> operations = [];

  void moveTo(double x, double y) => operations.add('moveTo($x, $y)');
  void lineTo(double x, double y) => operations.add('lineTo($x, $y)');
  void close() => operations.add('close()');
}

/// Native Canvas abstraction executing drawing operations on CoreGraphics, Canvas, or Skia.
class Canvas {
  final List<String> drawCalls = [];

  void drawRect(LayoutRect rect, Paint paint) {
    drawCalls.add('drawRect($rect, color: 0x${paint.color.value.toRadixString(16)})');
  }

  void drawCircle(double cx, double cy, double radius, Paint paint) {
    drawCalls.add('drawCircle(($cx, $cy), r: $radius, color: 0x${paint.color.value.toRadixString(16)})');
  }

  void drawPath(Path path, Paint paint) {
    drawCalls.add('drawPath(${path.operations}, color: 0x${paint.color.value.toRadixString(16)})');
  }
}

/// Abstract CustomPainter matching Flutter / DartNative CustomPainter API.
abstract class CustomPainter {
  void paint(Canvas canvas, LayoutRect rect);
  bool shouldRepaint(covariant CustomPainter oldDelegate);
}

/// Component embedding CustomPainter into Valdi component tree.
class CustomPaint extends ValdiComponent {
  final CustomPainter painter;

  CustomPaint({
    super.key,
    required this.painter,
    YogaStyle? style,
  }) : super(style: style);

  @override
  ValdiComponent build() => this;

  @override
  YogaNode toYogaNode() => YogaNode(style: style);
}
