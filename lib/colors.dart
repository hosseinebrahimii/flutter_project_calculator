import 'package:flutter/material.dart';

class CustomColors {
  Color backgroundColor;
  Color screenNumbersColor;
  Color resultColor;
  Color cleanButtonsColor;
  Color operationColor;
  Color operationButtonsColor;
  Color numbersColor;
  Color activeTabColor;
  Color activeTabButtonColor;
  Color inactiveTabColor;
  Color inactiveTabButtonColor;

  CustomColors({
    this.backgroundColor = const Color.fromARGB(255, 38, 38, 38),
    this.screenNumbersColor = const Color(0xff757575),
    this.resultColor = const Color(0xffF5F5F5),
    this.cleanButtonsColor = const Color(0xff616161),
    this.operationColor = const Color(0xff616161),
    this.operationButtonsColor = const Color(0xffF5F5F5),
    this.numbersColor = const Color(0xffE0E0E0),
    this.activeTabColor = const Color(0xff616161),
    this.activeTabButtonColor = const Color(0xffF5F5F5),
    this.inactiveTabColor = const Color(0xff616161),
    this.inactiveTabButtonColor = const Color.fromARGB(255, 38, 38, 38),
  });

  factory CustomColors.themeSelector(bool theme) {
    return theme
        ? CustomColors()
        : CustomColors(
            backgroundColor: const Color(0xffF5F5F5),
            screenNumbersColor: const Color(0xff757575),
            resultColor: const Color.fromARGB(255, 38, 38, 38),
            cleanButtonsColor: const Color(0xffF5F5F5),
            operationColor: const Color(0xff616161),
            operationButtonsColor: const Color(0xffF5F5F5),
            numbersColor: const Color(0xff757575),
            activeTabColor: const Color(0xffF5F5F5),
            activeTabButtonColor: const Color(0xff616161),
            inactiveTabColor: const Color(0xff616161),
            inactiveTabButtonColor: const Color(0xffF5F5F5),
          );
  }
}
