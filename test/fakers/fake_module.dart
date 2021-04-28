import 'package:flutter/widgets.dart' hide Router;
import 'package:mockito/mockito.dart';
import 'package:survey/core/viper/module.dart';

class FakeInteractor extends Fake implements Interactor {}

class FakePresenter extends Fake implements Presenter {}

class FakeRouter extends Fake implements Router {}

class FakeModule<V extends View, D>
    extends Module<V, FakeInteractor, FakePresenter, FakeRouter> {
  @override
  // ignore: overridden_fields
  final interactor = FakeInteractor();
  @override
  // ignore: overridden_fields
  final presenter = FakePresenter();
  @override
  // ignore: overridden_fields
  final router = FakeRouter();

  final D delegate;
  final Widget Function() builder;
  FakeModule({required this.builder, required this.delegate});

  @override
  void assembly(V view) {
    this.view = view;
    view.delegate = delegate;
  }

  @override
  Widget build(BuildContext context) {
    return builder();
  }
}
