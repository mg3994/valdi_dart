import 'package:test/test.dart';
import 'package:valdi/valdi.dart';

void main() {
  group('FlexWrap, VideoTextureStreamer, & EventStream Tests', () {
    test('Wrap widget multi-line flex wrapping layout tree', () {
      final wrap = Wrap(
        direction: FlexDirection.row,
        alignment: JustifyContent.spaceBetween,
        children: [
          Container(width: 100, height: 40, child: Text('Chip 1')),
          Container(width: 100, height: 40, child: Text('Chip 2')),
          Container(width: 100, height: 40, child: Text('Chip 3')),
        ],
      );

      final node = wrap.toYogaNode();
      expect(node.style.flexWrap, equals(FlexWrap.wrap));
      expect(node.children.length, equals(3));
    });

    test('VideoTextureStreamer texture registration and release', () async {
      final streamer = VideoTextureStreamer();
      final texId = await streamer.registerTexture('https://cdn.example.com/stream.mp4');
      expect(texId, equals(1001));
      expect(streamer.textureId, equals(1001));

      await streamer.releaseTexture();
      expect(streamer.textureId, isNull);
    });

    test('ValdiEventStream streaming native events', () async {
      final stream = ValdiEventStream<String>('location_updates');
      bool eventReceived = false;

      stream.stream.listen((data) {
        if (data == 'lat:37.7,lng:-122.4') eventReceived = true;
      });

      stream.emit('lat:37.7,lng:-122.4');
      await Future.delayed(Duration(milliseconds: 10));
      expect(eventReceived, isTrue);

      await stream.close();
    });
  });
}
