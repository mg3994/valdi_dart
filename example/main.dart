import 'package:valdi/valdi.dart';

void main() async {
  print('=== Valdi + DartNative Enterprise Realtime Suite Showcase ===\n');

  // 1. Biometric Authentication over FFI (FaceID / TouchID)
  print('[1] Authenticating User via FaceID / TouchID Biometrics over FFI:');
  final biometrics = BiometricAuth();
  if (await biometrics.isBiometricsAvailable()) {
    final bioSuccess = await biometrics.authenticate(reason: 'Access Valdi Secure Vault');
    print('  -> Biometric Authentication Result: $bioSuccess');
  }

  // 2. Real-time Bi-directional WebSockets over FFI
  print('\n[2] Connecting Real-time FFI WebSocket:');
  final ws = ValdiWebSocket('wss://realtime.valdi.native/feed');
  ws.stream.listen((msg) => print('  -> WebSocket Stream Received Message: "$msg"'));
  await ws.connect();
  ws.send('ping');
  NativeBridge().handleNativeEvent('ValdiWebSocket.onMessage', ['{"type": "connected", "status": "online"}']);

  // 3. Fast LRU In-Memory Image Cache & NetworkImageView
  print('\n[3] In-Memory LRU Image Caching & NetworkImageView:');
  ValdiImageCache.cacheImage('https://cdn.valdi.native/photo1.jpg', '/var/cache/photo1_cached.jpg');
  print('  -> Image Cache Lookup: ${ValdiImageCache.getCachedPath('https://cdn.valdi.native/photo1.jpg')}');

  Navigator.pushNamed('/realtime_vault', () {
    return Column(
      children: [
        SearchAppBar(
          title: 'Secure Realtime Vault',
          searchBar: SearchBar(placeholder: 'Search secure vault...'),
        ),
        NetworkImageView(url: 'https://cdn.valdi.native/photo1.jpg'),
        Text('Vault Secured with FaceID & Realtime WebSocket Sync'),
      ],
    );
  });

  final rootWidget = Navigator.currentRoute!.buildPage();

  // 4. Dual-Mode Rendering Pipeline
  final controller = ValdiRenderController();

  print('\n[4.1] Rendering Realtime Vault in Primary Native View Mode (Zero-Fork Flutter):');
  controller.setRenderBackend(RenderBackend.nativeViews);
  controller.render(rootWidget);
  print('Active Native Views Created: ${ZeroForkManager().activeNativeViews.length}');

  print('\n[4.2] Switching Rendering Backend to Direct Skia Canvas Mode (DartNative Style Optional Skia):');
  controller.setRenderBackend(RenderBackend.skiaCanvas);
  controller.render(rootWidget);
  print('Recorded Skia Direct Canvas Draw Commands: ${controller.skiaRenderer.recordedCommands.length}');

  await ws.close();
  print('\n=== Enterprise Realtime Suite Showcase Completed Successfully ===');
}
