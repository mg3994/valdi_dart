import 'package:test/test.dart';
import 'package:valdi/valdi.dart';

int multiplyTask(int val) => val * 2;

void main() {
  group('Enterprise Extensions Suite Tests', () {
    test('ValdiIsolateBridge off-main-thread compute task', () async {
      final res = await ValdiIsolateBridge.compute(multiplyTask, 21);
      expect(res, equals(42));
    });

    test('ValdiPlatformChannel and ValdiEventChannel migration bridge', () async {
      final methodChannel = ValdiPlatformChannel('plugins.example.com/share');
      final eventChannel = ValdiEventChannel('plugins.example.com/events');

      bool eventReceived = false;
      eventChannel.receiveBroadcastStream().listen((ev) {
        if (ev == 'ping') eventReceived = true;
      });

      eventChannel.emitNativeEvent('ping');

      final res = await methodChannel.invokeMethod<String>('shareText', ['Hello']);
      expect(res, contains('shareText'));
      await Future.delayed(Duration(milliseconds: 10));
      expect(eventReceived, isTrue);
    });

    test('TextField, TextEditingController, and Form', () {
      final controller = TextEditingController(text: 'John Doe');
      final field = TextField(
        controller: controller,
        placeholder: 'Enter name',
      );

      final form = Form(child: field);
      expect(form.toYogaNode(), isNotNull);
    });

    test('LayoutBuilder and ResponsiveLayout', () {
      final layout = LayoutBuilder(
        builder: (constraints) => Text('Max width: ${constraints.maxWidth}'),
      );

      final responsive = ResponsiveLayout(
        mobile: Text('Mobile View'),
        desktop: Text('Desktop View'),
      );

      expect(layout.toYogaNode(), isNotNull);
      expect(responsive.toYogaNode(), isNotNull);
    });
  });
}
