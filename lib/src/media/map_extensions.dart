import '../component/valdi_component.dart';
import '../layout/yoga_node.dart';
import '../bridge/native_bridge.dart';

class MapMarker {
  final String markerId;
  final double latitude;
  final double longitude;
  final String title;

  const MapMarker({
    required this.markerId,
    required this.latitude,
    required this.longitude,
    required this.title,
  });
}

class MapCameraUpdate {
  final double latitude;
  final double longitude;
  final double zoom;

  const MapCameraUpdate({
    required this.latitude,
    required this.longitude,
    this.zoom = 15.0,
  });
}

/// Controller and overlay manager for native Map SDKs (Google Maps SDK / Apple Maps MKMapView) (DartNative native map tutorial).
class MapOverlayController {
  final NativeBridge _bridge = NativeBridge();

  Future<void> addMarker(MapMarker marker) async {
    _bridge.invokeNativeMethod('MapOverlayController.addMarker', [
      marker.markerId,
      marker.latitude,
      marker.longitude,
      marker.title,
    ]);
  }

  Future<void> animateCamera(MapCameraUpdate cameraUpdate) async {
    _bridge.invokeNativeMethod('MapOverlayController.animateCamera', [
      cameraUpdate.latitude,
      cameraUpdate.longitude,
      cameraUpdate.zoom,
    ]);
  }
}

/// Overlay Component floating Dart widgets over native Map SDK surface.
class MapOverlay extends ValdiComponent {
  final ValdiComponent child;

  MapOverlay({
    super.key,
    required this.child,
  });

  @override
  ValdiComponent build() => child;

  @override
  YogaNode toYogaNode() => child.toYogaNode();
}
