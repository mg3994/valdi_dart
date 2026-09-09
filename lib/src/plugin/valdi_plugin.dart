import '../bridge/native_bridge.dart';

/// Base class for custom Valdi / DartNative plugins using direct FFI bridges.
abstract class ValdiPlugin {
  final String pluginName;
  final NativeBridge bridge = NativeBridge();

  ValdiPlugin(this.pluginName);

  void registerEventHandler(String event, dynamic Function(List<dynamic> args) handler) {
    bridge.registerCallback('$pluginName.$event', handler);
  }

  dynamic invokeNative(String method, List<dynamic> args) {
    return bridge.invokeNativeMethod('$pluginName.$method', args);
  }
}
