import 'dart:async';
import '../bridge/native_bridge.dart';

/// Flutter MethodChannel fallback migration bridge for legacy Flutter plugins.
class ValdiPlatformChannel {
  final String name;
  final NativeBridge _bridge = NativeBridge();

  ValdiPlatformChannel(this.name);

  Future<T?> invokeMethod<T>(String method, [dynamic arguments]) async {
    final result = _bridge.invokeNativeMethod('$name/$method', arguments is List ? arguments : [arguments]);
    return result as T?;
  }
}

/// Flutter EventChannel fallback bridge.
class ValdiEventChannel {
  final String name;
  final StreamController<dynamic> _controller = StreamController<dynamic>.broadcast();

  ValdiEventChannel(this.name);

  Stream<dynamic> receiveBroadcastStream() => _controller.stream;

  void emitNativeEvent(dynamic event) {
    _controller.add(event);
  }
}
