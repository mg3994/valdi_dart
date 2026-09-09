import 'dart:async';
import '../bridge/native_bridge.dart';

/// Real-time streaming native platform event channel over FFI.
class ValdiEventStream<T> {
  final String streamName;
  final StreamController<T> _controller = StreamController<T>.broadcast();
  final NativeBridge _bridge = NativeBridge();

  ValdiEventStream(this.streamName) {
    _bridge.registerCallback('ValdiEventStream.$streamName', (args) {
      if (args.isNotEmpty && args.first is T) {
        _controller.add(args.first as T);
      }
      return null;
    });
  }

  Stream<T> get stream => _controller.stream;

  void emit(T data) {
    _controller.add(data);
  }

  Future<void> close() => _controller.close();
}
