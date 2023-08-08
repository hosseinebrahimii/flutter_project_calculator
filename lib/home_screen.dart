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
late SharedPreferences _prefs;
bool _themeStateChanger = true;
CustomColors _appTheme = CustomColors();
bool _tab1Situation = true;
bool _tab2Situation = false;
String _displayText = '';
var _result = '';
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
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: _appTheme.backgroundColor,
          appBar: _getAppBar(),
          body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _getCalculatorTabView(),
              _getHistoryTabView(),
            ],
          ),
        ),
      ),
    );
  }

//  TabBar and its TabViews:
  PreferredSizeWidget _getAppBar() {
    return PreferredSize(
      preferredSize: const Size(double.infinity, 200),
      child: TabBar(
        indicatorColor: Colors.transparent,
        splashBorderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
        splashFactory: NoSplash.splashFactory,
        onTap: (int tabNumber) {
          if (tabNumber == 0) {
            setState(() {
              _tab1Situation = true;
              _tab2Situation = false;
            });
          } else {
            setState(() {
              _tab1Situation = false;
              _tab2Situation = true;
            });
          }
        },
        tabs: [
          Tab(
            child: Container(
              height: 40,
              width: 150,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: (_tab1Situation) ? _appTheme.activeTabButtonColor : _appTheme.inactiveTabButtonColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Calculator',
                style: TextStyle(
                  color: (_tab1Situation) ? _appTheme.activeTabColor : _appTheme.inactiveTabColor,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          Tab(
            child: Container(
              height: 40,
              width: 150,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: (_tab2Situation) ? _appTheme.activeTabButtonColor : _appTheme.inactiveTabButtonColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'History',
                style: TextStyle(
                  color: (_tab2Situation) ? _appTheme.activeTabColor : _appTheme.inactiveTabColor,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getCalculatorTabView() {
    return Column(
      children: [
        _themeButton(),
        Expanded(
          flex: 4,
          child: Container(
            color: _appTheme.backgroundColor,
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
            child: calculatorScreenWidget(),
          ),
        ),
        Expanded(
          flex: 6,
          child: Container(
            color: _appTheme.backgroundColor,
            child: caculatorButtonsWidget(),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }

  Widget _getHistoryTabView() {
    return Container(
      color: Colors.red,
    );
  }
//----------------------------------------------------

//  saving and loading theme with shared preferences package:
  Future<bool> getTheme() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs.getBool('theme') ?? true;
  }

  void loadTheme() async {
    _prefs = await SharedPreferences.getInstance();
    var theme = await getTheme();
    setState(
      () {
        _appTheme = CustomColors.themeSelector(theme);
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
              color: _appTheme.numbersColor,
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
                  color: _appTheme.screenNumbersColor,
                  fontSize: 26,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                _displayText,
                style: TextStyle(
                  color: _appTheme.screenNumbersColor,
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
              color: _appTheme.resultColor,
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
                backgroundColor: _appTheme.cleanButtonsColor,
                foregroundColor: _appTheme.numbersColor,
                text: 'AC',
              ),
              _calculatorButton(
                backgroundColor: _appTheme.cleanButtonsColor,
                foregroundColor: _appTheme.numbersColor,
                text: 'CE',
                child: Icon(
                  Icons.backspace_outlined,
                  color: _appTheme.numbersColor,
                  size: 30,
                ),
              ),
              _calculatorButton(
                backgroundColor: _appTheme.operationButtonsColor,
                foregroundColor: _appTheme.operationColor,
                text: ' % ',
                child: Image.asset(
                  'images/percent.png',
                  width: 17,
                  color: _appTheme.operationColor,
                ),
              ),
              _calculatorButton(
                backgroundColor: _appTheme.operationButtonsColor,
                foregroundColor: _appTheme.operationColor,
                text: ' / ',
                child: Image.asset(
                  'images/divide.png',
                  width: 19,
                  color: _appTheme.operationColor,
                ),
              ),
            ],
          ),
          //second row:
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _calculatorButton(
                backgroundColor: _appTheme.backgroundColor,
                foregroundColor: _appTheme.numbersColor,
                text: '7',
              ),
              _calculatorButton(
                backgroundColor: _appTheme.backgroundColor,
                foregroundColor: _appTheme.numbersColor,
                text: '8',
              ),
              _calculatorButton(
                backgroundColor: _appTheme.backgroundColor,
                foregroundColor: _appTheme.numbersColor,
                text: '9',
              ),
              _calculatorButton(
                backgroundColor: _appTheme.operationButtonsColor,
                foregroundColor: _appTheme.operationColor,
                text: ' * ',
                child: Image.asset(
                  'images/multiply.png',
                  width: 17,
                  color: _appTheme.operationColor,
                ),
              ),
            ],
          ),
          //third row:
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _calculatorButton(
                backgroundColor: _appTheme.backgroundColor,
                foregroundColor: _appTheme.numbersColor,
                text: '4',
              ),
              _calculatorButton(
                backgroundColor: _appTheme.backgroundColor,
                foregroundColor: _appTheme.numbersColor,
                text: '5',
              ),
              _calculatorButton(
                backgroundColor: _appTheme.backgroundColor,
                foregroundColor: _appTheme.numbersColor,
                text: '6',
              ),
              _calculatorButton(
                backgroundColor: _appTheme.operationButtonsColor,
                foregroundColor: _appTheme.operationColor,
                text: ' + ',
                child: Icon(
                  Icons.add,
                  color: _appTheme.operationColor,
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
                backgroundColor: _appTheme.backgroundColor,
                foregroundColor: _appTheme.numbersColor,
                text: '1',
              ),
              _calculatorButton(
                backgroundColor: _appTheme.backgroundColor,
                foregroundColor: _appTheme.numbersColor,
                text: '2',
              ),
              _calculatorButton(
                backgroundColor: _appTheme.backgroundColor,
                foregroundColor: _appTheme.numbersColor,
                text: '3',
              ),
              _calculatorButton(
                  backgroundColor: _appTheme.operationButtonsColor,
                  foregroundColor: _appTheme.operationColor,
                  text: ' - ',
                  child: Icon(
                    Icons.remove,
                    color: _appTheme.operationColor,
                    size: 30,
                  )),
            ],
          ),
          //fifth row:
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _calculatorButton(
                backgroundColor: _appTheme.backgroundColor,
                foregroundColor: _appTheme.numbersColor,
                text: '000',
              ),
              _calculatorButton(
                backgroundColor: _appTheme.backgroundColor,
                foregroundColor: _appTheme.numbersColor,
                text: '0',
              ),
              _calculatorButton(
                backgroundColor: _appTheme.backgroundColor,
                foregroundColor: _appTheme.numbersColor,
                text: '.',
              ),
              _calculatorButton(
                backgroundColor: _appTheme.operationButtonsColor,
                foregroundColor: _appTheme.operationColor,
                text: '=',
                child: Image.asset(
                  'images/equal.png',
                  width: 19,
                  color: _appTheme.operationColor,
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
        if (text == '=' && !_result.contains('Error')) {
          _displayText = _result;
        }
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
      }
      //
      else if (text == 'CE' && _displayText.isNotEmpty) {
        _displayText = _displayText.substring(0, _displayText.length - 1);
      }
      //
      else if ((text == 'CE' && _displayText == '') || (text == '=' && _displayText == '')) {
        _displayText = '';
      }
      //
      else if (text == '=' && _displayText.isNotEmpty) {
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
      }
      //
      else {
        _displayText = _displayText + text;
      }
    } catch (error) {
      _result = 'Error! try again';
    }
  }
//----------------------------------------------------
}
