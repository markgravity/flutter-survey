part of 'package:survey/screens/landing/landing_screen.dart';

class _AnimationStateListener
    implements StreamsListenable<LandingVM, LandingAnimationState> {
  @override
  void handler(
      BuildContext context, LandingVM viewModel, LandingAnimationState state) {
    final viewState =
        context.findRootAncestorStateOfType<_LandingScreenState>();
    switch (state) {
      case LandingAnimationState.animating:
        viewState?._animationController.forward();
        break;

      default:
        break;
    }
  }

  @override
  Stream<LandingAnimationState> selector(
      BuildContext context, LandingVM viewModel) {
    return viewModel.animationState;
  }
}
