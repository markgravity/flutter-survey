import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:survey/components/alert/alert.dart';
import 'package:survey/components/button/button.dart';
import 'package:survey/components/progress_hud/progress_hud.dart';
import 'package:survey/components/translucent_text_field/translucent_text_field.dart';
import 'package:survey/gen/assets.gen.dart';
import 'package:survey/screens/login/login_router.dart';
import 'package:survey/services/locator/locator_register.dart';
import 'package:survey/screens/login/login_vm.dart';
import 'package:survey/screens/screen.dart';
import 'package:streams_provider/streams_provider.dart';

part 'components/form.dart';

part 'listeners/state_listener.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  final LoginVM _viewModel = locator.get();
  final LoginRouter _router = locator.get();

  late final AnimationController _animationController = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  );

  late final Animation<double> _animation = CurvedAnimation(
    parent: _animationController,
    curve: Curves.easeIn,
  );

  @override
  void initState() {
    super.initState();
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return StreamsProvider.value(
      value: _viewModel,
      child: StreamsListener(
        listenable: _StateListener(),
        child: StreamsSelector<LoginVM, LoginState>(
          selector: (_, vm) => vm.state,
          builder: (_, state, child) {
            return ProgressHUD(
              isShow: state == LoginState.logging,
              child: child,
            );
          },
          child: Screen(
            body: Stack(
              fit: StackFit.expand,
              children: [
                AnimatedBuilder(
                  builder: (context, child) {
                    return ImageFiltered(
                      imageFilter: ImageFilter.blur(
                        sigmaX: 50.0 * _animation.value,
                        sigmaY: 50.0 * _animation.value,
                        tileMode: TileMode.mirror,
                      ),
                      child: Assets.images.mainBackgroundDimmed
                          .image(fit: BoxFit.fill),
                    );
                  },
                  animation: _animationController,
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedBuilder(
                          animation: _animationController,
                          builder: (_, __) {
                            return Opacity(
                              opacity: _animation.value,
                              child: _Form(),
                            );
                          })
                    ],
                  ),
                ),
                AnimatedBuilder(
                  animation: _animationController,
                  builder: (_, __) => Positioned(
                    left: 0.0,
                    right: 0.0,
                    bottom: 0.0,
                    top: -450 * _animation.value,
                    child: Assets.images.logoWhite.svg(fit: BoxFit.none),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
