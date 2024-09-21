import 'package:flutter/material.dart';

class ApplicationColors {
  ApplicationColors._();

  static Color greyWhite = const Color(0xFFF9F9F9);
  static Color black = Colors.black;
  static Color versionGrey = const Color(0xFF5B5B5B);
  static Color bottomNavigationBarSelectedItem = const Color(0xFF8ADEEA);
  static Color lightGrey = const Color(0x4C3C3C43);
  static Color darkGrey = const Color(0x993C3C43);

  static Color purpleTable = const Color(0xFFA28CBA);
  static Color missedLessonsTable = const Color.fromARGB(255, 235, 96, 96);
  static Color subjectMarksTable = const Color(0xFFB5F2C2);

  static Color textDivider = const Color(0xFF192fbf);

  static LinearGradient backgroundGradient = const LinearGradient(
    begin: Alignment(0.03, -1.00),
    end: Alignment(-0.03, 1),
    colors: [Color(0xFFAABBC3), Color(0xFFDD8D9E), Color(0xFFA28CBA)],
  );

  static Color markBad = const Color(0xFF690505);
  static Color markNotBad = const Color(0xFF695905);
  static Color markGood = const Color(0xFF05691B);

  static Color logOutButtonRed = const Color.fromARGB(255, 205, 44, 44);
}
