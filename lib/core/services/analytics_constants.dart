/// Analytics Event Constants
/// 
/// This file contains all analytics event names and parameter keys
/// to ensure consistency across the application.
class AnalyticsEvents {
  // Screen Events
  static const String screenHomeOpened = 'screen_home_opened';
  static const String screenSplashOpened = 'screen_splash_opened';
  static const String screenSignInOpened = 'screen_sign_in_opened';
  static const String screenSignUpOpened = 'screen_sign_up_opened';
  static const String screenMyOrdersOpened = 'screen_my_orders_opened';
  static const String screenCategoriesOpened = 'screen_categories_opened';
  static const String screenClearanceOpened = 'screen_clearance_opened';
  static const String screenProductDetailOpened = 'screen_product_detail_opened';
  static const String screenProductMoreDetailOpened = 'screen_product_more_detail_opened';
  static const String screenFilterProductOpened = 'screen_filter_product_opened';
  static const String screenCartOpened = 'screen_cart_opened';
  static const String screenAddAddressOpened = 'screen_add_address_opened';
  static const String screenContactUsOpened = 'screen_contact_us_opened';
  static const String screenCreditCardOpened = 'screen_credit_card_opened';
  static const String screenNotificationOpened = 'screen_notification_opened';
  static const String screenMoreOpened = 'screen_more_opened';
  static const String screenProfileOpened = 'screen_profile_opened';
  static const String screenSettingsOpened = 'screen_settings_opened';
  static const String screenChangePasswordOpened = 'screen_change_password_opened';
  static const String screenOrderDetailOpened = 'screen_order_detail_opened';
  static const String screenFavProductsOpened = 'screen_fav_products_opened';
  static const String screenWebViewOpened = 'screen_web_view_opened';

  // Action Events
  static const String actionSignInTapped = 'action_sign_in_tapped';
  static const String actionSignUpTapped = 'action_sign_up_tapped';
  static const String actionSignOutTapped = 'action_sign_out_tapped';
  static const String actionAddToCartTapped = 'action_add_to_cart_tapped';
  static const String actionRemoveFromCartTapped = 'action_remove_from_cart_tapped';
  static const String actionCheckoutTapped = 'action_checkout_tapped';
  static const String actionProductTapped = 'action_product_tapped';
  static const String actionCategoryTapped = 'action_category_tapped';
  static const String actionFilterTapped = 'action_filter_tapped';
  static const String actionSearchTapped = 'action_search_tapped';
  static const String actionFavoriteTapped = 'action_favorite_tapped';
  static const String actionShareTapped = 'action_share_tapped';
  static const String actionProfileEditTapped = 'action_profile_edit_tapped';
  static const String actionPasswordChangeTapped = 'action_password_change_tapped';
  static const String actionAddressAddTapped = 'action_address_add_tapped';
  static const String actionAddressEditTapped = 'action_address_edit_tapped';
  static const String actionCreditCardAddTapped = 'action_credit_card_add_tapped';
  static const String actionOrderDetailTapped = 'action_order_detail_tapped';
  static const String actionContactUsTapped = 'action_contact_us_tapped';
  static const String actionNotificationTapped = 'action_notification_tapped';

  // Flow Events
  static const String flowLoginStarted = 'flow_login_started';
  static const String flowLoginCompleted = 'flow_login_completed';
  static const String flowLoginFailed = 'flow_login_failed';
  static const String flowSignUpStarted = 'flow_sign_up_started';
  static const String flowSignUpCompleted = 'flow_sign_up_completed';
  static const String flowSignUpFailed = 'flow_sign_up_failed';
  static const String flowCheckoutStarted = 'flow_checkout_started';
  static const String flowCheckoutCompleted = 'flow_checkout_completed';
  static const String flowCheckoutFailed = 'flow_checkout_failed';
  static const String flowPasswordChangeStarted = 'flow_password_change_started';
  static const String flowPasswordChangeCompleted = 'flow_password_change_completed';
  static const String flowPasswordChangeFailed = 'flow_password_change_failed';
  static const String flowAddAddressStarted = 'flow_add_address_started';
  static const String flowAddAddressCompleted = 'flow_add_address_completed';
  static const String flowAddAddressFailed = 'flow_add_address_failed';

  // API Events
  static const String apiCallStarted = 'api_call_started';
  static const String apiCallCompleted = 'api_call_completed';
  static const String apiCallFailed = 'api_call_failed';

  // E-commerce Events
  static const String ecommerceViewItem = 'view_item';
  static const String ecommerceAddToCart = 'add_to_cart';
  static const String ecommerceRemoveFromCart = 'remove_from_cart';
  static const String ecommerceBeginCheckout = 'begin_checkout';
  static const String ecommercePurchase = 'purchase';
  static const String ecommerceViewItemList = 'view_item_list';
  static const String ecommerceSelectContent = 'select_content';

  // Error Events
  static const String errorOccurred = 'error_occurred';
  static const String errorNetwork = 'error_network';
  static const String errorAuth = 'error_auth';
  static const String errorPayment = 'error_payment';
}

/// Analytics Parameter Keys
class AnalyticsParams {
  static const String screenName = 'screen_name';
  static const String screenClass = 'screen_class';
  static const String actionName = 'action_name';
  static const String flowName = 'flow_name';
  static const String success = 'success';
  static const String errorMessage = 'error_message';
  static const String errorCode = 'error_code';
  static const String duration = 'duration';
  static const String timestamp = 'timestamp';
  static const String platform = 'platform';
  static const String appVersion = 'app_version';
  static const String buildNumber = 'build_number';
  
  // E-commerce params
  static const String itemId = 'item_id';
  static const String itemName = 'item_name';
  static const String itemCategory = 'item_category';
  static const String itemPrice = 'price';
  static const String currency = 'currency';
  static const String quantity = 'quantity';
  static const String value = 'value';
  static const String transactionId = 'transaction_id';
  
  // API params
  static const String endpoint = 'endpoint';
  static const String method = 'method';
  static const String statusCode = 'status_code';
  static const String responseTime = 'response_time';
  
  // User params
  static const String userId = 'user_id';
  static const String userEmail = 'user_email';
  static const String userName = 'user_name';
}

/// User Property Keys
class UserProperties {
  static const String userId = 'user_id';
  static const String userType = 'user_type';
  static const String signUpDate = 'sign_up_date';
  static const String lastLoginDate = 'last_login_date';
  static const String totalOrders = 'total_orders';
  static const String preferredLanguage = 'preferred_language';
  static const String isVip = 'is_vip';
}

