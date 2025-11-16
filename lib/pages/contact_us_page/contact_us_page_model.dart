import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'contact_us_page_widget.dart' show ContactUsPageWidget;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ContactUsPageModel extends FlutterFlowModel<ContactUsPageWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for nameF widget.
  FocusNode? nameFFocusNode;
  TextEditingController? nameFTextController;
  String? Function(BuildContext, String?)? nameFTextControllerValidator;
  // State field(s) for emailF widget.
  FocusNode? emailFFocusNode;
  TextEditingController? emailFTextController;
  String? Function(BuildContext, String?)? emailFTextControllerValidator;
  // State field(s) for messageF widget.
  FocusNode? messageFFocusNode;
  TextEditingController? messageFTextController;
  String? Function(BuildContext, String?)? messageFTextControllerValidator;

  final Map<String, DebugDataField> debugGeneratorVariables = {};
  final Map<String, DebugDataField> debugBackendQueries = {};
  final Map<String, FlutterFlowModel> widgetBuilderComponents = {};
  @override
  void initState(BuildContext context) {
    debugLogWidgetClass(this);
  }

  @override
  void dispose() {
    nameFFocusNode?.dispose();
    nameFTextController?.dispose();

    emailFFocusNode?.dispose();
    emailFTextController?.dispose();

    messageFFocusNode?.dispose();
    messageFTextController?.dispose();
  }

  @override
  WidgetClassDebugData toWidgetClassDebugData() => WidgetClassDebugData(
        widgetStates: {
          'nameFText': debugSerializeParam(
            nameFTextController?.text,
            ParamType.String,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=ContactUsPage',
            name: 'String',
            nullable: true,
          ),
          'emailFText': debugSerializeParam(
            emailFTextController?.text,
            ParamType.String,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=ContactUsPage',
            name: 'String',
            nullable: true,
          ),
          'messageFText': debugSerializeParam(
            messageFTextController?.text,
            ParamType.String,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=ContactUsPage',
            name: 'String',
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
            'https://app.flutterflow.io/project/pasargad-82dm1q/tab=uiBuilder&page=ContactUsPage',
        searchReference:
            'reference=Og1Db250YWN0VXNQYWdlUAFaDUNvbnRhY3RVc1BhZ2U=',
        widgetClassName: 'ContactUsPage',
      );
}
