import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:profile_page_test/workouts/make_workouts/map_with_mapbox/map_widget_page.dart';
import 'package:profile_page_test/workouts/make_workouts/map_with_mapbox/search_for_place.dart';

import '../../your_workouts_page.dart';

class SubmitFunctions {
  static void goToMapsPage(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      MapWidgetPage.mapWidgetPageName,
      //arguments: { kanskje senere
      //},
    );
  }

  static void goToYourWorkouts(BuildContext ctx) {
    Navigator.of(ctx).pop();
    Navigator.of(ctx).pushNamed(
      YourWorkoutsPage.yourSignedUpWorkoutspage,
    );
  }

  static void goToSearchPage(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      SearchForPlaceScreen.placeSearchPage,
    );
  }

  Widget setInputDate(
      DateTime dateOrTime,
      var dateTimeFormat,
      BuildContext ctx,
      Icon icon,
      VoidCallback changeDateTimeFunction,
      String chosenDateTime,
      String chooseDateTime) {
    return Container(
      height: 70,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              //_selectedDate == null
              //? 'No date chosen'
              chosenDateTime +
                  ' ${dateTimeFormat(dateOrTime)}', // DateFormat.yMd().format //Icons.date_range
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
          ),
          TextButton(
            child: Text(
              chooseDateTime,
              style: TextStyle(color: Colors.green),
            ),
            onPressed: changeDateTimeFunction,
          ),
          IconButton(
            iconSize: 50,
            onPressed: changeDateTimeFunction,
            icon: icon,
            color: Colors.green,
          ),
        ],
      ),
    );
  }

  Widget setInputTime(
      TimeOfDay dateOrTime,
      BuildContext ctx,
      Icon icon,
      VoidCallback changeDateTimeFunction,
      String chosenDateTime,
      String chooseDateTime) {
    return Container(
      height: 70,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              //_selectedDate == null
              //? 'No date chosen'
              chosenDateTime +
                  ' ${(dateOrTime.format(ctx))}', // DateFormat.yMd().format //Icons.date_range
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
          ),
          TextButton(
            child: Text(
              chooseDateTime,
              style: TextStyle(color: Colors.green),
            ),
            onPressed: changeDateTimeFunction,
          ),
          IconButton(
            iconSize: 50,
            onPressed: changeDateTimeFunction,
            icon: icon,
            color: Colors.green,
          ),
        ],
      ),
    );
  }
}
