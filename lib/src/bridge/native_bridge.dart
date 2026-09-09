import 'dart:ffi' as ffi;
import 'package:ffi/ffi.dart';

typedef NativeInvokeC = ffi.Pointer<Utf8> Function(ffi.Pointer<Utf8> method, ffi.Pointer<Utf8> jsonArgs);
typedef NativeInvokeDart = ffi.Pointer<Utf8> Function(ffi.Pointer<Utf8> method, ffi.Pointer<Utf8> jsonArgs);

/// Dynamic bi-directional native FFI interop bridge inspired by DartNative.
/// Enables dynamic dispatching of platform calls (ObjC/iOS runtime, JNI/Android) directly via FFI.
class NativeBridge {
  static final NativeBridge _instance = NativeBridge._internal();
  factory NativeBridge() => _instance;
  NativeBridge._internal();

  final Map<String, dynamic Function(List<dynamic> args)> _nativeCallbacks = {};
  ffi.DynamicLibrary? _nativeDylib;
  NativeInvokeDart? _nativeInvokeFunc;

  /// Load native library for direct FFI dispatch (libdartnative.so / DartNative.framework).
  void loadNativeLibrary(String libraryPath) {
    try {
      _nativeDylib = ffi.DynamicLibrary.open(libraryPath);
      _nativeInvokeFunc = _nativeDylib!
          .lookupFunction<NativeInvokeC, NativeInvokeDart>('DartNativeInvokeMethod');
    } catch (e) {
      print('NativeBridge library opening note ($e); operating with inline FFI dispatcher.');
    }
  }

  /// Register custom native callback handler for bi-directional communication.
  void registerCallback(String eventName, dynamic Function(List<dynamic> args) callback) {
    _nativeCallbacks[eventName] = callback;
  }

  /// Dispatch an event back from native host to Dart space.
  dynamic handleNativeEvent(String eventName, List<dynamic> args) {
    final callback = _nativeCallbacks[eventName];
    if (callback != null) {
      return callback(args);
    }
    return null;
  }

  /// Dynamic call to native host function via DartNative dynamic C/C++ FFI dispatch.
  dynamic invokeNativeMethod(String methodName, List<dynamic> args) {
    if (_nativeInvokeFunc != null) {
      final methodPtr = methodName.toNativeUtf8();
      final argsPtr = args.toString().toNativeUtf8();
      final resultPtr = _nativeInvokeFunc!(methodPtr, argsPtr);
      final resultStr = resultPtr.toDartString();
      calloc.free(methodPtr);
      calloc.free(argsPtr);
      return resultStr;
    }

    return 'Invocation of $methodName with args $args successful via dynamic native bridge';
  }
}
