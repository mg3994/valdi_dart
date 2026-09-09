import '../component/valdi_component.dart';
import 'canvas.dart';
import '../layout/yoga_node.dart';
import '../layout/yoga_style.dart';

/// Touch-interactive scrubber controller for Native Canvas Sparklines (DartNative Charts tutorial).
class ChartScrubber {
  double selectedX = 0.0;
  double? selectedValue;

  void scrubTo(double x, double value) {
    selectedX = x;
    selectedValue = value;
  }
}

/// CustomPainter rendering native sparkline charts.
class SparklinePainter extends CustomPainter {
  final List<double> dataPoints;

  SparklinePainter(this.dataPoints);

  @override
  void paint(Canvas canvas, LayoutRect rect) {
    canvas.drawRect(rect, Paint(color: Color.black));
    if (dataPoints.isNotEmpty) {
      final path = Path()..moveTo(0, rect.height / 2);
      for (int i = 0; i < dataPoints.length; i++) {
        final x = (rect.width / (dataPoints.length - 1)) * i;
        final y = rect.height - (dataPoints[i] * rect.height);
        path.lineTo(x, y);
      }
      canvas.drawPath(path, Paint(color: Color.green, strokeWidth: 2.0));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

/// Scrubbable Native Canvas Sparkline Chart Widget.
class SparklineChart extends ValdiComponent {
  final List<double> dataPoints;
  final ChartScrubber? scrubber;

  SparklineChart({
    super.key,
    required this.dataPoints,
    this.scrubber,
    YogaStyle? style,
  }) : super(style: style);

  @override
  ValdiComponent build() {
    return CustomPaint(
      painter: SparklinePainter(dataPoints),
      style: style,
    );
  }

  @override
  YogaNode toYogaNode() => build().toYogaNode();
}
