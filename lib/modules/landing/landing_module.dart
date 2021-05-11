import 'package:flutter/cupertino.dart' hide Router;
import 'package:flutter/material.dart' hide Router;
import 'package:streams_provider/streams_provider.dart';
import 'package:survey/components/alert/alert.dart';
import 'package:survey/core/viper/module.dart';
import 'package:survey/gen/assets.gen.dart';
import 'package:survey/modules/screen.dart';

part 'landing_presenter.dart';

part 'landing_router.dart';

part 'landing_view.dart';

part 'landing_interactor.dart';

class LandingModule extends Module<LandingView, LandingInteractor,
    LandingPresenter, LandingRouter> {
  static const routePath = "/";

  @override
  Widget build(BuildContext context) {
    return const LandingViewImpl();
  }
}
