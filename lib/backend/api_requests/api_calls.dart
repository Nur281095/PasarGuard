import 'dart:convert';
import 'dart:typed_data';
import '../schema/structs/index.dart';

import 'package:flutter/foundation.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

/// Start Pasargadrugs Group Code

class PasargadrugsGroup {
  static String getBaseUrl() => 'https://pasargad.com/api';
  // static String getBaseUrl() => 'https://184.72.83.156/api';
  static Map<String, String> headers = {};
  static LoginCall loginCall = LoginCall();
  static RegisterCall registerCall = RegisterCall();
  static HomeCall homeCall = HomeCall();
  static ProductsCall productsCall = ProductsCall();
  static ProductsCopyCall productsCopyCall = ProductsCopyCall();
  static ProductDetailCall productDetailCall = ProductDetailCall();
  static GetFavouritesCall getFavouritesCall = GetFavouritesCall();
  static GetCartCall getCartCall = GetCartCall();
  static UserAddressesCall userAddressesCall = UserAddressesCall();
  static OrderDetailCall orderDetailCall = OrderDetailCall();
  static UserPointsCall userPointsCall = UserPointsCall();
  static GetProfileCall getProfileCall = GetProfileCall();
  static CategoriesCall categoriesCall = CategoriesCall();
  static UserOrdersCall userOrdersCall = UserOrdersCall();
  static UpdateProfileCall updateProfileCall = UpdateProfileCall();
  static AddFavouritesCall addFavouritesCall = AddFavouritesCall();
  static WriteReviewCall writeReviewCall = WriteReviewCall();
  static DeleteAddressCall deleteAddressCall = DeleteAddressCall();
  static UpdateAddressCall updateAddressCall = UpdateAddressCall();
  static PostReviewCall postReviewCall = PostReviewCall();
  static AddCartCall addCartCall = AddCartCall();
  static UpdateCartCall updateCartCall = UpdateCartCall();
  static ClearCartCall clearCartCall = ClearCartCall();
  static RemoveCartCall removeCartCall = RemoveCartCall();
  static RemovePromoCall removePromoCall = RemovePromoCall();
  static CheckoutBillingCall checkoutBillingCall = CheckoutBillingCall();
  static CheckoutShippingCall checkoutShippingCall = CheckoutShippingCall();
  static PaymentStripeCall paymentStripeCall = PaymentStripeCall();
  static PaymentPaypalCall paymentPaypalCall = PaymentPaypalCall();
  static ApplyPromoCall applyPromoCall = ApplyPromoCall();
}

