# Valdi Dart Framework (`valdi`)

A declarative, cross-platform UI framework in Dart combining Snapchat's **Valdi** and **DartNative** architectural principles, featuring **zero-fork Flutter integration** (inspired by Matej Knopp's `flutter_zero`), **Yoga flexbox layout engine**, dynamic FFI interop, dynamic wallpaper color palettes, content windowing list controllers, sparkline charts, on-device vision ML inference, fluid glass depth canvas shaders, shimmer preloader tiles, neural voice audio streamers, off-main-thread isolate execution, Flutter MethodChannel migration bridges, controlled forms, responsive layout breakpoints, reactive signal stores, accessibility semantics, DevTools tree inspector, frame profiler & telemetry, hot reload state preservation, FFI networking, system i18n localizations, interactive gestures, SQLite & Keychain database, social auth sheets, camera & sticker engines, native navigation, search choreography, custom canvas graphics, animations, Material 3 / LiquidGlass materials, and an **optional Skia direct canvas rendering backend**.

---

## Architectural Foundations & Capabilities Map

1. **Dynamic Wallpaper Palettes & System Theme Listener**:
   - Extraction of OS Material You wallpaper palettes (`DynamicColorPalette`).
   - FFI-driven OS light/dark theme listener (`SystemThemeListener`).

2. **Content Windowing & Native Scroll Telemetry**:
   - Flat-memory windowing controller (`ContentWindowController`) for 10,000+ row native lists without jank.
   - Native scroll velocity and offset telemetry (`ScrollTelemetry`).

3. **Touch-Interactive Native Canvas Sparklines**:
   - Canvas sparkline chart renderer (`SparklineChart`, `SparklinePainter`) and scrubber controller (`ChartScrubber`).

4. **On-Device Vision Machine Learning & Tensor Inference**:
   - On-device computer vision and tensor classification (`ValdiVisionML`, `TensorClassifier`) over CoreML / TFLite FFI.

5. **Fluid Canvas Shaders & Depth Effects**:
   - GPU-accelerated fluid glass depth canvas shader (`FluidGlassShader`, `LiquidShaderPainter`).

6. **Shimmer Preloader & Infinite Grid Masonry**:
   - Shimmer preloader tiles (`ShimmerPlaceholder`, `ShimmerMasonryTile`) for Masonry photo grids.

7. **On-Device Neural Voice & Streaming TTS**:
   - Chunk-by-chunk streaming neural text-to-speech engine (`NeuralAudioStreamer`).

8. **Background Isolate Bridge**:
   - Off-main-thread execution for heavy FFI & layout tasks (`ValdiIsolateBridge`, `BackgroundTaskManager`).

9. **Flutter PlatformChannel Migration Bridges**:
   - Backward-compatibility fallback bridges for legacy Flutter plugins (`ValdiPlatformChannel`, `ValdiEventChannel`).

10. **Controlled Inputs & Forms**:
    - Controlled text input and form validation (`TextField`, `TextEditingController`, `Form`).

11. **Responsive Breakpoints & LayoutBuilder**:
    - Box constraints inspection (`LayoutBuilder`, `BoxConstraints`) and mobile/tablet/desktop breakpoint layout switching (`ResponsiveLayout`).

12. **DevTools & Profiler Suite**:
    - Widget tree serialization and hierarchy inspector (`ValdiDevTools`, `WidgetTreeInspector`).
    - Frame render timing telemetry and metrics (`ValdiProfiler`, `RenderMetrics`).
    - Hot reload state preservation signal manager (`HotReloadManager`).

13. **Accessibility & Screen Readers**:
    - Accessibility semantic nodes (`Semantics`, `SemanticNode`) providing VoiceOver & TalkBack tree info.

14. **Reactive Signal Stores & Action Dispatching**:
    - Centralized state stores (`SignalStore<S>`, `Action`) managing reactive signal updates via action dispatchers.

15. **Direct FFI HTTP Networking & i18n Localizations**:
    - High-performance HTTP client (`ValdiHttpClient`, `HttpResponse`) running directly on OS URLSession/Cronet over FFI.
    - System locale detection and translations (`ValdiLocalizations`).

