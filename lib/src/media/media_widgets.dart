import '../component/valdi_component.dart';
import '../layout/yoga_node.dart';
import '../layout/yoga_style.dart';

/// Native Video Player Component backed by AVPlayer (iOS) and ExoPlayer (Android).
class VideoPlayer extends ValdiComponent {
  final String url;
  final bool autoPlay;

  VideoPlayer({
    super.key,
    required this.url,
    this.autoPlay = true,
    YogaStyle? style,
  }) : super(style: style);

  @override
  ValdiComponent build() => this;

  @override
  YogaNode toYogaNode() => YogaNode(style: style);
}

/// Lottie Animation View Component backed by lottie-ios / lottie-android.
class LottieView extends ValdiComponent {
  final String assetPath;
  final bool loop;

  LottieView({
    super.key,
    required this.assetPath,
    this.loop = true,
    YogaStyle? style,
  }) : super(style: style);

  @override
  ValdiComponent build() => this;

  @override
  YogaNode toYogaNode() => YogaNode(style: style);
}

/// Camera Preview Component backed by AVFoundation / CameraX.
class CameraView extends ValdiComponent {
  CameraView({
    super.key,
    YogaStyle? style,
  }) : super(style: style);

  @override
  ValdiComponent build() => this;

  @override
  YogaNode toYogaNode() => YogaNode(style: style);
}

/// Native Map SDK View Component backed by MKMapView / Google Maps SDK.
class MapView extends ValdiComponent {
  final double latitude;
  final double longitude;

  MapView({
    super.key,
    required this.latitude,
    required this.longitude,
    YogaStyle? style,
  }) : super(style: style);

  @override
  ValdiComponent build() => this;

  @override
  YogaNode toYogaNode() => YogaNode(style: style);
}
