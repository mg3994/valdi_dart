import '../component/valdi_component.dart';
import '../layout/yoga_node.dart';

/// Serializes and inspects active Valdi widget hierarchies for DevTools.
class WidgetTreeInspector {
  static Map<String, dynamic> serializeTree(ValdiComponent rootComponent) {
    final node = rootComponent.toYogaNode();
    return {
      'type': rootComponent.runtimeType.toString(),
      'key': rootComponent.key,
      'layout': {
        'left': node.layout.left,
        'top': node.layout.top,
        'width': node.layout.width,
        'height': node.layout.height,
      },
      'childrenCount': node.children.length,
    };
  }
}

/// Valdi DevTools service interface.
class ValdiDevTools {
  static final List<String> _logs = [];

  static List<String> get logs => List.unmodifiable(_logs);

  static void log(String message) {
    _logs.add('[DevTools] $message');
  }

  static Map<String, dynamic> inspectComponent(ValdiComponent component) {
    return WidgetTreeInspector.serializeTree(component);
  }

  static void clearLogs() {
    _logs.clear();
  }
}
