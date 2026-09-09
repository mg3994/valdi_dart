/// Valdi Dart Framework Entrypoint.
///
/// A cross-platform declarative UI framework for Dart featuring Yoga flexbox layout,
/// zero-fork Flutter / native view binding (Valdi style), dynamic FFI interop (DartNative style),
/// and optional Skia direct canvas rendering.
library valdi;

export 'src/layout/yoga_node.dart';
export 'src/layout/yoga_style.dart';
export 'src/layout/layout_engine.dart';

export 'src/component/valdi_component.dart';
export 'src/reconciler/reconciler.dart';

export 'src/bridge/zero_fork_manager.dart';
export 'src/bridge/native_bridge.dart';

export 'src/render/native_renderer.dart';
export 'src/render/skia_renderer.dart';
export 'src/render/valdi_render_controller.dart';