class LoginCall {
  Future<ApiCallResponse> call({
    String? email = '',
    String? password = '',
  }) async {
    final baseUrl = PasargadrugsGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "email": "${escapeStringForJson(email)}",
  "password": "${escapeStringForJson(password)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'login',
      apiUrl: '${baseUrl}/login',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  int? statusCode(dynamic response) => castToType<int>(getJsonField(
    response,
    r'''$.status''',
  ));
  String? message(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.message''',
  ));
  String? token(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.data.token''',
  ));
  int? userID(dynamic response) => castToType<int>(getJsonField(
    response,
    r'''$.data.user.id''',
  ));
  String? firstname(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.data.user.first_name''',
  ));
  String? lastname(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.data.user.last_name''',
  ));
  String? email(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.data.user.email''',
  ));
  int? status(dynamic response) => castToType<int>(getJsonField(
    response,
    r'''$.data.user.status''',
  ));
  String? fullname(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.data.user.full_name''',
  ));
  String? cartID(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.data.user.ios_cart_id''',
  ));
}

class RegisterCall {
  Future<ApiCallResponse> call({
    String? firstName = '',
    String? lastName = '',
    String? email = '',
    String? password = '',
    String? passwordConfirmation = '',
  }) async {
    final baseUrl = PasargadrugsGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "first_name": "${escapeStringForJson(firstName)}",
  "last_name": "${escapeStringForJson(lastName)}",
  "email": "${escapeStringForJson(email)}",
  "password": "${escapeStringForJson(password)}",
  "password_confirmation": "${escapeStringForJson(passwordConfirmation)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'register',
      apiUrl: '${baseUrl}/register',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  int? statusCode(dynamic response) => castToType<int>(getJsonField(
    response,
    r'''$.status''',
  ));
  String? message(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.message''',
  ));
  dynamic? user(dynamic response) => getJsonField(
    response,
    r'''$.data.user''',
  );
  String? firstname(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.data.user.first_name''',
  ));
  String? lastname(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.data.user.last_name''',
  ));
  String? email(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.data.user.email''',
  ));
  int? status(dynamic response) => castToType<int>(getJsonField(
    response,
    r'''$.data.user.status''',
  ));
  int? userID(dynamic response) => castToType<int>(getJsonField(
    response,
    r'''$.data.user.id''',
  ));
  String? fullname(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.data.user.full_name''',
  ));
  String? token(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.data.token''',
  ));
}

class HomeCall {
  Future<ApiCallResponse> call() async {
    final baseUrl = PasargadrugsGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'home',
      apiUrl: '${baseUrl}/home',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List? slider(dynamic response) => getJsonField(
    response,
    r'''$.data.slider''',
    true,
  ) as List?;
  List<String>? sliderImages(dynamic response) => (getJsonField(
    response,
    r'''$.data.slider[:].image''',
    true,
  ) as List?)
      ?.withoutNulls
      .map((x) => castToType<String>(x))
      .withoutNulls
      .toList();
  List? products(dynamic response) => getJsonField(
    response,
    r'''$.data.products''',
    true,
  ) as List?;
  List<FilterObjectStruct>? categories(dynamic response) => (getJsonField(
    response,
    r'''$.data.filters.cateogries''',
    true,
  ) as List?)
      ?.withoutNulls
      .map((x) => FilterObjectStruct.maybeFromMap(x))
      .withoutNulls
      .toList();
  List<FilterObjectStruct>? collections(dynamic response) => (getJsonField(
    response,
    r'''$.data.filters.collections''',
    true,
  ) as List?)
      ?.withoutNulls
      .map((x) => FilterObjectStruct.maybeFromMap(x))
      .withoutNulls
      .toList();
  List<FilterObjectStruct>? styles(dynamic response) => (getJsonField(
    response,
    r'''$.data.filters.styles''',
    true,
  ) as List?)
      ?.withoutNulls
      .map((x) => FilterObjectStruct.maybeFromMap(x))
      .withoutNulls
      .toList();
  List<FilterObjectStruct>? colors(dynamic response) => (getJsonField(
    response,
    r'''$.data.filters.colors''',
    true,
  ) as List?)
      ?.withoutNulls
      .map((x) => FilterObjectStruct.maybeFromMap(x))
      .withoutNulls
      .toList();
  List? materials(dynamic response) => getJsonField(
    response,
    r'''$.data.filters.materials''',
    true,
  ) as List?;
  List<FilterObjectStruct>? types(dynamic response) => (getJsonField(
    response,
    r'''$.data.filters.types''',
    true,
  ) as List?)
      ?.withoutNulls
      .map((x) => FilterObjectStruct.maybeFromMap(x))
      .withoutNulls
      .toList();
  dynamic? shapes(dynamic response) => getJsonField(
    response,
    r'''$.data.filters.shapes''',
  );
  dynamic? filters(dynamic response) => getJsonField(
    response,
    r'''$.data.filters''',
  );
}

class ProductsCall {
  Future<ApiCallResponse> call({
    String? token = 'C3VWCG9YDCS0QG5VYMXLBWV0CMLJLMNVBQ==-67EF326E89F57',
    int? categories,
    int? style,
    String? shape = '',
    int? collection,
    int? material,
    int? color,
    String? type = '',
    String? search = '',
  }) async {
    final baseUrl = PasargadrugsGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'products',
      apiUrl: '${baseUrl}/products',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${token}',
      },
      params: {
        'categories': categories,
        'style': style,
        'shape': shape,
        'collection': collection,
        'material': material,
        'color': color,
        'type': type,
        'search': search,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List? products(dynamic response) => getJsonField(
    response,
    r'''$.data.products''',
    true,
  ) as List?;
  String? message(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.message''',
  ));
  int? totalPages(dynamic response) => castToType<int>(getJsonField(
    response,
    r'''$.data.total_pages''',
  ));
  int? totalRecords(dynamic response) => castToType<int>(getJsonField(
    response,
    r'''$.data.total_records''',
  ));
  List? catData(dynamic response) => getJsonField(
    response,
    r'''$.data.categoryData''',
    true,
  ) as List?;
  List<int>? isFav(dynamic response) => (getJsonField(
    response,
    r'''$.data.products[:].is_favourite''',
    true,
  ) as List?)
      ?.withoutNulls
      .map((x) => castToType<int>(x))
      .withoutNulls
      .toList();
  List? isSale(dynamic response) => getJsonField(
    response,
    r'''$.data.products[:].is_sale''',
    true,
  ) as List?;
  List<int>? saleValue(dynamic response) => (getJsonField(
    response,
    r'''$.data.products[:].sale_value''',
    true,
  ) as List?)
      ?.withoutNulls
      .map((x) => castToType<int>(x))
      .withoutNulls
      .toList();
  List<int>? isSoldOut(dynamic response) => (getJsonField(
    response,
    r'''$.data.products[:].is_sold_out''',
    true,
  ) as List?)
      ?.withoutNulls
      .map((x) => castToType<int>(x))
      .withoutNulls
      .toList();
  List<String>? saleType(dynamic response) => (getJsonField(
    response,
    r'''$.data.products[:].sale_type''',
    true,
  ) as List?)
      ?.withoutNulls
      .map((x) => castToType<String>(x))
      .withoutNulls
      .toList();
}

