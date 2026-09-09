# Valdi Dart Framework (`valdi`)

A declarative, cross-platform UI framework in Dart combining Snapchat's **Valdi** and **DartNative** architectural principles, featuring **zero-fork Flutter integration** (inspired by Matej Knopp's `flutter_zero`), **Yoga flexbox layout engine**, dynamic FFI interop, reactive signal stores, accessibility semantics, DevTools tree inspector, frame profiler & telemetry, hot reload state preservation, FFI networking, system i18n localizations, interactive gestures, SQLite & Keychain database, social auth sheets, camera & sticker engines, native navigation, search choreography, custom canvas graphics, animations, Material 3 / LiquidGlass materials, and an **optional Skia direct canvas rendering backend**.

---

## Architectural Foundations & Capabilities Map

1. **DevTools & Profiler Suite**:
   - Widget tree serialization and hierarchy inspector (`ValdiDevTools`, `WidgetTreeInspector`).
   - Frame render timing telemetry and metrics (`ValdiProfiler`, `RenderMetrics`).
   - Hot reload state preservation signal manager (`HotReloadManager`).

2. **Accessibility & Screen Readers**:
   - Accessibility semantic nodes (`Semantics`, `SemanticNode`) providing VoiceOver & TalkBack tree info.

3. **Reactive Signal Stores & Action Dispatching**:
   - Centralized state stores (`SignalStore<S>`, `Action`) managing reactive signal updates via action dispatchers.

4. **Direct FFI HTTP Networking & i18n Localizations**:
   - High-performance HTTP client (`ValdiHttpClient`, `HttpResponse`) running directly on OS URLSession/Cronet over FFI.
   - System locale detection and translations (`ValdiLocalizations`).

5. **Flutter Layout & Core Vocabulary**:
   - Layout primitives: `Row`, `Column`, `Stack`, `Positioned`, `Expanded`, `SizedBox`, `Container`, `Padding`.
   - Windowed high-performance native list (`ListView`, `ListView.builder`) backed by `UITableView` / `RecyclerView`.
   - Infinite photo grid layout (`MasonryGridView`) and virtualized `SliverList`.

6. **Gestures & Interactive Input**:
   - Touch, tap, double tap, and drag gesture recognizers (`GestureDetector`, `TapGestureRecognizer`, `PanGestureRecognizer`).

7. **Database & Secure Key-Value Storage**:
   - FFI-backed SQLite database store (`SQLiteStore`).
   - Hardware-backed secure Keychain / Keystore storage (`KeychainStore`).
   - Fast Key-Value storage (`ValdiStorage`).

8. **Social Authentication & Credential Sheets**:
   - Drop-in ASAuthorizationController sheet (`AppleSignInButton`).
   - Credential Manager sheet (`GoogleSignInButton`).
   - FFI Authentication Service (`AuthService`).

9. **Camera & Lottie Sticker Engines**:
   - Live native camera preview & capture controller (`CameraView`, `CameraController`).
   - Lottie CDN animation sticker grid (`LottieStickerGrid`, `LottieView`).

10. **Search Bar Choreography & Navigation**:
    - iOS 26 Apple in-place search choreography & Material 3 search bar (`SearchBar`, `SearchAppBar`).
    - Native route stack manager (`Navigator`, `Route`, `MaterialPageRoute`).

11. **Animations & Shared Element Transitions**:
    - Frame and status-driven animations (`AnimationController`, `Tween`).
    - Shared element page transitions (`Hero`) matching DartNative Hero stories pattern.

12. **Material 3 & Modern Native Materials**:
    - iOS 26 / Material 3 blurred glass material (`LiquidGlass`).
    - Material 3 badge system (`M3Badge`) and themes (`MaterialTheme`).

13. **Native Media & Real-time Audio Engine**:
    - `VideoPlayer` (backed by AVPlayer / ExoPlayer).
    - `AudioEngine` & `AudioPlayer` (background audio & neural stream engine).

14. **Platform Capabilities & Dynamic FFI Bridge**:
    - Push & Local Notifications (`NotificationManager` over FFI).
    - Neural Text-to-Speech (`TextToSpeechEngine` over ONNX / FFI).
    - Dynamic Plugin Bridge (`ValdiPlugin`).

15. **Reactive Signal State Management**:
    - Zero-boilerplate reactive state (`Signal<T>`) and watcher dependency tracking.
    - Subtree context dependency injection (`Provided<T>`).

16. **Yoga Flexbox Engine**:
    - W3C-compliant layout solver (`YogaNode`, `YogaStyle`, `LayoutEngine`) with optional native C `libyoga` bindings.

17. **Zero-Fork Flutter Engine Integration (`flutter_zero` style)**:
    - Direct native view creation and lifecycle management (`ZeroForkManager`, `NativeViewHandle`) without Flutter engine modifications.

18. **Dual-Mode Rendering Pipeline (Native Views & Optional Skia Canvas)**:
    - **Native Views Mode (Default / Valdi style)**: Translates component patches directly into native UI views.
    - **Optional Skia Canvas Mode (DartNative style)**: Direct-to-Skia surface rendering via recorded draw commands (`SkiaRenderer`), dynamically togglable via `ValdiRenderController`.

---

## Code Example

```dart
import 'package:valdi/valdi.dart';

void main() async {
  // DevTools & Profiler setup
  ValdiDevTools.log('DevTools active');
  HotReloadManager.preserveState('session_id', '12345');

  final root = Semantics(
    label: 'Root Node',
    child: Text('Hello Valdi'),
  );

  // DevTools inspection
  final treeMap = ValdiDevTools.inspectComponent(root);

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
