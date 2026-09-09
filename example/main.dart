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

void main() async {
  print('=== Valdi + DartNative Full Platform Architecture Showcase ===\n');

  // 1. Reactive Signal State Management
  final counterSignal = Signal<int>(10);
  print('[1] Reactive Signals: Initial Value = ${counterSignal.value}');
  counterSignal.addListener((val) {
    print('  -> Signal Listener Fired: counter = $val');
  });
  counterSignal.value = 25;

  // 2. Local Database & Secure Storage (SQLite & Keychain)
  print('\n[2] Local Database & Secure Keychain over Direct FFI:');
  final keychain = KeychainStore();
  await keychain.writeSecure('user_session', 'session_secret_9988');
  print('Read Secure Token from Keychain: ${await keychain.readSecure('user_session')}');

  final db = SQLiteStore('valdi_app.db');
  await db.execute('CREATE TABLE IF NOT EXISTS analytics (event TEXT)');
  await db.insert('analytics', {'event': 'app_launch'});
  print('SQLite Rows Inserted & Queried: ${await db.query('analytics')}');

  // 3. Interactive Gestures, Social Auth, Camera & SearchBar Navigation
  print('\n[3] Interactive Gestures, Social Auth, & Native Navigation:');
  Navigator.pushNamed('/dashboard', () {
    return GestureDetector(
      onTap: () => print('  -> Interactive View Tapped!'),
      child: Column(
        children: [
          SearchAppBar(
            title: 'Valdi Native Suite',
            searchBar: SearchBar(placeholder: 'Search suite capabilities...'),
          ),
          AppleSignInButton(
            onSuccess: (token) => print('  -> Apple Sign-In Succeeded: $token'),
          ),
          GoogleSignInButton(
            onSuccess: (token) => print('  -> Google Sign-In Succeeded: $token'),
          ),
          MasonryGridView(
            crossAxisCount: 2,
            itemCount: 2,
            itemBuilder: (i) => Container(
              height: 120,
              child: Text('Masonry Tile #$i'),
            ),
          ),
          CameraView(),
          LottieStickerGrid(stickerUrls: [
            'assets/sticker1.json',
            'assets/sticker2.json',
          ]),
          CustomPaint(
            painter: ChartPainter(),
            style: YogaStyle(width: 300, height: 100),
          ),
        ],
      ),
    );
  });

  final rootWidget = Navigator.currentRoute!.buildPage();

  // 4. Camera Controller Execution over FFI
  print('\n[4] Camera Controller Operations over FFI:');
  final cameraController = CameraController();
  await cameraController.takePhoto();
  await cameraController.toggleFlash();

  // 5. Dual-Mode Rendering (Native Views Default + Optional Skia Backend Switch)
  final controller = ValdiRenderController();

  print('\n[5.1] Rendering Suite in Primary Native View Mode (Zero-Fork Flutter):');
  controller.setRenderBackend(RenderBackend.nativeViews);
  controller.render(rootWidget);
  print('Active Native Views Created: ${ZeroForkManager().activeNativeViews.length}');

  print('\n[5.2] Switching Rendering Backend to Direct Skia Canvas Mode (DartNative Style Optional Skia):');
  controller.setRenderBackend(RenderBackend.skiaCanvas);
  controller.render(rootWidget);
  print('Recorded Skia Direct Canvas Draw Commands: ${controller.skiaRenderer.recordedCommands.length}');

  print('\n=== Full Platform Architecture Showcase Completed Successfully ===');
}
