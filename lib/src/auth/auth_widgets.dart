import '../component/valdi_component.dart';
import '../component/flutter_widgets.dart';
import '../platform/platform_services.dart';
import '../layout/yoga_node.dart';
import '../layout/yoga_style.dart';

/// Apple Sign In Button presenting ASAuthorizationController sheet (DartNative Social Sign In tutorial).
class AppleSignInButton extends ValdiComponent {
  final void Function(String token)? onSuccess;

  AppleSignInButton({
    super.key,
    this.onSuccess,
    YogaStyle? style,
  }) : super(style: style);

  @override
  ValdiComponent build() {
    return Container(
      color: '#000000',
      padding: const EdgeValues.symmetric(horizontal: 16, vertical: 12),
      child: Button(
        label: ' Sign in with Apple',
        backgroundColor: '#000000',
        textColor: '#FFFFFF',
        onPressed: () async {
          final auth = AuthService();
          final res = await auth.signInWithApple();
          onSuccess?.call(res);
        },
      ),
    );
  }

  @override
  YogaNode toYogaNode() => build().toYogaNode();
}

/// Google Sign In Button invoking Credential Manager sheet.
class GoogleSignInButton extends ValdiComponent {
  final void Function(String token)? onSuccess;

  GoogleSignInButton({
    super.key,
    this.onSuccess,
    YogaStyle? style,
  }) : super(style: style);

  @override
  ValdiComponent build() {
    return Container(
      color: '#4285F4',
      padding: const EdgeValues.symmetric(horizontal: 16, vertical: 12),
      child: Button(
        label: 'Sign in with Google',
        backgroundColor: '#4285F4',
        textColor: '#FFFFFF',
        onPressed: () async {
          final auth = AuthService();
          final res = await auth.signInWithGoogle();
          onSuccess?.call(res);
        },
      ),
    );
  }

  @override
  YogaNode toYogaNode() => build().toYogaNode();
}
