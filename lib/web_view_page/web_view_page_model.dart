import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_web_view.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'web_view_page_widget.dart' show WebViewPageWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class WebViewPageModel extends FlutterFlowModel<WebViewPageWidget> {
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
          'urlToOpen': debugSerializeParam(
            widget?.urlToOpen,
            ParamType.String,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=WebViewPage',
            searchReference:
                'reference=ShsKEwoJdXJsVG9PcGVuEgZieHdoM29yBAgDIAFQAVoJdXJsVG9PcGVu',
            name: 'String',
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
            'https://app.flutterflow.io/project/pasargad-82dm1q/tab=uiBuilder&page=WebViewPage',
        searchReference: 'reference=OgtXZWJWaWV3UGFnZVABWgtXZWJWaWV3UGFnZQ==',
        widgetClassName: 'WebViewPage',
      );
}
