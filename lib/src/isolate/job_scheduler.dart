import 'dart:async';
import 'isolate_bridge.dart';

/// Worker thread pool manager for background FFI and layout workloads.
class ValdiWorkerThread {
  static Future<T> executeWork<T>(FutureOr<T> Function() work) async {
    return await BackgroundTaskManager.runTask(work);
  }
}

/// Periodic and deferred background job scheduler.
class JobScheduler {
  static final List<String> _scheduledJobs = [];

  static List<String> get scheduledJobs => List.unmodifiable(_scheduledJobs);

  static void schedulePeriodicJob(String jobId, Duration interval, void Function() job) {
    _scheduledJobs.add(jobId);
    job();
  }

  static void cancelJob(String jobId) {
    _scheduledJobs.remove(jobId);
  }
}
