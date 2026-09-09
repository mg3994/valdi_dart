import 'dart:async';
import '../bridge/native_bridge.dart';

/// Real-time bi-directional WebSocket client over native FFI.
class ValdiWebSocket {
  final String url;
  final StreamController<String> _messageController = StreamController<String>.broadcast();
  final NativeBridge _bridge = NativeBridge();

  ValdiWebSocket(this.url);

  Stream<String> get stream => _messageController.stream;

  Future<void> connect() async {
    _bridge.invokeNativeMethod('ValdiWebSocket.connect', [url]);
    _bridge.registerCallback('ValdiWebSocket.onMessage', (args) {
      if (args.isNotEmpty && args.first is String) {
        _messageController.add(args.first as String);
      }
      return null;
    });
  }

  void send(String message) {
    _bridge.invokeNativeMethod('ValdiWebSocket.send', [url, message]);
  }

  Future<void> close() async {
    _bridge.invokeNativeMethod('ValdiWebSocket.close', [url]);
    await _messageController.close();
  }
}
