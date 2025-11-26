import 'dart:io';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'analytics_constants.dart';

/// AppAnalytics - Professional Analytics Wrapper
///
/// A singleton class that provides a centralized, type-safe interface
/// for logging analytics events throughout the application.
///
/// Features:
/// - Singleton pattern for consistent state
/// - Automatic metadata enrichment (timestamp, platform, version)
/// - Firebase Analytics integration
/// - Crashlytics integration for error tracking
/// - Null-safe parameter handling
/// - Debug logging support
class AppAnalytics {
  static final AppAnalytics _instance = AppAnalytics._internal();
  
  factory AppAnalytics() => _instance;
  
  AppAnalytics._internal();

  FirebaseAnalytics? _analytics;
  FirebaseCrashlytics? _crashlytics;
  PackageInfo? _packageInfo;
  bool _isInitialized = false;

  /// Initialize the analytics service
  /// 
  /// This must be called after Firebase.initializeApp() in main.dart
  Future<void> init() async {
    if (_isInitialized) {
      debugPrint('AppAnalytics: Already initialized');
      return;
    }

    try {
      _analytics = FirebaseAnalytics.instance;
      _crashlytics = FirebaseCrashlytics.instance;
      
      // Get package info for versioning
      try {
        _packageInfo = await PackageInfo.fromPlatform();
      } catch (e) {
        debugPrint('AppAnalytics: Could not load package info: $e');
        // Continue without package info
      }

      // Enable analytics collection
      await _analytics?.setAnalyticsCollectionEnabled(true);

      // Configure Crashlytics
      FlutterError.onError = (errorDetails) {
        _crashlytics?.recordFlutterFatalError(errorDetails);
      };

      // Pass all uncaught asynchronous errors to Crashlytics
      PlatformDispatcher.instance.onError = (error, stack) {
        _crashlytics?.recordError(error, stack, fatal: true);
        return true;
      };

      _isInitialized = true;
      debugPrint('AppAnalytics: Successfully initialized');
      
      // Log initialization event
      await logEvent('app_analytics_initialized', params: {
        AnalyticsParams.platform: _getPlatform(),
        AnalyticsParams.appVersion: _packageInfo?.version ?? 'unknown',
        AnalyticsParams.buildNumber: _packageInfo?.buildNumber ?? 'unknown',
      });
    } catch (e) {
      debugPrint('AppAnalytics: Initialization error: $e');
      // Don't throw - allow app to continue without analytics
    }
  }

  /// Check if analytics is initialized
  bool get isInitialized => _isInitialized;

  /// Log a custom analytics event
  ///
  /// [name] - Event name (use constants from AnalyticsEvents)
  /// [params] - Optional event parameters (max 25 params, max 100 chars per key)
  Future<void> logEvent(
    String name, {
    Map<String, dynamic>? params,
  }) async {
    if (!_isInitialized) {
      debugPrint('AppAnalytics: Not initialized, skipping event: $name');
      return;
    }

    try {
      // Enrich params with automatic metadata
      final enrichedParams = _enrichParams(params);
      
      // Sanitize params for Firebase (convert to proper types)
      final sanitizedParams = _sanitizeParams(enrichedParams);

      // Log to Firebase Analytics
      await _analytics?.logEvent(
        name: name,
        parameters: sanitizedParams,
      );

      if (kDebugMode) {
        debugPrint('📊 Analytics Event: $name');
        debugPrint('   Params: $sanitizedParams');
      }
    } catch (e) {
      debugPrint('AppAnalytics: Error logging event $name: $e');
      // Don't throw - analytics failures shouldn't crash the app
    }
  }

  /// Log a screen view event
  ///
  /// [screenName] - Name of the screen being viewed
  /// [screenClass] - Optional class name of the screen widget
  Future<void> logScreen(
    String screenName, {
    String? screenClass,
  }) async {
    if (!_isInitialized) {
      debugPrint('AppAnalytics: Not initialized, skipping screen: $screenName');
      return;
    }

    try {
      await _analytics?.logScreenView(
        screenName: screenName,
        screenClass: screenClass ?? screenName,
      );

      if (kDebugMode) {
        debugPrint('📱 Screen View: $screenName (${screenClass ?? "N/A"})');
      }
    } catch (e) {
      debugPrint('AppAnalytics: Error logging screen $screenName: $e');
    }
  }

  /// Set the current user ID
  ///
  /// [userId] - Unique identifier for the user
  Future<void> setUserId(String? userId) async {
    if (!_isInitialized) return;

    try {
      await _analytics?.setUserId(id: userId);
      await _crashlytics?.setUserIdentifier(userId ?? '');
      
      if (kDebugMode) {
        debugPrint('👤 User ID Set: $userId');
      }
    } catch (e) {
      debugPrint('AppAnalytics: Error setting user ID: $e');
    }
  }

