import 'package:flutter/material.dart';
import 'package:opennz_ua/colors.dart';

class CustomTableCell extends StatelessWidget {
  const CustomTableCell(
      {super.key,
      required this.text,
      required this.title,
      this.textAlign,
      this.padding});

  final String text;
  final bool title;
  final TextAlign? textAlign;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: Padding(
        padding: padding ?? const EdgeInsets.all(5),
        child: Text(
          text,
          style: TextStyle(
            color: ApplicationColors.black,
            fontWeight: title ? FontWeight.bold : FontWeight.normal,
          ),
          textAlign: textAlign,
        ),
      ),
    );
  }
}
