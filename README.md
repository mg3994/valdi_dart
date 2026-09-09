# Valdi Dart Framework (`valdi`)

A declarative, cross-platform UI framework in Dart combining Snapchat's **Valdi** and **DartNative** architectural principles, featuring **zero-fork Flutter integration** (inspired by Matej Knopp's `flutter_zero`), **Yoga flexbox layout engine**, dynamic FFI interop, reactive signal state management, native navigation, custom canvas graphics, animations, Material 3 / LiquidGlass materials, media views, platform services over FFI, and an **optional Skia direct canvas rendering backend**.

---

## Architectural Foundations & Capabilities Map

1. **Flutter Layout & Core Vocabulary**:
   - Layout primitives: `Row`, `Column`, `Stack`, `Positioned`, `Expanded`, `SizedBox`, `Container`, `Padding`.
   - Windowed high-performance native list (`ListView`, `ListView.builder`) backed by native `UITableView` / `RecyclerView`.

2. **Animations & Shared Element Transitions**:
   - Frame and status-driven animations (`AnimationController`, `Tween`).
   - Shared element page transitions (`Hero`) matching DartNative Hero stories pattern.

3. **Material 3 & Modern Native Materials**:
   - iOS 26 / Material 3 blurred glass material (`LiquidGlass`).
   - Material 3 badge system (`M3Badge`) and themes (`MaterialTheme`).

4. **Native Media & Map Views**:
   - `VideoPlayer` (backed by AVPlayer / ExoPlayer).
   - `LottieView` (backed by native lottie-ios / lottie-android engines).
   - `CameraView` (backed by AVFoundation / CameraX).
   - `MapView` (backed by Google Maps SDK / MKMapView).

5. **Platform Services & FFI Integration**:
   - Authentication (`AuthService`: Sign in with Apple & Google Credential Manager over FFI).
   - Push & Local Notifications (`NotificationManager` over FFI).
   - Neural Text-to-Speech (`TextToSpeechEngine` over ONNX / FFI).
   - Fast Key-Value & Relational Storage (`ValdiStorage`).
   - Dynamic Plugin Bridge (`ValdiPlugin`).

6. **Reactive Signal State Management**:
   - Zero-boilerplate reactive state (`Signal<T>`) and watcher dependency tracking.
   - Subtree context dependency injection (`Provided<T>`).

7. **Native Navigator & Page Transitions**:
   - Route stack manager (`Navigator`, `Route`, `MaterialPageRoute`).

8. **Yoga Flexbox Engine**:
   - W3C-compliant layout solver (`YogaNode`, `YogaStyle`, `LayoutEngine`) with optional native C `libyoga` bindings.

9. **Zero-Fork Flutter Engine Integration (`flutter_zero` style)**:
   - Direct native view creation and lifecycle management (`ZeroForkManager`, `NativeViewHandle`) without Flutter engine modifications.

10. **Dual-Mode Rendering Pipeline (Native Views & Optional Skia Canvas)**:
    - **Native Views Mode (Default / Valdi style)**: Translates component patches directly into native UI views.
    - **Optional Skia Canvas Mode (DartNative style)**: Direct-to-Skia surface rendering via recorded draw commands (`SkiaRenderer`), dynamically togglable via `ValdiRenderController`.

---

## Code Example

```dart
import 'package:valdi/valdi.dart';

final counterSignal = Signal<int>(0);

class HomeScreen extends ValdiComponent {
  @override
  ValdiComponent build() {
    return LiquidGlass(
      child: Column(
        children: [
          Hero(
            tag: 'profile_avatar',
            child: Container(width: 80, height: 80, color: '#007AFF'),
          ),
          Text('Count: ${counterSignal.value}'),
          Button(
            label: 'Increment',
            onPressed: () => counterSignal.update((c) => c + 1),
          ),
          VideoPlayer(url: 'https://cdn.example.com/video.mp4'),
        ],
      ),
    );
  }
}

void main() async {
  final controller = ValdiRenderController();

  Navigator.pushNamed('/home', () => HomeScreen());

  // Default: Native Views Backend (Valdi + Zero-Fork Flutter)
  controller.setRenderBackend(RenderBackend.nativeViews);
  controller.render(Navigator.currentRoute!.buildPage());

  // Optional Switch: Skia Direct Canvas Backend (DartNative Style)
  controller.setRenderBackend(RenderBackend.skiaCanvas);
  controller.render(Navigator.currentRoute!.buildPage());

  // Platform capabilities over FFI
  final auth = AuthService();
  await auth.signInWithApple();
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
