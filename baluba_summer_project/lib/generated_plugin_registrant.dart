//
// Generated file. Do not edit.
//

// ignore_for_file: lines_longer_than_80_chars

import 'package:geolocator_web/geolocator_web.dart';
import 'package:image_picker_for_web/image_picker_for_web.dart';
import 'package:location_web/location_web.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:mapbox_gl_web/mapbox_gl_web.dart';

import 'package:flutter_web_plugins/flutter_web_plugins.dart';

// ignore: public_member_api_docs
void registerPlugins(Registrar registrar) {
  GeolocatorPlugin.registerWith(registrar);
  ImagePickerPlugin.registerWith(registrar);
  LocationWebPlugin.registerWith(registrar);
  MapboxMapPlugin.registerWith(registrar);
  registrar.registerMessageHandler();
}