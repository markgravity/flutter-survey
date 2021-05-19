part of 'landing_module.dart';

abstract class LandingPresenter
    extends Presenter<LandingView, LandingInteractor, LandingRouter> {}

class LandingPresenterImpl extends LandingPresenter
    implements LandingInteractorDelegate, LandingViewDelegate {
  @override
  final stateDidInit = BehaviorSubject<void>();

  @override
  final alertDialogDidClose = BehaviorSubject<void>();

  @override
  final animationDidFinish = BehaviorSubject<void>();
}
