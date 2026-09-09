import '../bridge/native_bridge.dart';

/// Direct FFI Storage engine (SharedPreferences / Key-Value / SQLite inspired by DartNative FFI storage).
class ValdiStorage {
  final Map<String, dynamic> _inMemoryStore = {};
  final NativeBridge _bridge = NativeBridge();

  Future<void> setString(String key, String value) async {
    _inMemoryStore[key] = value;
    _bridge.invokeNativeMethod('ValdiStorage.setString', [key, value]);
  }

  String? getString(String key) {
    return _inMemoryStore[key] as String?;
  }

  Future<void> setInt(String key, int value) async {
    _inMemoryStore[key] = value;
    _bridge.invokeNativeMethod('ValdiStorage.setInt', [key, value]);
  }

  int? getInt(String key) {
    return _inMemoryStore[key] as int?;
  }

  Future<void> remove(String key) async {
    _inMemoryStore.remove(key);
    _bridge.invokeNativeMethod('ValdiStorage.remove', [key]);
  }

  void clear() {
    _inMemoryStore.clear();
  }
}
