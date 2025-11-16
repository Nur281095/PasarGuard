import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'signup_page_widget.dart' show SignupPageWidget;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SignupPageModel extends FlutterFlowModel<SignupPageWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for fNameF widget.
  FocusNode? fNameFFocusNode;
  TextEditingController? fNameFTextController;
  String? Function(BuildContext, String?)? fNameFTextControllerValidator;
  String? _fNameFTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'First name is required';
    }

    if (val.length < 3) {
      return 'First name required minimum 3 character in length';
    }

    return null;
  }

  // State field(s) for lastNameF widget.
  FocusNode? lastNameFFocusNode;
  TextEditingController? lastNameFTextController;
  String? Function(BuildContext, String?)? lastNameFTextControllerValidator;
  String? _lastNameFTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Last name is required';
    }

    if (val.length < 3) {
      return 'Last name required minimum 3 character in length';
    }

    return null;
  }

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

  // State field(s) for passF widget.
  FocusNode? passFFocusNode;
  TextEditingController? passFTextController;
  late bool passFVisibility;
  String? Function(BuildContext, String?)? passFTextControllerValidator;
  String? _passFTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Password is required';
    }

    if (val.length < 6) {
      return 'Password requires minimum 6 characters in length';
    }

    return null;
  }

  // State field(s) for conPassF widget.
  FocusNode? conPassFFocusNode;
  TextEditingController? conPassFTextController;
  late bool conPassFVisibility;
  String? Function(BuildContext, String?)? conPassFTextControllerValidator;
  String? _conPassFTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Confirm password is required';
    }

    if (val.length < 6) {
      return 'Confirm Password requires minimum 6 characters in length';
    }

    return null;
  }

  // Stores action output result for [Validate Form] action in Button widget.
  bool? _formValid;
  set formValid(bool? value) {
    _formValid = value;
    debugLogWidgetClass(this);
  }

  bool? get formValid => _formValid;

  // Stores action output result for [Backend Call - API (register)] action in Button widget.
  ApiCallResponse? _signupResult;
  set signupResult(ApiCallResponse? value) {
    _signupResult = value;
    debugLogWidgetClass(this);
  }

  ApiCallResponse? get signupResult => _signupResult;

  final Map<String, DebugDataField> debugGeneratorVariables = {};
  final Map<String, DebugDataField> debugBackendQueries = {};
  final Map<String, FlutterFlowModel> widgetBuilderComponents = {};
  @override
  void initState(BuildContext context) {
    fNameFTextControllerValidator = _fNameFTextControllerValidator;
    lastNameFTextControllerValidator = _lastNameFTextControllerValidator;
    emailFTextControllerValidator = _emailFTextControllerValidator;
    passFVisibility = false;
    passFTextControllerValidator = _passFTextControllerValidator;
    conPassFVisibility = false;
    conPassFTextControllerValidator = _conPassFTextControllerValidator;

    debugLogWidgetClass(this);
  }

  @override
  void dispose() {
    fNameFFocusNode?.dispose();
    fNameFTextController?.dispose();

    lastNameFFocusNode?.dispose();
    lastNameFTextController?.dispose();

    emailFFocusNode?.dispose();
    emailFTextController?.dispose();

    passFFocusNode?.dispose();
    passFTextController?.dispose();

    conPassFFocusNode?.dispose();
    conPassFTextController?.dispose();
  }

  @override
  WidgetClassDebugData toWidgetClassDebugData() => WidgetClassDebugData(
        widgetStates: {
          'fNameFText': debugSerializeParam(
            fNameFTextController?.text,
            ParamType.String,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=SignupPage',
            name: 'String',
            nullable: true,
          ),
          'lastNameFText': debugSerializeParam(
            lastNameFTextController?.text,
            ParamType.String,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=SignupPage',
            name: 'String',
            nullable: true,
          ),
          'emailFText': debugSerializeParam(
            emailFTextController?.text,
            ParamType.String,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=SignupPage',
            name: 'String',
            nullable: true,
          ),
          'passFText': debugSerializeParam(
            passFTextController?.text,
            ParamType.String,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=SignupPage',
            name: 'String',
            nullable: true,
          ),
          'conPassFText': debugSerializeParam(
            conPassFTextController?.text,
            ParamType.String,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=SignupPage',
            name: 'String',
            nullable: true,
          )
        },
        actionOutputs: {
          'formValid': debugSerializeParam(
            formValid,
            ParamType.bool,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=SignupPage',
            name: 'bool',
            nullable: true,
          ),
          'signupResult': debugSerializeParam(
            signupResult,
            ParamType.ApiResponse,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=SignupPage',
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
            'https://app.flutterflow.io/project/pasargad-82dm1q/tab=uiBuilder&page=SignupPage',
        searchReference: 'reference=OgpTaWdudXBQYWdlUAFaClNpZ251cFBhZ2U=',
        widgetClassName: 'SignupPage',
      );
}
