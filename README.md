# Valdi Dart Framework (`valdi`)

A declarative, cross-platform UI framework in Dart combining Snapchat's **Valdi** and **DartNative** architectural principles, featuring **zero-fork Flutter integration** (inspired by Matej Knopp's `flutter_zero`), **Yoga flexbox layout engine**, dynamic FFI interop, image memory caching (`ValdiImageCache`, `NetworkImageView`), real-time bi-directional WebSockets (`ValdiWebSocket`), biometric authentication (`BiometricAuth`: FaceID/TouchID/BiometricPrompt), native route transitions (slide, fade, sheet), neural TTS voice configuration, background job schedulers, dynamic wallpaper color palettes, content windowing list controllers, sparkline charts, on-device vision ML inference, fluid glass depth canvas shaders, shimmer preloader tiles, neural voice audio streamers, off-main-thread isolate execution, Flutter MethodChannel migration bridges, controlled forms, responsive layout breakpoints, reactive signal stores, accessibility semantics, DevTools tree inspector, frame profiler & telemetry, hot reload state preservation, FFI networking, system i18n localizations, interactive gestures, SQLite & Keychain database, social auth sheets, camera & sticker engines, native navigation, search choreography, custom canvas graphics, animations, Material 3 / LiquidGlass materials, and an **optional Skia direct canvas rendering backend**.

---

## Architectural Foundations & Capabilities Map

1. **Image Caching & NetworkImageView**:
   - Fast LRU in-memory image cache (`ValdiImageCache`) and network image widget (`NetworkImageView`).

2. **Real-time FFI WebSockets**:
   - Bi-directional streaming WebSocket client (`ValdiWebSocket`) operating over native OS socket stack over FFI.

3. **Biometric Security & Authentication**:
   - FaceID / TouchID / BiometricPrompt authentication over FFI (`BiometricAuth`).

4. **Native Route Transitions & Gestures**:
   - Platform navigation transitions: `SlideRouteTransition`, `FadeRouteTransition`, `SheetRouteTransition`.

5. **On-Device Neural Voice Customization**:
   - Voice configuration & language model selection (`NeuralVoiceConfig`, `NeuralTTSVoice`) over SuperTonic-3 ONNX/FFI.

6. **Background Job Scheduler & Worker Thread Pool**:
   - Multi-threaded worker pool (`ValdiWorkerThread`) & periodic job scheduler (`JobScheduler`).

7. **Dynamic Wallpaper Palettes & System Theme Listener**:
   - Extraction of OS Material You wallpaper palettes (`DynamicColorPalette`).
   - FFI-driven OS light/dark theme listener (`SystemThemeListener`).

8. **Content Windowing & Native Scroll Telemetry**:
   - Flat-memory windowing controller (`ContentWindowController`) for 10,000+ row native lists without jank.
   - Native scroll velocity and offset telemetry (`ScrollTelemetry`).

9. **Touch-Interactive Native Canvas Sparklines**:
   - Canvas sparkline chart renderer (`SparklineChart`, `SparklinePainter`) and scrubber controller (`ChartScrubber`).

10. **On-Device Vision Machine Learning & Tensor Inference**:
    - On-device computer vision and tensor classification (`ValdiVisionML`, `TensorClassifier`) over CoreML / TFLite FFI.

11. **Fluid Canvas Shaders & Depth Effects**:
    - GPU-accelerated fluid glass depth canvas shader (`FluidGlassShader`, `LiquidShaderPainter`).

12. **Shimmer Preloader & Infinite Grid Masonry**:
    - Shimmer preloader tiles (`ShimmerPlaceholder`, `ShimmerMasonryTile`) for Masonry photo grids.

13. **On-Device Neural Voice & Streaming TTS**:
    - Chunk-by-chunk streaming neural text-to-speech engine (`NeuralAudioStreamer`).

14. **Background Isolate Bridge**:
    - Off-main-thread execution for heavy FFI & layout tasks (`ValdiIsolateBridge`, `BackgroundTaskManager`).

15. **Flutter PlatformChannel Migration Bridges**:
    - Backward-compatibility fallback bridges for legacy Flutter plugins (`ValdiPlatformChannel`, `ValdiEventChannel`).

16. **Controlled Inputs & Forms**:
    - Controlled text input and form validation (`TextField`, `TextEditingController`, `Form`).

17. **Responsive Breakpoints & LayoutBuilder**:
    - Box constraints inspection (`LayoutBuilder`, `BoxConstraints`) and mobile/tablet/desktop breakpoint layout switching (`ResponsiveLayout`).

18. **DevTools & Profiler Suite**:
    - Widget tree serialization and hierarchy inspector (`ValdiDevTools`, `WidgetTreeInspector`).
    - Frame render timing telemetry and metrics (`ValdiProfiler`, `RenderMetrics`).
    - Hot reload state preservation signal manager (`HotReloadManager`).

19. **Accessibility & Screen Readers**:
    - Accessibility semantic nodes (`Semantics`, `SemanticNode`) providing VoiceOver & TalkBack tree info.

