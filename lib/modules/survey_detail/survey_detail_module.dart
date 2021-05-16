import 'package:flutter/material.dart' hide Router;
import 'package:flutter/widgets.dart' hide Router;
import 'package:streams_provider/streams_provider.dart';
import 'package:survey/components/alert/alert.dart';
import 'package:survey/components/button/button.dart';
import 'package:survey/components/common/progress_hud.dart';
import 'package:survey/components/navigation_bar/navigation_bar.dart';
import 'package:survey/core/viper/module.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:survey/models/detailed_survey_info.dart';
import 'package:survey/models/survey_info.dart';
import 'package:survey/modules/screen.dart';
import 'package:survey/modules/survey_questions/survey_questions_module.dart';
import 'package:survey/repositories/survey_repository.dart';
import 'package:survey/services/locator/locator_service.dart';

part 'survey_detail_view.dart';

part 'survey_detail_interactor.dart';

part 'survey_detail_presenter.dart';

part 'survey_detail_router.dart';

part 'components/content.dart';

class SurveyDetailModule extends ArgumentsModule<
    SurveyDetailView,
    SurveyDetailInteractor,
    SurveyDetailPresenter,
    SurveyDetailRouter,
    SurveyDetailArguments> {
  static const routePath = "/survey/detail";

  @override
  Widget build(BuildContext context) {
    return const SurveyDetailViewImpl();
  }
}

class SurveyDetailArguments extends ModuleArguments {
  SurveyDetailArguments({required this.survey});

  final SurveyInfo survey;
}
