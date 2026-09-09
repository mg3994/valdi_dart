import 'package:test/test.dart';
import 'package:valdi/valdi.dart';

void main() {
  group('Image Cache, WebSockets, & Biometrics Tests', () {
    test('ValdiImageCache & NetworkImageView cached loading', () {
      ValdiImageCache.clear();
      ValdiImageCache.cacheImage('https://cdn.example.com/photo.jpg', 'local/cached_photo.jpg');

      expect(ValdiImageCache.getCachedPath('https://cdn.example.com/photo.jpg'), equals('local/cached_photo.jpg'));

      final networkImage = NetworkImageView(url: 'https://cdn.example.com/photo.jpg');
      final node = networkImage.toYogaNode();
      expect(node, isNotNull);
    });

    test('ValdiWebSocket connection & message dispatch', () async {
      final ws = ValdiWebSocket('wss://realtime.valdi.native');
      await ws.connect();

      bool messageReceived = false;
      ws.stream.listen((msg) {
        if (msg == 'welcome') messageReceived = true;
      });

      ws.send('hello server');
      NativeBridge().handleNativeEvent('ValdiWebSocket.onMessage', ['welcome']);

      await Future.delayed(Duration(milliseconds: 10));
      expect(messageReceived, isTrue);

      await ws.close();
    });

    test('BiometricAuth availability & authentication over FFI', () async {
      final biometrics = BiometricAuth();
      final isAvail = await biometrics.isBiometricsAvailable();
      expect(isAvail, isTrue);

      final authSuccess = await biometrics.authenticate(reason: 'Unlock sensitive data');
      expect(authSuccess, isTrue);
    });
  });
}
