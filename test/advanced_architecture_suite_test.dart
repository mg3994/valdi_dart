import 'package:test/test.dart';
import 'package:valdi/valdi.dart';

class IncrementAction extends Action {
  IncrementAction([int amount = 1]) : super('INCREMENT', amount);
}

void main() {
  group('Semantics, SignalStore, HttpClient, & Localizations Tests', () {
    test('Semantics accessibility node wrapper', () {
      final sem = Semantics(
        label: 'Submit Button',
        hint: 'Submits user form',
        button: true,
        child: Text('Submit'),
      );

      final node = sem.toYogaNode();
      expect(node, isNotNull);
    });

    test('SignalStore state store and action dispatcher', () {
      final store = SignalStore<int>(
        initialState: 0,
        reducer: (state, action) {
          if (action.type == 'INCREMENT') {
            return state + (action.payload as int? ?? 1);
          }
          return state;
        },
      );

      expect(store.state, equals(0));
      store.dispatch(IncrementAction(5));
      expect(store.state, equals(5));
    });

    test('ValdiHttpClient low-level FFI requests', () async {
      final client = ValdiHttpClient();
      final getRes = await client.get('https://api.valdi.native/users');
      expect(getRes.statusCode, equals(200));
      expect(getRes.body, contains('https://api.valdi.native/users'));

      final postRes = await client.post('https://api.valdi.native/users', body: {'name': 'Jules'});
      expect(postRes.statusCode, equals(201));
    });

    test('ValdiLocalizations i18n system locale bridge', () async {
      final i18n = ValdiLocalizations(
        translations: {
          'en': {'welcome': 'Welcome to Valdi'},
          'es': {'welcome': 'Bienvenido a Valdi'},
        },
        defaultLocale: 'en',
      );

      expect(i18n.translate('welcome'), equals('Welcome to Valdi'));
      i18n.setLocale('es');
      expect(i18n.translate('welcome'), equals('Bienvenido a Valdi'));
      await i18n.fetchSystemLocale();
    });
  });
}
