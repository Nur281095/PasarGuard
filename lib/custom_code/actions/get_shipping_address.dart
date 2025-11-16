// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<dynamic> getShippingAddress(List<dynamic> addresses) async {
  try {
    if (addresses.isEmpty) {
      return null;
    }

    for (var address in addresses) {
      if (address is Map<String, dynamic> && address['type'] == 'shipping') {
        return address;
      }
    }

    return null;
  } catch (e) {
    return null;
  }
}
