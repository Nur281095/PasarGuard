import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';

class FirebaseAnalyticsService {
  FirebaseAnalyticsService._();

  static final FirebaseAnalyticsService instance =
      FirebaseAnalyticsService._();

  FirebaseAnalytics? _analytics;
  FirebaseAnalyticsObserver? _observer;

  bool get isInitialized => _analytics != null;

  FirebaseAnalyticsObserver? get observer => _observer;

  Future<void> initialize() async {
    if (_analytics != null) {
      return;
    }

    try {
      _analytics = FirebaseAnalytics.instance;
      _observer = FirebaseAnalyticsObserver(analytics: _analytics!);
    } catch (error, stackTrace) {
      debugPrint('FirebaseAnalytics initialization failed: $error');
      debugPrintStack(stackTrace: stackTrace);
    }
  }

  Future<void> logScreenView({
    required String screenName,
    String? screenClass,
    Map<String, Object?>? parameters,
  }) async {
    if (_analytics == null) {
      return;
    }

    await _analytics!.logScreenView(
      screenName: screenName,
      screenClass: screenClass,
      parameters: _sanitizeParameters(parameters),
    );
  }

  Future<void> logEvent(
    String name, {
    Map<String, Object?>? parameters,
  }) async {
    if (_analytics == null) {
      return;
    }

    await _analytics!.logEvent(
      name: name,
      parameters: _sanitizeParameters(parameters),
    );
  }

  Future<void> setUserId(String? userId) async {
    if (_analytics == null) {
      return;
    }

    await _analytics!.setUserId(id: userId);
  }

  Future<void> setUserProperty({
    required String name,
    String? value,
  }) async {
    if (_analytics == null) {
      return;
    }

    await _analytics!.setUserProperty(name: name, value: value);
  }

  Future<void> logRouteChange({
    required String routePath,
    required List<String> routeStack,
  }) async {
    await logScreenView(
      screenName: routePath,
      parameters: {
        'route_stack': routeStack.join(' > '),
      },
    );
  }

  Map<String, Object?>? _sanitizeParameters(
    Map<String, Object?>? parameters,
  ) {
    if (parameters == null) {
      return null;
    }

    final sanitized = <String, Object?>{};
    parameters.forEach((key, value) {
      sanitized[key] = _sanitizeValue(value);
    });
    return sanitized;
  }

  Object? _sanitizeValue(Object? value) {
    if (value == null ||
        value is num ||
        value is String ||
        value is bool) {
      return value;
    }

    if (value is DateTime) {
      return value.toIso8601String();
    }

    if (value is Enum) {
      return value.name;
    }

    return value.toString();
  }
}
