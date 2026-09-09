import '../bridge/native_bridge.dart';

/// Real-time Native Audio Controller and Engine (DartNative audio engine pattern).
class AudioEngine {
  final NativeBridge _bridge = NativeBridge();

  Future<void> playAudio(String url) async {
    _bridge.invokeNativeMethod('AudioEngine.playAudio', [url]);
  }

  Future<void> pauseAudio() async {
    _bridge.invokeNativeMethod('AudioEngine.pauseAudio', []);
  }

  Future<void> stopAudio() async {
    _bridge.invokeNativeMethod('AudioEngine.stopAudio', []);
  }
}

/// High-level AudioPlayer controller.
class AudioPlayer {
  final AudioEngine _engine = AudioEngine();

  Future<void> play(String source) => _engine.playAudio(source);
  Future<void> pause() => _engine.pauseAudio();
  Future<void> stop() => _engine.stopAudio();
}
