import 'package:valdi/valdi.dart';

class CounterApp extends StatefulComponent {
  int count = 0;

  CounterApp({super.key});

  void increment() {
    setState(() {
      count++;
    });
  }

  @override
  ValdiComponent build() {
    return View(
      key: 'root_view',
      style: YogaStyle(
        flexDirection: FlexDirection.column,
        justifyContent: JustifyContent.center,
        alignItems: AlignItems.center,
        width: 375,
        height: 812,
        padding: const EdgeValues.all(20),
      ),
      backgroundColor: '#F5F5F7',
      children: [
        Text(
          'Valdi + DartNative + ZeroFork',
          key: 'title',
          style: YogaStyle(
            margin: const EdgeValues(bottom: 16),
          ),
          fontSize: 22,
          fontWeight: 'bold',
          color: '#1C1C1E',
        ),
        Text(
          'Counter Value: $count',
          key: 'counter_text',
          style: YogaStyle(
            margin: const EdgeValues(bottom: 24),
          ),
          fontSize: 18,
          color: '#007AFF',
        ),
        Button(
          key: 'increment_button',
          label: 'Increment Counter',
          style: YogaStyle(
            width: 200,
            height: 48,
          ),
          onPressed: () {
            increment();
          },
        ),
      ],
    );
  }
}

void main() {
  print('=== Valdi Dart Cross-Platform Framework Demo ===\n');

  final renderController = ValdiRenderController();
  final counterApp = CounterApp();

  // 1. Render in Native View Mode (Valdi style with Zero-Fork Flutter)
  print('[1] Rendering in Primary Native View Mode (Zero-Fork Flutter):');
  renderController.setRenderBackend(RenderBackend.nativeViews);
  renderController.render(counterApp.build());

  final activeViews = ZeroForkManager().activeNativeViews;
  print('Active Native View Handles Created: ${activeViews.length}');
  for (final handle in activeViews.values) {
    print('  - Native View #${handle.viewId} (${handle.viewType}) at ${handle.layout} props: ${handle.props}');
  }

  print('\n--------------------------------------------------\n');

  // 2. State Mutation
  print('[2] Incrementing state in CounterApp...');
  counterApp.increment();
  renderController.render(counterApp.build());

  print('Updated Native Views after state change:');
  for (final handle in ZeroForkManager().activeNativeViews.values) {
    print('  - Native View #${handle.viewId} (${handle.viewType}) at ${handle.layout} props: ${handle.props}');
  }

  print('\n--------------------------------------------------\n');

  // 3. Optional Direct Skia Canvas Mode Switch (DartNative style optional Skia)
  print('[3] Switching Rendering Backend to Direct Skia Canvas Mode (DartNative style optional Skia):');
  renderController.setRenderBackend(RenderBackend.skiaCanvas);

  final skiaCommands = renderController.skiaRenderer.recordedCommands;
  print('Recorded Skia Draw Commands: ${skiaCommands.length}');
  for (final cmd in skiaCommands) {
    print('  - $cmd');
  }

  print('\n=== Demo Completed Successfully ===');
}
