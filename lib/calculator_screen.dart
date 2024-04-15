import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String result = '0';
  String calculation = '';

  void handleButtonPress(String buttonText) {
    setState(() {
      switch (buttonText) {
        case 'C':
          result = '0';
          calculation = '';
          break;
        case '+/-':
          result = (double.parse(result) * -1).toString();
          break;
        case '=':
          try {
            result = evaluateExpression(calculation);
            calculation = '';
          } catch (e) {
            result = 'Error';
          }
          break;
        default:
          if (result == '0' || result == 'Error') {
            result = buttonText;
          } else {
            result += buttonText;
          }
          calculation += buttonText;
      }
    });
  }

  String evaluateExpression(String expression) {
    try {
      final operands = expression.split(RegExp(r'[\+\-\*\/]'));
      final operator = expression
          .replaceAll(operands[0], '')
          .replaceAll(operands[1], '')
          .trim();
      final num1 = double.parse(operands[0]);
      final num2 = double.parse(operands[1]);

      switch (operator) {
        case '+':
          return (num1 + num2).toString();
        case '-':
          return (num1 - num2).toString();
        case '*':
          return (num1 * num2).toString();
        case '/':
          if (num2 == 0) {
            throw FormatException('Division by zero');
          }
          return (num1 / num2).toString();
        default:
          throw FormatException('Invalid operator');
      }
    } catch (e) {
      throw FormatException('Invalid expression');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(height: 70),
            Text(
              result,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BuildCalcButton('C', handleButtonPress),
                BuildCalcButton('%', handleButtonPress),
                BuildCalcButton('+/-', handleButtonPress),
                BuildCalcButton('/', handleButtonPress),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BuildCalcButton('7', handleButtonPress),
                BuildCalcButton('8', handleButtonPress),
                BuildCalcButton('9', handleButtonPress),
                BuildCalcButton('*', handleButtonPress),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BuildCalcButton('4', handleButtonPress),
                BuildCalcButton('5', handleButtonPress),
                BuildCalcButton('6', handleButtonPress),
                BuildCalcButton('-', handleButtonPress),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BuildCalcButton('1', handleButtonPress),
                BuildCalcButton('2', handleButtonPress),
                BuildCalcButton('3', handleButtonPress),
                BuildCalcButton('+', handleButtonPress),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BuildCalcButton('0', handleButtonPress),
                BuildCalcButton('00', handleButtonPress),
                BuildCalcButton('.', handleButtonPress),
                BuildCalcButton('=', handleButtonPress),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget BuildCalcButton(String buttonText, Function handleButtonPress) {
  return Expanded(
    child: ElevatedButton(
      onPressed: () => handleButtonPress(buttonText),
      child: Text(
        buttonText,
        style: const TextStyle(fontSize: 30),
      ),
    ),
  );
}
