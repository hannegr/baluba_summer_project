import 'dart:ui';

import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:mapbox_search/mapbox_search.dart';
import 'package:profile_page_test/make_workouts/map_with_mapbox/map_widget_page.dart';
import 'package:profile_page_test/make_workouts/workouts.dart';
import 'package:flutter/foundation.dart';
import '../submit_workout/submit_workout_functions.dart';

void submitData(var workoutTitleInput, var locationInput, var maxNumberInput,
    var startTime, var endTime, var date, var description) {
  final workoutTitle = workoutTitleInput.text;
  final location = locationInput.text;
  final maxNumber = int.parse(maxNumberInput.text);
  //final startT = DateFormat.Hm().format(startTime);
  //final endT = DateFormat.Hm().format(endTime);

  if (workoutTitle.isEmpty || location.isEmpty || maxNumber < 0) {
    /*   ||
      startT == null ||
      endT == null) { */
    return;
  }

  //widget.addTx(enteredTitle, enteredAmount, _selectedDate);
  //Navigator.of(context).pop();
}

class SubmitWorkout extends StatefulWidget {
  @override
  SubmitWorkoutState createState() => SubmitWorkoutState();
}

class SubmitWorkoutState extends State<SubmitWorkout> {
  final workoutTitleInput = TextEditingController();
  final locationInput =
      TextEditingController(); //vil endres når location fikses vha maps
  final maxNumberInput = TextEditingController();
  final descriptionInput = TextEditingController();

  DateTime date = DateTime.now();
  DateTime startTimeDate = DateTime.now();
  DateTime endTimeDate = DateTime.now();

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
      location: null);

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
            //ta dette med senere når du har statefulWidget hehe
            date = pickedDate;
            print(date);
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
      } else if (selectedTime.hour < endTime.hour) {
        print('Du må slutte før du starter, hallo?');
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
    if (ModalRoute.of(context)!.settings.arguments != null) {
      final args = ModalRoute.of(context)!.settings.arguments as MapBoxPlace;
      print(args.placeName);
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          TextField(
            /* onChanged: (value) => titleInput = value, */
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
                'Plassering (søk)', //må her hente inn info fra forrige screen, se search_for_place.
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            ),
          ),
          SizedBox(height: 5),
          /*
          TextField(
            onTap: () {
              SubmitFunctions.goToSearchPage(context); //locationInput.text);
            },
            controller: locationInput,
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: 'Plassering (søk)'),
            style: TextStyle(
              fontSize: 18,
            ),
            onSubmitted: (_) {},
            //keyboardType: TextInputType.number,
          ),
          */
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
          /*TextField(
            /* onChanged: (value) => titleInput = value, */
            controller: locationInput,
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: 'Sted'),
            style: TextStyle(
              fontSize: 18,
            ),
            autocorrect: true,
            onSubmitted: (_) => {},
          ),
          SizedBox(height: 5),*/
          TextField(
            /* onChanged: (value) {
                        amountInput = value;
                      }, */
            controller: maxNumberInput,
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: 'Maks antall'),
            style: TextStyle(
              fontSize: 18,
            ),
            onChanged: (maxNumValue) {
              if (int.parse(maxNumValue) <= 0) {
                print('Du må velge en verdi større eller lik 0.');
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
                          backgroundColor: Colors.green,
                          //onSurface: Colors.grey,
                        ),
                        //style: TextButton.styleFrom(primary: Colors.black),
                        onPressed: () {
                          workout.difficulty = describeEnum(Difficulty.enkel);
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
                        backgroundColor: Colors.green,
                        //onSurface: Colors.grey,
                      ),
                      onPressed: () {
                        workout.difficulty = describeEnum(Difficulty.middels);
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
                        backgroundColor: Colors.green,
                        //onSurface: Colors.grey,
                      ),
                      onPressed: () {
                        workout.difficulty = describeEnum(Difficulty.krevende);
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
                        backgroundColor: Colors.green,
                        //onSurface: Colors.grey,
                      ),
                      onPressed: () {
                        workout.difficulty = describeEnum(Difficulty.ekstrem);
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
                  print('${workout.workoutTitle} ${workout.date} ${workout.maxNumber} ${workout.description} ${workout.difficulty} ${workout.date} ${workout.startTime} ${workout.endTime}')
                      //lagre dette i Firebase.
                      //Gå til en ny side som viser dine økter, for å vise at økten er registrert der
                      ;
                },
              ))
        ],
      ),
    );
  }
}
