import 'package:flutter/material.dart';

enum ButtonType { outlined, text }

enum ButtomShape { rounded, sharp }

class CustomButton extends StatelessWidget {
  final Widget title;
  final Function() onTap;
  final ButtonType buttonType;
  final double? width;
  final EdgeInsets? padding;

  const CustomButton(
      {required this.title,
      required this.onTap,
      required this.buttonType,
      this.padding,
      this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      child: Padding(
        padding: padding ?? const EdgeInsets.all(8),
        child: OutlinedButton(
          onPressed: onTap,
          style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.all(16),
              side: const BorderSide(color: Color(0xff33bede)),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              backgroundColor: (buttonType == ButtonType.text)
                  ? const Color(0xff33bede)
                  : Colors.white),
          child: title,
        ),
      ),
    );
  }
}