20. **Reactive Signal Stores & Action Dispatching**:
    - Centralized state stores (`SignalStore<S>`, `Action`) managing reactive signal updates via action dispatchers.

21. **Direct FFI HTTP Networking & i18n Localizations**:
    - High-performance HTTP client (`ValdiHttpClient`, `HttpResponse`) running directly on OS URLSession/Cronet over FFI.
    - System locale detection and translations (`ValdiLocalizations`).

22. **Flutter Layout & Core Vocabulary**:
    - Layout primitives: `Row`, `Column`, `Stack`, `Positioned`, `Expanded`, `SizedBox`, `Container`, `Padding`.
    - Windowed high-performance native list (`ListView`, `ListView.builder`) backed by `UITableView` / `RecyclerView`.
    - Infinite photo grid layout (`MasonryGridView`) and virtualized `SliverList`.

23. **Gestures & Interactive Input**:
    - Touch, tap, double tap, and drag gesture recognizers (`GestureDetector`, `TapGestureRecognizer`, `PanGestureRecognizer`).

24. **Database & Secure Key-Value Storage**:
    - FFI-backed SQLite database store (`SQLiteStore`).
    - Hardware-backed secure Keychain / Keystore storage (`KeychainStore`).
    - Fast Key-Value storage (`ValdiStorage`).

25. **Social Authentication & Credential Sheets**:
    - Drop-in ASAuthorizationController sheet (`AppleSignInButton`).
    - Credential Manager sheet (`GoogleSignInButton`).
    - FFI Authentication Service (`AuthService`).

26. **Camera & Lottie Sticker Engines**:
    - Live native camera preview & capture controller (`CameraView`, `CameraController`).
    - Lottie CDN animation sticker grid (`LottieStickerGrid`, `LottieView`).

27. **Search Bar Choreography & Navigation**:
    - iOS 26 Apple in-place search choreography & Material 3 search bar (`SearchBar`, `SearchAppBar`).
    - Native route stack manager (`Navigator`, `Route`, `MaterialPageRoute`).

28. **Animations & Shared Element Transitions**:
    - Frame and status-driven animations (`AnimationController`, `Tween`).
    - Shared element page transitions (`Hero`) matching DartNative Hero stories pattern.

29. **Material 3 & Modern Native Materials**:
    - iOS 26 / Material 3 blurred glass material (`LiquidGlass`).
    - Material 3 badge system (`M3Badge`) and themes (`MaterialTheme`).

30. **Native Media & Real-time Audio Engine**:
    - `VideoPlayer` (backed by AVPlayer / ExoPlayer).
    - `AudioEngine` & `AudioPlayer` (background audio & neural stream engine).

31. **Platform Capabilities & Dynamic FFI Bridge**:
    - Push & Local Notifications (`NotificationManager` over FFI).
    - Neural Text-to-Speech (`TextToSpeechEngine` over ONNX / FFI).
    - Dynamic Plugin Bridge (`ValdiPlugin`).

32. **Reactive Signal State Management**:
    - Zero-boilerplate reactive state (`Signal<T>`) and watcher dependency tracking.
    - Subtree context dependency injection (`Provided<T>`).

33. **Yoga Flexbox Engine**:
    - W3C-compliant layout solver (`YogaNode`, `YogaStyle`, `LayoutEngine`) with optional native C `libyoga` bindings.

34. **Zero-Fork Flutter Engine Integration (`flutter_zero` style)**:
    - Direct native view creation and lifecycle management (`ZeroForkManager`, `NativeViewHandle`) without Flutter engine modifications.

35. **Dual-Mode Rendering Pipeline (Native Views & Optional Skia Canvas)**:
    - **Native Views Mode (Default / Valdi style)**: Translates component patches directly into native UI views.
    - **Optional Skia Canvas Mode (DartNative style)**: Direct-to-Skia surface rendering via recorded draw commands (`SkiaRenderer`), dynamically togglable via `ValdiRenderController`.

---

## Code Example

```dart
import 'package:valdi/valdi.dart';

void main() async {
  // Biometric Auth over FFI
  final bio = BiometricAuth();
  await bio.authenticate(reason: 'Unlock App');

  // Real-time WebSocket over FFI
  final ws = ValdiWebSocket('wss://realtime.valdi.native');
  await ws.connect();

  // Cached Network Image
  ValdiImageCache.cacheImage('https://cdn.example.com/a.jpg', 'local/cached.jpg');

  final root = NetworkImageView(url: 'https://cdn.example.com/a.jpg');

  final controller = ValdiRenderController();

  // Primary Native Views Backend
  controller.setRenderBackend(RenderBackend.nativeViews);
  controller.render(root);

  // Optional Skia Direct Canvas Backend
  controller.setRenderBackend(RenderBackend.skiaCanvas);
  controller.render(root);
}
```

---

## Running Tests & Example

Run unit and integration tests:

```bash
dart test
```

Run the demonstration application:

```bash
dart run example/main.dart
```
