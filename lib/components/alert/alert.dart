import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/widgets.dart';
import 'package:survey/core/classes/localized_exception.dart';

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
  String message = "Unknown error";
  if (error is String) {
    message = error;
  }

  if (error is LocalizedException) {
    message = error.message;
  }

  return alert(
    context: context,
    title: "Error",
    message: message,
    okLabel: "OK",
  );
}
