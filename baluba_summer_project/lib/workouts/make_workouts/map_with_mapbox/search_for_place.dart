import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:mapbox_search/mapbox_search.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:mapbox_search_flutter/mapbox_search_flutter.dart';
import 'package:profile_page_test/workouts/make_workouts/submit_workout/submit_workout.dart';

import '../workout_page.dart';
import 'map_widget_page.dart';

class SearchForPlaceScreen extends StatefulWidget {
  static const placeSearchPage = '/placeSearchPage';
  @override
  _SearchForPlaceScreenState createState() => _SearchForPlaceScreenState();
}

class _SearchForPlaceScreenState extends State<SearchForPlaceScreen> {
  var placesSearch = PlacesSearch(
    apiKey: ApiKey,
    limit: 5,
  );

  void _savePlaceInWorkoutPage(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
        WorkoutPage.workoutName); //, arguments: {'place': finalPlace});
    Navigator.of(context).pop();
  }

  List<MapBoxPlace>? places;
  //MapBoxPlace? finalPlace;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Søk på sted'),
      ),
      body: MapBoxPlaceSearchWidget(
        popOnSelect: true,
        apiKey: ApiKey,
        searchHint: 'Skriv addresse eller sted her',
        country: "NO",
        onSelected: (place) {
          //print(place.geometry); //DETTE GIR LAT OG LNG!
          //print(place.addressNumber); //gir adressenummer som string
          //print(place.placeName); //bare plassnavn
          setState(() {
            SubmitWorkout.finalLocation = place;
            SubmitWorkoutState();
          });
          _savePlaceInWorkoutPage(context);

          //print(finalPlace!.geometry);

          /* print(place
              .geometry.coordinates[0]); // tror [0] gir lat og [1] gir lng.
          */
        },
        context: context,
      ),
      /*
      body: Column(
        children: [TextField(
          onChanged: (value) async {
            places = await placesSearch.getPlaces(value);
            print(places[0]); 
        
          },
        ),

        ]
      ),
      */
    );
  }
}