class ProductsCopyCall {
  Future<ApiCallResponse> call({
    String? token = 'C3VWCG9YDCS0QG5VYMXLBWV0CMLJLMNVBQ==-67EF326E89F57',
    int? categories,
    int? style,
    String? shape = '',
    int? collection,
    int? material,
    int? color,
    String? type = '',
  }) async {
    final baseUrl = PasargadrugsGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'products Copy',
      apiUrl: '${baseUrl}/products',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${token}',
      },
      params: {
        'categories': categories,
        'style': style,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List? products(dynamic response) => getJsonField(
    response,
    r'''$.data.products''',
    true,
  ) as List?;
  String? message(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.message''',
  ));
  int? totalPages(dynamic response) => castToType<int>(getJsonField(
    response,
    r'''$.data.total_pages''',
  ));
  int? totalRecords(dynamic response) => castToType<int>(getJsonField(
    response,
    r'''$.data.total_records''',
  ));
  List? catData(dynamic response) => getJsonField(
    response,
    r'''$.data.categoryData''',
    true,
  ) as List?;
}

class ProductDetailCall {
  Future<ApiCallResponse> call({
    String? token = 'C3VWCG9YDCS0QG5VYMXLBWV0CMLJLMNVBQ==-67EF326E89F57',
    String? id = '820',
  }) async {
    final baseUrl = PasargadrugsGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'productDetail',
      apiUrl: '${baseUrl}/product/${id}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${token}',
      },
      params: {
        'id': id,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  dynamic? product(dynamic response) => getJsonField(
    response,
    r'''$.data.product''',
  );
  List? newArrivals(dynamic response) => getJsonField(
    response,
    r'''$.data.new_arrivals''',
    true,
  ) as List?;
  int? isFav(dynamic response) => castToType<int>(getJsonField(
    response,
    r'''$.data.favourite''',
  ));
  List? reviews(dynamic response) => getJsonField(
    response,
    r'''$.data.reviews''',
    true,
  ) as List?;
  int? avgRating(dynamic response) => castToType<int>(getJsonField(
    response,
    r'''$.data.average_rating''',
  ));
  List? relatedProds(dynamic response) => getJsonField(
    response,
    r'''$.data.related_products''',
    true,
  ) as List?;
  List? color(dynamic response) => getJsonField(
    response,
    r'''$.data.colors''',
    true,
  ) as List?;
  List? quantity(dynamic response) => getJsonField(
    response,
    r'''$.data.quantity''',
    true,
  ) as List?;
  String? message(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.message''',
  ));
  int? isSale(dynamic response) => castToType<int>(getJsonField(
    response,
    r'''$.data.product.is_sale''',
  ));
  int? saleValue(dynamic response) => castToType<int>(getJsonField(
    response,
    r'''$.data.product.sale_value''',
  ));
  int? isFavourite(dynamic response) => castToType<int>(getJsonField(
    response,
    r'''$.data.product.is_favourite''',
  ));
  int? isSoldOut(dynamic response) => castToType<int>(getJsonField(
    response,
    r'''$.data.product.is_sold_out''',
  ));
  int? salePrice(dynamic response) => castToType<int>(getJsonField(
    response,
    r'''$.data.product.sale_price''',
  ));
}

class GetFavouritesCall {
  Future<ApiCallResponse> call({
    String? token = 'C3VWCG9YDCS0QG5VYMXLBWV0CMLJLMNVBQ==-67EF326E89F57',
  }) async {
    final baseUrl = PasargadrugsGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'getFavourites',
      apiUrl: '${baseUrl}/user/get-favourites',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${token}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List? favs(dynamic response) => getJsonField(
    response,
    r'''$.data.favourites''',
    true,
  ) as List?;
}

class GetCartCall {
  Future<ApiCallResponse> call({
    String? token = 'C3VWCG9YDCS0QG5VYMXLBWV0CMLJLMNVBQ==-67EF326E89F57',
    String? cartId = '',
  }) async {
    final baseUrl = PasargadrugsGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'getCart',
      apiUrl: '${baseUrl}/cart/get',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${token}',
      },
      params: {
        'cart_id': cartId,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  String? message(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.message''',
  ));
  dynamic? data(dynamic response) => getJsonField(
    response,
    r'''$.data''',
  );
  dynamic? billingAddress(dynamic response) => getJsonField(
    response,
    r'''$.data.billing_address''',
  );
  dynamic? shippingAddress(dynamic response) => getJsonField(
    response,
    r'''$.data.shipping_address''',
  );
  double? cartTotal(dynamic response) => castToType<double>(getJsonField(
    response,
    r'''$.data.cart_total''',
  ));
  List? cartItems(dynamic response) => getJsonField(
    response,
    r'''$.data.cart_items''',
    true,
  ) as List?;
  List? promos(dynamic response) => getJsonField(
    response,
    r'''$.data.cart_promos''',
    true,
  ) as List?;
  int? discounts(dynamic response) => castToType<int>(getJsonField(
    response,
    r'''$.data.cart_discount''',
  ));
  double? shippingFee(dynamic response) => castToType<double>(getJsonField(
    response,
    r'''$.data.cart_shipping''',
  ));
  String? cartID(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.data.cart_id''',
  ));
}

class UserAddressesCall {
  Future<ApiCallResponse> call({
    String? token = '',
  }) async {
    final baseUrl = PasargadrugsGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'userAddresses',
      apiUrl: '${baseUrl}/user/addresses',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${token}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  String? message(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.message''',
  ));
  List? addresses(dynamic response) => getJsonField(
    response,
    r'''$.data.addresses''',
    true,
  ) as List?;
}

class OrderDetailCall {
  Future<ApiCallResponse> call({
    String? token = 'C3VWCG9YDCS0QG5VYMXLBWV0CMLJLMNVBQ==-67EF326E89F57',
    int? id,
  }) async {
    final baseUrl = PasargadrugsGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'orderDetail',
      apiUrl: '${baseUrl}/user/orders/${id}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${token}',
      },
      params: {
        'cart_id': id,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  String? message(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.message''',
  ));
  dynamic? data(dynamic response) => getJsonField(
    response,
    r'''$.data''',
  );
  dynamic? billingAddress(dynamic response) => getJsonField(
    response,
    r'''$.data.billing_address''',
  );
  dynamic? shippingAddress(dynamic response) => getJsonField(
    response,
    r'''$.data.shipping_address''',
  );
  dynamic? order(dynamic response) => getJsonField(
    response,
    r'''$.data.order''',
  );
  String? status(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.data.order.status''',
  ));
  List? products(dynamic response) => getJsonField(
    response,
    r'''$.data.products''',
    true,
  ) as List?;
}

class UserPointsCall {
  Future<ApiCallResponse> call({
    String? token = 'C3VWCG9YDCS0QG5VYMXLBWV0CMLJLMNVBQ==-67EF326E89F57',
    String? cartId = '',
  }) async {
    final baseUrl = PasargadrugsGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'userPoints',
      apiUrl: '${baseUrl}/user/points',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${token}',
      },
      params: {
        'cart_id': cartId,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  String? message(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.message''',
  ));
  dynamic? data(dynamic response) => getJsonField(
    response,
    r'''$.data''',
  );
  dynamic? billingAddress(dynamic response) => getJsonField(
    response,
    r'''$.data.billing_address''',
  );
  dynamic? shippingAddress(dynamic response) => getJsonField(
    response,
    r'''$.data.shipping_address''',
  );
  double? cartTotal(dynamic response) => castToType<double>(getJsonField(
    response,
    r'''$.data.cart_total''',
  ));
  List? cartItems(dynamic response) => getJsonField(
    response,
    r'''$.data.cart_items''',
    true,
  ) as List?;
  List? promos(dynamic response) => getJsonField(
    response,
    r'''$.data.cart_promos''',
    true,
  ) as List?;
  int? discounts(dynamic response) => castToType<int>(getJsonField(
    response,
    r'''$.data.cart_discount''',
  ));
  double? shippingFee(dynamic response) => castToType<double>(getJsonField(
    response,
    r'''$.data.cart_shipping''',
  ));
}

