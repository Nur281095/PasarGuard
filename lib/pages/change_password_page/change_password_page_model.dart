import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'change_password_page_widget.dart' show ChangePasswordPageWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ChangePasswordPageModel
    extends FlutterFlowModel<ChangePasswordPageWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for oldPasswordF widget.
  FocusNode? oldPasswordFFocusNode;
  TextEditingController? oldPasswordFTextController;
  late bool oldPasswordFVisibility;
  String? Function(BuildContext, String?)? oldPasswordFTextControllerValidator;
  String? _oldPasswordFTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Last name is required';
    }

    if (val.length < 3) {
      return 'Last name required minimum 3 character in length';
    }

    return null;
  }

  // State field(s) for newPasswordF widget.
  FocusNode? newPasswordFFocusNode;
  TextEditingController? newPasswordFTextController;
  late bool newPasswordFVisibility;
  String? Function(BuildContext, String?)? newPasswordFTextControllerValidator;

  final Map<String, DebugDataField> debugGeneratorVariables = {};
  final Map<String, DebugDataField> debugBackendQueries = {};
  final Map<String, FlutterFlowModel> widgetBuilderComponents = {};
  @override
  void initState(BuildContext context) {
    oldPasswordFVisibility = false;
    oldPasswordFTextControllerValidator = _oldPasswordFTextControllerValidator;
    newPasswordFVisibility = false;

    debugLogWidgetClass(this);
  }

  @override
  void dispose() {
    oldPasswordFFocusNode?.dispose();
    oldPasswordFTextController?.dispose();

    newPasswordFFocusNode?.dispose();
    newPasswordFTextController?.dispose();
  }

  @override
  WidgetClassDebugData toWidgetClassDebugData() => WidgetClassDebugData(
        widgetStates: {
          'oldPasswordFText': debugSerializeParam(
            oldPasswordFTextController?.text,
            ParamType.String,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=ChangePasswordPage',
            name: 'String',
            nullable: true,
          ),
          'newPasswordFText': debugSerializeParam(
            newPasswordFTextController?.text,
            ParamType.String,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=ChangePasswordPage',
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
            'https://app.flutterflow.io/project/pasargad-82dm1q/tab=uiBuilder&page=ChangePasswordPage',
        searchReference:
            'reference=OhJDaGFuZ2VQYXNzd29yZFBhZ2VQAVoSQ2hhbmdlUGFzc3dvcmRQYWdl',
        widgetClassName: 'ChangePasswordPage',
      );
}
