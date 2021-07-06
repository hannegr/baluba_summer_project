import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_search/mapbox_search.dart';
import 'package:mapbox_search_flutter/mapbox_search_flutter.dart';
import 'package:profile_page_test/workouts/map_with_mapbox/map_widget_page.dart';
import 'package:quiver/async.dart';

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
  List<MapBoxPlace>? places;

  Future<List<MapBoxPlace>> getPlaces() => placesSearch.getPlaces("New York");

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
          print(place.geometry); //DETTE GIR LAT OG LNG!
          print(place.addressNumber); //gir adressenummer som string
          print(place.placeName); //bare plassnavn'

          //TODO: lagre plassnavnet og latlng i Firebase
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
