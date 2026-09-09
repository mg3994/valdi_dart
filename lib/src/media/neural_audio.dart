import '../bridge/native_bridge.dart';

/// On-Device Neural Text-to-Speech audio chunk streamer (DartNative Neural TTS tutorial).
class NeuralAudioStreamer {
  final NativeBridge _bridge = NativeBridge();

  Future<void> streamAudioChunk(String textChunk, {String voiceModel = 'SuperTonic-3'}) async {
    _bridge.invokeNativeMethod('NeuralAudioStreamer.streamAudioChunk', [textChunk, voiceModel]);
  }

  Future<void> stopStream() async {
    _bridge.invokeNativeMethod('NeuralAudioStreamer.stopStream', []);
  }
}
