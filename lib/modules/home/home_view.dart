part of 'home_module.dart';

abstract class HomeViewDelegate implements AlertViewMixinDelegate {
  BehaviorSubject<void> get stateDidInit;

  BehaviorSubject<SurveyInfo> get showDetailButtonDidTap;

  BehaviorSubject<void> get didSwipeDown;
}

abstract class HomeView extends View<HomeViewDelegate> with AlertViewMixin {
  static const currentDateTextKey = Key("current_date_text");
  static const userAvatarImageKey = Key("user_avatar_image");
  static const titleTextSlideItemKey = Key("title_text_slide_item");
  static const descriptionTextSlideItemKey = Key("description_text_slide_item");
  static const backgroundImageSlideItemKey = Key("background_image_slide_item");
  static const dotPageControlKey = Key("dot_page_control_key");
  static const skeletonKey = Key("skeleton_key");
  static const showDetailButtonKey = Key("show_detail_button");
  static const dotPageControlHighlightColor = Colors.white;
  static const dotPageControlNormalColor = Color.fromRGBO(255, 255, 255, 0.2);

  static const bodyKey = Key("body");

  void setDateTimeText(String text);

  void showUser(UserInfo user);

  void showSurveys(List<SurveyInfo> surveys);

  void beginSkeletonAnimation();

  void stopSkeletonAnimation();

  void showRefreshIndicator();

  void dismissRefreshIndicator();
}

class HomeViewImpl extends StatefulWidget {
  const HomeViewImpl({Key? key}) : super(key: key);

  @override
  _HomeViewImplState createState() => _HomeViewImplState();
}

class _HomeViewImplState extends ViewState<HomeViewImpl, HomeModule, HomeViewDelegate>
    with AlertViewMixin, SingleTickerProviderStateMixin
    implements HomeView {
  final _dateTimeText = BehaviorSubject<String>();
  final _user = BehaviorSubject<UserInfo>();
  final _surveys = BehaviorSubject<List<SurveyInfo>>.seeded([]);
  final _pageController = CarouselController();
  final _currentPage = BehaviorSubject<int>.seeded(0);
  final _isLoading = BehaviorSubject<bool>.seeded(false);
  final _isRefreshing = BehaviorSubject<bool>.seeded(false);

  late final AnimationController _refreshIndicatorAnimationController = AnimationController(
    duration: const Duration(milliseconds: 300),
    vsync: this,
  );

  late final Animation<Offset> _refreshIndicatorAnimation = Tween<Offset>(
    begin: const Offset(0.0, -1.0),
    end: Offset.zero,
  ).animate(_refreshIndicatorAnimationController);

  @override
  void initState() {
    super.initState();
    delegate?.stateDidInit.add(null);
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
  void showRefreshIndicator() {
    _isRefreshing.add(true);
    _refreshIndicatorAnimationController.forward(from: 0);
  }

  @override
  void dismissRefreshIndicator() {
    _isRefreshing.add(false);
    _refreshIndicatorAnimationController.reverse(from: 1);
  }
}
