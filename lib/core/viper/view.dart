part of 'module.dart';

abstract class View<D> {
  BuildContext get context;

  D? delegate;
}

abstract class ViewState<V extends StatefulWidget, M extends Widget, D>
    extends State<V> implements View<D> {
  static Module? overriddenModule;

  @override
  D? delegate;

  @override
  void initState() {
    super.initState();

    ((context.findAncestorWidgetOfExactType<M>() ?? overriddenModule)
            as Module?)
        ?.assembly(this);
  }
}
