import 'package:flutter/material.dart';

class CustomColors extends ChangeNotifier {
  static bool darkmode = false;
  static Color backgroundColor = darkmode ? const Color.fromARGB(255, 38, 38, 38) : const Color(0xffF5F5F5);
  static Color screenNumbersColor = const Color(0xff757575);
  static Color resultColor = darkmode ? const Color(0xffF5F5F5) : const Color.fromARGB(255, 38, 38, 38);
  static Color cleanButtonsColor = darkmode ? const Color(0xff616161) : const Color(0xffF5F5F5);
  static Color operationColor = const Color(0xff616161);
  static Color operationButtonsColor = const Color(0xffF5F5F5);
  static Color numbersColor = darkmode ? const Color(0xffBDBDBD) : const Color(0xff757575);
}
