import 'package:flutter/material.dart' hide Router;
import 'package:flutter/widgets.dart' hide Router;
import 'package:survey/components/button/button.dart';
import 'package:survey/components/navigation_bar/navigation_bar.dart';
import 'package:survey/core/viper/module.dart';
import 'package:survey/gen/assets.gen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:survey/modules/screen.dart';

part 'survey_detail_view.dart';

part 'survey_detail_interactor.dart';

part 'survey_detail_presenter.dart';

part 'survey_detail_router.dart';

part 'components/content.dart';

class SurveyDetailModule extends Module<SurveyDetailView,
    SurveyDetailInteractor, SurveyDetailPresenter, SurveyDetailRouter> {
  static const routePath = "/survey/detail";

  @override
  Widget build(BuildContext context) {
    return const SurveyDetailViewImpl();
  }
}
