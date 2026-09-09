import '../bridge/native_bridge.dart';

class NotificationPayload {
  final String senderName;
  final String avatarUrl;
  final String messageBody;

  const NotificationPayload({
    required this.senderName,
    required this.avatarUrl,
    required this.messageBody,
  });
}

/// Chat-style banner notification manager displaying avatar banners on iOS & Android over FFI (DartNative notifications tutorial).
class ChatBannerNotification {
  final NativeBridge _bridge = NativeBridge();

  Future<void> showChatBanner(NotificationPayload payload) async {
    _bridge.invokeNativeMethod('ChatBannerNotification.showChatBanner', [
      payload.senderName,
      payload.avatarUrl,
      payload.messageBody,
    ]);
  }
}