  /// Set user properties
  ///
  /// [properties] - Map of user property key-value pairs
  Future<void> setUserProperties(Map<String, String?> properties) async {
    if (!_isInitialized) return;

    try {
      for (final entry in properties.entries) {
        await _analytics?.setUserProperty(
          name: entry.key,
          value: entry.value,
        );
      }

      if (kDebugMode) {
        debugPrint('👤 User Properties Set: $properties');
      }
    } catch (e) {
      debugPrint('AppAnalytics: Error setting user properties: $e');
    }
  }

  /// Log an error to Crashlytics
  ///
  /// [error] - The error object
  /// [stackTrace] - Optional stack trace
  /// [reason] - Optional description of the error
  /// [fatal] - Whether this is a fatal error
  Future<void> logError(
    dynamic error, {
    StackTrace? stackTrace,
    String? reason,
    bool fatal = false,
  }) async {
    if (!_isInitialized) return;

    try {
      await _crashlytics?.recordError(
        error,
        stackTrace,
        reason: reason,
        fatal: fatal,
      );

      if (kDebugMode) {
        debugPrint('❌ Error Logged: $error');
        if (reason != null) debugPrint('   Reason: $reason');
      }
    } catch (e) {
      debugPrint('AppAnalytics: Error logging error: $e');
    }
  }

  /// Log a message to Crashlytics
  ///
  /// Useful for adding breadcrumbs to error reports
  Future<void> logMessage(String message) async {
    if (!_isInitialized) return;

    try {
      await _crashlytics?.log(message);
    } catch (e) {
      debugPrint('AppAnalytics: Error logging message: $e');
    }
  }

  /// Set custom key-value pairs for Crashlytics
  Future<void> setCustomKey(String key, dynamic value) async {
    if (!_isInitialized) return;

    try {
      await _crashlytics?.setCustomKey(key, value);
    } catch (e) {
      debugPrint('AppAnalytics: Error setting custom key: $e');
    }
  }

  // Private helper methods

  /// Enrich parameters with automatic metadata
  Map<String, dynamic> _enrichParams(Map<String, dynamic>? params) {
    final enriched = Map<String, dynamic>.from(params ?? {});
    
    // Add timestamp
    enriched[AnalyticsParams.timestamp] = DateTime.now().toIso8601String();
    
    // Add platform
    enriched[AnalyticsParams.platform] = _getPlatform();
    
    // Add version info if available
    if (_packageInfo != null) {
      enriched[AnalyticsParams.appVersion] = _packageInfo!.version;
      enriched[AnalyticsParams.buildNumber] = _packageInfo!.buildNumber;
    }
    
    return enriched;
  }

  /// Sanitize parameters for Firebase Analytics
  /// 
  /// Firebase has strict requirements:
  /// - Max 25 parameters per event
  /// - Parameter names max 40 characters
  /// - String parameter values max 100 characters
  /// - Supports: String, int, double, bool
  Map<String, Object> _sanitizeParams(Map<String, dynamic> params) {
    final sanitized = <String, Object>{};
    
    int count = 0;
    for (final entry in params.entries) {
      if (count >= 25) break; // Firebase limit
      
      final key = entry.key.length > 40 
          ? entry.key.substring(0, 40) 
          : entry.key;
      
      final value = entry.value;
      
      // Convert to Firebase-compatible types
      if (value == null) {
        sanitized[key] = 'null';
      } else if (value is String) {
        sanitized[key] = value.length > 100 
            ? value.substring(0, 100) 
            : value;
      } else if (value is int || value is double || value is bool) {
        sanitized[key] = value;
      } else {
        // Convert other types to string
        final stringValue = value.toString();
        sanitized[key] = stringValue.length > 100 
            ? stringValue.substring(0, 100) 
            : stringValue;
      }
      
      count++;
    }
    
    return sanitized;
  }

  /// Get the current platform name
  String _getPlatform() {
    if (kIsWeb) return 'web';
    if (Platform.isIOS) return 'ios';
    if (Platform.isAndroid) return 'android';
    if (Platform.isMacOS) return 'macos';
    if (Platform.isWindows) return 'windows';
    if (Platform.isLinux) return 'linux';
    return 'unknown';
  }

  /// Get Firebase Analytics instance (for advanced usage)
  FirebaseAnalytics? get analytics => _analytics;

  /// Get Firebase Crashlytics instance (for advanced usage)
  FirebaseCrashlytics? get crashlytics => _crashlytics;
}

