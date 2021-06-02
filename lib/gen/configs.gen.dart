import 'package:survey/gen/flavors.gen.dart';
import 'package:flutter/widgets.dart';
import 'package:survey/models/auth_token_info.dart';
import 'package:survey/models/user_info.dart';
import 'package:survey/modules/forgot_password/forgot_password_module.dart';
import 'package:survey/modules/home/home_module.dart';
import 'package:survey/modules/landing/landing_module.dart';
import 'package:survey/modules/login/login_module.dart';

part 'package:survey/configs/app.dart';
part 'package:survey/configs/factories.dart';
part 'package:survey/configs/routes.dart';
part 'package:survey/configs/colors.dart';

class Configs {
  static const app = _AppConfig();
  static final factories = _factories;
  static final routes = _routes;
  static const colors = _ColorsConfig();

  const Configs();
}
