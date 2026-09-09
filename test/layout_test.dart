import 'package:test/test.dart';
import 'package:valdi/valdi.dart';

void main() {
  group('Yoga Layout Engine Tests', () {
    test('Calculates simple column layout rects correctly', () {
      final root = YogaNode(
        style: YogaStyle(
          flexDirection: FlexDirection.column,
          width: 300.0,
          height: 600.0,
        ),
      );

      final child1 = YogaNode(
        style: YogaStyle(
          width: 300.0,
          height: 100.0,
        ),
      );

      final child2 = YogaNode(
        style: YogaStyle(
          width: 300.0,
          height: 200.0,
        ),
      );

      root.addChild(child1);
      root.addChild(child2);

      LayoutEngine.solve(root, width: 300.0, height: 600.0);

      expect(root.layout.width, equals(300.0));
      expect(root.layout.height, equals(600.0));

      expect(child1.layout.top, equals(0.0));
      expect(child1.layout.height, equals(100.0));

      expect(child2.layout.top, equals(100.0));
      expect(child2.layout.height, equals(200.0));
    });

    test('Calculates row layout with flexGrow correctly', () {
      final root = YogaNode(
        style: YogaStyle(
          flexDirection: FlexDirection.row,
          width: 400.0,
          height: 100.0,
        ),
      );

      final child1 = YogaNode(
        style: YogaStyle(
          flexGrow: 1.0,
          height: 100.0,
        ),
      );

      final child2 = YogaNode(
        style: YogaStyle(
          flexGrow: 3.0,
          height: 100.0,
        ),
      );

      root.addChild(child1);
      root.addChild(child2);

      LayoutEngine.solve(root, width: 400.0, height: 100.0);

      expect(child1.layout.width, equals(100.0));
      expect(child2.layout.width, equals(300.0));
      expect(child2.layout.left, equals(100.0));
    });
  });
}
