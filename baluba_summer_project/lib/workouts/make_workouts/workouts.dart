//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  double? latitude;
  double? longitude;
  //LatLng? location;
  //MapBoxPlace? location;
  String description;
  //String workoutId;

  NewFreeWorkout({
    required this.workoutTitle,
    required this.description,
    required this.date,
    required this.latitude,
    required this.longitude,
    required this.maxNumber,
    required this.endTime,
    required this.startTime,
    required this.difficulty,
  });
}
