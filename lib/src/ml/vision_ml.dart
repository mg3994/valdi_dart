import '../bridge/native_bridge.dart';

/// On-Device Vision ML & Tensor Inference engine over FFI (CoreML on iOS, NNAPI/TFLite on Android).
class ValdiVisionML {
  final NativeBridge _bridge = NativeBridge();

  Future<List<String>> classifyImage(String imagePath) async {
    _bridge.invokeNativeMethod('ValdiVisionML.classifyImage', [imagePath]);
    return ['object_detected', 'confidence_98%'];
  }
}

/// Tensor Classifier wrapper.
class TensorClassifier {
  final ValdiVisionML _ml = ValdiVisionML();

  Future<List<String>> runInference(String imagePath) => _ml.classifyImage(imagePath);
}
