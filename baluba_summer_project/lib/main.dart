// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_auth/firebase_auth.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:profile_page_test/profile/make_profile_page.dart';
import 'package:profile_page_test/user_authentication/log_in.dart';
import 'package:profile_page_test/user_authentication/sign_up.dart';
import 'package:profile_page_test/workouts/make_workouts/map_with_mapbox/map_widget_page.dart';
import 'package:profile_page_test/workouts/make_workouts/map_with_mapbox/search_for_place.dart';
import 'package:profile_page_test/workouts/make_workouts/workout_page.dart';
import 'package:profile_page_test/workouts/your_workouts/your_detailed_workout_page.dart';
import 'package:profile_page_test/your_page/bottomButtons/bottomButtons.dart';

import 'workouts/your_workouts_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();

  runApp(MyApp());
}

bool checkForAuthentication() {
  if (FirebaseAuth.instance.currentUser != null) {
    return true;
  } else {
    return false;
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
        accentColor:
            Colors.black, //fromRGBO(0, 0, 153, 1), //(79, 213, 214, 1),
        canvasColor:
            Colors.white, //fromRGBO(205, 255, 255, 1), //(255, 254, 229, 1)
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyText1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              headline6: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'RobotoCondensed',
              ),
            ),
      ),
      home: YourPage(),
      //getLoggedInOrNotPage(), // checkForAuthentication() ? YourPage() : LoginPage(),
      /* StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, userSnapshot) =>
            userSnapshot.hasData ? WorkoutPage() : SignUpPage(),
      ),*/
      routes: {
        YourPage.yourPageName: (ctx) => YourPage(),
        WorkoutPage.workoutName: (ctx) => WorkoutPage(),
        ProfilePage.profilePageName: (ctx) => ProfilePage(),
        MapWidgetPage.mapWidgetPageName: (ctx) => MapWidgetPage(),
        SearchForPlaceScreen.placeSearchPage: (ctx) => SearchForPlaceScreen(),
        YourWorkoutsPage.yourSignedUpWorkoutspage: (ctx) => YourWorkoutsPage(),
        LoginPage.LoginPageName: (ctx) => LoginPage(),
        SignUpPage.SignUpPageName: (ctx) => SignUpPage(),
        DetailedWorkoutPage.PageDetailWorkout: (ctx) => DetailedWorkoutPage(),
      },
    );
  }
}

StreamBuilder<dynamic> getLoggedInOrNotPage() {
  return StreamBuilder<User>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          return YourPage();
        } else {
          return LoginPage();
        }
        /*
        if (snapshot.data!.providerData.length == 1) {
          // logged in using email and password
          return snapshot.data!.isEmailVerified
              ? MainPage()
              : VerifyEmailPage(user: snapshot.data);
        } else {
          // logged in using other providers
          return MainPage();
        }
      } else {
        return LoginPage();
      }
    },
  );
  */
      });
}
