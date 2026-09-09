import 'dart:ffi' as ffi;
import 'yoga_node.dart';
import 'yoga_style.dart';

/// Layout Engine providing high-level layout calculations and optional native C-FFI Yoga bindings.
class LayoutEngine {
  static bool _useNativeYoga = false;
  static ffi.DynamicLibrary? _yogaLib;

  /// Enable or disable native C libyoga FFI bindings.
  static void configureNativeYoga({required bool enabled, String? libraryPath}) {
    _useNativeYoga = enabled;
    if (enabled && libraryPath != null) {
      try {
        _yogaLib = ffi.DynamicLibrary.open(libraryPath);
      } catch (e) {
        _useNativeYoga = false;
        print('Native Yoga FFI library not available, falling back to pure Dart layout solver: $e');
      }
    }
  }

  /// Whether native Yoga bindings are active.
  static bool get isNativeYogaActive => _useNativeYoga && _yogaLib != null;

  /// Solves the layout for the given node hierarchy.
  static void solve(YogaNode rootNode, {double? width, double? height}) {
    rootNode.calculateLayout(parentWidth: width, parentHeight: height);
  }
}
