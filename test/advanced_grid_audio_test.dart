import 'package:test/test.dart';
import 'package:valdi/valdi.dart';

void main() {
  group('Masonry Grid, Audio Engine, & Search Bar Tests', () {
    test('MasonryGridView building and Yoga node tree construction', () {
      final grid = MasonryGridView(
        crossAxisCount: 2,
        itemCount: 6,
        itemBuilder: (index) => Container(
          height: (index % 2 == 0) ? 120.0 : 180.0,
          child: Text('Photo $index'),
        ),
      );

      final node = grid.toYogaNode();
      expect(node.children.length, equals(6));
    });

    test('AudioEngine & AudioPlayer method invocations', () async {
      final player = AudioPlayer();
      await player.play('https://cdn.example.com/stream.mp3');
      await player.pause();
      await player.stop();
    });

    test('SearchBar & SearchAppBar component rendering', () {
      final searchAppbar = SearchAppBar(
        title: 'Explore',
        searchBar: SearchBar(placeholder: 'Search photos...'),
      );

      final node = searchAppbar.toYogaNode();
      expect(node, isNotNull);
    });
  });
}
