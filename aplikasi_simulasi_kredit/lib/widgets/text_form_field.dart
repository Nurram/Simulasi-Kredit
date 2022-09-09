import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  final FocusNode focusNode;
  final TextEditingController textEditingController;
  final Function validator;
  final TextInputType? textInputType;
  final String? labelText;
  final String? hintText;
  final bool? obscureText;
  final String? prefix;
  final bool? readOnly;
  final int? maxLines;

  const MyTextFormField(
      {Key? key,
      required this.focusNode,
      required this.textEditingController,
      required this.validator,
      this.textInputType,
      this.labelText,
      this.hintText,
      this.obscureText,
      this.prefix,
      this.readOnly,
      this.maxLines})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      controller: textEditingController,
      keyboardType: textInputType ?? TextInputType.visiblePassword,
      obscureText: obscureText ?? false,
      readOnly: readOnly ?? false,
      // ignore: prefer_if_null_operators
      maxLines: maxLines == null ? null : maxLines,
      decoration: InputDecoration(
        hintText: hintText,
        prefix: Text(prefix ?? ''),
        labelText: labelText,
        labelStyle: TextStyle(
            color: focusNode.hasFocus
                ? Theme.of(context).primaryColor
                : Colors.grey),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: Colors.grey[400]!,
            width: 2.0,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: Theme.of(context).errorColor,
            width: 2.0,
          ),
        ),
      ),
      validator: (value) => validator(value),
    );
  }
}
