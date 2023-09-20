import 'dart:async';
import 'dart:math';

import 'package:ahadu/Models/algo.dart';
import 'package:flutter/material.dart';

class GameView extends StatefulWidget {
  const GameView({Key? key}) : super(key: key);

  @override
  _GameViewState createState() => _GameViewState();
}

class _GameViewState extends State<GameView> with MaterialStateMixin {
  double loadingWidth = 720;
  static int time = 4,
      score = 0,
      maxTime = 4,
      num1 = 1,
      num2 = 2,
      indexSolution = 2;
  bool gameOver = false, filling = false, countDown = true;
  Random random = new Random();
  List<int> numbers = [1, 2, 3];
  String question =
      "${convertToGeez(num1.toString())} + ${convertToGeez(num2.toString())} = ?";

  void resetLoading() async {
    setState(() {
      filling = true;
      loadingWidth = (MediaQuery.of(context).size.width * 0.8);
    });

    await Future.delayed(Duration(milliseconds: 500));
    setState(() {
      filling = false;
      countDown = true;
      time = 4;
      gameOver = false;
    });
  }

  Stream<int> gameloop() async* {
    while (true) {
      if (!gameOver) {
        setState(() {
          if (countDown) {
            loadingWidth = 0;
            countDown = false;
          }
          time -= 1;

          if (time == 0) {
            gameOver = true;
          }
        });
        await Future.delayed(const Duration(seconds: 1));

        yield time;
      } else {
        await Future.delayed(const Duration(seconds: 1));

        yield time;
      }
    }
  }

  int searchSolution(int n) {
    for (int i = 0; i < 3; i++) {
      if (numbers[i] == n) {
        return i;
      }
    }
    return -1;
  }

  void userInput(int index) {
    if (index == indexSolution && !gameOver) {
      resetLoading();
      generateGame();
      setState(() {
        score += 1;
      });
    } else {
      setState(() {
        gameOver = true;
      });
    }
  }

  void generateGame() {
    numbers.shuffle();
    num1 = random.nextInt(3) + 1;
    num2 = random.nextInt(3) + 1;
    numbers.shuffle();
    int temp = 0;

    setState(() {
      if (num1 + num2 > 3) {
        int n = random.nextInt(100);
        if (n <= 33 && num1 != num2) {
          if (num1 < num2) {
            temp = num2;
            num2 = num1;
            num1 = temp;
          }
          indexSolution = searchSolution(num1 - num2);
          question =
              "${convertToGeez(num1.toString())} - ${convertToGeez(num2.toString())} = ?";
        } else if (n < 100) {
          indexSolution = searchSolution(num1);
          int odd = random.nextInt(3);
          if (odd <= 1) {
            question =
                "${convertToGeez(num1.toString())} + ${convertToGeez(num2.toString())} - ${convertToGeez(num2.toString())} = ?";
          }
          if (odd == 2) {
            question =
                "${convertToGeez(num2.toString())} - ${convertToGeez(num2.toString())} + ${convertToGeez(num1.toString())} = ?";
          }
        }
      } else {
        indexSolution = searchSolution(num1 + num2);
        question =
            "${convertToGeez(num1.toString())} + ${convertToGeez(num2.toString())} = ?";
      }
    });
    print('$numbers $question \n $indexSolution');
  }

  Widget gameOverView() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.black45,
      child: Center(
        child: Container(
            width: MediaQuery.of(context).size.width / 1.2,
            height: MediaQuery.of(context).size.height / 1.6,
            child: Material(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // ignore: sized_box_for_whitespace
                  Container(
                    width: 200,
                    height: 60,
                    // ignore: prefer_const_constructors
                    child: Center(
                        child: const Text(
                      "Game Over!",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    )),
                  ),
                  // ignore: sized_box_for_whitespace
                  Container(
                    width: 200,
                    height: 100,
                    child: Center(
                        child: Text(
                      "Score: $score",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    )),
                  ),
                  Container(
                    width: 220,
                    height: 65,
                    child: Material(
                      color: Colors.greenAccent,
                      child: InkWell(
                          onTap: () {
                            setState(() {
                              score = 0;
                              gameOver = false;
                              resetLoading();
                              generateGame();
                            });
                          },
                          child: Center(
                              child: Icon(
                            Icons.replay,
                            color: Color(0xfffefefe),
                            size: 50,
                          ))),
                    ),
                  ),
                  Container(
                    width: 220,
                    height: 65,
                    child: Material(
                      color: Colors.red,
                      child: InkWell(
                          onTap: () {},
                          child: Center(
                              child: Icon(
                            Icons.exit_to_app,
                            color: Color(0xfffefefe),
                            size: 50,
                          ))),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    gameloop().listen((event) {});
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff39B4BF),
        body: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 100,
                child: Material(
                  elevation: 4,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(90),
                      bottomRight: Radius.circular(90)),
                  child: Center(
                    child: Text(
                      "Score $score ",
                      overflow: TextOverflow.visible,
                      style: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
            Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                      width: 250,
                      height: 200,
                      child: Material(
                        color: Colors.transparent,
                        child: Center(
                            child: Text(
                          question,
                          style: const TextStyle(
                              fontSize: 45,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        )),
                      ),
                    ),
                  ),
                  Center(
                    child: Column(
                      children: [
                        Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Material(
                            elevation: 4,
                            color: Colors.amberAccent,
                            child: Stack(
                              children: [
                                AnimatedContainer(
                                  height: 50,
                                  width: loadingWidth,
                                  color: Colors.red,
                                  duration: Duration(
                                      milliseconds: filling ? 10 : 3300),
                                ),
                                Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                      userInput(0);
                                    },
                                    child: Center(
                                      child: Text(
                                        convertToGeez(numbers[0].toString()),
                                        style: const TextStyle(
                                            fontSize: 35,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Material(
                            elevation: 4,
                            color: Colors.amberAccent,
                            child: Stack(
                              children: [
                                AnimatedContainer(
                                  height: 50,
                                  width: loadingWidth,
                                  color: Colors.red,
                                  duration: Duration(
                                      milliseconds: filling ? 10 : 3500),
                                ),
                                Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                      userInput(1);
                                    },
                                    child: Center(
                                      child: Text(
                                        convertToGeez(numbers[1].toString()),
                                        style: const TextStyle(
                                            fontSize: 35,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Material(
                            elevation: 4,
                            color: Colors.amberAccent,
                            child: Stack(
                              children: [
                                AnimatedContainer(
                                  height: 50,
                                  width: loadingWidth,
                                  color: Colors.red,
                                  duration: Duration(
                                      milliseconds: filling ? 10 : 3500),
                                ),
                                Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                      userInput(2);
                                    },
                                    child: Center(
                                      child: Text(
                                        convertToGeez(numbers[2].toString()),
                                        style: const TextStyle(
                                            fontSize: 35,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ]),
            gameOver ? gameOverView() : Container()
          ],
        ),
      ),
    );
  }
}
