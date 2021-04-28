import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/widgets.dart';
import 'package:streams_provider/streams_provider.dart';
import 'package:survey/core/classes/localized_exception.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:survey/core/viper/module.dart';
export 'package:adaptive_dialog/adaptive_dialog.dart';

Future<OkCancelResult> alert({
  required BuildContext context,
  String? title,
  String? message,
  String? okLabel,
}) {
  return showOkAlertDialog(
    context: context,
    title: title,
    message: message,
    okLabel: okLabel,
  );
}

Future<OkCancelResult> alertError({
  required BuildContext context,
  required Object error,
  String? okLabel,
}) {
  String message = AppLocalizations.of(context)!.alertErrorFallbackMessage;
  if (error is String) {
    message = error;
  }

  if (error is LocalizedException) {
    message = error.message;
  }

  return alert(
    context: context,
    title: AppLocalizations.of(context)!.alertErrorTitle,
    message: message,
    okLabel: AppLocalizations.of(context)!.alertErrorOKLabel,
  );
}

abstract class AlertViewMixinDelegate {
  BehaviorSubject<void> get alertDialogDidClose;
}

mixin AlertViewMixin<D extends AlertViewMixinDelegate> on View<D> {
  void alert(Object error) {
    alertError(
      context: context,
      error: error,
    ).then((_) => delegate?.alertDialogDidClose.add(null));
  }
}
