part of 'login_module.dart';

abstract class LoginView extends View<LoginViewDelegate>
    with AlertViewMixin, ProgressHUDViewMixin {
  static const backgroundImageKey = Key("background_image");
  static const logoImageKey = Key("logo_image");
  static const loginButtonKey = Key("login_button");
  static const forgotButtonKey = Key("forgot_button");
  static const emailTextFieldKey = Key("email_text_field");
  static const passwordTextFieldKey = Key("password_text_field");
  static const opacityFormKey = Key("opacity_form");
  static const progressHUDKey = Key("progress_hud_key");

  static const animationDuration = Duration(seconds: 1);

  void beginAnimation();

  void setLoginButton({required bool isEnabled});
}

abstract class LoginViewDelegate implements AlertViewMixinDelegate {
  BehaviorSubject<void> get forgotButtonDidTap;

  BehaviorSubject<void> get stateDidInit;

  BehaviorSubject<String> get emailTextFieldDidChange;

  BehaviorSubject<String> get passwordTextFieldDidChange;

  BehaviorSubject<List<String>> get loginButtonDidTap;
}

class LoginViewImpl extends StatefulWidget {
  @override
  _LoginViewImplState createState() => _LoginViewImplState();
}

class _LoginViewImplState
    extends ViewState<LoginViewImpl, LoginModule, LoginViewDelegate>
    with TickerProviderStateMixin, AlertViewMixin, ProgressHUDViewMixin
    implements LoginView {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _isLoginButtonDisabled = BehaviorSubject<bool>.seeded(true);

  late final AnimationController _animationController = AnimationController(
    duration: LoginView.animationDuration,
    vsync: this,
  );

  late final Animation<double> _animation = CurvedAnimation(
    parent: _animationController,
    curve: Curves.easeIn,
  );

  @override
  void initState() {
    super.initState();
    _emailController.addListener(() {
      delegate?.emailTextFieldDidChange.add(_emailController.text);
    });

    _passwordController.addListener(() {
      delegate?.passwordTextFieldDidChange.add(_passwordController.text);
    });
    delegate?.stateDidInit.add(null);
  }

  @override
  Widget build(BuildContext context) {
    return StreamsSelector0<bool>.value(
      stream: isProgressHUDShown,
      builder: (_, isShow, child) {
        return ProgressHUD(
          key: LoginView.progressHUDKey,
          isShow: isShow,
          child: child!,
        );
      },
      child: Screen(
        body: Stack(
          fit: StackFit.expand,
          children: [
            AnimatedBuilder(
              builder: (context, child) {
                return ImageFiltered(
                  imageFilter: ImageFilter.blur(
                    sigmaX: 50.0 * _animation.value,
                    sigmaY: 50.0 * _animation.value,
                    tileMode: TileMode.mirror,
                  ),
                  child: Assets.images.mainBackgroundDimmed.image(
                      key: LoginView.backgroundImageKey, fit: BoxFit.fill),
                );
              },
              animation: _animationController,
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedBuilder(
                      animation: _animationController,
                      builder: (_, __) {
                        return Opacity(
                          key: LoginView.opacityFormKey,
                          opacity: _animation.value,
                          child: _Form(),
                        );
                      })
                ],
              ),
            ),
            AnimatedBuilder(
              animation: _animationController,
              builder: (_, __) => Positioned(
                left: 0.0,
                right: 0.0,
                bottom: 0.0,
                top: -450 * _animation.value,
                child: Assets.images.logoWhite.svg(
                  key: LoginView.logoImageKey,
                  fit: BoxFit.none,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void beginAnimation() {
    _animationController.forward();
  }

  @override
  void setLoginButton({required bool isEnabled}) {
    _isLoginButtonDisabled.add(isEnabled);
  }
}
