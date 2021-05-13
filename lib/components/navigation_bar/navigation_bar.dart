import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:survey/gen/assets.gen.dart';

class NavigationBar extends StatelessWidget {
  const NavigationBar({
    Key? key,
    this.isBackButtonHidden = false,
    this.leftChildren = const [],
  }) : super(key: key);

  final bool isBackButtonHidden;
  final List<Widget> leftChildren;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (!isBackButtonHidden)
          PlatformButton(
            onPressed: () => Navigator.pop(context),
            child:
                SizedBox(height: 44, child: Assets.images.navBackButton.svg()),
          )
        else
          const SizedBox.shrink(),
        Row(
          children: leftChildren,
        )
      ],
    );
  }
}