class GetProfileCall {
  Future<ApiCallResponse> call({
    String? token = 'C3VWCG9YDCS0QG5VYMXLBWV0CMLJLMNVBQ==-67EF326E89F57',
    String? cartId = '',
  }) async {
    final baseUrl = PasargadrugsGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'getProfile',
      apiUrl: '${baseUrl}/user/get-profile',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${token}',
      },
      params: {
        'cart_id': cartId,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  String? message(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.message''',
  ));
  dynamic? data(dynamic response) => getJsonField(
    response,
    r'''$.data''',
  );
  dynamic? billingAddress(dynamic response) => getJsonField(
    response,
    r'''$.data.billing_address''',
  );
  dynamic? shippingAddress(dynamic response) => getJsonField(
    response,
    r'''$.data.shipping_address''',
  );
  double? cartTotal(dynamic response) => castToType<double>(getJsonField(
    response,
    r'''$.data.cart_total''',
  ));
  List? cartItems(dynamic response) => getJsonField(
    response,
    r'''$.data.cart_items''',
    true,
  ) as List?;
  List? promos(dynamic response) => getJsonField(
    response,
    r'''$.data.cart_promos''',
    true,
  ) as List?;
  int? discounts(dynamic response) => castToType<int>(getJsonField(
    response,
    r'''$.data.cart_discount''',
  ));
  double? shippingFee(dynamic response) => castToType<double>(getJsonField(
    response,
    r'''$.data.cart_shipping''',
  ));
}

class CategoriesCall {
  Future<ApiCallResponse> call({
    String? token = 'C3VWCG9YDCS0QG5VYMXLBWV0CMLJLMNVBQ==-67EF326E89F57',
    String? cartId = '',
  }) async {
    final baseUrl = PasargadrugsGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'categories ',
      apiUrl: '${baseUrl}/categories',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${token}',
      },
      params: {
        'cart_id': cartId,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  String? message(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.message''',
  ));
  dynamic? data(dynamic response) => getJsonField(
    response,
    r'''$.data''',
  );
  dynamic? billingAddress(dynamic response) => getJsonField(
    response,
    r'''$.data.billing_address''',
  );
  dynamic? shippingAddress(dynamic response) => getJsonField(
    response,
    r'''$.data.shipping_address''',
  );
  double? cartTotal(dynamic response) => castToType<double>(getJsonField(
    response,
    r'''$.data.cart_total''',
  ));
  List? cartItems(dynamic response) => getJsonField(
    response,
    r'''$.data.cart_items''',
    true,
  ) as List?;
  List? promos(dynamic response) => getJsonField(
    response,
    r'''$.data.cart_promos''',
    true,
  ) as List?;
  int? discounts(dynamic response) => castToType<int>(getJsonField(
    response,
    r'''$.data.cart_discount''',
  ));
  double? shippingFee(dynamic response) => castToType<double>(getJsonField(
    response,
    r'''$.data.cart_shipping''',
  ));
}

