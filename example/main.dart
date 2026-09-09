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

int backgroundComputeTask(int num) => num * 10;

void main() async {
  print('=== Valdi + DartNative Enterprise Capabilities Showcase ===\n');

  // 1. Off-Main-Thread Isolate Bridge
  print('[1] Background Isolate Processing:');
  final computeResult = await ValdiIsolateBridge.compute(backgroundComputeTask, 5);
  print('  -> Background Isolate Result: $computeResult');

  // 2. Flutter MethodChannel Migration Bridge
  print('\n[2] Flutter Platform Channel Migration Bridge:');
  final legacyChannel = ValdiPlatformChannel('flutter.plugins.com/share');
  final legacyRes = await legacyChannel.invokeMethod<String>('sharePayload', ['Hello Valdi']);
  print('  -> MethodChannel Invocation Result: $legacyRes');

  // 3. Forms, TextField & Responsive Layout
  print('\n[3] Form Validation, Controlled TextField, & Responsive Layout:');
  final inputController = TextEditingController(text: 'Valdi Developer');

  Navigator.pushNamed('/dashboard', () {
    return ResponsiveLayout(
      mobile: Form(
        child: Column(
          children: [
            SearchAppBar(
              title: 'Valdi Enterprise Suite',
              searchBar: SearchBar(placeholder: 'Search features...'),
            ),
            TextField(
              controller: inputController,
              placeholder: 'User Profile Name',
            ),
            LayoutBuilder(
              builder: (constraints) => Text('Container Width: ${constraints.maxWidth}'),
            ),
            CustomPaint(
              painter: ChartPainter(),
              style: YogaStyle(width: 300, height: 100),
            ),
          ],
        ),
      ),
    );
  });

  final rootWidget = Navigator.currentRoute!.buildPage();

  // 4. Dual-Mode Rendering Pipeline
  final controller = ValdiRenderController();

  print('\n[4.1] Rendering Suite in Primary Native View Mode (Zero-Fork Flutter):');
  controller.setRenderBackend(RenderBackend.nativeViews);
  controller.render(rootWidget);
  print('Active Native Views Created: ${ZeroForkManager().activeNativeViews.length}');

  print('\n[4.2] Switching Rendering Backend to Direct Skia Canvas Mode (DartNative Style Optional Skia):');
  controller.setRenderBackend(RenderBackend.skiaCanvas);
  controller.render(rootWidget);
  print('Recorded Skia Direct Canvas Draw Commands: ${controller.skiaRenderer.recordedCommands.length}');

  print('\n=== Enterprise Capabilities Showcase Completed Successfully ===');
}
