import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:flutter/widgets.dart' hide Router;
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:streams_provider/streams_provider.dart';
import 'package:survey/components/alert/alert.dart';
import 'package:survey/components/button/button.dart';
import 'package:survey/components/confirm/confirm.dart';
import 'package:survey/components/navigation_bar/navigation_bar.dart';
import 'package:survey/core/viper/module.dart';
import 'package:survey/gen/assets.gen.dart';
import 'package:survey/models/detailed_survey_info.dart';
import 'package:survey/models/survey_answer_info.dart';
import 'package:survey/models/survey_question_info.dart';
import 'package:survey/modules/screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

part 'survey_questions_view.dart';

part 'survey_questions_interactor.dart';

part 'survey_questions_presenter.dart';

part 'survey_questions_router.dart';

part 'components/content.dart';

part 'components/answers/rating_answer.dart';

part 'components/answers/nps_answer.dart';

part 'components/answers/select_answer.dart';

part 'components/answers/textarea_answer.dart';

part 'components/slide.dart';

class SurveyQuestionsModule extends ArgumentsModule<
    SurveyQuestionsView,
    SurveyQuestionsInteractor,
    SurveyQuestionsPresenter,
    SurveyQuestionsRouter,
    SurveyQuestionsArguments> {
  static const routePath = "";

  @override
  Widget build(BuildContext context) {
    return const SurveyQuestionsViewImpl();
  }
}

class SurveyQuestionsArguments extends ModuleArguments {
  SurveyQuestionsArguments({required this.survey});

  final DetailedSurveyInfo survey;
}
