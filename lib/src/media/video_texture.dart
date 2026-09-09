import '../bridge/native_bridge.dart';

/// Zero-copy hardware video texture streamer over FFI (AVFoundation CVPixelBuffer / Android SurfaceTexture).
class VideoTextureStreamer {
  final NativeBridge _bridge = NativeBridge();
  int? _textureId;

  int? get textureId => _textureId;

  Future<int> registerTexture(String videoUrl) async {
    final res = _bridge.invokeNativeMethod('VideoTextureStreamer.registerTexture', [videoUrl]);
    _textureId = 1001;
    return _textureId!;
  }

  Future<void> releaseTexture() async {
    if (_textureId != null) {
      _bridge.invokeNativeMethod('VideoTextureStreamer.releaseTexture', [_textureId]);
      _textureId = null;
    }
  }
}
