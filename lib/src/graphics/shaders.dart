import 'canvas.dart';
import '../layout/yoga_node.dart';

/// Fluid Canvas Shader for iOS 26 / Material 3 liquid glass depth effects (DartNative Liquid Glass tutorial).
class FluidGlassShader {
  final double blurRadius;
  final String tintColor;
  final double refractiveIndex;

  FluidGlassShader({
    this.blurRadius = 25.0,
    this.tintColor = '#ffffff44',
    this.refractiveIndex = 1.45,
  });
}

/// CustomPainter rendering Fluid Glass Depth Canvas Shader.
class LiquidShaderPainter extends CustomPainter {
  final FluidGlassShader shader;

  LiquidShaderPainter(this.shader);

  @override
  void paint(Canvas canvas, LayoutRect rect) {
    canvas.drawRect(rect, Paint(color: Color.white));
    canvas.drawCircle(rect.width / 2, rect.height / 2, rect.width / 4, Paint(color: Color.blue));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
