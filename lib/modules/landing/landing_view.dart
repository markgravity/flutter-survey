part of 'landing_module.dart';

abstract class LandingView extends View<LandingViewDelegate>
    with AlertViewMixin {
  static const viewKey = Key("view");
  static const backgroundKey = Key("background");
  static const fadeTransitionLogoKey = Key("fade_transition_logo");
  static const animationDuration = Duration(milliseconds: 800);

  void beginAnimation();
}

abstract class LandingViewDelegate implements AlertViewMixinDelegate {
  BehaviorSubject<void> get stateDidInit;

  BehaviorSubject<void> get animationDidFinish;
}

class LandingViewImpl extends StatefulWidget {
  const LandingViewImpl() : super(key: LandingView.viewKey);

  @override
  _LandingViewImplState createState() => _LandingViewImplState();
}

class _LandingViewImplState
    extends ViewState<LandingViewImpl, LandingModule, LandingViewDelegate>
    with SingleTickerProviderStateMixin, AlertViewMixin
    implements LandingView {
  late final AnimationController _animationController = AnimationController(
    duration: LandingView.animationDuration,
    vsync: this,
  );

  late final Animation<double> _animation = CurvedAnimation(
    parent: _animationController,
    curve: Curves.easeIn,
  );

  @override
  void initState() {
    super.initState();
    delegate?.stateDidInit.add(null);
    _animationController.addStatusListener((status) {
      if (status != AnimationStatus.completed) return;
      delegate?.animationDidFinish.add(null);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            color: Colors.black,
          ),
          Assets.images.mainBackgroundDimmed.image(
            key: LandingView.backgroundKey,
            fit: BoxFit.fill,
          ),
          Center(
            child: FadeTransition(
              key: LandingView.fadeTransitionLogoKey,
              opacity: _animation,
              child: Assets.images.logoWhite.svg(),
            ),
          )
        ],
      ),
    );
  }

  @override
  void beginAnimation() {
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
