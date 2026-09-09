/// Content Windowing Controller for 10,000+ row native lists keeping memory flat (DartNative fast lists tutorial).
class ContentWindowController {
  final int totalItems;
  final int windowSize;
  int _startIndex = 0;

  ContentWindowController({
    required this.totalItems,
    this.windowSize = 50,
  });

  int get startIndex => _startIndex;
  int get endIndex => (_startIndex + windowSize).clamp(0, totalItems);

  void updateScrollOffset(double scrollOffsetY, double itemHeight) {
    _startIndex = (scrollOffsetY / itemHeight).floor().clamp(0, totalItems - windowSize);
  }
}

/// Native Scroll Telemetry telemetry metrics.
class ScrollTelemetry {
  final double scrollOffset;
  final double velocity;
  final bool isFastScrolling;

  ScrollTelemetry({
    required this.scrollOffset,
    required this.velocity,
    required this.isFastScrolling,
  });
}
