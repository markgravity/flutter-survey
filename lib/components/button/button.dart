import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class Button extends StatelessWidget {
  final String? title;
  final VoidCallback? onPressed;
  final bool isEnabled;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final Widget? child;

  const Button({
    Key? key,
    this.title,
    this.onPressed,
    this.isEnabled = true,
    this.width,
    this.height,
    this.borderRadius,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isEnabled ? Colors.white : Colors.grey,
        borderRadius: borderRadius ?? BorderRadius.circular(12.0),
      ),
      width: width,
      height: height,
      child: PlatformButton(
        onPressed: isEnabled ? onPressed : null,
        materialFlat: (_, __) => MaterialFlatButtonData(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (title != null)
              Text(
                title!,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            if (child != null) child!
          ],
        ),
      ),
    );
  }
}
