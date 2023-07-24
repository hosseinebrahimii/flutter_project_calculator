import 'package:flutter/material.dart';
import 'package:flutter_project_calculator/colors.dart';
import 'package:math_expressions/math_expressions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

// ---------------------Project states:
String displayText = '';
var result = '';
//----------------------

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: CustomColors.backgroundGrey,
        body: _getBody(),
      ),
    );
  }

// Custom widgets and functions: ---------------------body:
  Widget _getBody() {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              color: CustomColors.backgroundGreyDark,
              child: calculatorScreenWidget(),
            ),
          ),
          Expanded(
            flex: 7,
            child: Container(
              color: CustomColors.backgroundGrey,
              child: numbersWidget(),
            ),
          ),
        ],
      ),
    );
  }
//----------------------------------------------------

// Custom widgets and functions: ---------------------Calculator Buttons:
  Widget numbersWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _numbers('ac', 'ce', '%', '/'),
        _numbers('7', '8', '9', '*'),
        _numbers('4', '5', '6', '-'),
        _numbers('1', '2', '3', '+'),
        _numbers('000', '0', '.', '='),
      ],
    );
  }

  Widget _numbers(String name1, String name2, String name3, String name4) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _number(name1),
        _number(name2),
        _number(name3),
        _number(name4),
      ],
    );
  }

  Widget _number(String text) {
    return TextButton(
      onPressed: () {
        setState(() {
          calculatorActions(text);
        });
      },
      style: TextButton.styleFrom(
        minimumSize: const Size.fromRadius(40),
        backgroundColor: backgroundColorChecker(text),
        shape: const CircleBorder(),
        foregroundColor: foregroundColorChecker(text),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }

  Color backgroundColorChecker(String name) {
    var operatorsList = ['ac', 'ce', '%', '/', '*', '-', '+', '='];
    for (var item in operatorsList) {
      if (item == name) return CustomColors.backgroundGreyDark;
    }
    return CustomColors.backgroundGrey;
  }

  Color foregroundColorChecker(String name) {
    var operatorsList = ['ac', 'ce', '%', '/', '*', '-', '+', '='];
    for (var item in operatorsList) {
      if (item == name) return CustomColors.textGreen;
    }
    return CustomColors.textGrey;
  }
//----------------------------------------------------

// Custom widgets and functions: ---------------------Calculator Screen:
  Widget calculatorScreenWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(
                '>',
                style: TextStyle(
                  color: CustomColors.textGreen,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                displayText,
                style: TextStyle(
                  color: CustomColors.textGreen,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            result,
            style: TextStyle(
              color: CustomColors.textGrey,
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
//----------------------------------------------------

  // Custom widgets and functions: ---------------------Calculator Logic:
  void calculatorActions(String text) {
    if (text == 'ac') {
      displayText = '';
      result = '';
    } else if (text == 'ce' && displayText.length > 1) {
      displayText = displayText.substring(0, displayText.length - 1);
    } else if (text == '=') {
      //these codes were added from math_expressions library
      //and this is how it works to evaluate the equations.
      Parser p = Parser();
      Expression exp = p.parse(displayText);
      ContextModel contextModel = ContextModel();
      double answer = exp.evaluate(EvaluationType.REAL, contextModel);
      result = answer.toString();
    } else {
      displayText = displayText + text;
    }
  }
//----------------------------------------------------
}
