import 'package:test/test.dart';
import 'package:valdi/valdi.dart';

void main() {
  group('Reconciler Virtual Tree Diffing Tests', () {
    test('Produces create patch for initial mount', () {
      final view = View(
        key: 'container',
        backgroundColor: '#FF0000',
        style: YogaStyle(width: 200, height: 200),
      );

      final patches = Reconciler.reconcile(null, view, width: 200, height: 200);

      expect(patches.length, equals(1));
      expect(patches.first.type, equals(PatchType.create));
      expect(patches.first.componentType, equals('View'));
      expect(patches.first.key, equals('container'));
      expect(patches.first.props?['backgroundColor'], equals('#FF0000'));
    });

    test('Produces update patch when props update on same component', () {
      final oldView = View(
        key: 'box',
        backgroundColor: '#00FF00',
        style: YogaStyle(width: 100, height: 100),
      );

      final newView = View(
        key: 'box',
        backgroundColor: '#0000FF',
        style: YogaStyle(width: 100, height: 100),
      );

      final patches = Reconciler.reconcile(oldView, newView, width: 100, height: 100);

      expect(patches.length, equals(1));
      expect(patches.first.type, equals(PatchType.update));
      expect(patches.first.props?['backgroundColor'], equals('#0000FF'));
    });

    test('Produces delete and create patches when component type changes', () {
      final oldComponent = Text('Hello', key: 'widget');
      final newComponent = Button(label: 'Click', key: 'widget', onPressed: null);

      final patches = Reconciler.reconcile(oldComponent, newComponent);

      expect(patches.length, equals(2));
      expect(patches[0].type, equals(PatchType.delete));
      expect(patches[1].type, equals(PatchType.create));
    });
  });
}
