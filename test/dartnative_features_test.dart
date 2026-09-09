import 'package:test/test.dart';
import 'package:valdi/valdi.dart';

class SamplePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, LayoutRect rect) {
    canvas.drawRect(rect, Paint(color: Color.blue));
    canvas.drawCircle(rect.width / 2, rect.height / 2, 20.0, Paint(color: Color.red));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class TestSharePlugin extends ValdiPlugin {
  TestSharePlugin() : super('share');

  dynamic shareText(String text) {
    return invokeNative('shareText', [text]);
  }
}

void main() {
  group('DartNative Architecture Features Tests', () {
    test('Signal and watch state management', () {
      final counter = Signal<int>(0);
      int observed = -1;

      counter.addListener((val) {
        observed = val;
      });

      counter.value = 42;
      expect(counter.value, equals(42));
      expect(observed, equals(42));

      counter.update((c) => c + 1);
      expect(counter.value, equals(43));
      expect(observed, equals(43));
    });

    test('Provided dependency injection', () {
      Provided.clear();
      Provided.inject<String>('GlobalConfigValue');

      expect(Provided.get<String>(), equals('GlobalConfigValue'));
    });

    test('Flutter-style Widgets (Row, Column, Stack, ListView)', () {
      final widgetTree = Column(
        children: [
          Row(
            children: [
              Expanded(child: Text('Item 1')),
              SizedBox(width: 10),
              Expanded(child: Text('Item 2')),
            ],
          ),
          Stack(
            children: [
              Container(color: '#FF0000', width: 100, height: 100),
              Positioned(
                left: 10,
                top: 10,
                child: Text('Overlay'),
              ),
            ],
          ),
          ListView.builder(
            itemCount: 3,
            itemBuilder: (index) => Text('Row $index'),
          ),
        ],
      );

      final node = widgetTree.toYogaNode();
      LayoutEngine.solve(node, width: 375, height: 812);

      expect(node.children.length, equals(3));
    });

    test('Navigator route stack push & pop', () {
      Navigator.reset();

      Navigator.pushNamed('/home', () => Text('Home Page'));
      expect(Navigator.routeStack.length, equals(1));
      expect(Navigator.currentRoute?.name, equals('/home'));

      Navigator.pushNamed('/details', () => Text('Details Page'));
      expect(Navigator.routeStack.length, equals(2));
      expect(Navigator.currentRoute?.name, equals('/details'));

      final popped = Navigator.pop();
      expect(popped?.name, equals('/details'));
      expect(Navigator.routeStack.length, equals(1));
    });

    test('Canvas and CustomPainter drawing pipeline', () {
      final canvas = Canvas();
      final painter = SamplePainter();
      const rect = LayoutRect(left: 0, top: 0, width: 200, height: 200);

      painter.paint(canvas, rect);

      expect(canvas.drawCalls.length, equals(2));
      expect(canvas.drawCalls.first, contains('drawRect'));
      expect(canvas.drawCalls.last, contains('drawCircle'));
    });

    test('ValdiStorage FFI Key-Value storage', () async {
      final storage = ValdiStorage();
      await storage.setString('auth_token', 'secret_xyz');
      await storage.setInt('user_id', 1001);

      expect(storage.getString('auth_token'), equals('secret_xyz'));
      expect(storage.getInt('user_id'), equals(1001));
    });

    test('ValdiPlugin FFI bridge plugin system', () {
      final plugin = TestSharePlugin();
      final res = plugin.shareText('Hello World');

      expect(res, contains('share.shareText'));
    });
  });
}
