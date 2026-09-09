import 'dart:isolate';
import 'dart:async';

/// Background Isolate execution bridge running heavy FFI and layout computations off the UI thread.
class ValdiIsolateBridge {
  static Future<R> compute<T, R>(R Function(T message) callback, T message) async {
    final receivePort = ReceivePort();
    await Isolate.spawn<_IsolateData<T, R>>(_isolateEntry, _IsolateData(callback, message, receivePort.sendPort));
    return await receivePort.first as R;
  }

  static void _isolateEntry<T, R>(_IsolateData<T, R> data) {
    final result = data.callback(data.message);
    data.sendPort.send(result);
  }
}

class _IsolateData<T, R> {
  final R Function(T message) callback;
  final T message;
  final SendPort sendPort;

  _IsolateData(this.callback, this.message, this.sendPort);
}

/// Task manager scheduling background jobs.
class BackgroundTaskManager {
  static Future<T> runTask<T>(FutureOr<T> Function() task) async {
    return await task();
  }
}
