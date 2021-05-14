part of 'module.dart';

abstract class View<D> {
  BuildContext get context;

  D? delegate;
}

abstract class ViewState<V extends StatefulWidget, M extends Widget, D>
    extends State<V> implements View<D> {
  @visibleForTesting
  static Module? overriddenModule;
  Module? _disposedModule;
  @override
  D? delegate;

  @override
  void initState() {
    super.initState();

    final module = _getModule();
    module?.assembly(this);
  }

  @override
  void didChangeDependencies() {
    final module = _getModule();

    if (module is ArgumentsModule) {
      module.setArguments(ModalRoute.of(context)?.settings.arguments);
    }

    _disposedModule = module;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _disposedModule?.dispose();
    super.dispose();
  }

  Module? _getModule() =>
      (context.findAncestorWidgetOfExactType<M>() ?? overriddenModule)
          as Module?;
}
