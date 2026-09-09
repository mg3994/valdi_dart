import '../component/valdi_component.dart';

/// State preservation and hot reload signals manager for Valdi framework.
class HotReloadManager {
  static final Map<String, dynamic> _preservedState = {};

  static void preserveState(String key, dynamic state) {
    _preservedState[key] = state;
  }

  static dynamic restoreState(String key) {
    return _preservedState[key];
  }

  static void triggerHotReload(ValdiComponent newTree) {
    // Re-renders root tree preserving state keys
  }

  static void clear() {
    _preservedState.clear();
  }
}
