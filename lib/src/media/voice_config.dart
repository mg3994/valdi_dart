import '../bridge/native_bridge.dart';

class NeuralTTSVoice {
  final String id;
  final String name;
  final String languageCode;

  const NeuralTTSVoice({
    required this.id,
    required this.name,
    required this.languageCode,
  });
}

/// Configuration manager for On-Device SuperTonic-3 Neural TTS voice models over FFI (DartNative TTS tutorial).
class NeuralVoiceConfig {
  static const List<NeuralTTSVoice> availableVoices = [
    NeuralTTSVoice(id: 'v1_en_us', name: 'SuperTonic English US', languageCode: 'en-US'),
    NeuralTTSVoice(id: 'v2_es_es', name: 'SuperTonic Spanish ES', languageCode: 'es-ES'),
    NeuralTTSVoice(id: 'v3_fr_fr', name: 'SuperTonic French FR', languageCode: 'fr-FR'),
  ];

  final NativeBridge _bridge = NativeBridge();

  Future<void> setVoiceModel(NeuralTTSVoice voice) async {
    _bridge.invokeNativeMethod('NeuralVoiceConfig.setVoiceModel', [voice.id, voice.languageCode]);
  }
}
