import 'package:flutter/material.dart';
import 'package:profile_page_test/profile/make_profile_page.dart';

class SideBar extends StatelessWidget {
  void _goToProfilePage(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      ProfilePage.profilePageName,
      //arguments: { kanskje senere
      //},
    );
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                buildListTile('Utforsk', Icons.search, () {}, context),
                buildListTile(
                    'Finn venner', Icons.person_search, () {}, context),
                buildListTile('Innstillinger', Icons.settings, () {}, context),
                buildListTile('Profil', Icons.person,
                    () => _goToProfilePage(context), context),
              ],
            ),
            buildListTile('Logg ut', Icons.logout, () {}, context),
          ],
        ),
      ),
    );
  }
}
