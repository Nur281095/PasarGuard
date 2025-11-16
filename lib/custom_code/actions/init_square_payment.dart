// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:square_in_app_payments/in_app_payments.dart';

Future<void> initSquarePayment() async {
  await InAppPayments.setSquareApplicationId('YOUR_SQUARE_APPLICATION_ID');
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
