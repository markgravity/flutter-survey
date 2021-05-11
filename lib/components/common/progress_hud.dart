import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:streams_provider/streams_provider.dart';
import 'package:survey/core/viper/module.dart';

class ProgressHUD extends StatelessWidget {
  final Widget child;
  final bool isShow;
  const ProgressHUD({
    Key? key,
    required this.child,
    this.isShow = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget? progressIndicator;

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        progressIndicator = PlatformCircularProgressIndicator();
        break;
      default:
        progressIndicator = Container(
          width: 100,
          height: 100,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          child: PlatformCircularProgressIndicator(
            cupertino: (_, __) => CupertinoProgressIndicatorData(radius: 20),
          ),
        );
    }

    return ModalProgressHUD(
      inAsyncCall: isShow,
      progressIndicator: progressIndicator,
      child: child,
    );
  }
}

mixin ProgressHUDViewMixin<D> on View<D> {
  final isProgressHUDShown = BehaviorSubject<bool>.seeded(false);
  void showProgressHUD() {
    isProgressHUDShown.add(true);
  }

  void dismissProgressHUD() {
    isProgressHUDShown.add(false);
  }
}
