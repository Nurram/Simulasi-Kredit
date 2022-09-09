import 'package:flutter/material.dart';

class MyElevatedButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final EdgeInsets? padding;
  final double? borderRadius;

  const MyElevatedButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      this.padding,
      this.borderRadius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => onPressed(),
        child: Text(text),
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsets>(
              padding ?? const EdgeInsets.all(8)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 8),
            ),
          ),
        ),
      ),
    );
  }
}
