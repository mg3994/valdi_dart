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
  print('=== Valdi + DartNative Enterprise Architecture Showcase ===\n');

  // 1. SignalStore State Management
  print('[1] Centralized SignalStore State Management:');
  final store = SignalStore<int>(
    initialState: 100,
    reducer: (state, action) {
      if (action.type == 'ADD') {
        return state + (action.payload as int);
      }
      return state;
    },
  );
  store.addListener((st) => print('  -> SignalStore State Updated: $st'));
  store.dispatch(AddCounterAction(50));

  // 2. Direct FFI HTTP Client & System i18n Localizations
  print('\n[2] Direct FFI HTTP Client & System i18n Bridge:');
  final httpClient = ValdiHttpClient();
  final httpRes = await httpClient.get('https://api.valdi.native/feed');
  print('FFI HTTP Response Status: ${httpRes.statusCode}');

  final i18n = ValdiLocalizations(
    translations: {
      'en': {'app_title': 'Valdi Enterprise Native Suite'},
      'es': {'app_title': 'Suite Empresarial Valdi'},
    },
  );
  await i18n.fetchSystemLocale();
  print('Translated Header (${i18n.currentLocale}): ${i18n.translate('app_title')}');

  // 3. Accessibility Semantics, Interactive Gestures, & Navigation
  print('\n[3] Accessibility Semantics, Interactive Gestures, & Native Navigation:');
  Navigator.pushNamed('/enterprise', () {
    return Semantics(
      label: 'Main Dashboard',
      hint: 'Contains enterprise native controls',
      child: GestureDetector(
        onTap: () => print('  -> Accessibility Container Tapped!'),
        child: Column(
          children: [
            SearchAppBar(
              title: i18n.translate('app_title'),
              searchBar: SearchBar(placeholder: 'Search enterprise features...'),
            ),
            AppleSignInButton(
              onSuccess: (token) => print('  -> Apple Auth Token: $token'),
            ),
            MasonryGridView(
              crossAxisCount: 2,
              itemCount: 2,
              itemBuilder: (i) => Container(
                height: 120,
                child: Text('Masonry Tile #$i'),
              ),
            ),
            CustomPaint(
              painter: ChartPainter(),
              style: YogaStyle(width: 300, height: 100),
            ),
          ],
        ),
      ),
    );
  });

  final rootWidget = Navigator.currentRoute!.buildPage();

  // 4. Dual-Mode Rendering Pipeline
  final controller = ValdiRenderController();

  print('\n[4.1] Rendering Enterprise Suite in Primary Native View Mode (Zero-Fork Flutter):');
  controller.setRenderBackend(RenderBackend.nativeViews);
  controller.render(rootWidget);
  print('Active Native Views Created: ${ZeroForkManager().activeNativeViews.length}');

  print('\n[4.2] Switching Rendering Backend to Direct Skia Canvas Mode (DartNative Style Optional Skia):');
  controller.setRenderBackend(RenderBackend.skiaCanvas);
  controller.render(rootWidget);
  print('Recorded Skia Direct Canvas Draw Commands: ${controller.skiaRenderer.recordedCommands.length}');

  print('\n=== Enterprise Architecture Showcase Completed Successfully ===');
}
