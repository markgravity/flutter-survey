part of '../forgot_password_module.dart';

class ResetSuccessfullyNotification extends StatelessWidget {
  const ResetSuccessfullyNotification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff252525).withOpacity(0.6),
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
      child: SafeArea(
        bottom: false,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Assets.images.forgotPasswordBellIcon.svg(),
            const SizedBox(
              width: 15.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppLocalizations.of(context)!
                      .forgotPasswordScreenResetSuccessfullyNotificationTitle,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13.0,
                  ),
                ),
                Text(
                  AppLocalizations.of(context)!
                      .forgotPasswordScreenResetSuccessfullyNotificationMessage,
                  style: const TextStyle(
                    fontSize: 13.0,
                    color: Colors.white,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
