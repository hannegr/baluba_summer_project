//Hva vil jeg gjøre her?
//- lagre alt i collection 'workouts'

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:profile_page_test/workouts/make_workouts/submit_workout/submit_workout.dart';
import 'package:profile_page_test/workouts/make_workouts/workouts.dart';
import 'package:quiver/iterables.dart';

void saveWorkout(NewFreeWorkout soonSavedWorkout) {
  FirebaseFirestore.instance.collection('baluba_workouts').add({
    'title': soonSavedWorkout.workoutTitle,
    'createdAt': Timestamp.now(),
    'max_number': soonSavedWorkout.maxNumber,
    'latitude': soonSavedWorkout.latitude,
    'longitude': soonSavedWorkout.longitude,
    'description': soonSavedWorkout.description,
    'difficulty': soonSavedWorkout.difficulty,
    'date': soonSavedWorkout.date,
    'starttime':
        '${soonSavedWorkout.startTime.hour}:${soonSavedWorkout.startTime.minute}',
    'endtime':
        '${soonSavedWorkout.endTime.hour}:${soonSavedWorkout.endTime.minute}',
  });
}

void getWorkout(String title, double maxNumber, String description) async {
  var collection = FirebaseFirestore.instance.collection('baluba_workouts');
  QuerySnapshot querySnapshot = await collection.get();
  final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
  var element;
  for (element in allData) {
    if (element['title'] == title &&
        element['max_number'] == maxNumber &&
        element['description'] == description) {
      //delete it but how?
    }
  }
  print(allData);
}


  /*Stream snap = collection
      .orderBy(
        'createdAt',
      )
      .snapshots();
}*/

/*void deleteWorkout(NewFreeWorkout soonSavedWorkout) async{
  await FirebaseFirestore
  .instance.runTransaction((Transaction myTransaction) async {
    myTransaction.delete(snapshot.data.documents[index].reference);
});
}
*/

/*

void changeWorkout (bør kun funke om du har brukerID)
*/
