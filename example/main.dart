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
  print('=== Valdi + DartNative Extended Capabilities Showcase ===\n');

  // 1. Reactive Signal State Management
  final counterSignal = Signal<int>(10);
  print('[1] Reactive Signals: Initial Value = ${counterSignal.value}');
  counterSignal.addListener((val) {
    print('  -> Signal Listener Fired: counter = $val');
  });
  counterSignal.value = 25;

  // 2. SearchBar Choreography & Native Navigator
  print('\n[2] Search Bar Choreography & Native Routing:');
  Navigator.pushNamed('/photos', () {
    return Column(
      children: [
        SearchAppBar(
          title: 'Photo Gallery',
          searchBar: SearchBar(placeholder: 'Search high-res photos...'),
        ),
        MasonryGridView(
          crossAxisCount: 2,
          itemCount: 4,
          itemBuilder: (index) => Container(
            height: (index % 2 == 0) ? 140.0 : 200.0,
            child: Text('Masonry Photo Card #$index'),
          ),
        ),
        Hero(
          tag: 'profile_avatar',
          child: Container(width: 80, height: 80, color: '#007AFF'),
        ),
        VideoPlayer(url: 'https://cdn.valdi.native/sample.mp4'),
        CustomPaint(
          painter: ChartPainter(),
          style: YogaStyle(width: 300, height: 100),
        ),
      ],
    );
  });

  print('Active Route Name: ${Navigator.currentRoute?.name}');
  final rootWidget = Navigator.currentRoute!.buildPage();

  // 3. Audio Player Engine
  print('\n[3] Native Audio Engine Execution:');
  final audioPlayer = AudioPlayer();
  await audioPlayer.play('https://cdn.valdi.native/stream.mp3');

  // 4. Dual-Mode Rendering (Native Views Default + Optional Skia Backend Switch)
  final controller = ValdiRenderController();

  print('\n[4.1] Rendering Photo Gallery in Primary Native View Mode (Zero-Fork Flutter):');
  controller.setRenderBackend(RenderBackend.nativeViews);
  controller.render(rootWidget);
  print('Active Native Views Created: ${ZeroForkManager().activeNativeViews.length}');

  print('\n[4.2] Switching Rendering Backend to Direct Skia Canvas Mode (DartNative Style Optional Skia):');
  controller.setRenderBackend(RenderBackend.skiaCanvas);
  controller.render(rootWidget);
  print('Recorded Skia Direct Canvas Draw Commands: ${controller.skiaRenderer.recordedCommands.length}');

  // 5. Platform Capabilities Services over FFI
  print('\n[5] Platform Capabilities Services over Dynamic FFI Bridge:');
  final notifications = NotificationManager();
  await notifications.requestPermissions();
  await notifications.showLocalNotification('Valdi Framework', 'Photo gallery loaded successfully!');

  final tts = TextToSpeechEngine();
  await tts.speak('Photo gallery loaded smoothly');

  print('\n=== Extended Showcase Completed Successfully ===');
}
