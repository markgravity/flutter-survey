part of 'home_module.dart';

abstract class HomeViewDelegate implements AlertViewMixinDelegate {
  BehaviorSubject<void> get stateDidInit;

  BehaviorSubject<SurveyInfo> get showDetailButtonDidTap;

  BehaviorSubject<void> get didSwipeDown;

  BehaviorSubject<void> get userAvatarButtonDidTap;

  BehaviorSubject<void> get sideMenuDidShow;

  BehaviorSubject<void> get sideMenuDidDismiss;

  BehaviorSubject<int> get currentPageDidChange;
}

abstract class HomeView extends View<HomeViewDelegate>
    with AlertViewMixin, ProgressHUDViewMixin {
  static const currentDateTextKey = Key("current_date_text");
  static const userAvatarImageKey = Key("user_avatar_image");
  static const userAvatarButtonKey = Key("user_avatar_button");
  static const titleTextSlideItemKey = Key("title_text_slide_item");
  static const descriptionTextSlideItemKey = Key("description_text_slide_item");
  static const backgroundImageSlideItemKey = Key("background_image_slide_item");
  static const dotPageControlKey = Key("dot_page_control_key");
  static const skeletonKey = Key("skeleton_key");
  static const showDetailButtonKey = Key("show_detail_button");
  static const sliderMenuContainerKey = Key("slider_menu_container");
  static const mainIgnorePointer = Key("home_ignore_pointer");

  static const dotPageControlHighlightColor = Colors.white;
  static const dotPageControlNormalColor = Color.fromRGBO(255, 255, 255, 0.2);

  static const bodyKey = Key("body");

  void setDateTimeText(String text);

  void showUser(UserInfo user);

  void showSurveys(List<SurveyInfo> surveys);

  void beginSkeletonAnimation();

  void stopSkeletonAnimation();

  void showSideMenu();

  void setUserInteractionEnable({required bool isEnabled});

  void setCurrentPage(int page);
}

class HomeViewImpl extends StatefulWidget {
  const HomeViewImpl({Key? key}) : super(key: key);

  @override
  _HomeViewImplState createState() => _HomeViewImplState();
}

class _HomeViewImplState
    extends ViewState<HomeViewImpl, HomeModule, HomeViewDelegate>
    with AlertViewMixin, ProgressHUDViewMixin
    implements HomeView {
  final _dateTimeText = BehaviorSubject<String>();
  final _user = BehaviorSubject<UserInfo>();
  final _surveys = BehaviorSubject<List<SurveyInfo>>.seeded([]);
  final _pageController = CarouselController();
  final _currentPage = BehaviorSubject<int>.seeded(0);
  final _isLoading = BehaviorSubject<bool>.seeded(false);
  final _isUserInteractionEnabled = BehaviorSubject<bool>.seeded(true);
  final _sliderMenuContainerKey = GlobalKey<SliderMenuContainerState>();
  final _widgetsBinding = WidgetsBinding.instance!;

  @override
  void initState() {
    super.initState();
    delegate?.stateDidInit.add(null);

    _widgetsBinding
        .scheduleFrameCallback(_listenSliderMenuContainerAnimationController);
  }

  @override
  Widget build(BuildContext context) {
    return const Body(
      key: HomeView.bodyKey,
    );
  }

  @override
  void setDateTimeText(String text) {
    _dateTimeText.add(text);
  }

  @override
  void showSurveys(List<SurveyInfo> surveys) {
    _surveys.add(surveys);
  }

  @override
  void showUser(UserInfo user) {
    _user.add(user);
  }

  @override
  void stopSkeletonAnimation() {
    _isLoading.add(false);
  }

  @override
  void beginSkeletonAnimation() {
    _isLoading.add(true);
  }

  @override
  void showSideMenu() {
    _sliderMenuContainerKey.currentState?.openDrawer();
  }

  @override
  void setUserInteractionEnable({required bool isEnabled}) {
    _isUserInteractionEnabled.add(isEnabled);
  }

  @override
  void setCurrentPage(int page) {
    _currentPage.add(page);
  }

  void _listenSliderMenuContainerAnimationController(Duration timestamp) {
    final animationController =
        _sliderMenuContainerKey.currentState?.animationController;
    if (animationController == null) {
      _widgetsBinding
          .scheduleFrameCallback(_listenSliderMenuContainerAnimationController);
      return;
    }

    animationController.addListener(() {
      switch (animationController.status) {
        case AnimationStatus.completed:
          delegate?.sideMenuDidShow.add(null);
          break;
        case AnimationStatus.dismissed:
          delegate?.sideMenuDidDismiss.add(null);
          break;
        default:
          break;
      }
    });
  }
}
