import '../bridge/native_bridge.dart';

/// System Localizations and i18n Bridge querying native system locale over FFI.
class ValdiLocalizations {
  final Map<String, Map<String, String>> _translations;
  String _currentLocale;
  final NativeBridge _bridge = NativeBridge();

  ValdiLocalizations({
    required Map<String, Map<String, String>> translations,
    String defaultLocale = 'en',
  })  : _translations = translations,
        _currentLocale = defaultLocale;

  String get currentLocale => _currentLocale;

  Future<void> fetchSystemLocale() async {
    final res = _bridge.invokeNativeMethod('ValdiLocalizations.getSystemLocale', []);
    if (res is String && _translations.containsKey(res)) {
      _currentLocale = res;
    }
  }

  void setLocale(String locale) {
    if (_translations.containsKey(locale)) {
      _currentLocale = locale;
    }
  }

  String translate(String key) {
    final localeMap = _translations[_currentLocale] ?? _translations['en'];
    return localeMap?[key] ?? key;
  }
}
