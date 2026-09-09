import 'package:valdi/valdi.dart';

void main() async {
  print('=== Valdi + DartNative Ultra Capabilities Showcase ===\n');

  // 1. System Wallpaper Dynamic Color Palette Extraction
  print('[1] Extracting Host OS Wallpaper Dynamic Color Palette:');
  final palette = await DynamicColorPalette.extractFromSystem();
  print('  -> System Wallpaper Palette Colors: Primary = ${palette.primary}, Surface = ${palette.surface}');

  // 2. Content Windowing for 10,000+ Row Jank-Free Native List
  print('\n[2] Content Windowing Calculation for 10,000 Row Native List:');
  final window = ContentWindowController(totalItems: 10000, windowSize: 50);
  window.updateScrollOffset(4000.0, 40.0); // Scroll to item 100
  print('  -> Flat Memory Window Range: Item #${window.startIndex} to #${window.endIndex}');

  // 3. Touch-Scrubbable Native Canvas Sparkline Chart
  print('\n[3] Interactive Native Canvas Sparkline Chart:');
  final chartScrubber = ChartScrubber()..scrubTo(120.0, 88.5);
  print('  -> Sparkline Chart Scrubber Value: ${chartScrubber.selectedValue}');

  // 4. On-Device Vision ML & Tensor Inference over FFI
  print('\n[4] On-Device Vision ML Inference over FFI:');
  final classifier = TensorClassifier();
  final mlLabels = await classifier.runInference('input_frame.jpg');
  print('  -> CoreML / TFLite Inferred Labels: $mlLabels');

  // 5. UI Construction & Dual-Mode Rendering Pipeline
  Navigator.pushNamed('/analytics', () {
    return Column(
      children: [
        SearchAppBar(
          title: 'Analytics Dashboard',
          searchBar: SearchBar(placeholder: 'Search metrics...'),
        ),
        SparklineChart(
          dataPoints: [0.2, 0.4, 0.6, 0.3, 0.9, 0.7, 0.95],
          scrubber: chartScrubber,
          style: YogaStyle(width: 350, height: 120),
        ),
        ListView.builder(
          itemCount: 3,
          itemBuilder: (i) => Text('Windowed List Item #${window.startIndex + i}'),
        ),
      ],
    );
  });

  final rootWidget = Navigator.currentRoute!.buildPage();
  final controller = ValdiRenderController();

  print('\n[5.1] Rendering Dashboard in Primary Native View Mode (Zero-Fork Flutter):');
  controller.setRenderBackend(RenderBackend.nativeViews);
  controller.render(rootWidget);
  print('Active Native Views Created: ${ZeroForkManager().activeNativeViews.length}');

  print('\n[5.2] Switching Rendering Backend to Direct Skia Canvas Mode (DartNative Style Optional Skia):');
  controller.setRenderBackend(RenderBackend.skiaCanvas);
  controller.render(rootWidget);
  print('Recorded Skia Direct Canvas Draw Commands: ${controller.skiaRenderer.recordedCommands.length}');

  print('\n=== Ultra Capabilities Showcase Completed Successfully ===');
}
