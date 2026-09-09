import 'package:valdi/valdi.dart';

void main() async {
  print('=== Valdi + DartNative Next-Gen Architecture Showcase ===\n');

  // 1. On-Device SuperTonic-3 Neural TTS Voice Configuration
  print('[1] Configuring On-Device SuperTonic-3 Neural Voice Model over FFI:');
  final voiceConfig = NeuralVoiceConfig();
  final targetVoice = NeuralVoiceConfig.availableVoices.first;
  await voiceConfig.setVoiceModel(targetVoice);
  print('  -> Selected Voice: ${targetVoice.name} (${targetVoice.languageCode})');

  // 2. Periodic & Deferred Background Job Scheduler
  print('\n[2] Background Worker Thread & Job Scheduler Execution:');
  JobScheduler.schedulePeriodicJob('sync_telemetry_job', const Duration(minutes: 15), () {
    print('  -> Background Sync Telemetry Job Fired on Schedule.');
  });
  final workerResult = await ValdiWorkerThread.executeWork(() => 500 * 20);
  print('  -> ValdiWorkerThread Computed Task Result: $workerResult');

  // 3. Native Navigation Transitions (Slide-up Modal Sheet & Gesture Choreography)
  print('\n[3] Pushing Slide-Up Sheet Route Transition to Native Navigator:');
  Navigator.push(SheetRouteTransition(
    name: '/modal_sheet',
    builder: () => Column(
      children: [
        SearchAppBar(
          title: 'Sheet Modal Title',
          searchBar: SearchBar(placeholder: 'Search modal content...'),
        ),
        Text('Modal Sheet Page Content'),
      ],
    ),
  ));

  print('Active Route Name: ${Navigator.currentRoute?.name}');
  final rootWidget = Navigator.currentRoute!.buildPage();

  // 4. Dual-Mode Rendering Pipeline
  final controller = ValdiRenderController();

  print('\n[4.1] Rendering Sheet Modal in Primary Native View Mode (Zero-Fork Flutter):');
  controller.setRenderBackend(RenderBackend.nativeViews);
  controller.render(rootWidget);
  print('Active Native Views Created: ${ZeroForkManager().activeNativeViews.length}');

  print('\n[4.2] Switching Rendering Backend to Direct Skia Canvas Mode (DartNative Style Optional Skia):');
  controller.setRenderBackend(RenderBackend.skiaCanvas);
  controller.render(rootWidget);
  print('Recorded Skia Direct Canvas Draw Commands: ${controller.skiaRenderer.recordedCommands.length}');

  print('\n=== Next-Gen Architecture Showcase Completed Successfully ===');
}
