import 'package:valdi/valdi.dart';

class ChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, LayoutRect rect) {
    canvas.drawRect(rect, Paint(color: Color.black));
    canvas.drawCircle(rect.width / 2, rect.height / 2, 30.0, Paint(color: Color.green));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class AddCounterAction extends Action {
  AddCounterAction(int delta) : super('ADD', delta);
}

void main() async {
  print('=== Valdi + DartNative DevTools & Profiler Showcase ===\n');

  // 1. DevTools Logging & Hot Reload State Preservation
  ValdiDevTools.log('Framework initialized with DevTools suite.');
  HotReloadManager.preserveState('app_session_id', 'session_778899');
  print('[1] DevTools Logging & Hot Reload State Preservation:');
  print('  -> DevTools Log: ${ValdiDevTools.logs.first}');
  print('  -> Restored Hot Reload State: ${HotReloadManager.restoreState('app_session_id')}');

  // 2. SignalStore & FFI Localizations
  final store = SignalStore<int>(
    initialState: 100,
    reducer: (state, action) => action.type == 'ADD' ? state + (action.payload as int) : state,
  );
  store.dispatch(AddCounterAction(25));

  final i18n = ValdiLocalizations(translations: {
    'en': {'app_title': 'Valdi Enterprise Native Suite'},
  });

  // 3. UI Construction & Inspection
  Navigator.pushNamed('/dashboard', () {
    return Semantics(
      label: 'Main Dashboard',
      child: Column(
        children: [
          SearchAppBar(
            title: i18n.translate('app_title'),
            searchBar: SearchBar(placeholder: 'Search features...'),
          ),
          Text('Store State: ${store.state}'),
          CustomPaint(
            painter: ChartPainter(),
            style: YogaStyle(width: 300, height: 100),
          ),
        ],
      ),
    );
  });

  final rootWidget = Navigator.currentRoute!.buildPage();

  print('\n[2] DevTools Inspector Tree Serialization:');
  final treeMap = ValdiDevTools.inspectComponent(rootWidget);
  print('  -> Serialized Tree Node: $treeMap');

  // 4. Dual-Mode Rendering & Profiler Metrics Recording
  final controller = ValdiRenderController();

  final stopwatch = Stopwatch()..start();
  controller.setRenderBackend(RenderBackend.nativeViews);
  controller.render(rootWidget);
  stopwatch.stop();

  ValdiProfiler.recordFrameMetrics(RenderMetrics(
    layoutTimeMicros: 120,
    reconcileTimeMicros: 85,
    renderTimeMicros: stopwatch.elapsedMicroseconds,
    viewCount: ZeroForkManager().activeNativeViews.length,
  ));

  print('\n[3] ValdiProfiler Telemetry Metrics:');
  print('  -> Recorded Metrics: ${ValdiProfiler.latestMetrics}');

  print('\n=== DevTools & Profiler Showcase Completed Successfully ===');
}
