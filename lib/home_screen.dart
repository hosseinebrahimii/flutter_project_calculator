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
bool theme = true;
int iterationOfUse = 0;
List<String> displayTextMemory = [];
List<String> resultMemory = [];
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
              _themeButton(),
              Expanded(
                flex: 4,
                child: Container(
                  color: CustomColors.backgroundColor,
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
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
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _themeButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton(
            onPressed: () {
              setState(
                () {
                  theme = !theme;
                  CustomColors.darkMode(theme);
                },
              );
            },
            child: Icon(
              Icons.light_mode_outlined,
              size: 25,
              color: CustomColors.numbersColor,
            ),
          ),
        ),
      ],
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
              fontSize: 36,
              fontWeight: FontWeight.bold,
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
      padding: const EdgeInsets.symmetric(horizontal: 20),
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
                child: Icon(
                  Icons.backspace_outlined,
                  color: CustomColors.numbersColor,
                  size: 30,
                ),
              ),
              _calculatorButton(
                backgroundColor: CustomColors.operationButtonsColor,
                foregroundColor: CustomColors.operationColor,
                text: ' % ',
                child: Image.asset(
                  'images/percent.png',
                  width: 17,
                  color: CustomColors.operationColor,
                ),
              ),
              _calculatorButton(
                backgroundColor: CustomColors.operationButtonsColor,
                foregroundColor: CustomColors.operationColor,
                text: ' / ',
                child: Image.asset(
                  'images/divide.png',
                  width: 19,
                  color: CustomColors.operationColor,
                ),
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
                text: ' * ',
                child: Image.asset(
                  'images/multiply.png',
                  width: 17,
                  color: CustomColors.operationColor,
                ),
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
                child: Icon(
                  Icons.add,
                  color: CustomColors.operationColor,
                  size: 30,
                ),
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
                  child: Icon(
                    Icons.remove,
                    color: CustomColors.operationColor,
                    size: 30,
                  )),
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
                child: Image.asset(
                  'images/equal.png',
                  width: 19,
                  color: CustomColors.operationColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _calculatorButton({
    required String text,
    Widget? child,
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
        minimumSize: const Size.fromRadius(40),
        backgroundColor: backgroundColor,
        shape: const CircleBorder(),
        foregroundColor: foregroundColor,
      ),
      child: (child != null)
          ? child
          : Text(
              text,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w400,
              ),
            ),
    );
  }

//----------------------------------------------------

//  Calculator Logic:
  void calculatorActions(String text) {
    try {
      if (text == 'AC') {
        displayText = '';
        result = '';
      } else if (text == 'CE' && displayText.isNotEmpty) {
        displayText = displayText.substring(0, displayText.length - 1);
      } else if ((text == 'CE' && displayText == '') || (text == '=' && displayText == '')) {
        displayText = '';
      } else if (text == '=' && displayText.isNotEmpty) {
        //these codes were added from math_expressions library
        //and this is how it works to evaluate the equations.
        Parser p = Parser();
        Expression exp = p.parse(displayText);
        ContextModel contextModel = ContextModel();
        double answer = exp.evaluate(EvaluationType.REAL, contextModel);
        result = answer.toString();
        iterationOfUse++;
        displayTextMemory.add(displayText);
        resultMemory.add(result);
      } else {
        displayText = displayText + text;
      }
    } catch (error) {
      result = 'Error! please try again';
    }
  }
//----------------------------------------------------
}
