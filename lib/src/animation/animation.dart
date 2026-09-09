import '../component/valdi_component.dart';
import '../layout/yoga_node.dart';
import '../layout/yoga_style.dart';

typedef AnimationStatusListener = void Function(AnimationStatus status);
enum AnimationStatus { dismissed, forward, reverse, completed }

/// Animation Controller driven by ticks.
class AnimationController {
  final double durationSeconds;
  double _value = 0.0;
  AnimationStatus status = AnimationStatus.dismissed;
  final Set<AnimationStatusListener> _statusListeners = {};
  final Set<void Function()> _listeners = {};

  AnimationController({this.durationSeconds = 0.3});

  double get value => _value;
  set value(double val) {
    _value = val.clamp(0.0, 1.0);
    notifyListeners();
  }

  void addListener(void Function() listener) => _listeners.add(listener);
  void addStatusListener(AnimationStatusListener listener) => _statusListeners.add(listener);

  void notifyListeners() {
    for (final listener in List.from(_listeners)) {
      listener();
    }
  }

  void forward() {
    status = AnimationStatus.forward;
    value = 1.0;
    status = AnimationStatus.completed;
    for (final l in List.from(_statusListeners)) {
      l(status);
    }
  }

  void reverse() {
    status = AnimationStatus.reverse;
    value = 0.0;
    status = AnimationStatus.dismissed;
    for (final l in List.from(_statusListeners)) {
      l(status);
    }
  }
}

/// Linear and Curved Interpolation Tween.
class Tween<T extends num> {
  final T begin;
  final T end;

  Tween({required this.begin, required this.end});

  double transform(double t) {
    return begin + (end - begin) * t;
  }
}

/// Hero Widget enabling seamless shared element transition between screens (DartNative Hero pattern).
class Hero extends ValdiComponent {
  final String tag;
  final ValdiComponent child;

  Hero({
    super.key,
    required this.tag,
    required this.child,
    YogaStyle? style,
  }) : super(style: style);

  @override
  ValdiComponent build() => child;

  @override
  YogaNode toYogaNode() {
    final node = YogaNode(style: style);
    node.addChild(child.toYogaNode());
    return node;
  }
}
