import 'package:test/test.dart';
import 'package:valdi/valdi.dart';

void main() {
  group('Zero-Fork Native Bridge & Skia Backend Tests', () {
    test('ZeroForkManager creates and manages native view handles', () {
      final manager = ZeroForkManager();
      manager.clearAll();

      final handle = manager.createNativeView(
        'View',
        const LayoutRect(left: 0, top: 0, width: 100, height: 100),
        {'backgroundColor': '#FFFFFF'},
      );

      expect(manager.activeNativeViews.length, equals(1));
      expect(handle.viewType, equals('View'));

      manager.destroyNativeView(handle.viewId);
      expect(manager.activeNativeViews.length, equals(0));
    });

    test('NativeBridge dispatches registered callbacks', () {
      final bridge = NativeBridge();
      bool callbackFired = false;

      bridge.registerCallback('onButtonClick', (args) {
        callbackFired = true;
        return 'handled';
      });

      final result = bridge.handleNativeEvent('onButtonClick', ['btn_1']);
      expect(callbackFired, isTrue);
      expect(result, equals('handled'));
    });

    test('ValdiRenderController switches between Native Views and Optional Skia Canvas', () {
      final controller = ValdiRenderController();

      final rootComponent = View(
        key: 'root',
        backgroundColor: '#121212',
        style: YogaStyle(width: 375, height: 812),
        children: [
          Text('Valdi Engine', key: 'title', color: '#FFFFFF'),
        ],
      );

      // 1. Render using Native View backend
      controller.setRenderBackend(RenderBackend.nativeViews);
      controller.render(rootComponent);

      expect(controller.backend, equals(RenderBackend.nativeViews));
      expect(ZeroForkManager().activeNativeViews.isNotEmpty, isTrue);
      expect(controller.skiaRenderer.recordedCommands.isEmpty, isTrue);

      // 2. Switch to Optional Skia Canvas backend (DartNative style optional Skia)
      controller.setRenderBackend(RenderBackend.skiaCanvas);

      expect(controller.backend, equals(RenderBackend.skiaCanvas));
      expect(ZeroForkManager().activeNativeViews.isEmpty, isTrue);
      expect(controller.skiaRenderer.recordedCommands.isNotEmpty, isTrue);
      expect(controller.skiaRenderer.recordedCommands.first.commandType, equals('drawRect'));
    });
  });
}
