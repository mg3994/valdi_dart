import '../component/valdi_component.dart';
import '../reconciler/reconciler.dart';
import 'native_renderer.dart';
import 'skia_renderer.dart';

enum RenderBackend { nativeViews, skiaCanvas }

/// Master Rendering Controller managing the dual-mode pipeline:
/// Primary Native View Mode (Valdi architecture with zero-fork Flutter)
/// Optional Skia Canvas Mode (DartNative optional Skia rendering architecture).
class ValdiRenderController {
  RenderBackend _backend = RenderBackend.nativeViews;
  final NativeRenderer _nativeRenderer = NativeRenderer();
  final SkiaRenderer _skiaRenderer = SkiaRenderer();

  ValdiComponent? _currentTree;

  RenderBackend get backend => _backend;
  NativeRenderer get nativeRenderer => _nativeRenderer;
  SkiaRenderer get skiaRenderer => _skiaRenderer;

  /// Configure rendering backend (Native Views vs Optional Skia direct Canvas).
  void setRenderBackend(RenderBackend backend) {
    _backend = backend;
    if (_currentTree != null) {
      render(_currentTree!);
    }
  }

  /// Render or re-render a component tree to active backend.
  void render(ValdiComponent newTree, {double width = 375.0, double height = 812.0}) {
    final patches = Reconciler.reconcile(_currentTree, newTree, width: width, height: height);
    _currentTree = newTree;

    if (_backend == RenderBackend.nativeViews) {
      _skiaRenderer.reset();
      _nativeRenderer.applyPatches(patches);
    } else {
      _nativeRenderer.reset();
      _skiaRenderer.renderFromPatches(patches);
    }
  }
}
