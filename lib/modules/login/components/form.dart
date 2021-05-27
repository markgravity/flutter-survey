part of '../login_module.dart';

class _Form extends StatefulWidget {
  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  _LoginViewImplState get _state => context.findAncestorStateOfType()!;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _emailTextField(),
          const SizedBox(
            height: 20,
          ),
          _passwordTextField(),
          const SizedBox(
            height: 20,
          ),
          StreamsSelector0<bool>.value(
            stream: _state._isLoginButtonEnabled,
            builder: (_, isEnabled, __) {
              return Button(
                key: LoginView.loginButtonKey,
                title: AppLocalizations.of(context)!.loginScreenLoginButtonText,
                isEnabled: isEnabled,
                onPressed: () => _state.delegate?.loginButtonDidTap.add([
                  _state._emailController.text,
                  _state._passwordController.text
                ]),
              );
            },
          )
        ],
      ),
    );
  }

  Widget _emailTextField() {
    return SizedBox(
      height: 56.0,
      child: TranslucentTextField(
        key: LoginView.emailTextFieldKey,
        placeholder: AppLocalizations.of(context)!
            .loginScreenEmailTextFieldPlaceholderText,
        keyboardType: TextInputType.emailAddress,
        controller: _state._emailController,
      ),
    );
  }

  Widget _passwordTextField() {
    return SizedBox(
      height: 56.0,
      child: TranslucentTextField(
        key: LoginView.passwordTextFieldKey,
        placeholder: AppLocalizations.of(context)!
            .loginScreenPasswordTextFieldPlaceholderText,
        obscureText: true,
        controller: _state._passwordController,
        trailing: PlatformButton(
          key: LoginView.forgotButtonKey,
          onPressed: () => _state.delegate?.forgotButtonDidTap.add(null),
          materialFlat: (_, __) => MaterialFlatButtonData(
            color: Colors.transparent,
          ),
          child: Text(
            AppLocalizations.of(context)!.loginScreenForgotButtonText,
            style: TextStyle(
              color: Colors.white.withAlpha(50),
              fontSize: 15.0,
            ),
          ),
        ),
      ),
    );
  }
}
