// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<int?> findIDofJson(
  String name,
  List<dynamic> jsonList,
) async {
  // json array each object has name of type string and id of tye int keys . find object where passed param name is equal to json object name then return that object's id
  for (var item in jsonList) {
    if (item['name'] == name) {
      return item['id'];
    }
  }
  return null; // Return null if not found}
}
