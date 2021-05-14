part of 'module.dart';

class Interactor<D> {
  D? delegate;
}

abstract class ArgumentsInteractor<D, A extends ModuleArguments>
    extends Interactor<D> {
  A? arguments;
}
