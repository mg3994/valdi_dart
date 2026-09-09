import '../component/valdi_component.dart';
import '../component/grid_view.dart';
import 'media_widgets.dart';
import '../bridge/native_bridge.dart';

/// Controller managing camera capture, flash, tap-to-focus (DartNative Camera tutorial).
class CameraController {
  final NativeBridge _bridge = NativeBridge();

  Future<void> takePhoto() async {
    _bridge.invokeNativeMethod('CameraController.takePhoto', []);
  }

  Future<void> toggleFlash() async {
    _bridge.invokeNativeMethod('CameraController.toggleFlash', []);
  }

  Future<void> switchCamera() async {
    _bridge.invokeNativeMethod('CameraController.switchCamera', []);
  }
}

/// Lottie Animation CDN Sticker Grid (DartNative Lottie CDN sticker grid tutorial).
class LottieStickerGrid extends ValdiComponent {
  final List<String> stickerUrls;

  LottieStickerGrid({
    super.key,
    required this.stickerUrls,
  });

  @override
  ValdiComponent build() {
    return MasonryGridView(
      crossAxisCount: 3,
      itemCount: stickerUrls.length,
      itemBuilder: (index) => LottieView(assetPath: stickerUrls[index]),
    );
  }
}
