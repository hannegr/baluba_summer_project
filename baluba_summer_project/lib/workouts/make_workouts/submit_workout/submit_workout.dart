import 'dart:ui';

import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:mapbox_search/mapbox_search.dart';
import 'package:flutter/foundation.dart';
import 'package:profile_page_test/workouts/make_workouts/firebase_save_workout/save_workout.dart';
import 'package:profile_page_test/workouts/make_workouts/submit_workout/submit_workout_functions.dart';
import 'package:profile_page_test/workouts/make_workouts/workouts.dart';

class SubmitWorkout extends StatefulWidget {
  static MapBoxPlace? finalLocation;
  @override
  SubmitWorkoutState createState() => SubmitWorkoutState();
}

class SubmitWorkoutState extends State<SubmitWorkout> {
  final workoutTitleInput = TextEditingController();
  final maxNumberInput = TextEditingController();
  final descriptionInput = TextEditingController();

  String? difficultyChosen;

  DateTime date = DateTime.now();
  TimeOfDay startTime = TimeOfDay(hour: 16, minute: 30);
  TimeOfDay endTime = TimeOfDay(hour: 18, minute: 30);

  NewFreeWorkout workout = NewFreeWorkout(
    workoutTitle: '',
    description: '',
    date: DateTime.now(),
    maxNumber: 0,
    endTime: TimeOfDay(hour: 18, minute: 30),
    startTime: TimeOfDay(hour: 18, minute: 30),
    difficulty: 'Medium',
    latitude: null,
    longitude: null,
  );

  final SubmitFunctions submitFunctions = new SubmitFunctions();

