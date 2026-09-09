import '../component/valdi_component.dart';
import '../component/flutter_widgets.dart';
import '../layout/yoga_node.dart';
import '../layout/yoga_style.dart';

/// Search Bar component matching iOS 26 AppBar.searchBar & Material 3 SearchBar choreography (DartNative Search tutorial).
class SearchBar extends ValdiComponent {
  final String placeholder;
  final void Function(String query)? onChanged;
  final void Function(String query)? onSubmitted;

  SearchBar({
    super.key,
    this.placeholder = 'Search...',
    this.onChanged,
    this.onSubmitted,
    YogaStyle? style,
  }) : super(style: style);

  @override
  ValdiComponent build() {
    return Container(
      padding: const EdgeValues.symmetric(horizontal: 12, vertical: 8),
      color: '#EFEFF4',
      child: Text(placeholder, color: '#8E8E93'),
    );
  }

  @override
  YogaNode toYogaNode() => build().toYogaNode();
}

/// Search AppBar wrapping SearchBar and Title Header.
class SearchAppBar extends ValdiComponent {
  final String title;
  final SearchBar searchBar;

  SearchAppBar({
    super.key,
    required this.title,
    required this.searchBar,
    YogaStyle? style,
  }) : super(style: style);

  @override
  ValdiComponent build() {
    return Column(
      children: [
        Text(title, fontSize: 24, fontWeight: 'bold'),
        searchBar,
      ],
    );
  }

  @override
  YogaNode toYogaNode() => build().toYogaNode();
}
