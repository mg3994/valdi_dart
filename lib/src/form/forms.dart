import '../component/valdi_component.dart';
import '../component/flutter_widgets.dart';
import '../layout/yoga_node.dart';
import '../layout/yoga_style.dart';

class TextEditingController {
  String text;
  TextEditingController({this.text = ''});
}

/// Controlled Text Input Widget.
class TextField extends ValdiComponent {
  final TextEditingController? controller;
  final String placeholder;
  final void Function(String text)? onChanged;

  TextField({
    super.key,
    this.controller,
    this.placeholder = '',
    this.onChanged,
    YogaStyle? style,
  }) : super(style: style);

  @override
  ValdiComponent build() {
    return Container(
      padding: const EdgeValues.symmetric(horizontal: 12, vertical: 10),
      color: '#F2F2F7',
      child: Text(controller?.text.isNotEmpty == true ? controller!.text : placeholder, color: '#8E8E93'),
    );
  }

  @override
  YogaNode toYogaNode() => build().toYogaNode();
}

/// Form Validation Container.
class Form extends ValdiComponent {
  final ValdiComponent child;

  Form({
    super.key,
    required this.child,
    YogaStyle? style,
  }) : super(style: style);

  @override
  ValdiComponent build() => child;

  @override
  YogaNode toYogaNode() => child.toYogaNode();
}
