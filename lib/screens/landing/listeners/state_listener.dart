part of 'package:survey/screens/landing/landing_screen.dart';

class _StateListener implements StreamsListenable<LandingVM, LandingState> {
  @override
  void handler(BuildContext context, LandingVM viewModel, LandingState state) {
    final viewState =
        context.findRootAncestorStateOfType<_LandingScreenState>();

    switch (state) {
      case LandingState.error:
        break;

      case LandingState.completed:
        switch (viewModel.isAuthenticated.value) {
          case true:
            viewState?._router.replaceToHomeScreen(context: context);
            break;

          case false:
            viewState?._router.replaceToLoginScreen(context: context);
            break;
        }

        break;

      default:
        break;
    }
  }

  @override
  Stream<LandingState> selector(BuildContext context, LandingVM viewModel) {
    return viewModel.state;
  }
//
}
