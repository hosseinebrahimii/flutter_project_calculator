import 'package:flutter/material.dart';
import 'package:flutter_project_calculator/colors.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

// ---------------------Project states:
String _displayText = '';
var _result = '';
late SharedPreferences _prefs;
bool _themeStateChanger = true;
CustomColors appTheme = CustomColors();
int _iterationOfUse = 0;
List<String> _displayTextMemory = [];
List<String> _resultMemory = [];
//----------------------

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    loadTheme();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            _themeButton(),
            Expanded(
              flex: 4,
              child: Container(
                color: appTheme.backgroundColor,
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
                child: calculatorScreenWidget(),
              ),
            ),
            Expanded(
              flex: 6,
              child: Container(
                color: appTheme.backgroundColor,
                child: caculatorButtonsWidget(),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }

// saving and loading theme with shared preferences package:
  Future<bool> getTheme() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs.getBool('theme') ?? true;
  }

  void loadTheme() async {
    _prefs = await SharedPreferences.getInstance();
    var theme = await getTheme();
    setState(
      () {
        appTheme = CustomColors.themeSelector(theme);
      },
    );
  }

  void saveTheme(bool theme) async {
    _prefs = await SharedPreferences.getInstance();
    _prefs.setBool('theme', theme);
  }
//----------------------------------------------------

  Widget _themeButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton(
            onPressed: () async {
              _themeStateChanger = !_themeStateChanger;

              setState(
                () {
                  saveTheme(_themeStateChanger);
                  loadTheme();
                },
              );
            },
            child: Icon(
              Icons.light_mode_outlined,
              size: 25,
              color: appTheme.numbersColor,
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
                  color: appTheme.screenNumbersColor,
                  fontSize: 26,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                _displayText,
                style: TextStyle(
                  color: appTheme.screenNumbersColor,
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
            _result,
            style: TextStyle(
              color: appTheme.resultColor,
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
                backgroundColor: appTheme.cleanButtonsColor,
                foregroundColor: appTheme.numbersColor,
                text: 'AC',
              ),
              _calculatorButton(
                backgroundColor: appTheme.cleanButtonsColor,
                foregroundColor: appTheme.numbersColor,
                text: 'CE',
                child: Icon(
                  Icons.backspace_outlined,
                  color: appTheme.numbersColor,
                  size: 30,
                ),
              ),
              _calculatorButton(
                backgroundColor: appTheme.operationButtonsColor,
                foregroundColor: appTheme.operationColor,
                text: ' % ',
                child: Image.asset(
                  'images/percent.png',
                  width: 17,
                  color: appTheme.operationColor,
                ),
              ),
              _calculatorButton(
                backgroundColor: appTheme.operationButtonsColor,
                foregroundColor: appTheme.operationColor,
                text: ' / ',
                child: Image.asset(
                  'images/divide.png',
                  width: 19,
                  color: appTheme.operationColor,
                ),
              ),
            ],
          ),
          //second row:
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _calculatorButton(
                backgroundColor: appTheme.backgroundColor,
                foregroundColor: appTheme.numbersColor,
                text: '7',
              ),
              _calculatorButton(
                backgroundColor: appTheme.backgroundColor,
                foregroundColor: appTheme.numbersColor,
                text: '8',
              ),
              _calculatorButton(
                backgroundColor: appTheme.backgroundColor,
                foregroundColor: appTheme.numbersColor,
                text: '9',
              ),
              _calculatorButton(
                backgroundColor: appTheme.operationButtonsColor,
                foregroundColor: appTheme.operationColor,
                text: ' * ',
                child: Image.asset(
                  'images/multiply.png',
                  width: 17,
                  color: appTheme.operationColor,
                ),
              ),
            ],
          ),
          //third row:
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _calculatorButton(
                backgroundColor: appTheme.backgroundColor,
                foregroundColor: appTheme.numbersColor,
                text: '4',
              ),
              _calculatorButton(
                backgroundColor: appTheme.backgroundColor,
                foregroundColor: appTheme.numbersColor,
                text: '5',
              ),
              _calculatorButton(
                backgroundColor: appTheme.backgroundColor,
                foregroundColor: appTheme.numbersColor,
                text: '6',
              ),
              _calculatorButton(
                backgroundColor: appTheme.operationButtonsColor,
                foregroundColor: appTheme.operationColor,
                text: ' + ',
                child: Icon(
                  Icons.add,
                  color: appTheme.operationColor,
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
                backgroundColor: appTheme.backgroundColor,
                foregroundColor: appTheme.numbersColor,
                text: '1',
              ),
              _calculatorButton(
                backgroundColor: appTheme.backgroundColor,
                foregroundColor: appTheme.numbersColor,
                text: '2',
              ),
              _calculatorButton(
                backgroundColor: appTheme.backgroundColor,
                foregroundColor: appTheme.numbersColor,
                text: '3',
              ),
              _calculatorButton(
                  backgroundColor: appTheme.operationButtonsColor,
                  foregroundColor: appTheme.operationColor,
                  text: ' - ',
                  child: Icon(
                    Icons.remove,
                    color: appTheme.operationColor,
                    size: 30,
                  )),
            ],
          ),
          //fifth row:
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _calculatorButton(
                backgroundColor: appTheme.backgroundColor,
                foregroundColor: appTheme.numbersColor,
                text: '000',
              ),
              _calculatorButton(
                backgroundColor: appTheme.backgroundColor,
                foregroundColor: appTheme.numbersColor,
                text: '0',
              ),
              _calculatorButton(
                backgroundColor: appTheme.backgroundColor,
                foregroundColor: appTheme.numbersColor,
                text: '.',
              ),
              _calculatorButton(
                backgroundColor: appTheme.operationButtonsColor,
                foregroundColor: appTheme.operationColor,
                text: '=',
                child: Image.asset(
                  'images/equal.png',
                  width: 19,
                  color: appTheme.operationColor,
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
        _displayText = '';
        _result = '';
      } else if (text == 'CE' && _displayText.isNotEmpty) {
        _displayText = _displayText.substring(0, _displayText.length - 1);
      } else if ((text == 'CE' && _displayText == '') || (text == '=' && _displayText == '')) {
        _displayText = '';
      } else if (text == '=' && _displayText.isNotEmpty) {
        //these codes were added from math_expressions library
        //and this is how it works to evaluate the equations.
        Parser p = Parser();
        Expression exp = p.parse(_displayText);
        ContextModel contextModel = ContextModel();
        double answer = exp.evaluate(EvaluationType.REAL, contextModel);
        _result = answer.toString();
        _iterationOfUse = _iterationOfUse + 1;
        _displayTextMemory.add(_displayText);
        _resultMemory.add(_result);
      } else {
        _displayText = _displayText + text;
      }
    } catch (error) {
      _result = 'Error! please try again';
    }
  }
//----------------------------------------------------
}
