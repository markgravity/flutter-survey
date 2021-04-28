import 'package:survey/gen/flavors.gen.dart';
import 'package:flutter/widgets.dart';
import 'package:survey/screens/landing/landing_screen.dart';

part 'package:survey/configs/app.dart';
part 'package:survey/configs/factories.dart';
part 'package:survey/configs/routes.dart';

class Configs {
  static const app = _AppConfig();
  static final factories = _factories;
  static final routes = _routes;

  const Configs();
}
