part of '../login_screen.dart';

class _Form extends StatefulWidget {
  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  LoginVM get _vm => StreamsProvider.of<LoginVM>(context);
  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  @override
  void initState() {
    _emailController.addListener(() {
      _vm.setEmail(_emailController.text);
    });

    _passwordController.addListener(() {
      _vm.setPassword(_passwordController.text);
    });

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
          StreamsSelector<LoginVM, bool>(
            selector: (_, vm) => vm.isValid,
            builder: (_, isValid, __) {
              return Button(
                title: "Log in",
                isEnabled: isValid,
                onPressed: () => _vm.login(),
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
        placeholder: "Email",
        keyboardType: TextInputType.emailAddress,
        controller: _emailController,
      ),
    );
  }

  Widget _passwordTextField() {
    return SizedBox(
      height: 56.0,
      child: TranslucentTextField(
        placeholder: "Password",
        obscureText: true,
        controller: _passwordController,
        after: PlatformButton(
          onPressed: () => {},
          child: Text(
            "Forgot?",
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
