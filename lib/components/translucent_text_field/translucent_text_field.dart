import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class TranslucentTextField extends StatelessWidget {
  const TranslucentTextField({
    Key? key,
    this.placeholder,
    this.trailing,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.controller,
  }) : super(key: key);

  final String? placeholder;
  final Widget? trailing;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    final placeholderStyle = TextStyle(
      fontSize: 17.0,
      color: Colors.white.withAlpha(30),
    );

    return Container(
      padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(10),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Center(
        child: Row(
          children: [
            Expanded(
              child: PlatformTextField(
                controller: controller,
                style: const TextStyle(color: Colors.white),
                material: (_, __) => MaterialTextFieldData(
                  keyboardType: keyboardType,
                  decoration: InputDecoration(
                    hintText: placeholder,
                    hintStyle: placeholderStyle,
                    border: InputBorder.none,
                  ),
                  obscureText: obscureText,
                ),
                cupertino: (_, __) => CupertinoTextFieldData(
                    keyboardType: keyboardType,
                    placeholder: placeholder,
                    placeholderStyle: placeholderStyle,
                    decoration: const BoxDecoration(border: Border()),
                    obscureText: obscureText),
              ),
            ),
            if (trailing != null) trailing!
          ],
        ),
      ),
    );
  }
}
