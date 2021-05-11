import 'package:flutter/cupertino.dart';
import 'package:streams_provider/streams_provider.dart';
import 'package:survey/services/locator/locator_service.dart';

export 'package:survey/core/extensions/build_context.dart';
export 'package:survey/core/extensions/stream.dart';
part 'presenter.dart';
part 'interactor.dart';
part 'router.dart';
part 'view.dart';

abstract class Module<V extends View, I extends Interactor, P extends Presenter,
    R extends Router> extends StatelessWidget {
  late final V view;
  late final I interactor = locator.get();
  late final P presenter = locator.get();
  late final R router = locator.get();

  void assembly(V view) {
    this.view = view;

    view.delegate = presenter;
    interactor.delegate = presenter;
    presenter.configure(view: view, interactor: interactor, router: router);
  }

  void dispose() {
    presenter.dispose();
  }
}
