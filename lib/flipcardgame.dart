import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'data.dart';
import 'dart:async';

class FlipCardGame extends StatefulWidget {
  final Level level;
  FlipCardGame(this.level);
  @override
  _FlipCardGameState createState() => _FlipCardGameState(level);
}

class _FlipCardGameState extends State<FlipCardGame> {
  _FlipCardGameState(
      {required this.level,
      required this.timer,
      required this.cardFlips,
      required this.isFinished,
      required this.left,
      required this.data,
      required this.cardStateKeys});

  int previousIndex = -1;
  bool flip = false;
  bool start = false;

  bool wait = false;
  Level level;
  Timer timer;
  int time = 5;
  int left;
  bool isFinished;
  List<String> data;

  List<bool> cardFlips;
  List<GlobalKey<FlipCardState>> cardStateKeys;

  Widget getItem(int index) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[100],
          boxShadow: [
            BoxShadow(
              color: Colors.black45,
              blurRadius: 3,
              spreadRadius: 0.8,
              offset: Offset(2.0, 1),
            )
          ],
          borderRadius: BorderRadius.circular(5)),
      margin: EdgeInsets.all(4.0),
      child: Image.asset(data[index]),
    );
  }

  startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (t) {
      setState(() {
        time = time - 1;
      });
    });
  }

  void restart() {
    startTimer();
    data = getSourceArray(
      level,
    );
    cardFlips = getInitialItemState(level);
    cardStateKeys = getCardStateKeys(level);
    time = 5;
    left = (data.length ~/ 2);

    isFinished = false;
    Future.delayed(const Duration(seconds: 6), () {
      setState(() {
        start = true;
        timer.cancel();
      });
    });
  }

  @override
  void initState() {
    super.initState();

    restart();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isFinished
        ? Scaffold(
            body: Center(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    restart();
                  });
                },
                child: Container(
                  height: 50,
                  width: 200,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Text(
                    "Replay",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          )
        : Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: time > 0
                          ? Text(
                              '$time',
                              style: Theme.of(context).textTheme.headline3,
                            )
                          : Text(
                              'Left:$left',
                              style: Theme.of(context).textTheme.headline3,
                            ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                        ),
                        itemBuilder: (context, index) => start
                            ? FlipCard(
                                key: cardStateKeys[index],
                                onFlip: () {
                                  if (!flip) {
                                    flip = true;
                                    previousIndex = index;
                                  } else {
                                    flip = false;
                                    if (previousIndex != index) {
                                      if (data[previousIndex] != data[index]) {
                                        wait = true;

                                        Future.delayed(
                                            const Duration(milliseconds: 1500),
                                            () {
                                          cardStateKeys[previousIndex]
                                              .currentState
                                              .toggleCard();
                                          previousIndex = index;
                                          cardStateKeys[previousIndex]
                                              .currentState
                                              .toggleCard();

                                          Future.delayed(
                                              const Duration(milliseconds: 160),
                                              () {
                                            setState(() {
                                              wait = false;
                                            });
                                          });
                                        });
                                      } else {
                                        cardFlips[previousIndex] = false;
                                        cardFlips[index] = false;
                                        print(cardFlips);

                                        setState(() {
                                          left -= 1;
                                        });
                                        if (cardFlips
                                            .every((t) => t == false)) {
                                          print("Won");
                                          Future.delayed(
                                              const Duration(milliseconds: 160),
                                              () {
                                            setState(() {
                                              isFinished = true;
                                              start = false;
                                            });
                                          });
                                        }
                                      }
                                    }
                                  }
                                  setState(() {});
                                },
                                flipOnTouch: wait ? false : cardFlips[index],
                                direction: FlipDirection.HORIZONTAL,
                                front: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(5),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black45,
                                          blurRadius: 3,
                                          spreadRadius: 0.8,
                                          offset: Offset(2.0, 1),
                                        )
                                      ]),
                                  margin: EdgeInsets.all(4.0),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      "assets/animalspics/quest.png",
                                    ),
                                  ),
                                ),
                                back: getItem(index))
                            : getItem(index),
                        itemCount: data.length,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
