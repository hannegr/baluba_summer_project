import 'dart:convert';

import 'package:flutter/services.dart';

const String _CONFIG_FILE_PATH = 'assets/config.json';
Future<Map<String, dynamic>> loadConfigFile() async {
  String json = await rootBundle.loadString(_CONFIG_FILE_PATH);
  //This is like JSON.stringify() in JS, meaning it converts the value into a
  //JSON string.
  return jsonDecode(json)
      as Map<String, dynamic>; //Decode it back into a String.
}
