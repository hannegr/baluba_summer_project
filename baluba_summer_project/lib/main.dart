import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:profile_page_test/profile/make_profile_page.dart';
import 'package:profile_page_test/make_workouts/map_with_mapbox/map_widget_page.dart';
import 'package:profile_page_test/make_workouts/map_with_mapbox/search_for_place.dart';
import 'package:profile_page_test/make_workouts/workout_page.dart';
import 'package:profile_page_test/your_page/side_bar.dart';
import 'your_page/bottomButtons/bottomButtons.dart';
import './your_page/side_bar.dart';

void main() {
  runApp(MyApp());
}

//Some parts of this taken from meal app intro.
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
      home: MyHomePage(title: 'Din side'),
      routes: {
        WorkoutPage.workoutName: (ctx) => WorkoutPage(),
        ProfilePage.profilePageName: (ctx) => ProfilePage(),
        MapWidgetPage.mapWidgetPageName: (ctx) => MapWidgetPage(),
        SearchForPlaceScreen.placeSearchPage: (ctx) => SearchForPlaceScreen(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      drawer: Drawer(
        child: SideBar(),
      ),
      body: Center(
        child: BottomButtons(),
      ),
    );
  }
}
