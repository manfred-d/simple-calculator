import 'package:flutter/material.dart';
import 'package:calculator/components/buttons.dart';
import 'package:math_expressions/math_expressions.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var userInput = '';
  var answer = '';
  final List<String> buttons = [
    'Cl',
    '+/-',
    '%',
    'Del',
    '7',
    '8',
    '9',
    '/',
    '4',
    '5',
    '6',
    'x',
    '1',
    '2',
    '3',
    '-',
    '0',
    '.',
    '=',
    '+',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
      ),
      backgroundColor: Colors.white38,
      body: Column(
        children: [
          Expanded(
            child: Container(
              height: 100,
              padding: const EdgeInsets.all(2.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      userInput,
                      style: const TextStyle(fontSize: 22, color: Colors.white),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      answer,
                      style: const TextStyle(
                          fontSize: 40,
                          color: Colors.white60,
                          fontWeight: FontWeight.bold),
                    ),
                  ), //container
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.all(2.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                ),
                itemCount: buttons.length,
                itemBuilder: (BuildContext context, int index) {
                  // clear button
                  if (index == 0) {
                    return MyButton(
                        buttontapped: () {
                          setState(() {
                            userInput = '';
                            answer = '0';
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.blue[50],
                        textColor: Colors.black);
                  }
                  // +/- button
                  else if (index == 1) {
                    return MyButton(
                      color: Colors.blue[50],
                      textColor: Colors.black,
                      buttonText: buttons[index],
                      buttontapped: () {},
                    );
                  }
                  // % button
                  else if (index == 2) {
                    return MyButton(
                      color: Colors.blue[50],
                      textColor: Colors.black,
                      buttonText: buttons[index],
                      buttontapped: () {
                        setState(() {
                          userInput += buttons[index];
                        });
                      },
                    );
                  }
                  // Del button
                  else if (index == 3) {
                    return MyButton(
                      color: Colors.red,
                      textColor: Colors.white,
                      buttonText: buttons[index],
                      buttontapped: () {
                        setState(() {
                          if (userInput.isNotEmpty) {
                            userInput =
                                userInput.substring(0, userInput.length - 1);
                          }
                        });
                      },
                    );
                  }
                  // Equal Button
                  else if (index == 18) {
                    return MyButton(
                      color: Colors.orange[700],
                      textColor: Colors.white,
                      buttonText: buttons[index],
                      buttontapped: () {
                        equalPressed();
                      },
                    );
                  }
                  // the rest of buttons
                  else {
                    return MyButton(
                        color: isOperator(buttons[index])
                            ? Colors.blueAccent
                            : Colors.white,
                        textColor: isOperator(buttons[index])
                            ? Colors.white
                            : Colors.black,
                        buttonText: buttons[index],
                        buttontapped: () {
                          setState(() {
                            userInput += buttons[index];
                          });
                        });
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  bool isOperator(String x) {
    if (x == '/' || x == 'x' || x == '-' || x == '+') {
      return true;
    }
    return false;
  }

  // function to calcuate
  void equalPressed() {
    String finaluserinput = userInput;
    finaluserinput = userInput.replaceAll('x', '*');

    Parser p = Parser();
    Expression exp = p.parse(finaluserinput);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    answer = eval.toString();
  }
}
