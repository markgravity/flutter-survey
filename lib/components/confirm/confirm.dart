import 'package:flutter/widgets.dart';
import 'package:streams_provider/streams_provider.dart';
import 'package:survey/core/viper/module.dart';
import 'package:adaptive_dialog/adaptive_dialog.dart';
export 'package:adaptive_dialog/adaptive_dialog.dart';

Future<OkCancelResult> confirm({
  required BuildContext context,
  String? title,
  String? message,
  String? okLabel,
  String? cancelLabel,
}) {
  return showOkCancelAlertDialog(
    context: context,
    title: title,
    message: message,
    okLabel: okLabel,
    cancelLabel: cancelLabel,
  );
}

abstract class ConfirmViewMixinDelegate {
  BehaviorSubject<OkCancelResult> get confirmDialogDidClose;
}

mixin ConfirmViewMixin<D extends ConfirmViewMixinDelegate> on View<D> {
  void confirm({
    String? title,
    String? message,
    String? okLabel,
    String? cancelLabel,
  }) {
    showOkCancelAlertDialog(
      context: context,
      title: title,
      message: message,
      okLabel: okLabel,
      cancelLabel: cancelLabel,
    ).then((value) => delegate?.confirmDialogDidClose.add(value));
  }
}
