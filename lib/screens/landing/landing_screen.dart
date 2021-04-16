import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:streams_provider/streams_provider.dart';
import 'package:survey/gen/assets.gen.dart';
import 'package:survey/screens/landing/landing_router.dart';
import 'package:survey/screens/landing/landing_vm.dart';
import 'package:survey/screens/screen.dart';
import 'package:survey/services/locator/locator_register.dart';

part 'package:survey/screens/landing/listeners/state_listener.dart';

part 'package:survey/screens/landing/listeners/animation_state_listener.dart';

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen>
    with SingleTickerProviderStateMixin {
  final LandingVM _viewModel = locator.get();
  final LandingRouter _router = locator.get();

  late final AnimationController _animationController = AnimationController(
    duration: const Duration(milliseconds: 800),
    vsync: this,
  );

  late final Animation<double> _animation = CurvedAnimation(
    parent: _animationController,
    curve: Curves.easeIn,
  );

  @override
  void initState() {
    super.initState();
    _viewModel.begin();
    _animationController.addStatusListener((status) {
      if (status != AnimationStatus.completed) return;
      _viewModel.markAsAnimationCompleted();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiStreamsListener<LandingVM, LandingState, LandingAnimationState>(
      provider: _viewModel,
      listenable1: _StateListener(),
      listenable2: _AnimationStateListener(),
      child: Screen(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              color: Colors.black,
            ),
            Assets.images.mainBackgroundDimmed.image(fit: BoxFit.fill),
            Center(
              child: FadeTransition(
                opacity: _animation,
                child: Assets.images.logoWhite.svg(),
              ),
            )
          ],
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
