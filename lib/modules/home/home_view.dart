part of 'home_module.dart';

abstract class HomeViewDelegate {}

abstract class HomeView extends View<HomeViewDelegate> {
  void setDateTime(DateTime dateTime);
  void setUser(UserInfo user);
  void setSurveys(List<SurveyInfo> surveys);
}

class HomeViewImpl extends StatefulWidget {
  const HomeViewImpl({Key? key}) : super(key: key);

  @override
  _HomeViewImplState createState() => _HomeViewImplState();
}

class _HomeViewImplState
    extends ViewState<HomeViewImpl, HomeModule, HomeViewDelegate>
    implements HomeView {
  final _dateTime = BehaviorSubject<DateTime>();
  final _user = BehaviorSubject<UserInfo>();
  final _surveys = BehaviorSubject<List<SurveyInfo>>();
  final _pageController = CarouselController();
  final _currentPage = BehaviorSubject<int>.seeded(0);
  final _isLoading = BehaviorSubject<bool>.seeded(false);

  @override
  void initState() {
    // TODO: Remove them when integrating
    final user = UserInfo();
    user.avatarUrl =
        "https://en.gravatar.com/userimage/137591909/3a20ad06832bc4cbf461554c5df4f2c6.jpg?size=200";

    final surveys = List<SurveyInfo>.empty(growable: true);
    var survey = SurveyInfo();
    survey.title = "Scarlett Bangkok";
    survey.description = "We'd love ot hear from you!";
    survey.coverImageUrl =
        "https://dhdbhh0jsld0o.cloudfront.net/m/1ea51560991bcb7d00d0_";
    surveys.add(survey);

    survey = SurveyInfo();
    survey.title = "ibis Bangkok Riverside";
    survey.description = "We'd love ot hear from you!";
    survey.coverImageUrl =
        "https://dhdbhh0jsld0o.cloudfront.net/m/287db81c5e4242412cc0_";
    surveys.add(survey);

    setDateTime(DateTime.now());
    setUser(user);
    setSurveys(surveys);

    _isLoading.add(true);
    Future.delayed(const Duration(seconds: 2), () => _isLoading.add(false));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Body();
  }

  @override
  void setDateTime(DateTime dateTime) {
    _dateTime.add(dateTime);
  }

  @override
  void setSurveys(List<SurveyInfo> surveys) {
    _surveys.add(surveys);
  }

  @override
  void setUser(UserInfo user) {
    _user.add(user);
  }
}