class UserOrdersCall {
  Future<ApiCallResponse> call({
    String? token = '',
  }) async {
    final baseUrl = PasargadrugsGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'userOrders ',
      apiUrl: '${baseUrl}/user/orders',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${token}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  String? message(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.message''',
  ));
  List? orders(dynamic response) => getJsonField(
    response,
    r'''$.data.orders''',
    true,
  ) as List?;
}

class UpdateProfileCall {
  Future<ApiCallResponse> call({
    String? firstName = '',
    String? lastName = '',
    String? token = '',
  }) async {
    final baseUrl = PasargadrugsGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "last_name": "${escapeStringForJson(lastName)}",
  "first_name": "${escapeStringForJson(firstName)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'updateProfile',
      apiUrl: '${baseUrl}/user/update-profile',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': '${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  String? message(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.message''',
  ));
  List? data(dynamic response) => getJsonField(
    response,
    r'''$.data''',
    true,
  ) as List?;
}

class AddFavouritesCall {
  Future<ApiCallResponse> call({
    int? productId,
    int? favourite,
    String? token = '',
  }) async {
    final baseUrl = PasargadrugsGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "product_id": "${productId}",
  "favourite": "${favourite}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'addFavourites ',
      apiUrl: '${baseUrl}/user/add-favourites',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': '${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List? favs(dynamic response) => getJsonField(
    response,
    r'''$.data.favourites''',
    true,
  ) as List?;
}

class WriteReviewCall {
  Future<ApiCallResponse> call({
    int? productId,
    int? favourite,
    String? token = '',
  }) async {
    final baseUrl = PasargadrugsGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "product_id": "${productId}",
  "favourite": "${favourite}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'writeReview',
      apiUrl: '${baseUrl}/user/write-review',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': '${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List? favs(dynamic response) => getJsonField(
    response,
    r'''$.data.favourites''',
    true,
  ) as List?;
}

class DeleteAddressCall {
  Future<ApiCallResponse> call({
    int? id,
    String? token = '',
  }) async {
    final baseUrl = PasargadrugsGroup.getBaseUrl();
    return ApiManager.instance.makeApiCall(
      callName: 'deleteAddress',
      apiUrl: '${baseUrl}/user/addresses/delete/${id}',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': '${token}',
      },
      params: {},
      body: '{}', // no bogus fields
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class UpdateAddressCall {
  Future<ApiCallResponse> call({
    int? id,
    String? token = '',
    String? firstName = '',
    String? lastName = '',
    String? email = '',
    String? address = '',
    String? street = '',
    String? city = '',
    String? state = '',
    String? postalCode = '',
    String? phone = '',
  }) async {
    final baseUrl = PasargadrugsGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
     "first_name": "${escapeStringForJson(firstName)}",
     "last_name": "${escapeStringForJson(lastName)}",
     "email": "${escapeStringForJson(email)}",
     "address": "${escapeStringForJson(address)}",
     "street": "${escapeStringForJson(street)}",
     "city": "${escapeStringForJson(city)}",
     "state": "${escapeStringForJson(state)}" ,
     "postal_code": "${escapeStringForJson(postalCode)}",
     "phone": "${escapeStringForJson(phone)}" 
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'updateAddress ',
      apiUrl: '${baseUrl}/user/addresses/edit/${id}',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': '${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List? favs(dynamic response) => getJsonField(
    response,
    r'''$.data.favourites''',
    true,
  ) as List?;
}

class PostReviewCall {
  Future<ApiCallResponse> call({
    String? title = '',
    int? rating,
    String? token = '',
    String? content = '',
    int? product,
  }) async {
    final baseUrl = PasargadrugsGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "title": "${escapeStringForJson(title)}",
  "rating": "${rating}",
  "content": "${escapeStringForJson(content)}",
  "product": "${product}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'postReview',
      apiUrl: '${baseUrl}/user/write-review',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': '${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  String? message(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.message''',
  ));
  int? status(dynamic response) => castToType<int>(getJsonField(
    response,
    r'''$.status''',
  ));
}

class AddCartCall {
  Future<ApiCallResponse> call({
    int? productId,
    int? quantity,
    String? token = '',
    String? cartId = '',
  }) async {
    final baseUrl = PasargadrugsGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "product_id": "${productId}",
  "quantity": "${quantity}",
  "cart_id": "${escapeStringForJson(cartId)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'addCart',
      apiUrl: '${baseUrl}/cart/add',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': '${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  String? message(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.message''',
  ));
  int? status(dynamic response) => castToType<int>(getJsonField(
    response,
    r'''$.status''',
  ));
  dynamic? data(dynamic response) => getJsonField(
    response,
    r'''$.data''',
  );
  String? cartID(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.data.cart_id''',
  ));
  List? cartItems(dynamic response) => getJsonField(
    response,
    r'''$.data.cart_items''',
    true,
  ) as List?;
  String? cartItemId(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.data.cart_items[:].cart_item_id''',
  ));
  double? cartTotla(dynamic response) => castToType<double>(getJsonField(
    response,
    r'''$.data.cart_total''',
  ));
  List? promors(dynamic response) => getJsonField(
    response,
    r'''$.data.cart_promos''',
    true,
  ) as List?;
  int? discount(dynamic response) => castToType<int>(getJsonField(
    response,
    r'''$.data.cart_discount''',
  ));
  double? shippingFee(dynamic response) => castToType<double>(getJsonField(
    response,
    r'''$.data.cart_shipping''',
  ));
  dynamic? billingAddress(dynamic response) => getJsonField(
    response,
    r'''$.data.billing_address''',
  );
  dynamic? shippingAddress(dynamic response) => getJsonField(
    response,
    r'''$.data.shipping_address''',
  );
}

class UpdateCartCall {
  Future<ApiCallResponse> call({
    String? cartItemId = '',
    String? token = '',
    String? cartId = '',
    int? quantity,
  }) async {
    final baseUrl = PasargadrugsGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "cart_id": "${escapeStringForJson(cartId)}",
  "quantity": "${quantity}",
  "cart_item_id": "${escapeStringForJson(cartItemId)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'updateCart',
      apiUrl: '${baseUrl}/cart/update',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': '${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  String? message(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.message''',
  ));
  int? status(dynamic response) => castToType<int>(getJsonField(
    response,
    r'''$.status''',
  ));
  dynamic? data(dynamic response) => getJsonField(
    response,
    r'''$.data''',
  );
  String? cartID(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.data.cart_id''',
  ));
  List? cartItems(dynamic response) => getJsonField(
    response,
    r'''$.data.cart_items''',
    true,
  ) as List?;
  String? cartItemId(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.data.cart_items[:].cart_item_id''',
  ));
  double? cartTotla(dynamic response) => castToType<double>(getJsonField(
    response,
    r'''$.data.cart_total''',
  ));
  List? promors(dynamic response) => getJsonField(
    response,
    r'''$.data.cart_promos''',
    true,
  ) as List?;
  int? discount(dynamic response) => castToType<int>(getJsonField(
    response,
    r'''$.data.cart_discount''',
  ));
  double? shippingFee(dynamic response) => castToType<double>(getJsonField(
    response,
    r'''$.data.cart_shipping''',
  ));
  dynamic? billingAddress(dynamic response) => getJsonField(
    response,
    r'''$.data.billing_address''',
  );
  dynamic? shippingAddress(dynamic response) => getJsonField(
    response,
    r'''$.data.shipping_address''',
  );
}

class ClearCartCall {
  Future<ApiCallResponse> call({
    String? token = '',
    String? cartId = '',
  }) async {
    final baseUrl = PasargadrugsGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "cart_id": "${escapeStringForJson(cartId)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'clearCart',
      apiUrl: '${baseUrl}/cart/clear',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': '${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  String? message(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.message''',
  ));
  int? status(dynamic response) => castToType<int>(getJsonField(
    response,
    r'''$.status''',
  ));
  dynamic? data(dynamic response) => getJsonField(
    response,
    r'''$.data''',
  );
  String? cartID(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.data.cart_id''',
  ));
  List? cartItems(dynamic response) => getJsonField(
    response,
    r'''$.data.cart_items''',
    true,
  ) as List?;
  String? cartItemId(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.data.cart_items[:].cart_item_id''',
  ));
  double? cartTotla(dynamic response) => castToType<double>(getJsonField(
    response,
    r'''$.data.cart_total''',
  ));
  List? promors(dynamic response) => getJsonField(
    response,
    r'''$.data.cart_promos''',
    true,
  ) as List?;
  int? discount(dynamic response) => castToType<int>(getJsonField(
    response,
    r'''$.data.cart_discount''',
  ));
  double? shippingFee(dynamic response) => castToType<double>(getJsonField(
    response,
    r'''$.data.cart_shipping''',
  ));
  dynamic? billingAddress(dynamic response) => getJsonField(
    response,
    r'''$.data.billing_address''',
  );
  dynamic? shippingAddress(dynamic response) => getJsonField(
    response,
    r'''$.data.shipping_address''',
  );
}

class RemoveCartCall {
  Future<ApiCallResponse> call({
    dynamic cartItemId,
    String? token = '',
    String? cartId = '',
  }) async {
    final baseUrl = PasargadrugsGroup.getBaseUrl();

    // Convert cartItemId to string for JSON body (handles both int and string IDs)
    final cartItemIdStr = cartItemId?.toString() ?? '';

    final ffApiRequestBody = '''
{
  "cart_item_id": "${escapeStringForJson(cartItemIdStr)}",
  "cart_id": "${escapeStringForJson(cartId)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'removeCart',
      apiUrl: '${baseUrl}/cart/remove',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': '${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  String? message(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.message''',
  ));
  int? status(dynamic response) => castToType<int>(getJsonField(
    response,
    r'''$.status''',
  ));
  dynamic? data(dynamic response) => getJsonField(
    response,
    r'''$.data''',
  );
  String? cartID(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.data.cart_id''',
  ));
  List? cartItems(dynamic response) => getJsonField(
    response,
    r'''$.data.cart_items''',
    true,
  ) as List?;
  String? cartItemId(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.data.cart_items[:].cart_item_id''',
  ));
  double? cartTotla(dynamic response) => castToType<double>(getJsonField(
    response,
    r'''$.data.cart_total''',
  ));
  List? promors(dynamic response) => getJsonField(
    response,
    r'''$.data.cart_promos''',
    true,
  ) as List?;
  int? discount(dynamic response) => castToType<int>(getJsonField(
    response,
    r'''$.data.cart_discount''',
  ));
  double? shippingFee(dynamic response) => castToType<double>(getJsonField(
    response,
    r'''$.data.cart_shipping''',
  ));
  dynamic? billingAddress(dynamic response) => getJsonField(
    response,
    r'''$.data.billing_address''',
  );
  dynamic? shippingAddress(dynamic response) => getJsonField(
    response,
    r'''$.data.shipping_address''',
  );
}

class RemovePromoCall {
  Future<ApiCallResponse> call({
    String? token = '',
    String? cartId = '',
  }) async {
    final baseUrl = PasargadrugsGroup.getBaseUrl();
    final ffApiRequestBody = '''
{
  "cart_id": "${escapeStringForJson(cartId)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'removePromo',
      apiUrl: '${baseUrl}/cart/removepromo',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': '${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  String? message(dynamic response) => castToType<String>(getJsonField(response, r'''$.message'''));
  int? status(dynamic response) => castToType<int>(getJsonField(response, r'''$.status'''));
  dynamic? data(dynamic response) => getJsonField(response, r'''$.data''');
}

class CheckoutBillingCall {
  Future<ApiCallResponse> call({
    String? token = '',
    String? cartId = '',
    String? firstName = '',
    String? lastName = '',
    String? email = '',
    String? address = '',
    String? street = '',
    String? city = '',
    String? postalCode = '',
    String? phone = '',
    String? state = '',
  }) async {
    final baseUrl = PasargadrugsGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "cart_id": "${escapeStringForJson(cartId)}",
  "email": "${escapeStringForJson(email)}",
  "first_name": "${escapeStringForJson(firstName)}",
  "last_name": "${escapeStringForJson(lastName)}",
  "address": "${escapeStringForJson(address)}",
  "street": "${escapeStringForJson(street)}",
  "city": "${escapeStringForJson(city)}",
  "state": "${escapeStringForJson(state)}",
  "postal_code": "${escapeStringForJson(postalCode)}",
  "phone": "${escapeStringForJson(phone)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'checkoutBilling',
      apiUrl: '${baseUrl}/checkout/billing',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': '${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  String? message(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.message''',
  ));
  int? status(dynamic response) => castToType<int>(getJsonField(
    response,
    r'''$.status''',
  ));
  dynamic? data(dynamic response) => getJsonField(
    response,
    r'''$.data''',
  );
  String? cartID(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.data.cart_id''',
  ));
  List? cartItems(dynamic response) => getJsonField(
    response,
    r'''$.data.cart_items''',
    true,
  ) as List?;
  String? cartItemId(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.data.cart_items[:].cart_item_id''',
  ));
  double? cartTotla(dynamic response) => castToType<double>(getJsonField(
    response,
    r'''$.data.cart_total''',
  ));
  List? promors(dynamic response) => getJsonField(
    response,
    r'''$.data.cart_promos''',
    true,
  ) as List?;
  int? discount(dynamic response) => castToType<int>(getJsonField(
    response,
    r'''$.data.cart_discount''',
  ));
  double? shippingFee(dynamic response) => castToType<double>(getJsonField(
    response,
    r'''$.data.cart_shipping''',
  ));
  dynamic? billingAddress(dynamic response) => getJsonField(
    response,
    r'''$.data.billing_address''',
  );
  dynamic? shippingAddress(dynamic response) => getJsonField(
    response,
    r'''$.data.shipping_address''',
  );
}

class CheckoutShippingCall {
  Future<ApiCallResponse> call({
    String? token = '',
    String? cartId = '',
    String? firstName = '',
    String? lastName = '',
    String? email = '',
    String? address = '',
    String? street = '',
    String? city = '',
    String? postalCode = '',
    String? phone = '',
    String? state = '',
  }) async {
    final baseUrl = PasargadrugsGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "cart_id": "${escapeStringForJson(cartId)}",
  "email": "${escapeStringForJson(email)}",
  "first_name": "${escapeStringForJson(firstName)}",
  "last_name": "${escapeStringForJson(lastName)}",
  "address": "${escapeStringForJson(address)}",
  "street": "${escapeStringForJson(street)}",
  "city": "${escapeStringForJson(city)}",
  "state": "${escapeStringForJson(state)}",
  "postal_code": "${escapeStringForJson(postalCode)}",
  "phone": "${escapeStringForJson(phone)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'checkoutShipping',
      apiUrl: '${baseUrl}/checkout/shipping',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': '${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  String? message(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.message''',
  ));
  int? status(dynamic response) => castToType<int>(getJsonField(
    response,
    r'''$.status''',
  ));
  dynamic? data(dynamic response) => getJsonField(
    response,
    r'''$.data''',
  );
  String? cartID(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.data.cart_id''',
  ));
  List? cartItems(dynamic response) => getJsonField(
    response,
    r'''$.data.cart_items''',
    true,
  ) as List?;
  String? cartItemId(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.data.cart_items[:].cart_item_id''',
  ));
  double? cartTotla(dynamic response) => castToType<double>(getJsonField(
    response,
    r'''$.data.cart_total''',
  ));
  List? promors(dynamic response) => getJsonField(
    response,
    r'''$.data.cart_promos''',
    true,
  ) as List?;
  int? discount(dynamic response) => castToType<int>(getJsonField(
    response,
    r'''$.data.cart_discount''',
  ));
  double? shippingFee(dynamic response) => castToType<double>(getJsonField(
    response,
    r'''$.data.cart_shipping''',
  ));
  dynamic? billingAddress(dynamic response) => getJsonField(
    response,
    r'''$.data.billing_address''',
  );
  dynamic? shippingAddress(dynamic response) => getJsonField(
    response,
    r'''$.data.shipping_address''',
  );
}

class PaymentStripeCall {
  Future<ApiCallResponse> call({
    String? token = '',
    String? cartId = '',
    String? ccName = '',
    String? ccCardNo = '',
    String? ccExpiryMonth = '',
    String? ccExpiryYear = '',
    String? ccCvv = '',
    String? identity = '',
  }) async {
    final baseUrl = PasargadrugsGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'paymentStripe',
      apiUrl: '${baseUrl}/checkout/payment/paypal',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${token}',
      },
      params: {
        'cart_id': cartId,
        'identity': identity,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  int? status(dynamic response) => castToType<int>(getJsonField(
    response,
    r'''$.status''',
  ));
  String? redirectUrl(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.redirect_url''',
  ));
}

class PaymentPaypalCall {
  Future<ApiCallResponse> call({
    String? token = '',
    String? cartId = '',
  }) async {
    final baseUrl = PasargadrugsGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'paymentPaypal',
      apiUrl: '${baseUrl}/checkout/payment/paypal',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${token}',
      },
      params: {
        'cart_id': cartId,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  int? status(dynamic response) => castToType<int>(getJsonField(
    response,
    r'''$.status''',
  ));
  dynamic redirectUrl(dynamic response) => getJsonField(
    response,
    r'''$.redirect_url''',
  );
}

class ApplyPromoCall {
  Future<ApiCallResponse> call({
    String? promocode = '',
    String? token = '',
    String? cartId = '',
  }) async {
    final baseUrl = PasargadrugsGroup.getBaseUrl();
    final ffApiRequestBody = '''
{
  "cart_id": "${escapeStringForJson(cartId)}",
  "promo_code": "${escapeStringForJson(promocode)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'applyPromo',
      apiUrl: '${baseUrl}/cart/applypromo',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': '${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  String? message(dynamic response) => castToType<String>(getJsonField(response, r'''$.message'''));
  int? status(dynamic response) => castToType<int>(getJsonField(response, r'''$.status'''));
  dynamic? data(dynamic response) => getJsonField(response, r'''$.data''');
}

/// End Pasargadrugs Group Code

/// Start SquarePayment Group Code

class SquarePaymentGroup {
  static String getBaseUrl({
    String? token,
  }) {
    token ??= FFAppConstants.SquareAccessToken;
    // return 'https://connect.squareupsandbox.com/v2';
    return 'https://connect.squareup.com/v2';
  }

  static Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer [token]',
  };
  static LocationCall locationCall = LocationCall();
  static PaymentlinksCall paymentlinksCall = PaymentlinksCall();
}

class LocationCall {
  Future<ApiCallResponse> call({
    String? token,
  }) async {
    token ??= FFAppConstants.SquareAccessToken;
    final baseUrl = SquarePaymentGroup.getBaseUrl(
      token: token,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'location',
      apiUrl: '${baseUrl}/locations/main',
      callType: ApiCallType.GET,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${token}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  String? locationId(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.location.id''',
  ));
  dynamic? locationAddress(dynamic response) => getJsonField(
    response,
    r'''$.location.address''',
  );
  String? locationName(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.location.name''',
  ));
}

class PaymentlinksCall {
  Future<ApiCallResponse> call({
    String? idempKey = '',
    String? cartId = '',
    int? amount,
    String? locationId = '',
    String? token,
  }) async {
    token ??= FFAppConstants.SquareAccessToken;
    final baseUrl = SquarePaymentGroup.getBaseUrl(
      token: token,
    );

    final ffApiRequestBody = '''
{
  "idempotency_key": "${escapeStringForJson(idempKey)}",
  "quick_pay": {
    "name": "Cart #${escapeStringForJson(cartId)}",
    "price_money": {
      "amount": ${amount},
      "currency": "USD"
    },
    "location_id": "${escapeStringForJson(locationId)}"
  },
  "checkout_options": {
    "redirect_url": "https://yourapp.example/checkout/return?cart_id=${escapeStringForJson(cartId)}"
  }
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'paymentlinks',
      apiUrl: '${baseUrl}/online-checkout/payment-links',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  String? payUrl(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.payment_link.url''',
  ));
  String? longPayUrl(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.payment_link.long_url''',
  ));
  String? redirectUrl(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.payment_link.checkout_options.redirect_url''',
  ));
}

/// End SquarePayment Group Code

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _toEncodable(dynamic item) {
  return item;
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("List serialization failed. Returning empty list.");
    }
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("Json serialization failed. Returning empty json.");
    }
    return isList ? '[]' : '{}';
  }
}

String? escapeStringForJson(String? input) {
  if (input == null) {
    return null;
  }
  return input
      .replaceAll('\\', '\\\\')
      .replaceAll('"', '\\"')
      .replaceAll('\n', '\\n')
      .replaceAll('\t', '\\t');
}
