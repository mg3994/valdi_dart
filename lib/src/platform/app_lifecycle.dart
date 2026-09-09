import '../bridge/native_bridge.dart';

enum AppLifecycleState { resumed, inactive, paused, detached }

/// Tracks OS app lifecycle transitions (foreground / background / paused) over FFI.
class AppLifecycleObserver {
  final NativeBridge _bridge = NativeBridge();
  AppLifecycleState _currentState = AppLifecycleState.resumed;

  AppLifecycleState get currentState => _currentState;

  void observeLifecycle(void Function(AppLifecycleState state) onStateChanged) {
    _bridge.registerCallback('AppLifecycle.onStateChanged', (args) {
      if (args.isNotEmpty && args.first is String) {
        final stateStr = args.first as String;
        switch (stateStr) {
          case 'resumed':
            _currentState = AppLifecycleState.resumed;
            break;
          case 'inactive':
            _currentState = AppLifecycleState.inactive;
            break;
          case 'paused':
            _currentState = AppLifecycleState.paused;
            break;
          case 'detached':
            _currentState = AppLifecycleState.detached;
            break;
        }
        onStateChanged(_currentState);
      }
      return null;
    });
  }
}
