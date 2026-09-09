import 'package:test/test.dart';
import 'package:valdi/valdi.dart';

void main() {
  group('Shaders, Shimmer, & Neural Audio Tests', () {
    test('FluidGlassShader & LiquidShaderPainter drawing', () {
      final shader = FluidGlassShader(blurRadius: 30.0, refractiveIndex: 1.5);
      final painter = LiquidShaderPainter(shader);
      final canvas = Canvas();

      painter.paint(canvas, const LayoutRect(left: 0, top: 0, width: 200, height: 200));
      expect(canvas.drawCalls.length, equals(2));
    });

    test('NeuralAudioStreamer TTS streaming over FFI', () async {
      final streamer = NeuralAudioStreamer();
      await streamer.streamAudioChunk('Hello neural voice chunk');
      await streamer.stopStream();
    });

    test('ShimmerPlaceholder & ShimmerMasonryTile rendering', () {
      final placeholder = ShimmerPlaceholder(width: 100, height: 100);
      final shimmerTileLoading = ShimmerMasonryTile(
        isLoading: true,
        child: Text('Loaded Item'),
      );
      final shimmerTileLoaded = ShimmerMasonryTile(
        isLoading: false,
        child: Text('Loaded Item'),
      );

      expect(placeholder.toYogaNode(), isNotNull);
      expect(shimmerTileLoading.toYogaNode(), isNotNull);
      expect(shimmerTileLoaded.toYogaNode(), isNotNull);
    });
  });
}
