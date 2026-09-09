import 'package:test/test.dart';
import 'package:valdi/valdi.dart';

void main() {
  group('LiquidGlassMerge, Rich Notifications & Map Overlays Tests', () {
    test('LiquidGlassMerge & ClearTitleBar widget tree construction', () {
      final titleBar = ClearTitleBar(
        title: 'Large Title',
        leading: Text('Back'),
      );

      final glassMerge = LiquidGlassMerge(
        glassNodes: [
          LiquidGlass(child: Text('Card 1')),
          LiquidGlass(child: Text('Card 2')),
        ],
      );

      expect(titleBar.toYogaNode(), isNotNull);
      expect(glassMerge.toYogaNode().children.length, equals(2));
    });

    test('ChatBannerNotification FFI invocation', () async {
      final banner = ChatBannerNotification();
      final payload = NotificationPayload(
        senderName: 'Alice',
        avatarUrl: 'https://cdn.example.com/avatar.png',
        messageBody: 'Hey Valdi developer!',
      );

      await banner.showChatBanner(payload);
    });

    test('MapOverlayController markers and camera updates', () async {
      final mapController = MapOverlayController();

      await mapController.addMarker(const MapMarker(
        markerId: 'm1',
        latitude: 37.7749,
        longitude: -122.4194,
        title: 'San Francisco',
      ));

      await mapController.animateCamera(const MapCameraUpdate(
        latitude: 37.7749,
        longitude: -122.4194,
        zoom: 16.0,
      ));

      final overlay = MapOverlay(child: Text('Floating Map Card'));
      expect(overlay.toYogaNode(), isNotNull);
    });
  });
}
