import 'package:flutter/material.dart';

class CustomColors {
  static Color backgroundColor = const Color.fromARGB(255, 38, 38, 38);
  static Color screenNumbersColor = const Color(0xff757575);
  static Color resultColor = const Color(0xffF5F5F5);
  static Color cleanButtonsColor = const Color(0xff616161);
  static Color operationColor = const Color(0xff616161);
  static Color operationButtonsColor = const Color(0xffF5F5F5);
  static Color numbersColor = const Color(0xffE0E0E0);

  static void darkMode(bool mode) {
    if (mode) {
      backgroundColor = const Color.fromARGB(255, 38, 38, 38);
      screenNumbersColor = const Color(0xff757575);
      resultColor = const Color(0xffF5F5F5);
      cleanButtonsColor = const Color(0xff616161);
      operationColor = const Color(0xff616161);
      operationButtonsColor = const Color(0xffF5F5F5);
      numbersColor = const Color(0xffE0E0E0);
    } else {
      backgroundColor = const Color(0xffF5F5F5);
      screenNumbersColor = const Color(0xff757575);
      resultColor = const Color.fromARGB(255, 38, 38, 38);
      cleanButtonsColor = const Color(0xffF5F5F5);
      operationColor = const Color(0xff616161);
      operationButtonsColor = const Color(0xffF5F5F5);
      numbersColor = const Color(0xff757575);
    }
  }
}
