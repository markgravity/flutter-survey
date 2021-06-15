import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart' hide Router;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:flutter/widgets.dart' hide Router;
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:intl/intl.dart';
import 'package:simple_gesture_detector/simple_gesture_detector.dart';
import 'package:skeletor/skeletor.dart';
import 'package:streams_provider/streams_provider.dart';
import 'package:survey/components/alert/alert.dart';
import 'package:survey/components/common/progress_hud.dart';
import 'package:survey/core/viper/module.dart';
import 'package:survey/gen/assets.gen.dart';
import 'package:survey/models/survey_info.dart';
import 'package:survey/models/user_info.dart';
import 'package:survey/modules/screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:survey/modules/survey_detail/survey_detail_module.dart';
import 'package:survey/repositories/auth_repository.dart';
import 'package:survey/repositories/survey_repository.dart';
import 'package:survey/services/locator/locator_service.dart';
import 'package:survey/core/extensions/build_context.dart';
import 'package:tuple/tuple.dart';

part 'home_view.dart';

part 'home_interactor.dart';

part 'home_presenter.dart';

part 'home_router.dart';

part 'components/top_bar.dart';

part 'components/slide_item.dart';

part 'components/page_control.dart';
part 'components/body.dart';
part 'components/refresh_indicator.dart';

class HomeModule
    extends Module<HomeView, HomeInteractor, HomePresenter, HomeRouter> {
  static const routePath = "/home";

  @override
  Widget build(BuildContext context) {
    return const HomeViewImpl();
  }
}
