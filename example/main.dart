import 'package:valdi/valdi.dart';

void main() async {
  print('=== Valdi + DartNative Ultra Performance Showcase ===\n');

  // 1. Zero-Copy HW Video Texture Streamer over FFI
  print('[1] Registering Zero-Copy Hardware Video Texture Streamer:');
  final textureStreamer = VideoTextureStreamer();
  final textureId = await textureStreamer.registerTexture('https://cdn.valdi.native/live_4k_stream.mp4');
  print('  -> Registered Native HW Texture ID: $textureId');

  // 2. Real-time Native Bi-directional Event Stream Sockets
  print('\n[2] Listening to Native Bi-directional Event Stream Sockets over FFI:');
  final eventStream = ValdiEventStream<String>('device_telemetry');
  eventStream.stream.listen((ev) => print('  -> Native Event Stream Received: "$ev"'));
  eventStream.emit('battery_level:98%,temp:32C');

  // 3. Multi-Line Flexbox Wrap Layout & UI Rendering
  print('\n[3] Constructing Multi-Line Flexbox Wrap Layout:');
  Navigator.pushNamed('/ultra_feed', () {
    return Column(
      children: [
        SearchAppBar(
          title: 'Ultra Performance Suite',
          searchBar: SearchBar(placeholder: 'Search ultra tags...'),
        ),
        Wrap(
          direction: FlexDirection.row,
          alignment: JustifyContent.spaceAround,
          children: [
            Container(padding: const EdgeValues.all(8), color: '#007AFF', child: Text('Chip #1')),
            Container(padding: const EdgeValues.all(8), color: '#34C759', child: Text('Chip #2')),
            Container(padding: const EdgeValues.all(8), color: '#FF9500', child: Text('Chip #3')),
          ],
        ),
        VideoPlayer(url: 'https://cdn.valdi.native/live_4k_stream.mp4'),
      ],
    );
  });

  final rootWidget = Navigator.currentRoute!.buildPage();

  // 4. Dual-Mode Rendering Pipeline
  final controller = ValdiRenderController();

  print('\n[4.1] Rendering Ultra Suite in Primary Native View Mode (Zero-Fork Flutter):');
  controller.setRenderBackend(RenderBackend.nativeViews);
  controller.render(rootWidget);
  print('Active Native Views Created: ${ZeroForkManager().activeNativeViews.length}');

  print('\n[4.2] Switching Rendering Backend to Direct Skia Canvas Mode (DartNative Style Optional Skia):');
  controller.setRenderBackend(RenderBackend.skiaCanvas);
  controller.render(rootWidget);
  print('Recorded Skia Direct Canvas Draw Commands: ${controller.skiaRenderer.recordedCommands.length}');

  await textureStreamer.releaseTexture();
  await eventStream.close();
  print('\n=== Ultra Performance Showcase Completed Successfully ===');
}
