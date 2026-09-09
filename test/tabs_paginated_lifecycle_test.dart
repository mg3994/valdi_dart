import 'package:test/test.dart';
import 'package:valdi/valdi.dart';

void main() {
  group('TabBar, PaginatedListView, & AppLifecycleObserver Tests', () {
    test('BottomNavigationBar & TabBar rendering with badges', () {
      final navBar = BottomNavigationBar(
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(label: 'Home', icon: 'home_icon'),
          BottomNavigationBarItem(label: 'Chat', icon: 'chat_icon', badge: '5'),
          BottomNavigationBarItem(label: 'Profile', icon: 'profile_icon'),
        ],
      );

      final node = navBar.toYogaNode();
      expect(node, isNotNull);
    });

    test('PaginatedListView & RefreshIndicator tree construction', () {
      final paginatedList = PaginatedListView(
        itemCount: 10,
        itemBuilder: (index) => Text('Row $index'),
        onRefresh: () async {},
        onLoadMore: () async {},
      );

      final node = paginatedList.toYogaNode();
      expect(node, isNotNull);
    });

    test('AppLifecycleObserver state transitions over FFI', () {
      final observer = AppLifecycleObserver();
      AppLifecycleState? observedState;

      observer.observeLifecycle((state) {
        observedState = state;
      });

      expect(observer.currentState, equals(AppLifecycleState.resumed));
      NativeBridge().handleNativeEvent('AppLifecycle.onStateChanged', ['paused']);

      expect(observedState, equals(AppLifecycleState.paused));
      expect(observer.currentState, equals(AppLifecycleState.paused));
    });
  });
}
