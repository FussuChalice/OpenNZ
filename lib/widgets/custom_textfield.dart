import 'package:flutter/material.dart';
import 'package:opennz_ua/colors.dart';

class CustomTextfield extends StatelessWidget {
  const CustomTextfield(
      {super.key,
      this.labelText,
      this.suffixIcon,
      this.keyboardType,
      this.controller,
      required this.obscureText,
      required this.enableSuggestions,
      required this.autocorrect});

  final String? labelText;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final bool obscureText;
  final bool enableSuggestions;
  final bool autocorrect;

  @override
  Widget build(BuildContext context) {
    FocusNode customTextFieldFocusNode = FocusNode();

    return TextField(
      focusNode: customTextFieldFocusNode,
      keyboardType: keyboardType,
      obscureText: obscureText,
      autocorrect: autocorrect,
      enableSuggestions: enableSuggestions,
      controller: controller,
      cursorColor: ApplicationColors.black,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ApplicationColors.black),
        ),
        focusColor: ApplicationColors.black,
        labelText: labelText,
        labelStyle: TextStyle(
          color: customTextFieldFocusNode.hasFocus
              ? ApplicationColors.black
              : ApplicationColors.black,
        ),
        suffixIcon: suffixIcon,
      ),
    );
  }
}
