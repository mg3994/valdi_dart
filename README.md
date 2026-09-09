# Valdi Dart Framework (`valdi`)

A declarative, cross-platform UI framework in Dart combining Snapchat's **Valdi** and **DartNative** architectural principles, featuring **zero-fork Flutter integration** (inspired by Matej Knopp's `flutter_zero`), **Yoga flexbox layout engine**, dynamic FFI interop, reactive signal state management, native navigation, custom canvas graphics, and an **optional Skia rendering backend**.

---

## Architectural Foundations & DartNative Alignment

1. **Flutter-Compatible Layout Vocabulary**:
   - High-level layout widgets matching Flutter's API: `Row`, `Column`, `Stack`, `Positioned`, `Expanded`, `SizedBox`, `Container`, `Padding`.
   - Windowed high-performance list view (`ListView`, `ListView.builder`) mapped to native `UITableView` / `RecyclerView` backings.

2. **Reactive Signal & Provided State Management (DartNative style)**:
   - Zero-boilerplate reactive signals (`Signal<T>`) and watcher dependency tracking.
   - Subtree dependency context injection (`Provided<T>`) without requiring complex provider scopes or boilerplate base classes.

3. **Native Navigator & Page Transitions**:
   - Native route stack management (`Navigator`, `Route`, `MaterialPageRoute`) using OS native page transitions and back gestures.

4. **Native Canvas & CustomPainter Engine**:
   - `CustomPainter`, `Canvas`, `Paint`, `Path`, and `Color` mapping directly to CoreGraphics, Android Canvas, or Skia.

5. **Yoga Flexbox Layout Engine**:
   - W3C-compliant layout solver (`YogaNode`, `YogaStyle`, `LayoutEngine`) with configurable native C `libyoga` bindings and pure Dart solver fallback.

6. **Zero-Fork Flutter Native View Integration (`flutter_zero` style)**:
   - Direct native view creation and lifecycle management (`ZeroForkManager`, `NativeViewHandle`) bypassing standard Flutter platform view overhead and engine modifications.

7. **Direct FFI Storage & Dynamic Interop Bridge**:
   - Low-latency FFI Key-Value storage (`ValdiStorage`) for SharedPreferences / Keychain / SQLite.
   - Dynamic bi-directional C/C++ FFI dispatch bridge (`NativeBridge`, `ValdiPlugin`) for plugin ecosystems.

8. **Dual-Mode Rendering Pipeline (Native Views & Optional Skia)**:
   - **Native Views Mode (Default / Valdi style)**: Translates component patches directly into native UI views (UIView / Android View).
   - **Optional Skia Canvas Mode (DartNative style)**: Direct-to-Skia surface rendering via recorded draw commands (`SkiaRenderer`, `SkiaDrawCommand`), dynamically togglable via `ValdiRenderController`.

---

## Code Example

```dart
import 'package:valdi/valdi.dart';

// 1. Reactive State via Signals
final counterSignal = Signal<int>(0);

class CounterScreen extends ValdiComponent {
  @override
  ValdiComponent build() {
    return Column(
      children: [
        Text('Count: ${counterSignal.value}'),
        Button(
          label: 'Increment',
          onPressed: () => counterSignal.update((c) => c + 1),
        ),
      ],
    );
  }
}

void main() {
  final controller = ValdiRenderController();

  // Push Route to Native Navigator
  Navigator.pushNamed('/home', () => CounterScreen());

  // Render via Primary Native View Backend (Zero-Fork)
  controller.setRenderBackend(RenderBackend.nativeViews);
  controller.render(Navigator.currentRoute!.buildPage());

  // Switch to Optional Skia Canvas Backend
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

Run the example application:

```bash
dart run example/main.dart
```
