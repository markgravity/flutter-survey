import 'package:survey/gen/flavors.gen.dart';
import 'package:flutter/widgets.dart';
import 'package:survey/models/auth_token_info.dart';
import 'package:survey/models/detailed_survey_info.dart';
import 'package:survey/models/survey_question_answer_info.dart';
import 'package:survey/models/survey_info.dart';
import 'package:survey/models/survey_question_info.dart';
import 'package:survey/models/user_info.dart';
import 'package:survey/modules/forgot_password/forgot_password_module.dart';
import 'package:survey/modules/home/home_module.dart';
import 'package:survey/modules/landing/landing_module.dart';
import 'package:survey/modules/login/login_module.dart';
import 'package:survey/modules/side_menu/side_menu_module.dart';
import 'package:survey/modules/survey_completed/survey_completed_module.dart';
import 'package:survey/modules/survey_detail/survey_detail_module.dart';
import 'package:survey/modules/survey_questions/survey_questions_module.dart';
import 'package:survey/services/api/api_service.dart';

part 'package:survey/configs/app.dart';
part 'package:survey/configs/factories.dart';
part 'package:survey/configs/routes.dart';

class Configs {
  static const app = _AppConfig();
  static final factories = _factories;
  static final routes = _routes;

  const Configs();
}
