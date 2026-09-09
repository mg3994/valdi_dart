import 'package:meta/meta.dart';

typedef SignalListener<T> = void Function(T value);

/// Reactive Signal store inspired by DartNative signal state management.
class Signal<T> {
  T _value;
  final Set<SignalListener<T>> _listeners = {};

  Signal(T initialValue) : _value = initialValue;

  T get value {
    if (_activeWatcher != null) {
      _listeners.add(_activeWatcher as SignalListener<T>);
    }
    return _value;
  }

  set value(T newValue) {
    if (_value != newValue) {
      _value = newValue;
      notifyListeners();
    }
  }

  void update(T Function(T current) updater) {
    value = updater(_value);
  }

  void addListener(SignalListener<T> listener) {
    _listeners.add(listener);
  }

  void removeListener(SignalListener<T> listener) {
    _listeners.remove(listener);
  }

  void notifyListeners() {
    final listenersList = List<SignalListener<T>>.from(_listeners);
    for (final listener in listenersList) {
      listener(_value);
    }
  }

  static dynamic _activeWatcher;

  /// Helper to record dependencies during `watch` calls.
  static R track<R>(SignalListener<dynamic> watcher, R Function() computation) {
    final prevWatcher = _activeWatcher;
    _activeWatcher = watcher;
    try {
      return computation();
    } finally {
      _activeWatcher = prevWatcher;
    }
  }
}

/// Inherited dependency container (DartNative Provided pattern).
class Provided<T> {
  static final Map<Type, dynamic> _dependencies = {};

  static void inject<T>(T dependency) {
    _dependencies[T] = dependency;
  }

  static T get<T>() {
    final dep = _dependencies[T];
    if (dep == null) {
      throw StateError('No Provided<$T> instance registered.');
    }
    return dep as T;
  }

  @visibleForTesting
  static void clear() {
    _dependencies.clear();
  }
}
