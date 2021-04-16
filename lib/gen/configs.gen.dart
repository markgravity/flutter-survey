import 'package:survey/gen/flavors.gen.dart';
import 'package:survey/models/auth_token_info.dart';
import 'package:flutter/widgets.dart';
import 'package:survey/models/user_info.dart';
import 'package:survey/screens/home/home_screen.dart';
import 'package:survey/screens/landing/landing_screen.dart';
import 'package:survey/screens/login/login_screen.dart';

part 'package:survey/configs/app.dart';
part 'package:survey/configs/factories.dart';
part 'package:survey/configs/routes.dart';

class Configs {
  static const app = _AppConfig();
  static final factories = _factories;
  static final routes = _routes;

  const Configs();
}
