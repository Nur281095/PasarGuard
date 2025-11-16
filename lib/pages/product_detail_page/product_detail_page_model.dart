import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'product_detail_page_widget.dart' show ProductDetailPageWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProductDetailPageModel extends FlutterFlowModel<ProductDetailPageWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (addCart)] action in Button widget.
  ApiCallResponse? _addCartResult;
  set addCartResult(ApiCallResponse? value) {
    _addCartResult = value;
    debugLogWidgetClass(this);
  }

  ApiCallResponse? get addCartResult => _addCartResult;

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
          'prodID': debugSerializeParam(
            widget?.prodID,
            ParamType.int,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=ProductDetailPage',
            searchReference:
                'reference=ShgKEAoGcHJvZElEEgY3M2M2MjZyBAgBIAFQAVoGcHJvZElE',
            name: 'int',
            nullable: true,
          )
        }.withoutNulls,
        actionOutputs: {
          'addCartResult': debugSerializeParam(
            addCartResult,
            ParamType.ApiResponse,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=ProductDetailPage',
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
            'https://app.flutterflow.io/project/pasargad-82dm1q/tab=uiBuilder&page=ProductDetailPage',
        searchReference:
            'reference=OhFQcm9kdWN0RGV0YWlsUGFnZVABWhFQcm9kdWN0RGV0YWlsUGFnZQ==',
        widgetClassName: 'ProductDetailPage',
      );
}
