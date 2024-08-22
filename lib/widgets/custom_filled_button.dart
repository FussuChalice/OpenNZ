import 'package:flutter/material.dart';
import 'package:opennz_ua/colors.dart';

class CustomFilledButton extends StatefulWidget {
  const CustomFilledButton({
    super.key,
    this.onPressed,
    this.width,
    this.height,
    required this.label,
  });

  final String label;
  final void Function()? onPressed;
  final double? width;
  final double? height;

  @override
  _CustomFilledButtonState createState() => _CustomFilledButtonState();
}

class _CustomFilledButtonState extends State<CustomFilledButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        setState(() {
          _isPressed = true;
        });
      },
      onTapUp: (details) {
        setState(() {
          _isPressed = false;
        });
      },
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        child: FilledButton(
          style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all<Color>(_isPressed
                  ? ApplicationColors.black.withOpacity(0.8)
                  : ApplicationColors.black)),
          onPressed: widget.onPressed,
          child: Text(
            widget.label,
            style: TextStyle(
              color: ApplicationColors.greyWhite,
            ),
          ),
        ),
      ),
    );
  }
}
