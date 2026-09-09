import 'package:test/test.dart';
import 'package:valdi/valdi.dart';

void main() {
  group('Gestures, Database, Social Auth & Camera Tests', () {
    test('GestureDetector and recognizer handling', () {
      bool tapped = false;
      double panX = 0;

      final tapRecognizer = TapGestureRecognizer(onTap: () => tapped = true);
      final panRecognizer = PanGestureRecognizer(onPanUpdate: (dx, dy) => panX += dx);

      tapRecognizer.handleTap();
      panRecognizer.handlePan(15.0, 0.0);

      expect(tapped, isTrue);
      expect(panX, equals(15.0));

      final detector = GestureDetector(
        child: Text('Interactive View'),
        onTap: () {},
      );

      final node = detector.toYogaNode();
      expect(node, isNotNull);
    });

    test('KeychainStore and SQLiteStore database ops over FFI', () async {
      final keychain = KeychainStore();
      await keychain.writeSecure('api_token', 'sec_12345');
      final readToken = await keychain.readSecure('api_token');
      expect(readToken, equals('sec_12345'));

      final db = SQLiteStore('app_database.db');
      await db.execute('CREATE TABLE users (id INT, name TEXT)');
      await db.insert('users', {'id': 1, 'name': 'Valdi User'});

      final rows = await db.query('users');
      expect(rows.length, equals(1));
      expect(rows.first['name'], equals('Valdi User'));
    });

    test('AppleSignInButton & GoogleSignInButton widget rendering', () {
      final appleBtn = AppleSignInButton(onSuccess: (token) {});
      final googleBtn = GoogleSignInButton(onSuccess: (token) {});

      expect(appleBtn.toYogaNode(), isNotNull);
      expect(googleBtn.toYogaNode(), isNotNull);
    });

    test('CameraController & LottieStickerGrid', () async {
      final camera = CameraController();
      await camera.takePhoto();
      await camera.toggleFlash();
      await camera.switchCamera();

      final stickerGrid = LottieStickerGrid(stickerUrls: [
        'assets/anim1.json',
        'assets/anim2.json',
      ]);

      expect(stickerGrid.toYogaNode().children.length, equals(2));
    });
  });
}
