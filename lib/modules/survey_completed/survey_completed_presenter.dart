part of 'survey_completed_module.dart';

abstract class SurveyCompletedPresenter extends Presenter<SurveyCompletedView,
    SurveyCompletedInteractor, SurveyCompletedRouter> {
  static const popBackDelayDuration = Duration(seconds: 2);
}

class SurveyCompletedPresenterImpl extends SurveyCompletedPresenter
    implements SurveyCompletedViewDelegate, SurveyCompletedInteractorDelegate {
  SurveyCompletedPresenterImpl() {
    stateDidInit.voidListen(_stateDidInit).addTo(disposeBag);
    animationDidFinish.voidListen(_animationDidFinish).addTo(disposeBag);

    [stateDidInit, animationDidLoad]
        .zip()
        .voidListen(_beginAnimation)
        .addTo(disposeBag);
  }

  @override
  final stateDidInit = BehaviorSubject<void>();

  @override
  final animationDidFinish = BehaviorSubject<void>();

  @override
  final animationDidLoad = BehaviorSubject<void>();

  void _stateDidInit() {
    view.setOutro(interactor.outro);
  }

  void _beginAnimation() {
    view.beginAnimation();
  }

  void _animationDidFinish() {
    Future.delayed(SurveyCompletedPresenter.popBackDelayDuration, () {
      router.popBack(view.context);
    });
  }
}
