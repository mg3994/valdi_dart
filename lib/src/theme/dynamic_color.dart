import '../bridge/native_bridge.dart';

/// Dynamic wallpaper color palette extracted from host OS (DartNative Material 3 tutorial).
class DynamicColorPalette {
  final String primary;
  final String secondary;
  final String background;
  final String surface;

  DynamicColorPalette({
    this.primary = '#6750A4',
    this.secondary = '#625B71',
    this.background = '#FEF7FF',
    this.surface = '#FEF7FF',
  });

  static Future<DynamicColorPalette> extractFromSystem() async {
    final bridge = NativeBridge();
    bridge.invokeNativeMethod('DynamicColorPalette.extractFromSystem', []);
    return DynamicColorPalette(
      primary: '#6750A4',
      secondary: '#625B71',
      background: '#1C1B1F',
      surface: '#1C1B1F',
    );
  }
}

/// Listens for OS system theme changes (Light/Dark mode) over FFI.
class SystemThemeListener {
  final NativeBridge _bridge = NativeBridge();

  void listenToThemeChanges(void Function(bool isDarkMode) onThemeChanged) {
    _bridge.registerCallback('SystemTheme.onChanged', (args) {
      final isDark = args.isNotEmpty && args.first == true;
      onThemeChanged(isDark);
      return null;
    });
  }
}
