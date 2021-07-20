//ønsker

// fra øverst til nederst
// -øverst: static image fra mapbox som viser hvor treningen skal være
//(aka må lagre latlng)
// - under: tittel på økt
// - vanskelighetsgrad, og maks antall (helst hvor mange som har meldt seg
//på av maks antall)
// - dato, starttid, sluttid helst på en linje med ikoner
// om det tilsvarer id-en til personen som har laget den skal det også være
//mulighet for rediger og slett helt under. Dette bør være et sted under.part '
// Det bør være delt i 2. Øverst kan man ha økter du deltar på, under kan man ha økter du arrangerer';

//Kanskje bruk det der Listview.builder for å få mange kloner av de samme layoutene av øktene.

// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:profile_page_test/workouts/your_workouts/your_detailed_workout_page.dart';

class WorkoutArguments {
  final String wTitle;
  final String wDate;
  final String wDescription;
  final String wDifficulty;
  final String wStartTime;
  final String wEndTime;
  final double wLatitude;
  final double wLongitude;
  final String wUserID;
  WorkoutArguments(
    this.wTitle,
    this.wDate,
    this.wDescription,
    this.wDifficulty,
    this.wEndTime,
    this.wStartTime,
    this.wLatitude,
    this.wLongitude,
    this.wUserID,
  );
}

class YourWorkoutsPage extends StatelessWidget {
  static const yourSignedUpWorkoutspage = '/workoutpages';
  void _gotoDetailedWorkout(
      BuildContext ctx,
      String title,
      String date,
      String description,
      String difficulty,
      String startTime,
      String endTime,
      double latitude,
      double longitude,
      String userID) {
    Navigator.of(ctx).pushNamed(DetailedWorkoutPage.PageDetailWorkout,
        arguments: WorkoutArguments(title, date, description, difficulty,
            endTime, startTime, latitude, longitude, userID));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('Påmeldte økter'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('baluba_workouts')
            .snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot> workoutSnapshot) {
          if (!workoutSnapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final workoutChats = workoutSnapshot.data!.docs;
          int myWorkoutCount = workoutChats.length;
          final String user = FirebaseAuth.instance.currentUser.uid;
          return ListView.builder(
            itemCount: workoutChats
                .length, //endre dette senere, men funker faktisk nå? idk
            itemBuilder: (ctx, index) {
              if (workoutChats[index].data()['userID'] == user) {
                //|| workoutChats[index].data()['signedup_users'].contains(FirebaseAuth.instance.currentUser)){ Add dette når vi kan legge til brukere som kan melde seg på.
                return InkWell(
                  onTap: () {}, //gå og se mer nøye på økten
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 4,
                    margin: EdgeInsets.all(10),
                    color: Colors.white,
                    child: Column(
                      children: [
                        Positioned(
                          bottom: 20,
                          right: 0,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 20),
                            width: 300,
                            color: Colors.white,
                            child: Text(
                              workoutChats[index].data()['title'],
                              style: TextStyle(
                                fontSize: 26,
                                color: Colors.black,
                              ),
                              softWrap: true,
                              overflow: TextOverflow.fade,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Icon(
                                      Icons.schedule,
                                    ),
                                    Text(
                                        '${workoutChats[index].data()['starttime']} - ${workoutChats[index].data()['endtime']}'),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Icon(
                                      Icons.date_range,
                                    ),
                                    Text(workoutChats[index].data()['date']),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Icon(
                                      Icons.person,
                                    ),
                                    Text(
                                        '${workoutChats[index].data()['signedup']}/${workoutChats[index].data()['max_number']}'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return Text('Du er ikke påmeldt noen økter.');
              }
            },
          );
        },
      ),
    );
  }
}
