import 'dart:math';
import 'package:mapbox_search_flutter/mapbox_search_flutter.dart';

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

  var reverseGeoCoding = ReverseGeoCoding(
    apiKey: ApiKey,
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
              minMaxZoomPreference: MinMaxZoomPreference(5, 500),
              accessToken: snapshot.data!['mapbox_api_token'],
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
                if (animateCameraResult) {
                  print('works');
                  controller.addCircle(
                    CircleOptions(
                      circleRadius: 7,
                      circleColor: '#050ac9',
                      circleOpacity: 0.5,
                      circleStrokeColor: '#050a7f',
                      circleStrokeOpacity: 1,
                      circleStrokeWidth: 2,
                      geometry: LatLng(location!.latitude, location.longitude),
                    ),
                  );
                }
              },
              onMapClick: (Point<double> point, LatLng latLng) async {
                Location coordinates = new Location();
                coordinates.lat = latLng.latitude;
                coordinates.lng = latLng.longitude;
                var address = await reverseGeoCoding.getAddress(coordinates);
                print(latLng);
                print(address[0].toString());

                /*staticImage.getStaticUrlWithMarker(
                  center: coordinates,
                  marker: MapBoxMarker(
                      markerColor:  Color.rgb(0, 0, 0),
                      markerLetter: 'h',
                      markerSize: MarkerSize.LARGE),
                  height: 300,
                  width: 600,
                  zoomLevel: 16,
                  render2x: true,
                );
                staticImage == null ? print('error!') : print('yes');
              },*/
              },
            );
          }
        },
      ),
    );
  }
}
