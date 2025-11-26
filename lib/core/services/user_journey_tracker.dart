import 'package:flutter/foundation.dart';
import 'app_analytics.dart';
import 'analytics_constants.dart';

/// UserJourneyTracker
///
/// Provides a high-level API for tracking user journeys and actions
/// throughout the application. This class wraps AppAnalytics with
/// convenient methods for common tracking scenarios.
///
/// Features:
/// - Consistent naming conventions for events
/// - Automatic event categorization (screen/action/flow)
/// - Flow state management (start/end tracking)
/// - Simplified API for common scenarios
class UserJourneyTracker {
  static final AppAnalytics _analytics = AppAnalytics();
  static final Map<String, DateTime> _flowStartTimes = {};

  /// Track a screen visit
  ///
  /// [screenName] - The name of the screen (e.g., "Home", "SignIn", "ProductDetail")
  /// [screenClass] - Optional widget class name
  /// [additionalParams] - Optional additional parameters
  static Future<void> trackScreenVisit(
    String screenName, {
    String? screenClass,
    Map<String, dynamic>? additionalParams,
  }) async {
    final eventName = 'screen_${_toSnakeCase(screenName)}_opened';
    
    final params = <String, dynamic>{
      AnalyticsParams.screenName: screenName,
      if (screenClass != null) AnalyticsParams.screenClass: screenClass,
      ...?additionalParams,
    };

    await _analytics.logScreen(screenName, screenClass: screenClass);
    await _analytics.logEvent(eventName, params: params);

    if (kDebugMode) {
      debugPrint('🚀 Journey: Screen Visit -> $screenName');
    }
  }

  /// Track a user action
  ///
  /// [actionName] - The name of the action (e.g., "SignIn", "AddToCart", "ProfileEdit")
  /// [details] - Optional details about the action
  static Future<void> trackAction(
    String actionName, {
    Map<String, dynamic>? details,
  }) async {
    final eventName = 'action_${_toSnakeCase(actionName)}_tapped';
    
    final params = <String, dynamic>{
      AnalyticsParams.actionName: actionName,
      ...?details,
    };

    await _analytics.logEvent(eventName, params: params);

    if (kDebugMode) {
      debugPrint('👆 Journey: Action -> $actionName');
    }
  }

  /// Track the start of a flow
  ///
  /// [flowName] - The name of the flow (e.g., "Login", "Checkout", "SignUp")
  /// [details] - Optional details about the flow
  static Future<void> trackFlowStart(
    String flowName, {
    Map<String, dynamic>? details,
  }) async {
    final eventName = 'flow_${_toSnakeCase(flowName)}_started';
    
    // Store start time for duration calculation
    _flowStartTimes[flowName] = DateTime.now();
    
    final params = <String, dynamic>{
      AnalyticsParams.flowName: flowName,
      ...?details,
    };

    await _analytics.logEvent(eventName, params: params);
    await _analytics.logMessage('Flow Started: $flowName');

    if (kDebugMode) {
      debugPrint('🎬 Journey: Flow Started -> $flowName');
    }
  }

  /// Track the end of a flow
  ///
  /// [flowName] - The name of the flow (must match trackFlowStart)
  /// [success] - Whether the flow completed successfully
  /// [details] - Optional details about the flow completion
  static Future<void> trackFlowEnd(
    String flowName, {
    bool success = true,
    Map<String, dynamic>? details,
  }) async {
    final eventName = success
        ? 'flow_${_toSnakeCase(flowName)}_completed'
        : 'flow_${_toSnakeCase(flowName)}_failed';
    
    final params = <String, dynamic>{
      AnalyticsParams.flowName: flowName,
      AnalyticsParams.success: success,
      ...?details,
    };

    // Calculate duration if flow was started
    if (_flowStartTimes.containsKey(flowName)) {
      final startTime = _flowStartTimes[flowName]!;
      final duration = DateTime.now().difference(startTime).inMilliseconds;
      params[AnalyticsParams.duration] = duration;
      _flowStartTimes.remove(flowName);
    }

    await _analytics.logEvent(eventName, params: params);
    await _analytics.logMessage('Flow ${success ? "Completed" : "Failed"}: $flowName');

    if (kDebugMode) {
      debugPrint('🏁 Journey: Flow ${success ? "Completed" : "Failed"} -> $flowName');
    }
  }

