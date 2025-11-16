import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'sign_in_page_widget.dart' show SignInPageWidget;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SignInPageModel extends FlutterFlowModel<SignInPageWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for emailF widget.
  FocusNode? emailFFocusNode;
  TextEditingController? emailFTextController;
  String? Function(BuildContext, String?)? emailFTextControllerValidator;
  String? _emailFTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Email is required';
    }

    if (!RegExp(kTextValidatorEmailRegex).hasMatch(val)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  // State field(s) for passwordF widget.
  FocusNode? passwordFFocusNode;
  TextEditingController? passwordFTextController;
  late bool passwordFVisibility;
  String? Function(BuildContext, String?)? passwordFTextControllerValidator;
  String? _passwordFTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Password is required';
    }

    if (val.length < 6) {
      return 'Password is required';
    }

    return null;
  }

  // Stores action output result for [Validate Form] action in Button widget.
  bool? _valid;
  set valid(bool? value) {
    _valid = value;
    debugLogWidgetClass(this);
  }

  bool? get valid => _valid;

  // Stores action output result for [Backend Call - API (login)] action in Button widget.
  ApiCallResponse? _apiResultx1h;
  set apiResultx1h(ApiCallResponse? value) {
    _apiResultx1h = value;
    debugLogWidgetClass(this);
  }

  ApiCallResponse? get apiResultx1h => _apiResultx1h;

  final Map<String, DebugDataField> debugGeneratorVariables = {};
  final Map<String, DebugDataField> debugBackendQueries = {};
  final Map<String, FlutterFlowModel> widgetBuilderComponents = {};
  @override
  void initState(BuildContext context) {
    emailFTextControllerValidator = _emailFTextControllerValidator;
    passwordFVisibility = false;
    passwordFTextControllerValidator = _passwordFTextControllerValidator;

    debugLogWidgetClass(this);
  }

  @override
  void dispose() {
    emailFFocusNode?.dispose();
    emailFTextController?.dispose();

    passwordFFocusNode?.dispose();
    passwordFTextController?.dispose();
  }

  @override
  WidgetClassDebugData toWidgetClassDebugData() => WidgetClassDebugData(
        widgetStates: {
          'emailFText': debugSerializeParam(
            emailFTextController?.text,
            ParamType.String,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=SignInPage',
            name: 'String',
            nullable: true,
          ),
          'passwordFText': debugSerializeParam(
            passwordFTextController?.text,
            ParamType.String,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=SignInPage',
            name: 'String',
            nullable: true,
          )
        },
        actionOutputs: {
          'valid': debugSerializeParam(
            valid,
            ParamType.bool,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=SignInPage',
            name: 'bool',
            nullable: true,
          ),
          'apiResultx1h': debugSerializeParam(
            apiResultx1h,
            ParamType.ApiResponse,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=SignInPage',
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
            'https://app.flutterflow.io/project/pasargad-82dm1q/tab=uiBuilder&page=SignInPage',
        searchReference: 'reference=OgpTaWduSW5QYWdlUAFaClNpZ25JblBhZ2U=',
        widgetClassName: 'SignInPage',
      );
}
