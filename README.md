# Valdi Dart Framework (`valdi`)

A declarative, cross-platform UI framework in Dart inspired by Snapchat's **Valdi** and **DartNative**, featuring **zero-fork Flutter integration** (inspired by Matej Knopp's `flutter_zero`), **Yoga flexbox layout engine**, dynamic FFI interop, and an **optional Skia rendering backend**.

---

## Key Features & Architectural Foundations

1. **Valdi-Inspired Declarative Paradigm**:
   - Write UI components in pure Dart using intuitive declarative primitives (`View`, `Text`, `Image`, `Button`, `ScrollView`, `StatefulComponent`).
   - Virtual DOM tree diffing and reconciler (`Reconciler`) generating minimal patches (`RenderPatch`) for state updates.

2. **Yoga Flexbox Layout Engine**:
   - Built-in Flexbox solver (`YogaNode`, `YogaStyle`, `LayoutEngine`) adhering to W3C Flexbox specifications.
   - Configurable C-FFI bindings to native `libyoga` with automatic fallback to pure Dart flexbox layout calculation.

3. **Zero-Fork Flutter Native View Integration (`flutter_zero` style)**:
   - Direct native view creation and lifecycle management (`ZeroForkManager`, `NativeViewHandle`) bypassing standard Flutter platform view overhead and without requiring custom Flutter engine forks.

4. **DartNative Bi-Directional Interop Bridge**:
   - Dynamic C/C++ FFI dispatch bridge (`NativeBridge`) for direct bi-directional native host platform calls (ObjC/Swift on iOS, JNI/Kotlin on Android).

5. **Dual-Mode Rendering Engine with Optional Skia Backend**:
   - **Native Views Mode (Default / Valdi style)**: Translates component patches directly into native UI views (UIView / Android View) for maximum native platform performance and accessibility.
   - **Optional Skia Canvas Mode (DartNative style)**: Directly draws UI nodes to a Skia canvas surface via recorded draw commands (`SkiaRenderer`, `SkiaDrawCommand`), configurable dynamically at runtime via `ValdiRenderController`.

---

## Directory Architecture

```
valdi/
├── lib/
│   ├── valdi.dart                           # Main library export file
│   └── src/
│       ├── layout/
│       │   ├── yoga_style.dart              # Flexbox style definitions and enums
│       │   ├── yoga_node.dart               # Yoga tree node & layout solver
│       │   └── layout_engine.dart           # High-level layout engine & native C-FFI
│       ├── component/
│       │   └── valdi_component.dart         # ValdiComponent, View, Text, Image, Button, etc.
│       ├── reconciler/
│       │   └── reconciler.dart              # Virtual tree reconciliation & patches
│       ├── bridge/
│       │   ├── zero_fork_manager.dart       # Zero-fork native platform view manager
│       │   └── native_bridge.dart           # Dynamic FFI interop bridge (DartNative style)
│       └── render/
│           ├── native_renderer.dart         # Native platform view renderer
│           ├── skia_renderer.dart           # Direct Skia canvas renderer
│           └── valdi_render_controller.dart # Master dual-mode rendering controller
├── example/
│   └── main.dart                            # Demonstration application
└── test/
    ├── layout_test.dart                     # Yoga flexbox solver tests
    ├── reconciler_test.dart                 # Virtual tree diffing & patch tests
    └── bridge_render_test.dart              # Native view bridge & Skia switch tests
```

---

## Getting Started & Usage

### 1. Basic Component Construction

```dart
import 'package:valdi/valdi.dart';

class MyComponent extends StatefulComponent {
  int count = 0;

  @override
  ValdiComponent build() {
    return View(
      style: YogaStyle(
        flexDirection: FlexDirection.column,
        justifyContent: JustifyContent.center,
        alignItems: AlignItems.center,
      ),
      children: [
        Text('Counter: $count', fontSize: 20),
        Button(
          label: 'Increment',
          onPressed: () {
            setState(() => count++);
          },
        ),
      ],
    );
  }
}
```

### 2. Dual-Mode Rendering & Backend Switching

```dart
final controller = ValdiRenderController();
final myApp = MyComponent();

// Default Mode: Native Views (Valdi + Zero-Fork Flutter)
controller.setRenderBackend(RenderBackend.nativeViews);
controller.render(myApp.build());

// Switch Mode: Optional Skia Direct Canvas (DartNative Style)
controller.setRenderBackend(RenderBackend.skiaCanvas);
controller.render(myApp.build());
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
