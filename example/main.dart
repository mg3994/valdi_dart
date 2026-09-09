import 'package:valdi/valdi.dart';

void main() async {
  print('=== Valdi + DartNative Infinite Navigation Suite Showcase ===\n');

  // 1. OS App Lifecycle Observer
  print('[1] Observing OS App Lifecycle Transitions over FFI:');
  final lifecycle = AppLifecycleObserver();
  lifecycle.observeLifecycle((state) {
    print('  -> App Lifecycle Transitioned to: $state');
  });
  print('  -> Current OS App Lifecycle State: ${lifecycle.currentState}');
  NativeBridge().handleNativeEvent('AppLifecycle.onStateChanged', ['paused']);
  NativeBridge().handleNativeEvent('AppLifecycle.onStateChanged', ['resumed']);

  // 2. TabBar & Paginated Infinite Scroll List
  print('\n[2] Constructing Paginated Infinite List & Adaptive TabBar:');
  Navigator.pushNamed('/feed', () {
    return Column(
      children: [
        SearchAppBar(
          title: 'Paginated Feed',
          searchBar: SearchBar(placeholder: 'Filter feed rows...'),
        ),
        PaginatedListView(
          itemCount: 8,
          onRefresh: () async => print('  -> Pull-To-Refresh Triggered'),
          onLoadMore: () async => print('  -> Infinite Scroll Load More Triggered'),
          itemBuilder: (i) => Text('Paginated Feed Row #$i'),
        ),
        TabBar(
          selectedIndex: 1,
          tabs: const [
            BottomNavigationBarItem(label: 'Home', icon: 'home'),
            BottomNavigationBarItem(label: 'Feed', icon: 'feed', badge: '12'),
            BottomNavigationBarItem(label: 'Settings', icon: 'settings'),
          ],
          onTabSelected: (idx) => print('  -> Tab Selected: Index $idx'),
        ),
      ],
    );
  });

  final rootWidget = Navigator.currentRoute!.buildPage();

  // 3. Dual-Mode Rendering Pipeline
  final controller = ValdiRenderController();

  print('\n[3.1] Rendering Paginated Suite in Primary Native View Mode (Zero-Fork Flutter):');
  controller.setRenderBackend(RenderBackend.nativeViews);
  controller.render(rootWidget);
  print('Active Native Views Created: ${ZeroForkManager().activeNativeViews.length}');

  print('\n[3.2] Switching Rendering Backend to Direct Skia Canvas Mode (DartNative Style Optional Skia):');
  controller.setRenderBackend(RenderBackend.skiaCanvas);
  controller.render(rootWidget);
  print('Recorded Skia Direct Canvas Draw Commands: ${controller.skiaRenderer.recordedCommands.length}');

  print('\n=== Infinite Navigation Suite Showcase Completed Successfully ===');
}
