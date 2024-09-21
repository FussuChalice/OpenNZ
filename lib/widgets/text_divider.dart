import 'package:flutter/widgets.dart';
import 'package:opennz_ua/colors.dart';

class TextDivider extends StatelessWidget {
  const TextDivider({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Text(
        text,
        style: TextStyle(
          color: ApplicationColors.textDivider,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
