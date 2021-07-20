//Hva vil jeg gjøre her?
//- lagre alt i collection 'workouts'
// ignore: import_of_legacy_library_into_null_safe
import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:profile_page_test/workouts/make_workouts/workouts.dart';

void saveWorkout(NewFreeWorkout soonSavedWorkout, int signedUp) {
  final user = FirebaseAuth.instance.currentUser;
  FirebaseFirestore.instance.collection('baluba_workouts').add({
    'title': soonSavedWorkout.workoutTitle,
    'createdAt': Timestamp.now(),
    'max_number': soonSavedWorkout.maxNumber,
    'latitude': soonSavedWorkout.latitude,
    'longitude': soonSavedWorkout.longitude,
    'description': soonSavedWorkout.description,
    'difficulty': soonSavedWorkout.difficulty,
    'date': DateFormat.yMMMd().format(soonSavedWorkout.date),
    'starttime':
        '${soonSavedWorkout.startTime.hour}:${soonSavedWorkout.startTime.minute}',
    'endtime':
        '${soonSavedWorkout.endTime.hour}:${soonSavedWorkout.endTime.minute}',
    'signedup':
        signedUp, //bør kanskje endre dette til personer som har signert at de ønsker å komme i en liste og heller telle antallet etter hvert.
    'userID': user.uid,
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
