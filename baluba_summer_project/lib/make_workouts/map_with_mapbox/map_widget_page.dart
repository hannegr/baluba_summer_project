import 'dart:io';
import 'dart:math';
import 'package:mapbox_search_flutter/mapbox_search_flutter.dart';
import 'package:color/color.dart';
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:profile_page_test/make_workouts/map_with_mapbox/config_helper.dart';
import 'package:profile_page_test/make_workouts/map_with_mapbox/location_helper.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:mapbox_gl/mapbox_gl.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:mapbox_search/mapbox_search.dart';
import 'package:profile_page_test/make_workouts/workout_page.dart';

const ApiKey =
    'pk.eyJ1IjoiaGFubmVnZ2EiLCJhIjoiY2txaWJkeXRvMDN6cTJ1cGQybGF6bnQ4dyJ9.p6zCJaj8XSponjP3-AndnA';

class MapWidgetPage extends StatefulWidget {
  static const mapWidgetPageName = '/Mapwidgetpage';

  @override
  _MapWidgetPageState createState() => _MapWidgetPageState();
}

class _MapWidgetPageState extends State<MapWidgetPage> {
  void _savePlaceInWorkoutPage(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(WorkoutPage.workoutName, arguments: finalPlace);
    Navigator.of(context).pop();
  }

  StaticImage staticImage = StaticImage(apiKey: ApiKey);

  List<MapBoxPlace?>? address;
  MapboxMapController? globalController;

  MapBoxPlace? finalPlace;

  var reverseGeoCoding = ReverseGeoCoding(
    apiKey: ApiKey,
    //country: "NO",
    limit: 5,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: loadConfigFile(),
        builder: (
          BuildContext buildContext,
          AsyncSnapshot<Map<String, dynamic>> snapshot,
        ) {
          if (!snapshot.hasData) {
            print(snapshot.data);
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Container(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 1.25,
                    child: MapboxMap(
                        compassEnabled: true,
                        zoomGesturesEnabled: true,
                        //minMaxZoomPreference: MinMaxZoomPreference(5, 50),
                        accessToken:
                            ApiKey, //snapshot.data!['mapbox_api_token'],
                        //'mapbox_api_token' is the name of the key we are using in our config file.
                        initialCameraPosition: CameraPosition(
                          target: LatLng(0, 0),
                          zoom: 15,
                        ),
                        onMapCreated: (MapboxMapController controller) async {
                          final location = await acquireCurrentLocation();
                          final animateCameraResult =
                              await controller.animateCamera(
                            CameraUpdate.newCameraPosition(
                              CameraPosition(zoom: 15.0, target: location),
                            ),
                          );
                          globalController = controller;
                          if (animateCameraResult) {
                            globalController!.addCircle(
                              CircleOptions(
                                circleRadius: 7,
                                circleColor: '#050ac9',
                                circleOpacity: 0.5,
                                circleStrokeColor: '#050a7f',
                                circleStrokeOpacity: 1,
                                circleStrokeWidth: 2,
                                geometry: LatLng(
                                    location!.latitude, location.longitude),
                                draggable: false,
                              ),
                            );
                          }
                        },
                        onMapClick: (Point<double> point, LatLng latLng) async {
                          final animateCameraResult =
                              await globalController!.animateCamera(
                            CameraUpdate.newCameraPosition(
                              CameraPosition(zoom: 15.0, target: latLng),
                            ),
                          );

                          Location coordinates = new Location();
                          coordinates.lat = latLng.latitude;
                          coordinates.lng = latLng.longitude;
                          address =
                              await reverseGeoCoding.getAddress(coordinates);
                          print(latLng); //riktige koordinater
                          setState(() {
                            finalPlace = address![0];
                          });

                          //globalController!.clearSymbols();

                          if (animateCameraResult) {
                            globalController!.addCircle(
                              CircleOptions(
                                circleRadius: 7,
                                circleColor: '#990000',
                                circleOpacity: 0.5,
                                circleStrokeColor: '#ff0000',
                                circleStrokeOpacity: 6,
                                circleStrokeWidth: 5,
                                geometry:
                                    LatLng(latLng.latitude, latLng.longitude),
                                draggable: false,
                              ),
                            );

                            /*

                            globalController!.addSymbol(
                              (SymbolOptions(
                                geometry:
                                    LatLng(latLng.latitude, latLng.longitude),
                                iconImage: "assets/images/location_pin.png",
                                iconSize: 30,
                              )),
                            );
                            */

                            //print(currentAddress);
                            globalController!.clearCircles();
                          }
                        }
                        /*

                  staticImage.getStaticUrlWithMarker(
                    center: coordinates,
                    marker: MapBoxMarker(
                        markerColor: Color.rgb(100, 100, 100)
                            as RgbColor, //Color.rgb(0, 0, 0),
                        markerLetter: 'h',
                        markerSize: MarkerSize.LARGE),
                    height: 300,
                    width: 600,
                    zoomLevel: 16,
                    render2x: true,
                  );
                  staticImage == null ? print('error!') : print('yes');
                },
                */

                        ),
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      color: Colors.amber,
                      child: Row(children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              finalPlace != null
                                  ? finalPlace!.placeName
                                  : 'Ingen plass valgt',
                              style: TextStyle(
                                fontSize: 30,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: FloatingActionButton(
                            onPressed: () {},
                            child: Icon(Icons.add),
                          ),
                        )
                      ]),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
