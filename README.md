# Valdi Dart Framework (`valdi`)

A declarative, cross-platform UI framework in Dart combining Snapchat's **Valdi** and **DartNative** architectural principles, featuring **zero-fork Flutter integration** (inspired by Matej Knopp's `flutter_zero`), **Yoga flexbox layout engine**, dynamic FFI interop, reactive signal state management, interactive gestures, SQLite & Keychain database, social auth sheets, camera & sticker engines, native navigation, search choreography, custom canvas graphics, animations, Material 3 / LiquidGlass materials, and an **optional Skia direct canvas rendering backend**.

---

## Architectural Foundations & Capabilities Map

1. **Flutter Layout & Core Vocabulary**:
   - Layout primitives: `Row`, `Column`, `Stack`, `Positioned`, `Expanded`, `SizedBox`, `Container`, `Padding`.
   - Windowed high-performance native list (`ListView`, `ListView.builder`) backed by `UITableView` / `RecyclerView`.
   - Infinite photo grid layout (`MasonryGridView`) and virtualized `SliverList`.

2. **Gestures & Interactive Input**:
   - Touch, tap, double tap, and drag gesture recognizers (`GestureDetector`, `TapGestureRecognizer`, `PanGestureRecognizer`).

3. **Database & Secure Key-Value Storage**:
   - FFI-backed SQLite database store (`SQLiteStore`).
   - Hardware-backed secure Keychain / Keystore storage (`KeychainStore`).
   - Fast Key-Value storage (`ValdiStorage`).

4. **Social Authentication & Credential Sheets**:
   - Drop-in ASAuthorizationController sheet (`AppleSignInButton`).
   - Credential Manager sheet (`GoogleSignInButton`).
   - FFI Authentication Service (`AuthService`).

5. **Camera & Lottie Sticker Engines**:
   - Live native camera preview & capture controller (`CameraView`, `CameraController`).
   - Lottie CDN animation sticker grid (`LottieStickerGrid`, `LottieView`).

6. **Search Bar Choreography & Navigation**:
   - iOS 26 Apple in-place search choreography & Material 3 search bar (`SearchBar`, `SearchAppBar`).
   - Native route stack manager (`Navigator`, `Route`, `MaterialPageRoute`).

7. **Animations & Shared Element Transitions**:
   - Frame and status-driven animations (`AnimationController`, `Tween`).
   - Shared element page transitions (`Hero`) matching DartNative Hero stories pattern.

8. **Material 3 & Modern Native Materials**:
   - iOS 26 / Material 3 blurred glass material (`LiquidGlass`).
   - Material 3 badge system (`M3Badge`) and themes (`MaterialTheme`).

9. **Native Media & Real-time Audio Engine**:
   - `VideoPlayer` (backed by AVPlayer / ExoPlayer).
   - `AudioEngine` & `AudioPlayer` (background audio & neural stream engine).

10. **Platform Capabilities & Dynamic FFI Bridge**:
    - Push & Local Notifications (`NotificationManager` over FFI).
    - Neural Text-to-Speech (`TextToSpeechEngine` over ONNX / FFI).
    - Dynamic Plugin Bridge (`ValdiPlugin`).

11. **Reactive Signal State Management**:
    - Zero-boilerplate reactive state (`Signal<T>`) and watcher dependency tracking.
    - Subtree context dependency injection (`Provided<T>`).

12. **Yoga Flexbox Engine**:
    - W3C-compliant layout solver (`YogaNode`, `YogaStyle`, `LayoutEngine`) with optional native C `libyoga` bindings.

13. **Zero-Fork Flutter Engine Integration (`flutter_zero` style)**:
    - Direct native view creation and lifecycle management (`ZeroForkManager`, `NativeViewHandle`) without Flutter engine modifications.

14. **Dual-Mode Rendering Pipeline (Native Views & Optional Skia Canvas)**:
    - **Native Views Mode (Default / Valdi style)**: Translates component patches directly into native UI views.
    - **Optional Skia Canvas Mode (DartNative style)**: Direct-to-Skia surface rendering via recorded draw commands (`SkiaRenderer`), dynamically togglable via `ValdiRenderController`.

---

## Code Example

```dart
import 'package:valdi/valdi.dart';

final counterSignal = Signal<int>(0);

class SuiteApp extends ValdiComponent {
  @override
  ValdiComponent build() {
    return GestureDetector(
      onTap: () => print('Tapped!'),
      child: Column(
        children: [
          AppleSignInButton(),
          Text('Count: ${counterSignal.value}'),
          MasonryGridView(
            crossAxisCount: 2,
            itemCount: 4,
            itemBuilder: (i) => Container(height: 100, child: Text('Tile $i')),
          ),
        ],
      ),
    );
  }
}

void main() async {
  final controller = ValdiRenderController();

  // SQLite & Keychain DB operations
  final keychain = KeychainStore();
  await keychain.writeSecure('token', 'sec_123');

  final db = SQLiteStore('app.db');
  await db.insert('users', {'name': 'Valdi'});

  Navigator.pushNamed('/app', () => SuiteApp());

  // Default: Native Views Backend (Valdi + Zero-Fork Flutter)
  controller.setRenderBackend(RenderBackend.nativeViews);
  controller.render(Navigator.currentRoute!.buildPage());

  // Optional Switch: Skia Direct Canvas Backend (DartNative Style)
  controller.setRenderBackend(RenderBackend.skiaCanvas);
  controller.render(Navigator.currentRoute!.buildPage());
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
