import 'package:valdi/valdi.dart';

void main() async {
  print('=== Valdi + DartNative Cutting-Edge Glass & Map Suite Showcase ===\n');

  // 1. Rich Avatar Chat Banner Notifications over FFI
  print('[1] Triggering Native Chat Banner Notification over FFI:');
  final bannerNotifier = ChatBannerNotification();
  await bannerNotifier.showChatBanner(const NotificationPayload(
    senderName: 'Sarah Connor',
    avatarUrl: 'https://cdn.valdi.native/avatars/sarah.jpg',
    messageBody: 'Valdi framework running natively on OS!',
  ));
  print('  -> Chat Banner Notification dispatched to native OS.');

  // 2. Native Map SDK Controller & Interactive Markers
  print('\n[2] Native Map SDK Camera Update & Interactive Marker Placement:');
  final mapController = MapOverlayController();
  await mapController.addMarker(const MapMarker(
    markerId: 'valdi_hq',
    latitude: 37.7749,
    longitude: -122.4194,
    title: 'Valdi Headquarters',
  ));
  await mapController.animateCamera(const MapCameraUpdate(
    latitude: 37.7749,
    longitude: -122.4194,
    zoom: 17.5,
  ));
  print('  -> Native Map Marker placed & Camera Animated.');

  // 3. iOS 26 Clear Large Title Bar & Fluid Glass Merge UI
  print('\n[3] Constructing Clear Title Bar & Fluid Glass Merge Effect UI:');
  Navigator.pushNamed('/map_suite', () {
    return Column(
      children: [
        ClearTitleBar(
          title: 'Explore Native World',
          leading: Text('◄ Menu'),
        ),
        LiquidGlassMerge(
          glassNodes: [
            LiquidGlass(
              child: Text('Card #1: Fluid Blur Node'),
            ),
            LiquidGlass(
              child: Text('Card #2: Fluid Glass Merge Node'),
            ),
          ],
        ),
        MapOverlay(
          child: Container(
            color: '#1C1C1E',
            padding: const EdgeValues.all(12),
            child: Text('Floating Map Card Over SDK', color: '#FFFFFF'),
          ),
        ),
      ],
    );
  });

  final rootWidget = Navigator.currentRoute!.buildPage();

  // 4. Dual-Mode Rendering Pipeline
  final controller = ValdiRenderController();

  print('\n[4.1] Rendering Glass & Map Suite in Primary Native View Mode (Zero-Fork Flutter):');
  controller.setRenderBackend(RenderBackend.nativeViews);
  controller.render(rootWidget);
  print('Active Native Views Created: ${ZeroForkManager().activeNativeViews.length}');

  print('\n[4.2] Switching Rendering Backend to Direct Skia Canvas Mode (DartNative Style Optional Skia):');
  controller.setRenderBackend(RenderBackend.skiaCanvas);
  controller.render(rootWidget);
  print('Recorded Skia Direct Canvas Draw Commands: ${controller.skiaRenderer.recordedCommands.length}');

  print('\n=== Cutting-Edge Glass & Map Suite Showcase Completed Successfully ===');
}
