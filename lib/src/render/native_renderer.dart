import '../reconciler/reconciler.dart';
import '../bridge/zero_fork_manager.dart';

/// Renderer that translates Valdi render patches recursively into zero-fork native platform views (UIView/Android View).
class NativeRenderer {
  final ZeroForkManager zeroForkManager = ZeroForkManager();
  final Map<String, int> _componentKeyToViewId = {};

  void applyPatches(List<RenderPatch> patches) {
    for (final patch in patches) {
      _applySinglePatch(patch);
    }
  }

  void _applySinglePatch(RenderPatch patch) {
    switch (patch.type) {
      case PatchType.create:
        final layout = patch.layout;
        if (layout != null) {
          final handle = zeroForkManager.createNativeView(
            patch.componentType ?? 'View',
            layout,
            patch.props ?? {},
          );
          if (patch.key != null) {
            _componentKeyToViewId[patch.key!] = handle.viewId;
          }
        }
        for (final childPatch in patch.childPatches) {
          _applySinglePatch(childPatch);
        }
        break;

      case PatchType.update:
        if (patch.key != null && _componentKeyToViewId.containsKey(patch.key)) {
          final viewId = _componentKeyToViewId[patch.key]!;
          if (patch.layout != null) {
            zeroForkManager.updateNativeView(
              viewId,
              patch.layout!,
              patch.props ?? {},
            );
          }
        }
        for (final childPatch in patch.childPatches) {
          _applySinglePatch(childPatch);
        }
        break;

      case PatchType.delete:
        if (patch.key != null && _componentKeyToViewId.containsKey(patch.key)) {
          final viewId = _componentKeyToViewId.remove(patch.key)!;
          zeroForkManager.destroyNativeView(viewId);
        }
        for (final childPatch in patch.childPatches) {
          _applySinglePatch(childPatch);
        }
        break;

      case PatchType.reorder:
        break;
    }
  }

  void reset() {
    _componentKeyToViewId.clear();
    zeroForkManager.clearAll();
  }
}
