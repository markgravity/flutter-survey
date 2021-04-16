part of '../login_screen.dart';

class _StateListener implements StreamsListenable<LoginVM, LoginState> {
  @override
  void handler(BuildContext context, LoginVM vm, LoginState state) {
    final viewState = context.findRootAncestorStateOfType<_LoginScreenState>();

    switch (state) {
      case LoginState.logging:
        break;
      case LoginState.completed:
        viewState?._router.replaceToHomeScreen(context: context);
        break;
      case LoginState.error:
        alertError(context: context, error: vm.error.value!);
        break;
      default:
        break;
    }
  }

  @override
  Stream<LoginState> selector(BuildContext context, LoginVM vm) {
    return vm.state;
  }
//
}
