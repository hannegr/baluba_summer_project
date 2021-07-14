//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:mapbox_search/mapbox_search.dart';

enum Difficulty {
  enkel,
  middels,
  krevende,
  ekstrem,
}

class NewFreeWorkout {
  String workoutTitle;
  DateTime date;
  TimeOfDay startTime;
  TimeOfDay endTime;
  int maxNumber;
  String difficulty;
  MapBoxPlace? location;
  // String location;
  String description;
  //String workoutId;
  //Image image; //legge til etterpå kanskje

  NewFreeWorkout({
    required this.workoutTitle,
    required this.description,
    required this.date,
    required this.location,
    required this.maxNumber,
    required this.endTime,
    required this.startTime,
    required this.difficulty,
    //required this.workoutId, not yet
  });
}
