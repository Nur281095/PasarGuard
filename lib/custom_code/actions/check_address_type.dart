// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

/// Checks a list of address maps and returns:
/// - "both"           if there are billing & shipping entries
/// - "billing_only"   if only billing entries exist
/// - "shipping_only"  if only shipping entries exist
/// - "none"           if neither type is present
Future<String> checkAddressType(List<dynamic> addresses) async {
  bool hasBilling = false;
  bool hasShipping = false;

  for (var addr in addresses) {
    final type = (addr['type'] as String?)?.toLowerCase();
    if (type == 'billing') {
      hasBilling = true;
    } else if (type == 'shipping') {
      hasShipping = true;
    }
    // early exit if we already know it's "both"
    if (hasBilling && hasShipping) break;
  }

  if (hasBilling && hasShipping) {
    return 'both';
  } else if (hasBilling) {
    return 'billing_only';
  } else if (hasShipping) {
    return 'shipping_only';
  } else {
    return 'none';
  }
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
