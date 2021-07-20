// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:profile_page_test/profile/make_profile_page.dart';
import 'package:profile_page_test/user_authentication/log_in.dart';
import 'package:profile_page_test/workouts/make_workouts/submit_workout/submit_workout_functions.dart';

class SideBar extends StatelessWidget {
  void _goToProfilePage(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      ProfilePage.profilePageName,
      //arguments: { kanskje senere
      //},
    );
  }

  void _goToLoginPage(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      LoginPage.LoginPageName,
      //arguments: { kanskje senere
      //},
    );
  }

  void _signOut() async {
    FirebaseAuth.instance.signOut();
  }

  Widget buildListTile(String title, IconData icon,
      VoidCallback onPressedFunction, BuildContext context) {
    return ListTile(
      tileColor: Theme.of(context).accentColor,
      leading: Icon(
        icon,
        size: 26,
        color: Theme.of(context).canvasColor,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'Raleway',
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).canvasColor,
        ),
      ),
      onTap: onPressedFunction,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Theme.of(context).accentColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              height: 80,
              width: double.infinity,
              //padding: EdgeInsets.all(20),
              alignment: Alignment.centerLeft,
              color: Theme.of(context).accentColor,
              child: Center(
                child: Text(
                  'MENY',
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 40,
                      color: Theme.of(context).primaryColor),
                ),
              ),
            ),
            Column(
              //mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                buildListTile('Logg inn', Icons.person,
                    () => _goToLoginPage(context), context),
                buildListTile('Utforsk', Icons.search, () {}, context),
                buildListTile('Dine økter', Icons.sports,
                    () => SubmitFunctions.goToYourWorkouts(context), context),
                buildListTile(
                    'Finn venner', Icons.person_search, () {}, context),
                buildListTile('Innstillinger', Icons.settings, () {}, context),
                buildListTile('Profil', Icons.person,
                    () => _goToProfilePage(context), context),
                buildListTile('Logg ut', Icons.logout, _signOut, context),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
