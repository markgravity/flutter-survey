import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:survey/gen/assets.gen.dart';

class NavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        PlatformButton(
          onPressed: () => Navigator.pop(context),
          child: SizedBox(height: 44, child: Assets.images.navBackButton.svg()),
        ),
      ],
    );
  }
}
