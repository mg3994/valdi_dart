import 'package:test/test.dart';
import 'package:valdi/valdi.dart';

void main() {
  group('Advanced Architecture Features Tests', () {
    test('AnimationController and Tween calculation', () {
      final controller = AnimationController(durationSeconds: 0.5);
      final tween = Tween<double>(begin: 0.0, end: 100.0);

      expect(controller.value, equals(0.0));
      expect(tween.transform(controller.value), equals(0.0));

      controller.forward();
      expect(controller.value, equals(1.0));
      expect(tween.transform(controller.value), equals(100.0));
    });

    test('Hero transition widget tree building', () {
      final heroWidget = Hero(
        tag: 'avatar_1',
        child: Container(width: 50, height: 50),
      );

      final node = heroWidget.toYogaNode();
      expect(node, isNotNull);
    });

    test('LiquidGlass and M3Badge material widgets', () {
      final glass = LiquidGlass(
        child: M3Badge(
          label: '3',
          child: Text('Messages'),
        ),
      );

      final node = glass.toYogaNode();
      expect(node, isNotNull);
    });

    test('Advanced Media Widgets (VideoPlayer, LottieView, CameraView, MapView)', () {
      final mediaCol = Column(
        children: [
          VideoPlayer(url: 'https://cdn.example.com/video.mp4'),
          LottieView(assetPath: 'assets/anim.json'),
          CameraView(),
          MapView(latitude: 37.7749, longitude: -122.4194),
        ],
      );

      final node = mediaCol.toYogaNode();
      expect(node.children.length, equals(4));
    });

    test('Platform Services over FFI (Auth, Notifications, TTS)', () async {
      final auth = AuthService();
      final notifications = NotificationManager();
      final tts = TextToSpeechEngine();

      final appleRes = await auth.signInWithApple();
      expect(appleRes, contains('AuthService.signInWithApple'));

      final permRes = await notifications.requestPermissions();
      expect(permRes, isTrue);

      await tts.speak('Hello Valdi');
    });
  });
}
