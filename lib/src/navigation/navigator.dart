import '../component/valdi_component.dart';

/// Base Route representation for Valdi / DartNative Navigator.
abstract class Route<T> {
  final String? name;

  Route({this.name});

  ValdiComponent buildPage();
}

/// MaterialPageRoute implementation holding page builder closure.
class MaterialPageRoute<T> extends Route<T> {
  final ValdiComponent Function() builder;

  MaterialPageRoute({required this.builder, super.name});

  @override
  ValdiComponent buildPage() => builder();
}

/// Native Navigator & Routing Manager (DartNative Navigator pattern).
class Navigator {
  static final List<Route<dynamic>> _routeStack = [];

  static List<Route<dynamic>> get routeStack => List.unmodifiable(_routeStack);

  static Route<dynamic>? get currentRoute => _routeStack.isNotEmpty ? _routeStack.last : null;

  static void push(Route<dynamic> route) {
    _routeStack.add(route);
  }

  static Route<dynamic>? pop() {
    if (_routeStack.isNotEmpty) {
      return _routeStack.removeLast();
    }
    return null;
  }

  static void pushNamed(String name, ValdiComponent Function() builder) {
    push(MaterialPageRoute(name: name, builder: builder));
  }

  static void reset() {
    _routeStack.clear();
  }
}