  /// Track an e-commerce product view
  ///
  /// [productId] - Unique product identifier
  /// [productName] - Product name
  /// [category] - Product category
  /// [price] - Product price
  static Future<void> trackProductView({
    required String productId,
    required String productName,
    String? category,
    double? price,
    Map<String, dynamic>? additionalParams,
  }) async {
    final params = <String, dynamic>{
      AnalyticsParams.itemId: productId,
      AnalyticsParams.itemName: productName,
      if (category != null) AnalyticsParams.itemCategory: category,
      if (price != null) AnalyticsParams.itemPrice: price,
      AnalyticsParams.currency: 'USD',
      ...?additionalParams,
    };

    await _analytics.logEvent(AnalyticsEvents.ecommerceViewItem, params: params);

    if (kDebugMode) {
      debugPrint('🛍️ Journey: Product View -> $productName ($productId)');
    }
  }

  /// Track adding a product to cart
  ///
  /// [productId] - Unique product identifier
  /// [productName] - Product name
  /// [quantity] - Quantity added
  /// [price] - Product price
  static Future<void> trackAddToCart({
    required String productId,
    required String productName,
    int quantity = 1,
    double? price,
    Map<String, dynamic>? additionalParams,
  }) async {
    final params = <String, dynamic>{
      AnalyticsParams.itemId: productId,
      AnalyticsParams.itemName: productName,
      AnalyticsParams.quantity: quantity,
      if (price != null) AnalyticsParams.itemPrice: price,
      if (price != null) AnalyticsParams.value: price * quantity,
      AnalyticsParams.currency: 'USD',
      ...?additionalParams,
    };

    await _analytics.logEvent(AnalyticsEvents.ecommerceAddToCart, params: params);

    if (kDebugMode) {
      debugPrint('🛒 Journey: Add to Cart -> $productName x$quantity');
    }
  }

  /// Track removing a product from cart
  ///
  /// [productId] - Unique product identifier
  /// [productName] - Product name
  /// [quantity] - Quantity removed
  static Future<void> trackRemoveFromCart({
    required String productId,
    required String productName,
    int quantity = 1,
    Map<String, dynamic>? additionalParams,
  }) async {
    final params = <String, dynamic>{
      AnalyticsParams.itemId: productId,
      AnalyticsParams.itemName: productName,
      AnalyticsParams.quantity: quantity,
      ...?additionalParams,
    };

    await _analytics.logEvent(AnalyticsEvents.ecommerceRemoveFromCart, params: params);

    if (kDebugMode) {
      debugPrint('🗑️ Journey: Remove from Cart -> $productName x$quantity');
    }
  }

  /// Track beginning checkout process
  ///
  /// [value] - Total cart value
  /// [items] - Number of items in cart
  static Future<void> trackBeginCheckout({
    required double value,
    int? items,
    Map<String, dynamic>? additionalParams,
  }) async {
    final params = <String, dynamic>{
      AnalyticsParams.value: value,
      AnalyticsParams.currency: 'USD',
      if (items != null) AnalyticsParams.quantity: items,
      ...?additionalParams,
    };

    await _analytics.logEvent(AnalyticsEvents.ecommerceBeginCheckout, params: params);

    if (kDebugMode) {
      debugPrint('💳 Journey: Begin Checkout -> \$${value.toStringAsFixed(2)}');
    }
  }