16. **Flutter Layout & Core Vocabulary**:
    - Layout primitives: `Row`, `Column`, `Stack`, `Positioned`, `Expanded`, `SizedBox`, `Container`, `Padding`.
    - Windowed high-performance native list (`ListView`, `ListView.builder`) backed by `UITableView` / `RecyclerView`.
    - Infinite photo grid layout (`MasonryGridView`) and virtualized `SliverList`.

17. **Gestures & Interactive Input**:
    - Touch, tap, double tap, and drag gesture recognizers (`GestureDetector`, `TapGestureRecognizer`, `PanGestureRecognizer`).

18. **Database & Secure Key-Value Storage**:
    - FFI-backed SQLite database store (`SQLiteStore`).
    - Hardware-backed secure Keychain / Keystore storage (`KeychainStore`).
    - Fast Key-Value storage (`ValdiStorage`).

19. **Social Authentication & Credential Sheets**:
    - Drop-in ASAuthorizationController sheet (`AppleSignInButton`).
    - Credential Manager sheet (`GoogleSignInButton`).
    - FFI Authentication Service (`AuthService`).

20. **Camera & Lottie Sticker Engines**:
    - Live native camera preview & capture controller (`CameraView`, `CameraController`).
    - Lottie CDN animation sticker grid (`LottieStickerGrid`, `LottieView`).

21. **Search Bar Choreography & Navigation**:
    - iOS 26 Apple in-place search choreography & Material 3 search bar (`SearchBar`, `SearchAppBar`).
    - Native route stack manager (`Navigator`, `Route`, `MaterialPageRoute`).

22. **Animations & Shared Element Transitions**:
    - Frame and status-driven animations (`AnimationController`, `Tween`).
    - Shared element page transitions (`Hero`) matching DartNative Hero stories pattern.

23. **Material 3 & Modern Native Materials**:
    - iOS 26 / Material 3 blurred glass material (`LiquidGlass`).
    - Material 3 badge system (`M3Badge`) and themes (`MaterialTheme`).

24. **Native Media & Real-time Audio Engine**:
    - `VideoPlayer` (backed by AVPlayer / ExoPlayer).
    - `AudioEngine` & `AudioPlayer` (background audio & neural stream engine).

25. **Platform Capabilities & Dynamic FFI Bridge**:
    - Push & Local Notifications (`NotificationManager` over FFI).
    - Neural Text-to-Speech (`TextToSpeechEngine` over ONNX / FFI).
    - Dynamic Plugin Bridge (`ValdiPlugin`).

26. **Reactive Signal State Management**:
    - Zero-boilerplate reactive state (`Signal<T>`) and watcher dependency tracking.
    - Subtree context dependency injection (`Provided<T>`).

27. **Yoga Flexbox Engine**:
    - W3C-compliant layout solver (`YogaNode`, `YogaStyle`, `LayoutEngine`) with optional native C `libyoga` bindings.

28. **Zero-Fork Flutter Engine Integration (`flutter_zero` style)**:
    - Direct native view creation and lifecycle management (`ZeroForkManager`, `NativeViewHandle`) without Flutter engine modifications.

29. **Dual-Mode Rendering Pipeline (Native Views & Optional Skia Canvas)**:
    - **Native Views Mode (Default / Valdi style)**: Translates component patches directly into native UI views.
    - **Optional Skia Canvas Mode (DartNative style)**: Direct-to-Skia surface rendering via recorded draw commands (`SkiaRenderer`), dynamically togglable via `ValdiRenderController`.

---

## Code Example

```dart
import 'package:valdi/valdi.dart';

void main() async {
  // System Palette Extraction
  final palette = await DynamicColorPalette.extractFromSystem();

  // On-Device Vision ML Inference
  final ml = TensorClassifier();
  final labels = await ml.runInference('input.jpg');

  // Sparkline Chart & Scrubber
  final scrubber = ChartScrubber()..scrubTo(100.0, 95.0);

  final root = SparklineChart(
    dataPoints: [0.1, 0.4, 0.8, 0.3, 0.9],
    scrubber: scrubber,
  );

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
