import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'submit_workout/submit_workout.dart';

class WorkoutPage extends StatelessWidget {
  static const workoutName = '/workouts';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          'Ny økt',
          style: TextStyle(
            fontFamily: 'Raleway',
            fontSize: 35,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).canvasColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SubmitWorkout(),
      ),
    );
  }
}
