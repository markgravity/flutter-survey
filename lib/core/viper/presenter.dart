part of 'module.dart';

abstract class Presenter<V extends View, I extends Interactor,
    R extends Router> {
  final disposeBag = CompositeSubscription();

  late final I interactor;
  late final V view;
  late final R router;

  void configure({
    required V view,
    required I interactor,
    required R router,
  }) {
    this.view = view;
    this.interactor = interactor;
    this.router = router;
  }

  void dispose() {
    disposeBag.dispose();
  }
}
