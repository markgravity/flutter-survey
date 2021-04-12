import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:survey/gen/assets.gen.dart';
import 'package:survey/screens/screen.dart';

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 800),
    vsync: this,
  );

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeIn,
  );

  @override
  void initState() {
    super.initState();
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
        body: Stack(
      fit: StackFit.expand,
      children: [
        Container(
          color: Colors.black,
        ),
        Assets.images.mainBackgroundDimmed.image(fit: BoxFit.fill),
        Center(
          child: FadeTransition(
            opacity: _animation,
            child: Assets.images.logoWhite.svg(),
          ),
        )
      ],
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
