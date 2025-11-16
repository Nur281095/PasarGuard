import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/components/no_data_found_component_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'cart_page_widget.dart' show CartPageWidget;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CartPageModel extends FlutterFlowModel<CartPageWidget> {
  ///  Local state fields for this page.

  late LoggableList<dynamic> _cartItems = LoggableList([]);
  set cartItems(List<dynamic> value) {
    if (value != null) {
      _cartItems = LoggableList(value);
    }

    debugLogWidgetClass(this);
  }

  List<dynamic> get cartItems =>
      _cartItems?..logger = () => debugLogWidgetClass(this);
  void addToCartItems(dynamic item) => cartItems.add(item);
  void removeFromCartItems(dynamic item) => cartItems.remove(item);
  void removeAtIndexFromCartItems(int index) => cartItems.removeAt(index);
  void insertAtIndexInCartItems(int index, dynamic item) =>
      cartItems.insert(index, item);
  void updateCartItemsAtIndex(int index, Function(dynamic) updateFn) =>
      cartItems[index] = updateFn(cartItems[index]);

  double? _cartTotal = 0.0;
  set cartTotal(double? value) {
    _cartTotal = value;
    debugLogWidgetClass(this);
  }

  double? get cartTotal => _cartTotal;

  late LoggableList<dynamic> _cartPromos = LoggableList([]);
  set cartPromos(List<dynamic> value) {
    if (value != null) {
      _cartPromos = LoggableList(value);
    }

    debugLogWidgetClass(this);
  }

  List<dynamic> get cartPromos =>
      _cartPromos?..logger = () => debugLogWidgetClass(this);
  void addToCartPromos(dynamic item) => cartPromos.add(item);
  void removeFromCartPromos(dynamic item) => cartPromos.remove(item);
  void removeAtIndexFromCartPromos(int index) => cartPromos.removeAt(index);
  void insertAtIndexInCartPromos(int index, dynamic item) =>
      cartPromos.insert(index, item);
  void updateCartPromosAtIndex(int index, Function(dynamic) updateFn) =>
      cartPromos[index] = updateFn(cartPromos[index]);

  double? _cartDiscount = 0.0;
  set cartDiscount(double? value) {
    _cartDiscount = value;
    debugLogWidgetClass(this);
  }

  double? get cartDiscount => _cartDiscount;

  double? _cartShipping = 0.0;
  set cartShipping(double? value) {
    _cartShipping = value;
    debugLogWidgetClass(this);
  }

  double? get cartShipping => _cartShipping;

  dynamic _billingAddress;
  set billingAddress(dynamic value) {
    _billingAddress = value;
    debugLogWidgetClass(this);
  }

  dynamic get billingAddress => _billingAddress;

  dynamic _shippingAddress;
  set shippingAddress(dynamic value) {
    _shippingAddress = value;
    debugLogWidgetClass(this);
  }

  dynamic get shippingAddress => _shippingAddress;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (getCart)] action in CartPage widget.
  ApiCallResponse? _cartxyz;
  set cartxyz(ApiCallResponse? value) {
    _cartxyz = value;
    debugLogWidgetClass(this);
  }

  ApiCallResponse? get cartxyz => _cartxyz;

  // Stores action output result for [Backend Call - API (updateCart)] action in Container widget.
  ApiCallResponse? _decCartResult;
  set decCartResult(ApiCallResponse? value) {
    _decCartResult = value;
    debugLogWidgetClass(this);
  }

  ApiCallResponse? get decCartResult => _decCartResult;

  // Stores action output result for [Backend Call - API (updateCart)] action in Container widget.
  ApiCallResponse? _incrementCartResult;
  set incrementCartResult(ApiCallResponse? value) {
    _incrementCartResult = value;
    debugLogWidgetClass(this);
  }

  ApiCallResponse? get incrementCartResult => _incrementCartResult;

  // Stores action output result for [Backend Call - API (removeCart)] action in Container widget.
  ApiCallResponse? _apiResult1ux;
  set apiResult1ux(ApiCallResponse? value) {
    _apiResult1ux = value;
    debugLogWidgetClass(this);
  }

  ApiCallResponse? get apiResult1ux => _apiResult1ux;

  final Map<String, DebugDataField> debugGeneratorVariables = {};
  final Map<String, DebugDataField> debugBackendQueries = {};
  final Map<String, FlutterFlowModel> widgetBuilderComponents = {};
  @override
  void initState(BuildContext context) {
    debugLogWidgetClass(this);
  }

  @override
  void dispose() {}

  @override
  WidgetClassDebugData toWidgetClassDebugData() => WidgetClassDebugData(
        localStates: {
          'cartItems': debugSerializeParam(
            cartItems,
            ParamType.JSON,
            isList: true,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=CartPage',
            searchReference:
                'reference=QhoKEgoJY2FydEl0ZW1zEgV6ZTd3cHIEEgIICVABWgljYXJ0SXRlbXNiCENhcnRQYWdl',
            name: 'dynamic',
            nullable: false,
          ),
          'cartTotal': debugSerializeParam(
            cartTotal,
            ParamType.double,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=CartPage',
            searchReference:
                'reference=QhoKEgoJY2FydFRvdGFsEgVrMjR5M3IECAIgAFABWgljYXJ0VG90YWxiCENhcnRQYWdl',
            name: 'double',
            nullable: true,
          ),
          'cartPromos': debugSerializeParam(
            cartPromos,
            ParamType.JSON,
            isList: true,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=CartPage',
            searchReference:
                'reference=QhsKEwoKY2FydFByb21vcxIFN2Yxdm1yBBICCAlQAVoKY2FydFByb21vc2IIQ2FydFBhZ2U=',
            name: 'dynamic',
            nullable: false,
          ),
          'cartDiscount': debugSerializeParam(
            cartDiscount,
            ParamType.double,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=CartPage',
            searchReference:
                'reference=QhsKFQoMY2FydERpc2NvdW50EgU1N2x6YnICCAJQAVoMY2FydERpc2NvdW50YghDYXJ0UGFnZQ==',
            name: 'double',
            nullable: true,
          ),
          'cartShipping': debugSerializeParam(
            cartShipping,
            ParamType.double,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=CartPage',
            searchReference:
                'reference=QhsKFQoMY2FydFNoaXBwaW5nEgV5bjFwZHICCAJQAVoMY2FydFNoaXBwaW5nYghDYXJ0UGFnZQ==',
            name: 'double',
            nullable: true,
          ),
          'billingAddress': debugSerializeParam(
            billingAddress,
            ParamType.JSON,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=CartPage',
            searchReference:
                'reference=Qh0KFwoOYmlsbGluZ0FkZHJlc3MSBTB6c2dicgIICVABWg5iaWxsaW5nQWRkcmVzc2IIQ2FydFBhZ2U=',
            name: 'dynamic',
            nullable: true,
          ),
          'shippingAddress': debugSerializeParam(
            shippingAddress,
            ParamType.JSON,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=CartPage',
            searchReference:
                'reference=Qh4KGAoPc2hpcHBpbmdBZGRyZXNzEgVjdWJ5YXICCAlQAVoPc2hpcHBpbmdBZGRyZXNzYghDYXJ0UGFnZQ==',
            name: 'dynamic',
            nullable: true,
          )
        },
        actionOutputs: {
          'cartxyz': debugSerializeParam(
            cartxyz,
            ParamType.ApiResponse,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=CartPage',
            name: 'ApiCallResponse',
            nullable: true,
          ),
          'decCartResult': debugSerializeParam(
            decCartResult,
            ParamType.ApiResponse,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=CartPage',
            name: 'ApiCallResponse',
            nullable: true,
          ),
          'incrementCartResult': debugSerializeParam(
            incrementCartResult,
            ParamType.ApiResponse,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=CartPage',
            name: 'ApiCallResponse',
            nullable: true,
          ),
          'apiResult1ux': debugSerializeParam(
            apiResult1ux,
            ParamType.ApiResponse,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=CartPage',
            name: 'ApiCallResponse',
            nullable: true,
          )
        },
        generatorVariables: debugGeneratorVariables,
        backendQueries: debugBackendQueries,
        componentStates: {
          ...widgetBuilderComponents.map(
            (key, value) => MapEntry(
              key,
              value.toWidgetClassDebugData(),
            ),
          ),
        }.withoutNulls,
        link:
            'https://app.flutterflow.io/project/pasargad-82dm1q/tab=uiBuilder&page=CartPage',
        searchReference: 'reference=OghDYXJ0UGFnZVABWghDYXJ0UGFnZQ==',
        widgetClassName: 'CartPage',
      );
}
