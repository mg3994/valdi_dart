import '../component/valdi_component.dart';
import 'navigator.dart';

enum TransitionType { slideRight, slideUp, fade, modalSheet }

/// Slide Right / Slide Up Route Transition (DartNative navigation tutorial).
class SlideRouteTransition<T> extends Route<T> {
  final ValdiComponent Function() builder;
  final TransitionType type;

  SlideRouteTransition({
    required this.builder,
    this.type = TransitionType.slideRight,
    super.name,
  });

  @override
  ValdiComponent buildPage() => builder();
}

/// Fade Route Transition.
class FadeRouteTransition<T> extends Route<T> {
  final ValdiComponent Function() builder;

  FadeRouteTransition({required this.builder, super.name});

  @override
  ValdiComponent buildPage() => builder();
}

/// Modal Sheet / Slide-up Full Screen Route Transition with OS back gestures.
class SheetRouteTransition<T> extends Route<T> {
  final ValdiComponent Function() builder;

  SheetRouteTransition({required this.builder, super.name});

  @override
  ValdiComponent buildPage() => builder();
}
