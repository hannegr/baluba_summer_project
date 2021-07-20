//import 'package:color/color.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:profile_page_test/profile/make_profile_page.dart';

enum Sports {
  Aikido,
  Alpint,
  Amerikansk_fotball,
  Badminton,
  Basketball,
  Biljard,
  Boksing,
  Bordtennis,
  Bryting,
  Buldring,
  Calisthenics,
  Crossfit,
  Curling,
  Dans,
  Dykking,
  Esport,
  Fekting,
  Fitness,
  Fotball,
  Friidrett,
  Frisbeegolf,
  Golf,
  Handball,
  Innebandy,
  Ishockey,
  Judo,
  Karate,
  Kickboxing,
  Klatring,
  Loeping,
  Orientering,
  Padling,
  Rugby,
  Seiling,
  Sjakk,
  Ski,
  Skoeyter,
  Styrketrening,
  Svoemming,
  Sykling,
  Taekwondo,
  Tennis,
  Vektloefting,
  Volleyball,
}

class SportItems extends StatefulWidget {
  @override
  _SportItemsState createState() => _SportItemsState();
}

class _SportItemsState extends State<SportItems> {
  int _noOfSports = Sports.values.length;
  List<int> favouriteSports = [];

  String _sportToString(Sports sport) {
    String sportString = describeEnum(sport);

    if (sportString.contains('oe')) {
      return sportString.replaceAll('oe', 'ø');
    }
    if (sportString.contains('_')) {
      return sportString.replaceAll('_', ' ');
    }
    return sportString;
  }

  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      width: MediaQuery.of(context).size.width - 30,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: _noOfSports,
        itemBuilder: (ctx, index) {
          return TextButton(
            style: ButtonStyle(
              backgroundColor: !favouriteSports.contains(index)
                  ? MaterialStateProperty.all(Colors.red)
                  : MaterialStateProperty.all(Colors.green),
            ),
            onPressed: () {
              setState(() {
                if (!favouriteSports.contains(index)) {
                  favouriteSports.add(index);
                } else {
                  favouriteSports.remove(index);
                }
                ProfilePage.mySports = favouriteSports;
              });
            },
            child: Center(
              child: Text(
                _sportToString(Sports.values[index]),
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          );
        },
      ),
    );
  }
}
