import 'package:test/test.dart';
import 'package:valdi/valdi.dart';

void main() {
  group('Dynamic Palette, Content Windowing, Sparklines & Vision ML Tests', () {
    test('DynamicColorPalette extraction & SystemThemeListener', () async {
      final palette = await DynamicColorPalette.extractFromSystem();
      expect(palette.primary, equals('#6750A4'));

      final listener = SystemThemeListener();
      bool darkHandled = false;
      listener.listenToThemeChanges((isDark) => darkHandled = isDark);
      NativeBridge().handleNativeEvent('SystemTheme.onChanged', [true]);
      expect(darkHandled, isTrue);
    });

    test('ContentWindowController 10,000 row memory windowing calculation', () {
      final window = ContentWindowController(totalItems: 10000, windowSize: 50);
      expect(window.startIndex, equals(0));
      expect(window.endIndex, equals(50));

      window.updateScrollOffset(2000.0, 40.0); // 50th item
      expect(window.startIndex, equals(50));
      expect(window.endIndex, equals(100));
    });

    test('SparklineChart & ChartScrubber rendering', () {
      final scrubber = ChartScrubber()..scrubTo(50.0, 120.5);
      expect(scrubber.selectedValue, equals(120.5));

      final chart = SparklineChart(
        dataPoints: [0.1, 0.5, 0.3, 0.8, 0.2, 0.9],
        scrubber: scrubber,
      );

      final node = chart.toYogaNode();
      expect(node, isNotNull);
    });

    test('ValdiVisionML & TensorClassifier inference over FFI', () async {
      final classifier = TensorClassifier();
      final labels = await classifier.runInference('sample_photo.jpg');
      expect(labels.length, equals(2));
      expect(labels.first, equals('object_detected'));
    });
  });
}
