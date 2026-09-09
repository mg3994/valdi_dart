import '../bridge/native_bridge.dart';

/// Secure Keychain / Keystore storage over FFI (DartNative storage tutorial).
class KeychainStore {
  final Map<String, String> _memoryCache = {};
  final NativeBridge _bridge = NativeBridge();

  Future<void> writeSecure(String key, String secret) async {
    _memoryCache[key] = secret;
    _bridge.invokeNativeMethod('KeychainStore.writeSecure', [key, secret]);
  }

  Future<String?> readSecure(String key) async {
    if (_memoryCache.containsKey(key)) {
      return _memoryCache[key];
    }
    final res = _bridge.invokeNativeMethod('KeychainStore.readSecure', [key]);
    return res as String?;
  }

  Future<void> deleteSecure(String key) async {
    _memoryCache.remove(key);
    _bridge.invokeNativeMethod('KeychainStore.deleteSecure', [key]);
  }
}

/// Local SQLite database store over direct FFI.
class SQLiteStore {
  final String dbName;
  final Map<String, List<Map<String, dynamic>>> _tables = {};
  final NativeBridge _bridge = NativeBridge();

  SQLiteStore(this.dbName);

  Future<void> execute(String query, [List<dynamic>? params]) async {
    _bridge.invokeNativeMethod('SQLiteStore.execute', [dbName, query, params ?? []]);
  }

  Future<void> insert(String table, Map<String, dynamic> row) async {
    _tables.putIfAbsent(table, () => []).add(row);
    _bridge.invokeNativeMethod('SQLiteStore.insert', [dbName, table, row]);
  }

  Future<List<Map<String, dynamic>>> query(String table) async {
    return _tables[table] ?? [];
  }
}
