import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'order_detail_page_widget.dart' show OrderDetailPageWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class OrderDetailPageModel extends FlutterFlowModel<OrderDetailPageWidget> {
  ///  Local state fields for this page.

  dynamic _order;
  set order(dynamic value) {
    _order = value;
    debugLogWidgetClass(this);
  }

  dynamic get order => _order;

  late LoggableList<dynamic> _products = LoggableList([]);
  set products(List<dynamic> value) {
    if (value != null) {
      _products = LoggableList(value);
    }

    debugLogWidgetClass(this);
  }

  List<dynamic> get products =>
      _products?..logger = () => debugLogWidgetClass(this);
  void addToProducts(dynamic item) => products.add(item);
  void removeFromProducts(dynamic item) => products.remove(item);
  void removeAtIndexFromProducts(int index) => products.removeAt(index);
  void insertAtIndexInProducts(int index, dynamic item) =>
      products.insert(index, item);
  void updateProductsAtIndex(int index, Function(dynamic) updateFn) =>
      products[index] = updateFn(products[index]);

  dynamic _shippingAddress;
  set shippingAddress(dynamic value) {
    _shippingAddress = value;
    debugLogWidgetClass(this);
  }

  dynamic get shippingAddress => _shippingAddress;

  dynamic _billingAddress;
  set billingAddress(dynamic value) {
    _billingAddress = value;
    debugLogWidgetClass(this);
  }

  dynamic get billingAddress => _billingAddress;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (orderDetail)] action in OrderDetailPage widget.
  ApiCallResponse? _orderDetailResult;
  set orderDetailResult(ApiCallResponse? value) {
    _orderDetailResult = value;
    debugLogWidgetClass(this);
  }

  ApiCallResponse? get orderDetailResult => _orderDetailResult;

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
        widgetParameters: {
          'id': debugSerializeParam(
            widget?.id,
            ParamType.int,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=OrderDetailPage',
            searchReference:
                'reference=ShQKDAoCaWQSBmxtdW43eXIECAEgAVABWgJpZA==',
            name: 'int',
            nullable: true,
          )
        }.withoutNulls,
        localStates: {
          'order': debugSerializeParam(
            order,
            ParamType.JSON,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=OrderDetailPage',
            searchReference:
                'reference=QhQKDgoFb3JkZXISBXR6ZmwxcgIICVABWgVvcmRlcmIPT3JkZXJEZXRhaWxQYWdl',
            name: 'dynamic',
            nullable: true,
          ),
          'products': debugSerializeParam(
            products,
            ParamType.JSON,
            isList: true,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=OrderDetailPage',
            searchReference:
                'reference=QhkKEQoIcHJvZHVjdHMSBWg5Y3F3cgQSAggJUAFaCHByb2R1Y3RzYg9PcmRlckRldGFpbFBhZ2U=',
            name: 'dynamic',
            nullable: false,
          ),
          'shippingAddress': debugSerializeParam(
            shippingAddress,
            ParamType.JSON,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=OrderDetailPage',
            searchReference:
                'reference=Qh4KGAoPc2hpcHBpbmdBZGRyZXNzEgVpMzZsOXICCAlQAVoPc2hpcHBpbmdBZGRyZXNzYg9PcmRlckRldGFpbFBhZ2U=',
            name: 'dynamic',
            nullable: true,
          ),
          'billingAddress': debugSerializeParam(
            billingAddress,
            ParamType.JSON,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=OrderDetailPage',
            searchReference:
                'reference=Qh0KFwoOYmlsbGluZ0FkZHJlc3MSBXNlc2d4cgIICVABWg5iaWxsaW5nQWRkcmVzc2IPT3JkZXJEZXRhaWxQYWdl',
            name: 'dynamic',
            nullable: true,
          )
        },
        actionOutputs: {
          'orderDetailResult': debugSerializeParam(
            orderDetailResult,
            ParamType.ApiResponse,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=OrderDetailPage',
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
            'https://app.flutterflow.io/project/pasargad-82dm1q/tab=uiBuilder&page=OrderDetailPage',
        searchReference:
            'reference=Og9PcmRlckRldGFpbFBhZ2VQAVoPT3JkZXJEZXRhaWxQYWdl',
        widgetClassName: 'OrderDetailPage',
      );
}
