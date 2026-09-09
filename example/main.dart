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
  print('=== Valdi + DartNative Comprehensive Showcase ===\n');

  // 1. Reactive Signal State Management
  final counterSignal = Signal<int>(10);
  print('[1] Reactive Signals: Initial Value = ${counterSignal.value}');
  counterSignal.addListener((val) {
    print('  -> Signal Listener Fired: counter = $val');
  });
  counterSignal.value = 25;

  // 2. Animations & Hero Transition
  print('\n[2] Animation Controller & Hero Transitions:');
  final animController = AnimationController(durationSeconds: 0.3);
  animController.addListener(() {
    print('  -> Animation Frame Value: ${animController.value}');
  });
  animController.forward();

  // 3. Native Navigator & Advanced Widgets (LiquidGlass, VideoPlayer, Hero, Lottie)
  print('\n[3] Native Navigator Routing & Advanced UI Components:');
  Navigator.pushNamed('/dashboard', () {
    return LiquidGlass(
      tintColor: '#ffffff44',
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: M3Badge(
                  label: 'NEW',
                  child: Text('Navigation Header'),
                ),
              ),
            ],
          ),
          Hero(
            tag: 'profile_avatar',
            child: Container(width: 80, height: 80, color: '#007AFF'),
          ),
          VideoPlayer(url: 'https://cdn.valdi.native/sample.mp4'),
          LottieView(assetPath: 'assets/lottie_success.json'),
          MapView(latitude: 37.7749, longitude: -122.4194),
          CustomPaint(
            painter: ChartPainter(),
            style: YogaStyle(width: 300, height: 100),
          ),
          ListView.builder(
            itemCount: 2,
            itemBuilder: (i) => Text('Native Row Item #$i'),
          ),
        ],
      ),
    );
  });

  print('Current Active Route: ${Navigator.currentRoute?.name}');
  final rootWidget = Navigator.currentRoute!.buildPage();

  // 4. Dual-Mode Rendering (Native Views Default + Optional Skia Backend Switch)
  final controller = ValdiRenderController();

  print('\n[4.1] Rendering Dashboard in Primary Native View Mode (Zero-Fork Flutter):');
  controller.setRenderBackend(RenderBackend.nativeViews);
  controller.render(rootWidget);
  print('Active Native Views Created: ${ZeroForkManager().activeNativeViews.length}');

  print('\n[4.2] Switching Rendering Backend to Direct Skia Canvas Mode (DartNative Style Optional Skia):');
  controller.setRenderBackend(RenderBackend.skiaCanvas);
  controller.render(rootWidget);
  print('Recorded Skia Direct Canvas Draw Commands: ${controller.skiaRenderer.recordedCommands.length}');

  // 5. Platform Capabilities Services over FFI (Notifications & AuthService)
  print('\n[5] Platform Capabilities Services over Dynamic FFI Bridge:');
  final notifications = NotificationManager();
  await notifications.requestPermissions();
  await notifications.showLocalNotification('Valdi Framework', 'Welcome to Valdi Cross-Platform Engine!');

  final auth = AuthService();
  final authResult = await auth.signInWithApple();
  print('Apple Sign-In Response over FFI: $authResult');

  print('\n=== Comprehensive Showcase Completed Successfully ===');
}
