import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/schema/structs/index.dart';
import '/auth/custom_auth/auth_util.dart';

Color hexOrRGBToColor(String hexString) {
  // convert hexString to Color and return  e.g #000000 as hexString and retun its black color
  // Remove the hash if it's there
  hexString = hexString.replaceFirst('#', '');

  // Parse the hex string
  int hexInt = int.parse(hexString, radix: 16);

  // Check if the hex string is 6 or 8 characters long
  if (hexString.length == 6) {
    return Color(hexInt | 0xFF000000); // Add alpha channel
  } else if (hexString.length == 8) {
    return Color(hexInt); // Already includes alpha channel
  } else {
    throw FormatException('Invalid hex color format');
  }
}

String? stringToDate(String? dateString) {
  // convert dateString to format  "29 May, 2021 | 10:30 am" and return as string
  if (dateString == null) return null;

  DateTime? dateTime = DateTime.tryParse(dateString);
  if (dateTime == null) return null;

  final DateFormat formatter = DateFormat("dd MMM, yyyy | hh:mm a");
  return formatter.format(dateTime);
}

int? toInt(String amount) {
  // take amount of type s tring as param and convert to Int and return
  // Trim, drop thousands separators
  final s = amount.trim().replaceAll(',', '');

  // Try integer first
  final asInt = int.tryParse(s);
  if (asInt != null) return asInt;

  // Fall back to double (handles "317.0", "317.9", etc.)
  final asDouble = double.tryParse(s);
  if (asDouble != null) return asDouble.toInt(); // truncates toward zero

  // Last resort: extract first numeric token from messy strings
  final m = RegExp(r'[-+]?\d+(?:\.\d+)?').firstMatch(s);
  if (m != null) {
    final d = double.tryParse(m.group(0)!);
    if (d != null) return d.toInt();
  }

  return null;
}
