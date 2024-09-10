import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:opennz_ua/colors.dart';
import 'dart:io' show Platform;

class CustomAppBar extends StatelessWidget {
  const CustomAppBar(
      {super.key,
      required this.title,
      this.onCodeBtnPress,
      this.onSettingsBtnPress,
      this.additionalButton});

  final String title;
  final void Function()? onCodeBtnPress;
  final void Function()? onSettingsBtnPress;
  final Widget? additionalButton;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: Platform.isIOS ? 132 : 110,
      color: ApplicationColors.greyWhite,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 35,
          right: 35,
        ),
        child: Column(
          children: [
            SizedBox(
              height: Platform.isIOS ? 75 : 45,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 24,
                    color: ApplicationColors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  children: [
                    additionalButton ?? const Gap(0),
                    IconButton(
                      onPressed: onCodeBtnPress,
                      icon: const Icon(Icons.data_object),
                      color: ApplicationColors.black,
                    ),
                    IconButton(
                      onPressed: onSettingsBtnPress,
                      icon: const Icon(Icons.settings_outlined),
                      color: ApplicationColors.black,
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
