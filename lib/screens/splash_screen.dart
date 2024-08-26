import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.03, -1.00),
            end: Alignment(-0.03, 1),
            colors: [Color(0xFFAABBC3), Color(0xFFDD8D9E), Color(0xFFA28CBA)],
          ),
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
