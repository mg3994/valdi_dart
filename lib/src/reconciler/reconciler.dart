import '../component/valdi_component.dart';
import '../component/flutter_widgets.dart';
import '../theme/material.dart';
import '../animation/animation.dart';
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
  final List<RenderPatch> childPatches;

  RenderPatch({
    required this.type,
    this.componentType,
    this.key,
    this.props,
    this.layout,
    this.index = 0,
    this.childPatches = const [],
  });

  @override
  String toString() => 'RenderPatch(type: $type, component: $componentType, key: $key, layout: $layout, children: ${childPatches.length})';
}

/// Virtual DOM Reconciler that diffs old and new Valdi component trees recursively.
class Reconciler {
  /// Mounts a root component and builds its initial Yoga layout node tree.
  static YogaNode buildYogaTree(ValdiComponent rootComponent, {double? containerWidth, double? containerHeight}) {
    final rootNode = rootComponent.toYogaNode();
    LayoutEngine.solve(rootNode, width: containerWidth, height: containerHeight);
    return rootNode;
  }

  /// Reconciles two component trees recursively and produces minimal patches for native view updates.
  static List<RenderPatch> reconcile(
    ValdiComponent? oldComponent,
    ValdiComponent? newComponent, {
    double? width,
    double? height,
  }) {
    final rootNode = newComponent?.toYogaNode();
    if (rootNode != null) {
      LayoutEngine.solve(rootNode, width: width, height: height);
    }

    return _reconcileNodes(oldComponent, newComponent, rootNode);
  }

  static List<RenderPatch> _reconcileNodes(
    ValdiComponent? oldComponent,
    ValdiComponent? newComponent,
    YogaNode? computedNode,
  ) {
    final List<RenderPatch> patches = [];

    if (oldComponent == null && newComponent != null) {
      final childPatches = _reconcileChildren([], _getChildren(newComponent), computedNode?.children ?? []);
      patches.add(RenderPatch(
        type: PatchType.create,
        componentType: newComponent.runtimeType.toString(),
        key: newComponent.key,
        props: _extractProps(newComponent),
        layout: computedNode?.layout,
        childPatches: childPatches,
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
        final childPatches = _reconcileChildren([], _getChildren(newComponent), computedNode?.children ?? []);
        patches.add(RenderPatch(
          type: PatchType.create,
          componentType: newComponent.runtimeType.toString(),
          key: newComponent.key,
          props: _extractProps(newComponent),
          layout: computedNode?.layout,
          childPatches: childPatches,
        ));
      } else {
        final childPatches = _reconcileChildren(_getChildren(oldComponent), _getChildren(newComponent), computedNode?.children ?? []);
        patches.add(RenderPatch(
          type: PatchType.update,
          componentType: newComponent.runtimeType.toString(),
          key: newComponent.key,
          props: _extractProps(newComponent),
          layout: computedNode?.layout,
          childPatches: childPatches,
        ));
      }
    }

    return patches;
  }

  static List<RenderPatch> _reconcileChildren(
    List<ValdiComponent> oldChildren,
    List<ValdiComponent> newChildren,
    List<YogaNode> computedNodes,
  ) {
    final List<RenderPatch> childPatches = [];
    final maxLen = oldChildren.length > newChildren.length ? oldChildren.length : newChildren.length;

    for (int i = 0; i < maxLen; i++) {
      final oldChild = i < oldChildren.length ? oldChildren[i] : null;
      final newChild = i < newChildren.length ? newChildren[i] : null;
      final yogaNode = i < computedNodes.length ? computedNodes[i] : null;

      childPatches.addAll(_reconcileNodes(oldChild, newChild, yogaNode));
    }

    return childPatches;
  }

  static List<ValdiComponent> _getChildren(ValdiComponent component) {
    if (component is View) return component.children;
    if (component is ScrollView) return component.children;
    if (component is Row) return component.children;
    if (component is Column) return component.children;
    if (component is Stack) return component.children;
    if (component is Container && component.child != null) return [component.child!];
    if (component is Padding) return [component.child];
    if (component is Positioned) return [component.child];
    if (component is Expanded) return [component.child];
    if (component is LiquidGlass) return [component.child];
    if (component is M3Badge) return [component.child];
    if (component is Hero) return [component.child];

    // For custom or composite components, inspect built tree
    final built = component.build();
    if (built != component) {
      return _getChildren(built);
    }

    return [];
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
