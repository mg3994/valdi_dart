/// Valdi Dart Framework Entrypoint.
///
/// A cross-platform declarative UI framework for Dart featuring Yoga flexbox layout,
/// zero-fork Flutter / native view binding (Valdi style), dynamic FFI interop (DartNative style),
/// fluid glass merge effects, clear large title bars, chat avatar banner notifications,
/// native map markers & camera updates, multi-line flex wrapping, zero-copy HW video texture streaming,
/// native event streams, tab bars & bottom navigation, paginated infinite lists, OS app lifecycle observers,
/// image memory caching, real-time FFI WebSockets, biometric authentication (FaceID/TouchID),
/// slide/sheet route transitions, neural TTS voice configuration, background job schedulers,
/// dynamic wallpaper color palettes, content windowing list controllers, sparkline charts,
/// on-device vision ML inference, fluid glass shaders, shimmer placeholders, neural audio streamers,
/// isolate processing, method channel migration bridges, controlled forms, responsive layout,
/// reactive signals & signal stores, native routing, gestures, accessibility semantics,
/// SQLite & secure keychain database, social auth sheets, FFI networking, system localizations,
/// camera & Lottie sticker engines, DevTools inspector, frame profiler, hot reload, and optional Skia direct canvas rendering.
library valdi;

export 'src/layout/yoga_node.dart';
export 'src/layout/yoga_style.dart';
export 'src/layout/layout_engine.dart';
export 'src/layout/responsive.dart';
export 'src/layout/flex_wrap.dart';

export 'src/component/valdi_component.dart';
export 'src/component/builder.dart';
export 'src/component/flutter_widgets.dart';
export 'src/component/list_view.dart';
export 'src/component/grid_view.dart';
export 'src/component/shimmer.dart';
export 'src/component/scroll_window.dart';
export 'src/component/paginated_list.dart';
export 'src/reconciler/reconciler.dart';

export 'src/accessibility/semantics.dart';
export 'src/gesture/gestures.dart';
export 'src/state/signals.dart';
export 'src/state/signal_store.dart';
export 'src/navigation/navigator.dart';
export 'src/navigation/search_bar.dart';
export 'src/navigation/transitions.dart';
export 'src/navigation/tab_bar.dart';
export 'src/graphics/canvas.dart';
export 'src/graphics/shaders.dart';
export 'src/graphics/sparkline.dart';
export 'src/network/http_client.dart';
export 'src/network/websocket.dart';
export 'src/network/event_stream.dart';
export 'src/i18n/localizations.dart';
export 'src/storage/valdi_storage.dart';
export 'src/storage/database.dart';
export 'src/auth/auth_widgets.dart';
export 'src/auth/biometrics.dart';
export 'src/form/forms.dart';

export 'src/plugin/valdi_plugin.dart';
export 'src/plugin/platform_channel.dart';
export 'src/isolate/isolate_bridge.dart';
export 'src/isolate/job_scheduler.dart';
export 'src/ml/vision_ml.dart';

export 'src/animation/animation.dart';
export 'src/theme/material.dart';
export 'src/theme/dynamic_color.dart';
export 'src/theme/glass_effects.dart';
export 'src/media/media_widgets.dart';
export 'src/media/media_extensions.dart';
export 'src/media/map_extensions.dart';
export 'src/media/image_cache.dart';
export 'src/media/video_texture.dart';
export 'src/media/audio_engine.dart';
export 'src/media/neural_audio.dart';
export 'src/media/voice_config.dart';
export 'src/platform/platform_services.dart';
export 'src/platform/app_lifecycle.dart';
export 'src/platform/rich_notifications.dart';

export 'src/devtools/inspector.dart';
export 'src/devtools/profiler.dart';
export 'src/devtools/hot_reload.dart';

export 'src/bridge/zero_fork_manager.dart';
export 'src/bridge/native_bridge.dart';

export 'src/render/native_renderer.dart';
export 'src/render/skia_renderer.dart';
export 'src/render/valdi_render_controller.dart';