  void getWorkoutDate(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 200)), //will this work?
    ).then(
      (pickedDate) {
        if (pickedDate == null) {
          return;
        }
        workout.date = pickedDate;

        setState(
          () {
            date = pickedDate;
          },
        );
      },
    );
  }

  void getWorkoutStartTime(BuildContext context) {
    showTimePicker(
            context: context, initialTime: TimeOfDay(hour: 16, minute: 30))
        .then((selectedTime) {
      if (selectedTime == null) {
        return;
      } else if (selectedTime.hour > endTime.hour) {
        print('Du må starte før du slutter, hallo?');
        return;
      }
      setState(() {
        startTime = selectedTime;
        workout.startTime = startTime;
      });
    });
  }

  void getWorkoutEndTime(BuildContext context) {
    showTimePicker(
            context: context, initialTime: TimeOfDay(hour: 16, minute: 30))
        .then((selectedTime) {
      if (selectedTime == null) {
        return;
      } else if (selectedTime.hour < startTime.hour) {
        print('Du må slutte etter du starter, hallo?');
        return;
      }
      setState(() {
        endTime = selectedTime;
        workout.endTime = endTime;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      if (SubmitWorkout.finalLocation != null) {
        workout.latitude = SubmitWorkout.finalLocation!.geometry.coordinates[0];
        workout.longitude =
            SubmitWorkout.finalLocation!.geometry.coordinates[1];
      }
    });
    if (workout.latitude == null || workout.longitude == null) {
      print('lat og lng ikke enna funnet');
    } else {
      print(SubmitWorkout.finalLocation!.placeName);
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 50,
            child: TextButton(
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.green,
              ),
              onPressed: () => SubmitFunctions.goToSearchPage(context),
              child: Text(
                workout.latitude == null
                    ? 'Plassering (søk)'
                    : SubmitWorkout.finalLocation!
                        .placeName, //må her hente inn info fra forrige screen, se search_for_place.
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            ),
          ),
          SizedBox(height: 5),
          Container(
            width: double.infinity,
            height: 50,
            child: TextButton(
              onPressed: () => SubmitFunctions.goToMapsPage(context),
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.green,
              ),
              child: Center(
                child: Text('Plassering (kart)',
                    style: TextStyle(
                        fontSize:
                            30)), //må også her hente inn info fra forrige screen.
              ),
            ),
          ),
          SizedBox(height: 5),
          TextField(
            controller: workoutTitleInput,
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: 'Tittel'),
            style: TextStyle(
              fontSize: 18,
            ),
            autocorrect: true,
            onChanged: (titleValue) => {workout.workoutTitle = titleValue},
          ),
          SizedBox(height: 5),
          TextField(
            controller: maxNumberInput,
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: 'Maks antall'),
            style: TextStyle(
              fontSize: 18,
            ),
            onChanged: (maxNumValue) {
              if (int.parse(maxNumValue) <= 0) {
                print('Du må velge en verdi større eller lik 0.');
                FocusScope.of(context).unfocus();
                return;
              } else {
                workout.maxNumber = int.parse(maxNumValue);
              }
            },
            keyboardType: TextInputType.number,
          ),
          SizedBox(
            height: 30,
          ),
          submitFunctions.setInputDate(
              date,
              DateFormat.MMMMd().format,
              context,
              Icon(Icons.date_range),
              () => getWorkoutDate(context),
              'Valgt dato: ',
              'Velg dato: '),
          SizedBox(
            height: 30,
          ),
          submitFunctions.setInputTime(
              startTime,
              context,
              Icon(Icons.more_time),
              () => getWorkoutStartTime(context),
              'Valgt starttid: ',
              'Velg starttid: '),
          SizedBox(
            height: 30,
          ),
          submitFunctions.setInputTime(
              endTime,
              context,
              Icon(Icons.more_time),
              () => getWorkoutEndTime(context),
              'Valgt sluttid: ',
              'Velg sluttid: '),
          SizedBox(
            height: 30,
          ),
          Container(
            margin: EdgeInsets.all(12),
            width: double.infinity,
            height: 5 * 24.0,
            child: TextField(
              controller: descriptionInput,
              keyboardType: TextInputType.multiline,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'Beskrivelse',
                border: OutlineInputBorder(),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                hintText:
                    'Her kan du legge til en liten beskrivelse av hva som skal bli gjennomgått i økten.',
              ),
              onChanged: (descriptionValue) {
                workout.description = descriptionValue;
              },
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            height: 200,
            width: double.infinity,
            child: Column(
              children: <Widget>[
                Center(
                  widthFactor: 10,
                  child: Text('Velg vanskelighetsgrad: ',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextButton(
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor:
                              difficultyChosen == describeEnum(Difficulty.enkel)
                                  ? Colors.red
                                  : Colors.green,
                        ),
                        onPressed: () {
                          workout.difficulty = describeEnum(Difficulty.enkel);

                          setState(() {
                            difficultyChosen = workout.difficulty;
                          });
                        },
                        child: Text(
                          describeEnum(Difficulty.enkel),
                          style: TextStyle(
                            fontSize: 30,
                          ),
                        )),
                    SizedBox(width: 10),
                    TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor:
                            difficultyChosen == describeEnum(Difficulty.middels)
                                ? Colors.red
                                : Colors.green,
                        //onSurface: Colors.grey,
                      ),
                      onPressed: () {
                        workout.difficulty = describeEnum(Difficulty.middels);
                        setState(() {
                          difficultyChosen = workout.difficulty;
                        });
                      },
                      child: Text(
                        describeEnum(Difficulty.middels),
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: difficultyChosen ==
                                describeEnum(Difficulty.krevende)
                            ? Colors.red
                            : Colors.green,
                        //onSurface: Colors.grey,
                      ),
                      onPressed: () {
                        workout.difficulty = describeEnum(Difficulty.krevende);
                        setState(() {
                          difficultyChosen = workout.difficulty;
                        });
                      },
                      child: Text(
                        describeEnum(Difficulty.krevende),
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor:
                            difficultyChosen == describeEnum(Difficulty.ekstrem)
                                ? Colors.red
                                : Colors.green,
                        //onSurface: Colors.grey,
                      ),
                      onPressed: () {
                        workout.difficulty = describeEnum(Difficulty.ekstrem);
                        setState(() {
                          difficultyChosen = workout.difficulty;
                        });
                      },
                      child: Text(
                        describeEnum(Difficulty.ekstrem),
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Container(
              width: double.infinity,
              child: TextButton(
                child: Text('Legg ut økt',
                    style: TextStyle(color: Colors.red, fontSize: 35)),
                onPressed: () {
                  print(
                      '${workout.workoutTitle} ${workout.date} ${workout.maxNumber} ${workout.description} ${workout.difficulty} ${workout.date} ${workout.startTime} ${workout.endTime} ${workout.latitude}');
                  saveWorkout(workout, 1);
                  SubmitFunctions.goToYourWorkouts(context);
                },
              ))
        ],
      ),
    );
  }
}
