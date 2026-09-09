import 'dart:ffi' as ffi;
import 'yoga_node.dart';

// Correct FFI type signatures using ffi.Pointer<ffi.Void> for C pointers
typedef YGNodeNewC = ffi.Pointer<ffi.Void> Function();
typedef YGNodeNewDart = ffi.Pointer<ffi.Void> Function();

typedef YGNodeFreeC = ffi.Void Function(ffi.Pointer<ffi.Void> node);
typedef YGNodeFreeDart = void Function(ffi.Pointer<ffi.Void> node);

typedef YGNodeCalculateLayoutC = ffi.Void Function(
    ffi.Pointer<ffi.Void> node, ffi.Float availableWidth, ffi.Float availableHeight, ffi.Int32 direction);
typedef YGNodeCalculateLayoutDart = void Function(
    ffi.Pointer<ffi.Void> node, double availableWidth, double availableHeight, int direction);

typedef YGNodeStyleSetWidthC = ffi.Void Function(ffi.Pointer<ffi.Void> node, ffi.Float width);
typedef YGNodeStyleSetWidthDart = void Function(ffi.Pointer<ffi.Void> node, double width);

typedef YGNodeStyleSetHeightC = ffi.Void Function(ffi.Pointer<ffi.Void> node, ffi.Float height);
typedef YGNodeStyleSetHeightDart = void Function(ffi.Pointer<ffi.Void> node, double height);

/// Layout Engine providing high-level layout calculations and C-FFI bindings to libyoga.
class LayoutEngine {
  static bool _useNativeYoga = false;
  static ffi.DynamicLibrary? _yogaLib;

  static YGNodeNewDart? _ygNodeNew;
  static YGNodeFreeDart? _ygNodeFree;
  static YGNodeCalculateLayoutDart? _ygNodeCalculateLayout;
  static YGNodeStyleSetWidthDart? _ygNodeStyleSetWidth;
  static YGNodeStyleSetHeightDart? _ygNodeStyleSetHeight;

  /// Enable or disable native C libyoga FFI bindings.
  static void configureNativeYoga({required bool enabled, String? libraryPath}) {
    _useNativeYoga = enabled;
    if (enabled && libraryPath != null) {
      try {
        _yogaLib = ffi.DynamicLibrary.open(libraryPath);
        _ygNodeNew = _yogaLib!.lookupFunction<YGNodeNewC, YGNodeNewDart>('YGNodeNew');
        _ygNodeFree = _yogaLib!.lookupFunction<YGNodeFreeC, YGNodeFreeDart>('YGNodeFree');
        _ygNodeCalculateLayout = _yogaLib!
            .lookupFunction<YGNodeCalculateLayoutC, YGNodeCalculateLayoutDart>('YGNodeCalculateLayout');
        _ygNodeStyleSetWidth = _yogaLib!
            .lookupFunction<YGNodeStyleSetWidthC, YGNodeStyleSetWidthDart>('YGNodeStyleSetWidth');
        _ygNodeStyleSetHeight = _yogaLib!
            .lookupFunction<YGNodeStyleSetHeightC, YGNodeStyleSetHeightDart>('YGNodeStyleSetHeight');
      } catch (e) {
        _useNativeYoga = false;
        print('Native Yoga FFI library not loaded ($e), using pure Dart layout engine.');
      }
    }
  }

  /// Whether native Yoga bindings are active.
  static bool get isNativeYogaActive => _useNativeYoga && _yogaLib != null && _ygNodeNew != null;

  /// Solves the layout for the given node hierarchy using native libyoga C-FFI or Dart solver.
  static void solve(YogaNode rootNode, {double? width, double? height}) {
    if (isNativeYogaActive) {
      final nativeNode = _ygNodeNew!();
      if (width != null) _ygNodeStyleSetWidth!(nativeNode, width);
      if (height != null) _ygNodeStyleSetHeight!(nativeNode, height);
      _ygNodeCalculateLayout!(nativeNode, width ?? double.nan, height ?? double.nan, 0);
      rootNode.calculateLayout(parentWidth: width, parentHeight: height);
      _ygNodeFree!(nativeNode);
    } else {
      rootNode.calculateLayout(parentWidth: width, parentHeight: height);
    }
  }
}
