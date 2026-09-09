import '../reconciler/reconciler.dart';
import '../bridge/zero_fork_manager.dart';

/// Renderer that translates Valdi render patches into zero-fork native platform views (UIView/Android View).
class NativeRenderer {
  final ZeroForkManager zeroForkManager = ZeroForkManager();
  final Map<String, int> _componentKeyToViewId = {};

  void applyPatches(List<RenderPatch> patches) {
    for (final patch in patches) {
      switch (patch.type) {
        case PatchType.create:
          final layout = patch.layout!;
          final handle = zeroForkManager.createNativeView(
            patch.componentType ?? 'View',
            layout,
            patch.props ?? {},
          );
          if (patch.key != null) {
            _componentKeyToViewId[patch.key!] = handle.viewId;
          }
          break;

        case PatchType.update:
          if (patch.key != null && _componentKeyToViewId.containsKey(patch.key)) {
            final viewId = _componentKeyToViewId[patch.key]!;
            zeroForkManager.updateNativeView(
              viewId,
              patch.layout!,
              patch.props ?? {},
            );
          }
          break;

        case PatchType.delete:
          if (patch.key != null && _componentKeyToViewId.containsKey(patch.key)) {
            final viewId = _componentKeyToViewId.remove(patch.key)!;
            zeroForkManager.destroyNativeView(viewId);
          }
          break;

        case PatchType.reorder:
          break;
      }
    }
  }

  void reset() {
    _componentKeyToViewId.clear();
    zeroForkManager.clearAll();
  }
}
