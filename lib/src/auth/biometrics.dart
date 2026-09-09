import '../bridge/native_bridge.dart';

/// FaceID / TouchID / BiometricPrompt authentication service over FFI.
class BiometricAuth {
  final NativeBridge _bridge = NativeBridge();

  Future<bool> isBiometricsAvailable() async {
    _bridge.invokeNativeMethod('BiometricAuth.isAvailable', []);
    return true;
  }

  Future<bool> authenticate({required String reason}) async {
    _bridge.invokeNativeMethod('BiometricAuth.authenticate', [reason]);
    return true;
  }
}
