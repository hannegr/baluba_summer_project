import 'package:flutter/material.dart';
import 'package:profile_page_test/workouts/workout_page.dart';

class BottomButtons extends StatefulWidget {
  @override
  _BottomButtonsState createState() => _BottomButtonsState();
}

class _BottomButtonsState extends State<BottomButtons> {
  void showPopupMenu(BuildContext ctx) {
    showMenu<String>(
      color: Theme.of(context).accentColor,
      context: context,
      position: RelativeRect.fromLTRB(60.0, 540.0, 50.0, 0.0),
      //position where you want to show the menu on screen
      items: [
        PopupMenuItem<String>(
            textStyle: TextStyle(
                fontFamily: 'RobotoCondensed',
                fontSize: 20,
                fontWeight: FontWeight.bold),
            child: const Text('Legg til økt'),
            value: '1'),
        PopupMenuItem<String>(
            textStyle: TextStyle(
                fontFamily: 'RobotoCondensed',
                fontSize: 20,
                fontWeight: FontWeight.bold),
            child: const Text('Ny samtale'),
            value: '2'),
        PopupMenuItem<String>(
            textStyle: TextStyle(
                fontFamily: 'RobotoCondensed',
                fontSize: 20,
                fontWeight: FontWeight.bold),
            child: const Text('Annet? Eventuelt bare en?'),
            value: '3'),
      ],
      elevation: 8.0,
    ).then<void>((_itemSelected) {
      if (_itemSelected == "1") {
        goToWorkoutpage(ctx);
      } else if (_itemSelected == "2") {
        //code here
      } else {
        //code here
      }
    });
  }

  void goToWorkoutpage(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      WorkoutPage.workoutName,
      //arguments: { kanskje senere
      //},
    );
  }
  /* void settingsMenu() {
    showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(-100.0, 1000.0, 100.0,
          0.0), //position where you want to show the menu on screen
      items: [
        PopupMenuItem<String>(child: const Text('Generelt'), value: '1'),
        PopupMenuItem<String>(
            child: const Text('Offentlig/privat'), value: '2'),
        PopupMenuItem<String>(child: const Text('andre ting idk'), value: '3'),
      ],
      elevation: 8.0,
    ).then<void>((_itemSelected) {
      if (_itemSelected == "1") {
        //code here
      } else if (_itemSelected == "2") {
        //code here
      } else {
        //code here
      }
    });
  } */

  Widget build(BuildContext context) {
    return (Container(
      height: double.infinity,
      width: double.infinity,
      child: Stack(
        children: <Widget>[
          /*Container(
            margin: EdgeInsets.only(top: 15),
            constraints: BoxConstraints.expand(height: 60),
            color: Colors.black,
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Container(
                  color: Colors.purpleAccent,
                  child: Text(
                    "Expanded StackFit",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                )
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[*/
          SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width / 2,
                  alignment: Alignment.centerLeft,
                  child: Center(
                    child: Text(
                      'Idretter',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    //DecorationImage
                    border: Border.all(
                      color: Colors.red,
                      width: 1,
                    ), //Border.all
                    //borderRadius: BorderRadius.circular(25),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width / 2,
                  alignment: Alignment.centerRight,
                  child: Center(
                    child: Text(
                      'Økter',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    //DecorationImage
                    border: Border.all(
                      color: Colors.red,
                      width: 1,
                    ), //Border.all
                    //borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment(0, 0.95),
            child: FloatingActionButton(
              onPressed: () => showPopupMenu(context),
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
    ));
  }
}
