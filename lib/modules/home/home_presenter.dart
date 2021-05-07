part of 'home_module.dart';

abstract class HomePresenter
    extends Presenter<HomeView, HomeInteractor, HomeRouter> {}

class HomePresenterImpl extends HomePresenter
    implements HomeViewDelegate, HomeInteractorDelegate {}
