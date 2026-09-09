import 'package:test/test.dart';
import 'package:valdi/valdi.dart';

void main() {
  group('Route Transitions, Voice Config & Job Scheduler Tests', () {
    test('Slide, Fade, and Sheet Route Transitions', () {
      final slideRoute = SlideRouteTransition(
        builder: () => Text('Slide Page'),
        type: TransitionType.slideUp,
      );
      final fadeRoute = FadeRouteTransition(builder: () => Text('Fade Page'));
      final sheetRoute = SheetRouteTransition(builder: () => Text('Sheet Page'));

      expect(slideRoute.buildPage(), isNotNull);
      expect(fadeRoute.buildPage(), isNotNull);
      expect(sheetRoute.buildPage(), isNotNull);
    });

    test('NeuralVoiceConfig available voice models & FFI setVoiceModel', () async {
      final voices = NeuralVoiceConfig.availableVoices;
      expect(voices.length, equals(3));
      expect(voices.first.languageCode, equals('en-US'));

      final voiceConfig = NeuralVoiceConfig();
      await voiceConfig.setVoiceModel(voices.first);
    });

    test('ValdiWorkerThread & JobScheduler background work', () async {
      bool jobFired = false;
      JobScheduler.schedulePeriodicJob('sync_job_1', Duration(seconds: 1), () {
        jobFired = true;
      });

      expect(jobFired, isTrue);
      expect(JobScheduler.scheduledJobs.contains('sync_job_1'), isTrue);

      JobScheduler.cancelJob('sync_job_1');
      expect(JobScheduler.scheduledJobs.contains('sync_job_1'), isFalse);

      final result = await ValdiWorkerThread.executeWork(() => 100 + 200);
      expect(result, equals(300));
    });
  });
}
