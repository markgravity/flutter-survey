import 'dart:ui';

import 'package:async/async.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:flutter/widgets.dart' hide Router;
import 'package:streams_provider/streams_provider.dart';
import 'package:survey/components/alert/alert.dart';
import 'package:survey/components/button/button.dart';
import 'package:survey/components/navigation_bar/navigation_bar.dart';
import 'package:survey/components/common/progress_hud.dart';
import 'package:survey/components/translucent_text_field/translucent_text_field.dart';
import 'package:survey/core/viper/module.dart';
import 'package:survey/gen/assets.gen.dart';
import 'package:survey/gen/configs.gen.dart';
import 'package:survey/modules/screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:survey/repositories/auth_repository.dart';
import 'package:survey/services/locator/locator_service.dart';

part 'forgot_password_view.dart';
part 'forgot_password_interactor.dart';
part 'forgot_password_presenter.dart';
part 'forgot_password_router.dart';
part 'components/reset_successfully_notification.dart';

class ForgotPasswordModule extends Module<ForgotPasswordView,
    ForgotPasswordInteractor, ForgotPasswordPresenter, ForgotPasswordRouter> {
  static const routePath = "/forgot-password";

  @override
  Widget build(BuildContext context) {
    return const ForgotPasswordViewImpl();
  }
}
