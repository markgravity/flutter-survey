import 'package:flutter/material.dart' hide Router;
import 'package:flutter/widgets.dart' hide Router;
import 'package:lottie/lottie.dart';
import 'package:streams_provider/streams_provider.dart';
import 'package:survey/core/viper/module.dart';
import 'package:survey/gen/assets.gen.dart';
import 'package:survey/models/survey_question_info.dart';
import 'package:survey/modules/screen.dart';

part 'survey_completed_view.dart';

part 'survey_completed_interactor.dart';

part 'survey_completed_presenter.dart';

part 'survey_completed_router.dart';

part 'components/content.dart';

class SurveyCompletedModule extends ArgumentsModule<
    SurveyCompletedView,
    SurveyCompletedInteractor,
    SurveyCompletedPresenter,
    SurveyCompletedRouter,
    SurveyCompletedArguments> {
  static const routePath = "survey/completed";

  @override
  Widget build(BuildContext context) {
    return const SurveyCompletedViewImpl();
  }
}

class SurveyCompletedArguments extends ModuleArguments {
  SurveyCompletedArguments({required this.outro});

  final SurveyQuestionInfo outro;
}
