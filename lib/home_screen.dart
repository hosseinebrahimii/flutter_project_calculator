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
        backgroundColor: CustomColors.backgroundColor,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 4,
                child: Container(
                  color: CustomColors.backgroundColor,
                  padding: const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 20),
                  child: calculatorScreenWidget(),
                ),
              ),
              Expanded(
                flex: 6,
                child: Container(
                  color: CustomColors.backgroundColor,
                  child: caculatorButtonsWidget(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

//  Calculator Screen:
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
                  color: CustomColors.screenNumbersColor,
                  fontSize: 26,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                displayText,
                style: TextStyle(
                  color: CustomColors.screenNumbersColor,
                  fontSize: 22,
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            result,
            style: TextStyle(
              color: CustomColors.resultColor,
              fontSize: 30,
            ),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
//----------------------------------------------------

//  Calculator Buttons:
  Widget caculatorButtonsWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          //first row:
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _calculatorButton(
                backgroundColor: CustomColors.cleanButtonsColor,
                foregroundColor: CustomColors.numbersColor,
                text: 'AC',
              ),
              _calculatorButton(
                backgroundColor: CustomColors.cleanButtonsColor,
                foregroundColor: CustomColors.numbersColor,
                text: 'CE',
                icon: Icons.backspace_outlined,
              ),
              _calculatorButton(
                backgroundColor: CustomColors.operationButtonsColor,
                foregroundColor: CustomColors.operationColor,
                text: ' % ',
              ),
              _calculatorButton(
                backgroundColor: CustomColors.operationButtonsColor,
                foregroundColor: CustomColors.operationColor,
                text: ' ÷ ',
              ),
            ],
          ),
          //second row:
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _calculatorButton(
                backgroundColor: CustomColors.backgroundColor,
                foregroundColor: CustomColors.numbersColor,
                text: '7',
              ),
              _calculatorButton(
                backgroundColor: CustomColors.backgroundColor,
                foregroundColor: CustomColors.numbersColor,
                text: '8',
              ),
              _calculatorButton(
                backgroundColor: CustomColors.backgroundColor,
                foregroundColor: CustomColors.numbersColor,
                text: '9',
              ),
              _calculatorButton(
                backgroundColor: CustomColors.operationButtonsColor,
                foregroundColor: CustomColors.operationColor,
                text: ' X ',
              ),
            ],
          ),
          //third row:
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _calculatorButton(
                backgroundColor: CustomColors.backgroundColor,
                foregroundColor: CustomColors.numbersColor,
                text: '4',
              ),
              _calculatorButton(
                backgroundColor: CustomColors.backgroundColor,
                foregroundColor: CustomColors.numbersColor,
                text: '5',
              ),
              _calculatorButton(
                backgroundColor: CustomColors.backgroundColor,
                foregroundColor: CustomColors.numbersColor,
                text: '6',
              ),
              _calculatorButton(
                backgroundColor: CustomColors.operationButtonsColor,
                foregroundColor: CustomColors.operationColor,
                text: ' + ',
                icon: Icons.add,
              ),
            ],
          ),
          //forth row:
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _calculatorButton(
                backgroundColor: CustomColors.backgroundColor,
                foregroundColor: CustomColors.numbersColor,
                text: '1',
              ),
              _calculatorButton(
                backgroundColor: CustomColors.backgroundColor,
                foregroundColor: CustomColors.numbersColor,
                text: '2',
              ),
              _calculatorButton(
                backgroundColor: CustomColors.backgroundColor,
                foregroundColor: CustomColors.numbersColor,
                text: '3',
              ),
              _calculatorButton(
                backgroundColor: CustomColors.operationButtonsColor,
                foregroundColor: CustomColors.operationColor,
                text: ' - ',
                icon: Icons.remove,
              ),
            ],
          ),
          //fifth row:
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _calculatorButton(
                backgroundColor: CustomColors.backgroundColor,
                foregroundColor: CustomColors.numbersColor,
                text: '000',
              ),
              _calculatorButton(
                backgroundColor: CustomColors.backgroundColor,
                foregroundColor: CustomColors.numbersColor,
                text: '0',
              ),
              _calculatorButton(
                backgroundColor: CustomColors.backgroundColor,
                foregroundColor: CustomColors.numbersColor,
                text: '.',
              ),
              _calculatorButton(
                backgroundColor: CustomColors.operationButtonsColor,
                foregroundColor: CustomColors.operationColor,
                text: '=',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _calculatorButton({
    required String text,
    IconData? icon,
    required Color backgroundColor,
    required Color foregroundColor,
  }) {
    return TextButton(
      onPressed: () {
        setState(() {
          calculatorActions(text);
        });
      },
      style: TextButton.styleFrom(
        minimumSize: const Size.fromRadius(36),
        backgroundColor: backgroundColor,
        shape: const CircleBorder(),
        foregroundColor: foregroundColor,
      ),
      child: (icon != null)
          ? Icon(
              icon,
              color: foregroundColor,
              size: 30,
            )
          : Text(
              text,
              style: const TextStyle(fontSize: 26),
            ),
    );
  }

//----------------------------------------------------

//  Calculator Logic:
  void calculatorActions(String text) {
    if (text == 'AC') {
      displayText = '';
      result = '';
    } else if (text == 'CE' && displayText.isNotEmpty) {
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
