import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'no_data_found_component_widget.dart' show NoDataFoundComponentWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class NoDataFoundComponentModel
    extends FlutterFlowModel<NoDataFoundComponentWidget> {
  final Map<String, DebugDataField> debugGeneratorVariables = {};
  final Map<String, DebugDataField> debugBackendQueries = {};
  final Map<String, FlutterFlowModel> widgetBuilderComponents = {};
  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}

  @override
  WidgetClassDebugData toWidgetClassDebugData() => WidgetClassDebugData(
        widgetParameters: {
          'message': debugSerializeParam(
            widget?.message,
            ParamType.String,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=NoDataFoundComponent',
            searchReference:
                'reference=ShkKEQoHbWVzc2FnZRIGZzk3b3BycgQIAyABUABaB21lc3NhZ2U=',
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
            'https://app.flutterflow.io/project/pasargad-82dm1q/tab=uiBuilder&page=NoDataFoundComponent',
        searchReference:
            'reference=OhROb0RhdGFGb3VuZENvbXBvbmVudFAAWhROb0RhdGFGb3VuZENvbXBvbmVudA==',
        widgetClassName: 'NoDataFoundComponent',
      );
}
