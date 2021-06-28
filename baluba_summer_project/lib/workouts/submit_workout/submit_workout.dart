import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_search/mapbox_search.dart';
import 'package:profile_page_test/workouts/map_with_mapbox/map_widget_page.dart';
import 'package:profile_page_test/workouts/workouts.dart';
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
  var placesSearch = PlacesSearch(
    apiKey: ApiKey,
    limit: 5,
  );
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
      }
      setState(() {
        startTime = selectedTime;
      });
    });
  }

  void getWorkoutEndTime(BuildContext context) {
    showTimePicker(
            context: context, initialTime: TimeOfDay(hour: 16, minute: 30))
        .then((selectedTime) {
      if (selectedTime == null) {
        return;
      }
      setState(() {
        endTime = selectedTime;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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
            onSubmitted: (_) => {},
          ),
          SizedBox(height: 5),
          TextField(
            onChanged: (String s) {
              placesSearch.getPlaces(locationInput.text);
            },
            controller: locationInput,
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: 'Maks antall'),
            style: TextStyle(
              fontSize: 18,
            ),
            onSubmitted: (_) {},
            //keyboardType: TextInputType.number,
          ),
          Container(
            width: double.infinity,
            height: 100,
            child: TextButton(
              onPressed: () => SubmitFunctions.goToMapsPage(context),
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.green,
                //onSurface: Colors.grey,
              ),
              child: Text('Plassering', style: TextStyle(fontSize: 30)),
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
            onSubmitted: (_) => {},
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
                          print('hello');
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
                      onPressed: () {},
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
                      onPressed: () {},
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
                      onPressed: () {},
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
        ],
      ),
    );
  }
}
