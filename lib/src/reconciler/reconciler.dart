import '../component/valdi_component.dart';
import '../layout/yoga_node.dart';
import '../layout/layout_engine.dart';

enum PatchType { create, update, delete, reorder }

class RenderPatch {
  final PatchType type;
  final String? componentType;
  final String? key;
  final Map<String, dynamic>? props;
  final LayoutRect? layout;
  final int index;

  RenderPatch({
    required this.type,
    this.componentType,
    this.key,
    this.props,
    this.layout,
    this.index = 0,
  });

  @override
  String toString() => 'RenderPatch(type: $type, component: $componentType, key: $key, layout: $layout)';
}

/// Virtual DOM Reconciler that diffs old and new Valdi component trees.
class Reconciler {
  /// Mounts a root component and builds its initial Yoga layout node tree.
  static YogaNode buildYogaTree(ValdiComponent rootComponent, {double? containerWidth, double? containerHeight}) {
    final rootNode = rootComponent.toYogaNode();
    LayoutEngine.solve(rootNode, width: containerWidth, height: containerHeight);
    return rootNode;
  }

  /// Reconciles two component trees and produces minimal patches for native view updates.
  static List<RenderPatch> reconcile(
    ValdiComponent? oldComponent,
    ValdiComponent? newComponent, {
    double? width,
    double? height,
  }) {
    final List<RenderPatch> patches = [];

    if (oldComponent == null && newComponent != null) {
      final node = newComponent.toYogaNode();
      LayoutEngine.solve(node, width: width, height: height);
      patches.add(RenderPatch(
        type: PatchType.create,
        componentType: newComponent.runtimeType.toString(),
        key: newComponent.key,
        props: _extractProps(newComponent),
        layout: node.layout,
      ));
    } else if (oldComponent != null && newComponent == null) {
      patches.add(RenderPatch(
        type: PatchType.delete,
        componentType: oldComponent.runtimeType.toString(),
        key: oldComponent.key,
      ));
    } else if (oldComponent != null && newComponent != null) {
      if (oldComponent.runtimeType != newComponent.runtimeType || oldComponent.key != newComponent.key) {
        patches.add(RenderPatch(
          type: PatchType.delete,
          componentType: oldComponent.runtimeType.toString(),
          key: oldComponent.key,
        ));
        final node = newComponent.toYogaNode();
        LayoutEngine.solve(node, width: width, height: height);
        patches.add(RenderPatch(
          type: PatchType.create,
          componentType: newComponent.runtimeType.toString(),
          key: newComponent.key,
          props: _extractProps(newComponent),
          layout: node.layout,
        ));
      } else {
        final node = newComponent.toYogaNode();
        LayoutEngine.solve(node, width: width, height: height);
        patches.add(RenderPatch(
          type: PatchType.update,
          componentType: newComponent.runtimeType.toString(),
          key: newComponent.key,
          props: _extractProps(newComponent),
          layout: node.layout,
        ));
      }
    }

    return patches;
  }

  static Map<String, dynamic> _extractProps(ValdiComponent component) {
    final Map<String, dynamic> props = {};
    if (component is View) {
      props['backgroundColor'] = component.backgroundColor;
      props['childrenCount'] = component.children.length;
    } else if (component is Text) {
      props['content'] = component.content;
      props['fontSize'] = component.fontSize;
      props['color'] = component.color;
    } else if (component is Image) {
      props['source'] = component.source;
      props['fit'] = component.fit;
    } else if (component is Button) {
      props['label'] = component.label;
      props['backgroundColor'] = component.backgroundColor;
      props['textColor'] = component.textColor;
    } else if (component is ScrollView) {
      props['scrollDirection'] = component.scrollDirection;
      props['childrenCount'] = component.children.length;
    }
    return props;
  }
}
