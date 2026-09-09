import 'package:test/test.dart';
import 'package:valdi/valdi.dart';

void main() {
  group('DevTools, Profiler & Hot Reload Tests', () {
    test('ValdiDevTools & WidgetTreeInspector tree serialization', () {
      ValdiDevTools.clearLogs();
      ValdiDevTools.log('Initializing devtools test');
      expect(ValdiDevTools.logs.length, equals(1));

      final root = Column(
        children: [
          Text('Inspector Node'),
        ],
      );

      final map = ValdiDevTools.inspectComponent(root);
      expect(map['type'], equals('Column'));
      expect(map['childrenCount'], equals(1));
    });

    test('ValdiProfiler frame metrics telemetry', () {
      ValdiProfiler.reset();
      ValdiProfiler.recordFrameMetrics(RenderMetrics(
        layoutTimeMicros: 150,
        reconcileTimeMicros: 80,
        renderTimeMicros: 220,
        viewCount: 12,
      ));

      expect(ValdiProfiler.metricHistory.length, equals(1));
      expect(ValdiProfiler.latestMetrics?.viewCount, equals(12));
    });

    test('HotReloadManager state preservation and restoration', () {
      HotReloadManager.clear();
      HotReloadManager.preserveState('counter_key', 42);

      expect(HotReloadManager.restoreState('counter_key'), equals(42));
    });
  });
}