  /// Track a completed purchase
  ///
  /// [transactionId] - Unique transaction ID
  /// [value] - Total purchase value
  /// [items] - Number of items purchased
  static Future<void> trackPurchase({
    required String transactionId,
    required double value,
    int? items,
    Map<String, dynamic>? additionalParams,
  }) async {
    final params = <String, dynamic>{
      AnalyticsParams.transactionId: transactionId,
      AnalyticsParams.value: value,
      AnalyticsParams.currency: 'USD',
      if (items != null) AnalyticsParams.quantity: items,
      ...?additionalParams,
    };

    await _analytics.logEvent(AnalyticsEvents.ecommercePurchase, params: params);

    if (kDebugMode) {
      debugPrint('✅ Journey: Purchase -> $transactionId (\$${value.toStringAsFixed(2)})');
    }
  }

  /// Track an API call
  ///
  /// [endpoint] - API endpoint
  /// [method] - HTTP method
  /// [success] - Whether the call succeeded
  /// [statusCode] - HTTP status code
  /// [responseTime] - Response time in milliseconds
  static Future<void> trackApiCall({
    required String endpoint,
    required String method,
    required bool success,
    int? statusCode,
    int? responseTime,
    String? errorMessage,
  }) async {
    final eventName = success 
        ? AnalyticsEvents.apiCallCompleted 
        : AnalyticsEvents.apiCallFailed;
    
    final params = <String, dynamic>{
      AnalyticsParams.endpoint: endpoint,
      AnalyticsParams.method: method,
      AnalyticsParams.success: success,
      if (statusCode != null) AnalyticsParams.statusCode: statusCode,
      if (responseTime != null) AnalyticsParams.responseTime: responseTime,
      if (errorMessage != null) AnalyticsParams.errorMessage: errorMessage,
    };

    await _analytics.logEvent(eventName, params: params);

    if (!success && errorMessage != null) {
      await _analytics.logMessage('API Error: $method $endpoint - $errorMessage');
    }

    if (kDebugMode) {
      final statusEmoji = success ? '✅' : '❌';
      debugPrint('$statusEmoji Journey: API Call -> $method $endpoint ${statusCode ?? ""}');
    }
  }

  /// Track an error
  ///
  /// [error] - The error object or message
  /// [stackTrace] - Optional stack trace
  /// [context] - Additional context about where the error occurred
  static Future<void> trackError(
    dynamic error, {
    StackTrace? stackTrace,
    String? context,
    bool fatal = false,
  }) async {
    final params = <String, dynamic>{
      AnalyticsParams.errorMessage: error.toString(),
      if (context != null) 'context': context,
      'fatal': fatal,
    };

    await _analytics.logEvent(AnalyticsEvents.errorOccurred, params: params);
    await _analytics.logError(
      error,
      stackTrace: stackTrace,
      reason: context,
      fatal: fatal,
    );

    if (kDebugMode) {
      debugPrint('❌ Journey: Error -> $error ${context != null ? "($context)" : ""}');
    }
  }

  /// Set user ID for tracking
  ///
  /// [userId] - Unique user identifier
  static Future<void> setUserId(String? userId) async {
    await _analytics.setUserId(userId);

    if (kDebugMode) {
      debugPrint('👤 Journey: User ID Set -> $userId');
    }
  }

  /// Set user properties
  ///
  /// [properties] - Map of user properties
  static Future<void> setUserProperties(Map<String, String?> properties) async {
    await _analytics.setUserProperties(properties);

    if (kDebugMode) {
      debugPrint('👤 Journey: User Properties Set -> $properties');
    }
  }

  // Private helper methods

  /// Convert a string to snake_case
  static String _toSnakeCase(String input) {
    return input
        .replaceAllMapped(
          RegExp(r'[A-Z]'),
          (match) => '_${match.group(0)!.toLowerCase()}',
        )
        .replaceAll(RegExp(r'^_'), '')
        .replaceAll(RegExp(r'[^\w]+'), '_')
        .toLowerCase();
  }
}

