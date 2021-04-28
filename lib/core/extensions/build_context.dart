import 'package:flutter/widgets.dart';
export 'navigator_state.dart';

extension BuildContextExtensions on BuildContext {
  NavigatorState get navigator => Navigator.of(this);
}
