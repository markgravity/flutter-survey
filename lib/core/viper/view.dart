part of 'module.dart';

abstract class View<D> {
  BuildContext get context;

  D? delegate;
}

abstract class ViewState<V extends StatefulWidget, M extends Widget, D>
    extends State<V> implements View<D> {
  static Module? overriddenModule;
  Module? _disposedModule;
  @override
  D? delegate;

  @override
  void initState() {
    super.initState();

    _getModule()?.assembly(this);
  }

  @override
  void didChangeDependencies() {
    _disposedModule = _getModule();
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
