import '../bridge/native_bridge.dart';

/// Authentication Service for Sign in with Apple & Google Credential Manager over FFI.
class AuthService {
  final NativeBridge _bridge = NativeBridge();

  Future<String> signInWithApple() async {
    return _bridge.invokeNativeMethod('AuthService.signInWithApple', []);
  }

  Future<String> signInWithGoogle() async {
    return _bridge.invokeNativeMethod('AuthService.signInWithGoogle', []);
  }
}

/// Local & Push Notifications Manager over FFI.
class NotificationManager {
  final NativeBridge _bridge = NativeBridge();

  Future<bool> requestPermissions() async {
    _bridge.invokeNativeMethod('NotificationManager.requestPermissions', []);
    return true;
  }

  Future<void> showLocalNotification(String title, String body) async {
    _bridge.invokeNativeMethod('NotificationManager.showLocalNotification', [title, body]);
  }
}

/// On-Device Neural Text-to-Speech Engine over FFI.
class TextToSpeechEngine {
  final NativeBridge _bridge = NativeBridge();

  Future<void> speak(String text, {String voice = 'default', double rate = 1.0}) async {
    _bridge.invokeNativeMethod('TextToSpeechEngine.speak', [text, voice, rate]);
  }

  Future<void> stop() async {
    _bridge.invokeNativeMethod('TextToSpeechEngine.stop', []);
  }
}
