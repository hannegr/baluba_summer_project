import 'dart:math';
// ignore: import_of_legacy_library_into_null_safe
import 'package:mapbox_search_flutter/mapbox_search_flutter.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:color/color.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:profile_page_test/workouts/map_with_mapbox/config_helper.dart';
import 'package:profile_page_test/workouts/map_with_mapbox/location_helper.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:mapbox_gl/mapbox_gl.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:mapbox_search/mapbox_search.dart';

const ApiKey = 'xxxx';

class MapWidgetPage extends StatelessWidget {
  static const mapWidgetPageName = '/Mapwidgetpage';
  StaticImage staticImage = StaticImage(apiKey: ApiKey);
  String? currentAddress;
  MapboxMapController? globalController;

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
            return MapboxMap(
              zoomGesturesEnabled: true,
              //minMaxZoomPreference: MinMaxZoomPreference(5, 50),
              accessToken: snapshot.data!['mapbox_api_token'], // ApiKey
              //'mapbox_api_token' is the name of the key we are using in our config file.
              initialCameraPosition: CameraPosition(
                target: LatLng(0, 0),
                zoom: 15,
              ),
              onMapCreated: (MapboxMapController controller) async {
                final location = await acquireCurrentLocation();
                final animateCameraResult = await controller.animateCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(zoom: 15.0, target: location),
                  ),
                );
                globalController = controller;
                if (animateCameraResult) {
                  controller.addCircle(
                    CircleOptions(
                      circleRadius: 7,
                      circleColor: '#050ac9',
                      circleOpacity: 0.5,
                      circleStrokeColor: '#050a7f',
                      circleStrokeOpacity: 1,
                      circleStrokeWidth: 2,
                      geometry: LatLng(location!.latitude, location.longitude),
                      draggable: false,
                    ),
                  );
                }
              },
              onMapClick: (Point<double> point, LatLng latLng) async {
                final animateCameraResult =
                    await globalController!.animateCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                        zoom: 15.0, target: latLng), //LatLng(69.6489, 18.95508)
                  ),
                );
                Location coordinates = new Location();
                coordinates.lat = latLng.latitude;
                coordinates.lng = latLng.longitude;
                var place = await reverseGeoCoding.getAddress(coordinates);
                print(latLng); //riktige koordinater
                currentAddress = place[0].placeName;
                ;
                print(currentAddress);
                globalController!.clearCircles();
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
                      geometry: LatLng(latLng.latitude, latLng.longitude),
                      draggable: false,
                    ),
                  );
                  /*
                  globalController!.addSymbol(
                    (SymbolOptions(
                      geometry: LatLng(coordinates.lat, coordinates.lng),
                      iconImage: "assets\\images\\location_pin.png",
                      iconSize: 30,
                    )),
                  );*/
                }
                /*

                staticImage.getStaticUrlWithMarker(
                  center: coordinates,
                  marker: MapBoxMarker(
                      markerColor:
                          Color.rgb(0, 0, 0) as RgbColor, //Color.rgb(0, 0, 0),
                      markerLetter: 'h',
                      markerSize: MarkerSize.LARGE),
                  height: 300,
                  width: 600,
                  zoomLevel: 16,
                  render2x: true,
                );
                staticImage == null ? print('error!') : print('yes');
              */
              },
            );
          }
        },
      ),
    );
  }
}
