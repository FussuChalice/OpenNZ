import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:opennz_ua/colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: ApplicationColors.backgroundGradient,
        ),
        child: Center(
          child: ClipSmoothRect(
            radius: SmoothBorderRadius(cornerRadius: 25, cornerSmoothing: 1),
            child: Image.asset(
              "assets/app_icon.png",
              width: 100,
              height: 100,
            ),
          ),
        ),
      ),
    );
  }
}
