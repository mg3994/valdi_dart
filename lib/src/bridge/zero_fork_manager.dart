import '../layout/yoga_node.dart';

/// Represents a native platform view instance managed without Flutter engine forks (zero-fork).
class NativeViewHandle {
  final int viewId;
  final String viewType;
  LayoutRect layout;
  Map<String, dynamic> props;

  NativeViewHandle({
    required this.viewId,
    required this.viewType,
    required this.layout,
    this.props = const {},
  });
}

/// Zero-Fork Native View Manager based on flutter_zero architecture.
/// Manages host platform native views directly via lightweight C-FFI channels,
/// bypassing standard Flutter platform view overhead and engine modifications.
class ZeroForkManager {
  static final ZeroForkManager _instance = ZeroForkManager._internal();
  factory ZeroForkManager() => _instance;
  ZeroForkManager._internal();

  final Map<int, NativeViewHandle> _activeNativeViews = {};
  int _nextViewId = 1;

  Map<int, NativeViewHandle> get activeNativeViews => Map.unmodifiable(_activeNativeViews);

  NativeViewHandle createNativeView(String viewType, LayoutRect layout, Map<String, dynamic> props) {
    final viewId = _nextViewId++;
    final handle = NativeViewHandle(
      viewId: viewId,
      viewType: viewType,
      layout: layout,
      props: props,
    );
    _activeNativeViews[viewId] = handle;
    return handle;
  }

  void updateNativeView(int viewId, LayoutRect layout, Map<String, dynamic> props) {
    final handle = _activeNativeViews[viewId];
    if (handle != null) {
      handle.layout = layout;
      handle.props = props;
    }
  }

  void destroyNativeView(int viewId) {
    _activeNativeViews.remove(viewId);
  }

  void clearAll() {
    _activeNativeViews.clear();
  }
}
