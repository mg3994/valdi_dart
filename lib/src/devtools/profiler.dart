class RenderMetrics {
  final int layoutTimeMicros;
  final int reconcileTimeMicros;
  final int renderTimeMicros;
  final int viewCount;

  RenderMetrics({
    required this.layoutTimeMicros,
    required this.reconcileTimeMicros,
    required this.renderTimeMicros,
    required this.viewCount,
  });

  @override
  String toString() =>
      'RenderMetrics(layout: ${layoutTimeMicros}us, reconcile: ${reconcileTimeMicros}us, render: ${renderTimeMicros}us, views: $viewCount)';
}

/// Performance telemetry and frame profiler for Valdi.
class ValdiProfiler {
  static final List<RenderMetrics> _metricHistory = [];

  static List<RenderMetrics> get metricHistory => List.unmodifiable(_metricHistory);

  static void recordFrameMetrics(RenderMetrics metrics) {
    _metricHistory.add(metrics);
  }

  static RenderMetrics? get latestMetrics => _metricHistory.isNotEmpty ? _metricHistory.last : null;

  static void reset() {
    _metricHistory.clear();
  }
}
