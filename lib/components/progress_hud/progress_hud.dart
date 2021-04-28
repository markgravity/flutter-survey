import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class ProgressHUD extends StatelessWidget {
  final Widget child;
  final bool isShow;
  const ProgressHUD({
    required this.child,
    this.isShow = false,
  });

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isShow,
      progressIndicator: Container(
        width: 100,
        height: 100,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(12))),
        child: PlatformCircularProgressIndicator(
          cupertino: (_, __) => CupertinoProgressIndicatorData(radius: 20),
        ),
      ),
      child: child,
    );
  }
}
