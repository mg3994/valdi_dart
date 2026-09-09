import 'package:valdi/valdi.dart';

void main() async {
  print('=== Valdi + DartNative Cutting-Edge Features Showcase ===\n');

  // 1. Fluid Canvas Depth Shader
  print('[1] Rendering iOS 26 / Material 3 Fluid Glass GPU Shader:');
  final glassShader = FluidGlassShader(blurRadius: 35.0, refractiveIndex: 1.52);
  final shaderPainter = LiquidShaderPainter(glassShader);
  final canvas = Canvas();
  shaderPainter.paint(canvas, const LayoutRect(left: 0, top: 0, width: 375, height: 200));
  print('  -> Recorded Shader Canvas Calls: ${canvas.drawCalls.length}');

  // 2. On-Device Neural Voice TTS Audio Streamer
  print('\n[2] Streaming On-Device Neural Voice Audio over FFI:');
  final ttsStreamer = NeuralAudioStreamer();
  await ttsStreamer.streamAudioChunk('Streaming neural audio chunk over ONNX engine...');
  print('  -> Neural TTS chunk sent to native audio queue.');

  // 3. Shimmer Preloader in Infinite Photo Grid Masonry
  print('\n[3] Shimmer Preloader Grid Construction:');
  Navigator.pushNamed('/photo_feed', () {
    return MasonryGridView(
      crossAxisCount: 2,
      itemCount: 4,
      itemBuilder: (index) => ShimmerMasonryTile(
        isLoading: index < 2,
        placeholderHeight: 180,
        child: Container(
          height: 180,
          color: '#007AFF',
          child: Text('Loaded Photo #$index'),
        ),
      ),
    );
  });

  final rootWidget = Navigator.currentRoute!.buildPage();

  // 4. Dual-Mode Rendering Pipeline
  final controller = ValdiRenderController();

  print('\n[4.1] Rendering Showcase in Primary Native View Mode (Zero-Fork Flutter):');
  controller.setRenderBackend(RenderBackend.nativeViews);
  controller.render(rootWidget);
  print('Active Native Views Created: ${ZeroForkManager().activeNativeViews.length}');

  print('\n[4.2] Switching Rendering Backend to Direct Skia Canvas Mode (DartNative Style Optional Skia):');
  controller.setRenderBackend(RenderBackend.skiaCanvas);
  controller.render(rootWidget);
  print('Recorded Skia Direct Canvas Draw Commands: ${controller.skiaRenderer.recordedCommands.length}');

  print('\n=== Cutting-Edge Features Showcase Completed Successfully ===');
}
