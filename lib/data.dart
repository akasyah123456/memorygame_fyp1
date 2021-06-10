import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';

enum Level { Hard, Medium, Easy }
List<String> fillsourceArray() {
  return [
    'assets/arabicpics/1.png',
    'assets/arabicpics/1.png',
    'assets/arabicpics/2.png',
    'assets/arabicpics/2.png',
    'assets/arabicpics/3.png',
    'assets/arabicpics/3.png',
    'assets/arabicpics/4.png',
    'assets/arabicpics/4.png',
    'assets/arabicpics/5.png',
    'assets/arabicpics/5.png',
    'assets/arabicpics/6.png',
    'assets/arabicpics/6.png',
    'assets/arabicpics/7.png',
    'assets/arabicpics/7.png',
    'assets/arabicpics/8.png',
    'assets/arabicpics/8.png',
    'assets/arabicpics/9.png',
    'assets/arabicpics/9.png'
  ];
}

List<String> getSourceArray(Level level) {
  // ignore: deprecated_member_use
  List<String> levelAndKindList = [];
  List sourceArray = fillsourceArray();
  if (level == Level.Hard) {
    sourceArray.forEach((element) {
      levelAndKindList.add(element);
    });
  } else if (level == Level.Medium) {
    for (int i = 0; i < 12; i++) {
      levelAndKindList.add(sourceArray[i]);
    }
  } else if (level == Level.Easy) {
    for (int i = 0; i < 6; i++) {
      levelAndKindList.add(sourceArray[i]);
    }
  }
  levelAndKindList.shuffle();
  return levelAndKindList;
}

List<bool> getInitialitemState(Level level) {
  List<bool> initialitemstate = [];
  if (level == Level.Hard) {
    for (int i = 0; i < 18; i++) {
      initialitemstate.add(true);
    }
  } else if (level == Level.Medium) {
    for (int i = 0; i < 18; i++) {
      initialitemstate.add(true);
    }
  } else if (level == Level.Easy) {
    for (int i = 0; i < 18; i++) {
      initialitemstate.add(true);
    }
  }
  return initialitemstate;
}

List<GlobalKey<FlipCardState>> getCardStateKeys(Level level) {
  List<GlobalKey<FlipCardState>> cardStateKeys = [];
  if (level == Level.Hard) {
    for (int i = 0; i < 18; i++) {
      cardStateKeys.add(GlobalKey<FlipCardState>());
    }
  } else if (level == Level.Medium) {
    for (int i = 0; i < 12; i++) {
      cardStateKeys.add(GlobalKey<FlipCardState>());
    }
  } else if (level == Level.Easy) {
    for (int i = 0; i < 6; i++) {
      cardStateKeys.add(GlobalKey<FlipCardState>());
    }
  }
  return cardStateKeys;
}
