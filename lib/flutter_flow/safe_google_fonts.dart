import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// Access internals to override the asset manifest lookup safely.
// ignore: implementation_imports
import 'package:google_fonts/src/asset_manifest.dart' as gf_asset_manifest;
// ignore: implementation_imports
import 'package:google_fonts/src/google_fonts_base.dart' as gf_base;

/// Configure google_fonts to fail softly when AssetManifest.json
/// cannot be loaded (e.g. on some release builds) so the app won't crash.
void installGoogleFontsSafeguard() {
  GoogleFonts.config.allowRuntimeFetching = true;
  gf_base.assetManifest = _SafeAssetManifest();
}

/// SafeGoogleFonts - Crash-proof Google Fonts wrapper
///
/// Prevents AssetManifest.json crashes by providing fallbacks
/// when Google Fonts fail to load.
class SafeGoogleFonts {
  /// Get Inter font safely with fallback
  static TextStyle inter({
    FontWeight? fontWeight,
    FontStyle? fontStyle,
  }) {
    try {
      return GoogleFonts.inter(
        fontWeight: fontWeight,
        fontStyle: fontStyle,
      );
    } catch (e) {
      debugPrint('⚠️ GoogleFonts.inter failed, using fallback: $e');
      return TextStyle(
        fontFamily: '.SF Pro Text', // iOS system font
        fontWeight: fontWeight,
        fontStyle: fontStyle,
      );
    }
  }

  /// Get InterTight font safely with fallback
  static TextStyle interTight({
    FontWeight? fontWeight,
    FontStyle? fontStyle,
  }) {
    try {
      return GoogleFonts.interTight(
        fontWeight: fontWeight,
        fontStyle: fontStyle,
      );
    } catch (e) {
      debugPrint('⚠️ GoogleFonts.interTight failed, using fallback: $e');
      return TextStyle(
        fontFamily: '.SF Pro Text',
        fontWeight: fontWeight,
        fontStyle: fontStyle,
      );
    }
  }

  /// Get RobotoFlex font safely with fallback
  static TextStyle robotoFlex({
    FontWeight? fontWeight,
    FontStyle? fontStyle,
  }) {
    try {
      return GoogleFonts.robotoFlex(
        fontWeight: fontWeight,
        fontStyle: fontStyle,
      );
    } catch (e) {
      debugPrint('⚠️ GoogleFonts.robotoFlex failed, using fallback: $e');
      return TextStyle(
        fontFamily: 'Roboto',
        fontWeight: fontWeight,
        fontStyle: fontStyle,
      );
    }
  }

  /// Generic safe font getter with fallback
  static TextStyle getFont(
    String fontFamily, {
    FontWeight? fontWeight,
    FontStyle? fontStyle,
  }) {
    try {
      return GoogleFonts.getFont(
        fontFamily,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
      );
    } catch (e) {
      debugPrint('⚠️ GoogleFonts.$fontFamily failed, using system font: $e');
      return TextStyle(
        fontWeight: fontWeight,
        fontStyle: fontStyle,
      );
    }
  }
}

class _SafeAssetManifest extends gf_asset_manifest.AssetManifest {
  _SafeAssetManifest() : super(enableCache: true);

  @override
  Future<Map<String, List<String>>?>? json() async {
    try {
      return await super.json();
    } catch (e) {
      debugPrint('⚠️ AssetManifest.json missing, GoogleFonts will fetch remotely: $e');
      return Future.value(<String, List<String>>{});
    }
  }
}
