//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';

enum Difficulty {
  enkel,
  middels,
  krevende,
  ekstrem,
}

class NyGratisOkt {
  String workoutTitle;
  DateTime date;
  DateTime startTime;
  DateTime endTime;
  int maxNumber;
  Difficulty difficulty;
  String location; //endre dette til sånn maps-ting
  String description;
  String workoutId;
  //Image image; //legge til etterpå kanskje

  NyGratisOkt({
    required this.workoutTitle,
    required this.description,
    required this.date,
    required this.location,
    required this.maxNumber,
    required this.endTime,
    required this.startTime,
    required this.difficulty,
    required this.workoutId,
  });
}
