import 'dart:ui';

import 'package:flutter/cupertino.dart' hide Router;
import 'package:flutter/material.dart' hide Router;
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:streams_provider/streams_provider.dart';
import 'package:survey/components/alert/alert.dart';
import 'package:survey/components/button/button.dart';
import 'package:survey/components/common/progress_hud.dart';
import 'package:survey/components/translucent_text_field/translucent_text_field.dart';
import 'package:survey/core/viper/module.dart';
import 'package:survey/gen/assets.gen.dart';
import 'package:survey/modules/forgot_password/forgot_password_module.dart';
import 'package:survey/modules/home/home_module.dart';
import 'package:survey/modules/screen.dart';
import 'package:survey/repositories/auth/auth_repository.dart';
import 'package:survey/services/locator/locator_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

part 'login_presenter.dart';

part 'login_router.dart';

part 'login_interactor.dart';

part 'login_view.dart';

part 'components/form.dart';

class LoginModule
    extends Module<LoginView, LoginInteractor, LoginPresenter, LoginRouter> {
  static const routePath = "/login";

  @override
  Widget build(BuildContext context) {
    return LoginViewImpl();
  }
}
