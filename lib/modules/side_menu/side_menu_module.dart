import 'package:flutter/material.dart' hide Router;
import 'package:flutter/widgets.dart' hide Router;
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:streams_provider/streams_provider.dart';
import 'package:survey/components/alert/alert.dart';
import 'package:survey/core/viper/module.dart';
import 'package:survey/models/user_info.dart';
import 'package:survey/modules/login/login_module.dart';
import 'package:survey/modules/screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:survey/repositories/auth_repository.dart';
import 'package:survey/services/locator/locator_service.dart';
part 'side_menu_interactor.dart';

part 'side_menu_router.dart';

part 'side_menu_presenter.dart';

part 'side_menu_view.dart';

part 'components/content.dart';

part 'components/user.dart';

part 'components/actions.dart';

class SideMenuModule extends Module<SideMenuView, SideMenuInteractor,
    SideMenuPresenter, SideMenuRouter> {
  static const routePath = "/side-menu";

  @override
  Widget build(BuildContext context) {
    return const SideMenuViewImpl();
  }
}
