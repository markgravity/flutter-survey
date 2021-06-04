part of 'forgot_password_module.dart';

abstract class ForgotPasswordView extends View<ForgotPasswordViewDelegate>
    with ProgressHUDViewMixin, AlertViewMixin {
  static const showingResetSuccessfullyNotificationDuration =
      Duration(milliseconds: 600);
  static const dismissResetSuccessfullyNotificationDelayDuration =
      Duration(seconds: 2);

  static const emailTextFieldKey = Key("email_text_field_key");
  static const resetButtonKey = Key("reset_button_key");
  static const resetSuccessfullyNotificationSlideTransitionKey =
      Key("reset_successfully_notification_slide_transition");
  static const resetSuccessfullyNotificationKey =
      Key("reset_successfully_notification");

  static const resetSuccessfullyNotificationSlideTransitionBeginOffset =
      Offset(0, -1);
  static const resetSuccessfullyNotificationSlideTransitionEndOffset =
      Offset.zero;

  void clearEmailTextField();

  void setResetButton({required bool isEnabled});

  void showResetSuccessfullyNotification();
}

abstract class ForgotPasswordViewDelegate implements AlertViewMixinDelegate {
  BehaviorSubject<String> get emailTextFieldDidChange;

  BehaviorSubject<String> get resetButtonDidTap;
}

class ForgotPasswordViewImpl extends StatefulWidget {
  const ForgotPasswordViewImpl({Key? key}) : super(key: key);

  @override
  _ForgotPasswordViewImplState createState() => _ForgotPasswordViewImplState();
}

class _ForgotPasswordViewImplState extends ViewState<ForgotPasswordViewImpl,
        ForgotPasswordModule, ForgotPasswordViewDelegate>
    with
        ProgressHUDViewMixin<ForgotPasswordViewDelegate>,
        SingleTickerProviderStateMixin,
        AlertViewMixin
    implements ForgotPasswordView {
  late final AnimationController _notificationAnimationController =
      AnimationController(
    duration: ForgotPasswordView.showingResetSuccessfullyNotificationDuration,
    vsync: this,
  );

  late final Animation<Offset> _notificationAnimation = Tween<Offset>(
    begin: ForgotPasswordView
        .resetSuccessfullyNotificationSlideTransitionBeginOffset,
    end: ForgotPasswordView
        .resetSuccessfullyNotificationSlideTransitionEndOffset,
  ).animate(_notificationAnimationController);

  final _emailTextController = TextEditingController();
  final _isResetButtonEnabled = BehaviorSubject<bool>.seeded(false);

  CancelableOperation? _dismissNotificationOperation;

  @override
  void initState() {
    _emailTextController.addListener(() {
      delegate?.emailTextFieldDidChange.add(_emailTextController.text);
    });
    _notificationAnimationController.addStatusListener((status) {
      if (status != AnimationStatus.completed) return;

      // Set a timeout to slide out the notification
      _dismissNotificationOperation?.cancel();
      _dismissNotificationOperation = CancelableOperation.fromFuture(
          Future.delayed(
              ForgotPasswordView
                  .dismissResetSuccessfullyNotificationDelayDuration, () {
        _dismissResetSuccessfullyNotification();
      }));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamsSelector0<bool>.value(
      stream: isProgressHUDShown,
      builder: (_, isShow, child) => ProgressHUD(
        isShow: isShow,
        child: child!,
      ),
      child: Screen(
        body: Stack(
          children: [
            ImageFiltered(
              imageFilter: ImageFilter.blur(
                sigmaX: 50.0,
                sigmaY: 50.0,
                tileMode: TileMode.mirror,
              ),
              child: Assets.images.mainBackgroundDimmed.image(),
            ),
            Column(
              children: [
                SafeArea(
                  child: NavigationBar(),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 53,
                      ),
                      Assets.images.logoWhite.svg(
                        fit: BoxFit.none,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Text(
                        AppLocalizations.of(context)!
                            .forgotPasswordScreenDescription,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.white.withOpacity(0.7),
                        ),
                      ),
                      const SizedBox(
                        height: 96,
                      ),
                      SizedBox(
                        height: 56,
                        child: TranslucentTextField(
                          key: ForgotPasswordView.emailTextFieldKey,
                          controller: _emailTextController,
                          placeholder: AppLocalizations.of(context)!
                              .forgotPasswordScreenEmailTextFieldPlaceholder,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      StreamsSelector0<bool>.value(
                        stream: _isResetButtonEnabled,
                        builder: (_, isEnabled, __) => Button(
                          key: ForgotPasswordView.resetButtonKey,
                          onPressed: () => delegate?.resetButtonDidTap
                              .add(_emailTextController.text),
                          isEnabled: isEnabled,
                          title: AppLocalizations.of(context)!
                              .forgotPasswordScreenResetButtonTitle,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            GestureDetector(
              onTap: () => _dismissResetSuccessfullyNotification(),
              child: SlideTransition(
                key: ForgotPasswordView
                    .resetSuccessfullyNotificationSlideTransitionKey,
                position: _notificationAnimation,
                child: const ResetSuccessfullyNotification(
                  key: ForgotPasswordView.resetSuccessfullyNotificationKey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void setResetButton({required bool isEnabled}) {
    _isResetButtonEnabled.add(isEnabled);
  }

  @override
  void clearEmailTextField() {
    _emailTextController.text = "";
  }

  @override
  void showResetSuccessfullyNotification() {
    _notificationAnimationController.forward(from: 0);
  }

  void _dismissResetSuccessfullyNotification() {
    _dismissNotificationOperation?.cancel();
    _notificationAnimationController.reverse();
  }

  @override
  void dispose() {
    _emailTextController.dispose();
    _notificationAnimationController.dispose();
    _dismissNotificationOperation?.cancel();
    super.dispose();
  }
}
