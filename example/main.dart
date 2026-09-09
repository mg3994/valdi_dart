import 'package:valdi/valdi.dart';

class ChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, LayoutRect rect) {
    canvas.drawRect(rect, Paint(color: Color.black));
    canvas.drawCircle(rect.width / 2, rect.height / 2, 30.0, Paint(color: Color.green));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

void main() async {
  print('=== Valdi + DartNative Extended Architecture Demo ===\n');

  // 1. Reactive Signal State
  final counterSignal = Signal<int>(10);
  print('[1] Reactive Signals: Initial Value = ${counterSignal.value}');
  counterSignal.addListener((val) {
    print('  -> Signal Listener Fired: counter = $val');
  });
  counterSignal.value = 25;

  // 2. Provided Dependency Context
  Provided.inject<String>('https://api.valdi.native');
  print('\n[2] Provided Context: API Base URL = ${Provided.get<String>()}');

  // 3. Native Navigator & Routes
  print('\n[3] Native Navigator Routing:');
  Navigator.pushNamed('/dashboard', () {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: Text('Navigation Bar Title')),
          ],
        ),
        Stack(
          children: [
            Container(color: '#1C1C1E', width: 375, height: 200),
            Positioned(
              left: 20,
              top: 20,
              child: Text('Overlay Banner', color: '#FFFFFF'),
            ),
          ],
        ),
        SizedBox(height: 16),
        CustomPaint(
          painter: ChartPainter(),
          style: YogaStyle(width: 300, height: 150),
        ),
        ListView.builder(
          itemCount: 3,
          itemBuilder: (i) => Text('Fast Native List Row #$i'),
        ),
      ],
    );
  });

  print('Current Route: ${Navigator.currentRoute?.name}');
  final rootWidget = Navigator.currentRoute!.buildPage();

  // 4. Dual-Mode Rendering Pipeline
  final controller = ValdiRenderController();

  print('\n[4.1] Rendering Dashboard in Native View Mode (Zero-Fork Flutter):');
  controller.setRenderBackend(RenderBackend.nativeViews);
  controller.render(rootWidget);
  print('Native View Count: ${ZeroForkManager().activeNativeViews.length}');

  print('\n[4.2] Switching to Optional Skia Direct Canvas Backend (DartNative Style):');
  controller.setRenderBackend(RenderBackend.skiaCanvas);
  controller.render(rootWidget);
  print('Skia Draw Commands Recorded: ${controller.skiaRenderer.recordedCommands.length}');

  // 5. Direct FFI Key-Value Storage
  print('\n[5] Direct FFI Storage Execution:');
  final storage = ValdiStorage();
  await storage.setString('session_token', 'valdi_token_9988');
  print('Read Token from FFI Storage: ${storage.getString('session_token')}');

  print('\n=== Extended Demo Completed Successfully ===');
}
