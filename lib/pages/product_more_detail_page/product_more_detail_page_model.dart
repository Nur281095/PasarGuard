import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'product_more_detail_page_widget.dart' show ProductMoreDetailPageWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProductMoreDetailPageModel
    extends FlutterFlowModel<ProductMoreDetailPageWidget> {
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
          'productID': debugSerializeParam(
            widget?.productID,
            ParamType.int,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=ProductMoreDetailPage',
            searchReference:
                'reference=ShsKEwoJcHJvZHVjdElEEgZzbnowbHFyBAgBIAFQAVoJcHJvZHVjdElE',
            name: 'int',
            nullable: true,
          )
        }.withoutNulls,
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
            'https://app.flutterflow.io/project/pasargad-82dm1q/tab=uiBuilder&page=ProductMoreDetailPage',
        searchReference:
            'reference=OhVQcm9kdWN0TW9yZURldGFpbFBhZ2VQAVoVUHJvZHVjdE1vcmVEZXRhaWxQYWdl',
        widgetClassName: 'ProductMoreDetailPage',
      );
}
