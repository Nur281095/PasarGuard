import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/random_data_util.dart' as random_data;
import 'credit_card_page_widget.dart' show CreditCardPageWidget;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class CreditCardPageModel extends FlutterFlowModel<CreditCardPageWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for nameF widget.
  FocusNode? nameFFocusNode;
  TextEditingController? nameFTextController;
  String? Function(BuildContext, String?)? nameFTextControllerValidator;
  String? _nameFTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Name is required';
    }

    return null;
  }

  // State field(s) for cardNumberF widget.
  FocusNode? cardNumberFFocusNode;
  TextEditingController? cardNumberFTextController;
  late MaskTextInputFormatter cardNumberFMask;
  String? Function(BuildContext, String?)? cardNumberFTextControllerValidator;
  String? _cardNumberFTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Card Number is required';
    }

    if (!RegExp('^(?:\\d{4} ){3}\\d{4}\$').hasMatch(val)) {
      return 'Please enter a correct card number';
    }
    return null;
  }

  // State field(s) for expDateF widget.
  FocusNode? expDateFFocusNode;
  TextEditingController? expDateFTextController;
  late MaskTextInputFormatter expDateFMask;
  String? Function(BuildContext, String?)? expDateFTextControllerValidator;
  String? _expDateFTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Exp. Date is required';
    }

    if (!RegExp('^(0[1-9]|1[0-2])/\\d{2}\$').hasMatch(val)) {
      return 'Please enter a valid expiry date';
    }
    return null;
  }

  // State field(s) for cvvF widget.
  FocusNode? cvvFFocusNode;
  TextEditingController? cvvFTextController;
  String? Function(BuildContext, String?)? cvvFTextControllerValidator;
  String? _cvvFTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'CVV is required';
    }

    if (val.length < 3) {
      return 'CVV is required';
    }

    return null;
  }

  // Stores action output result for [Backend Call - API (location)] action in Button widget.
  ApiCallResponse? _locationApiResult;
  set locationApiResult(ApiCallResponse? value) {
    _locationApiResult = value;
    debugLogWidgetClass(this);
  }

  ApiCallResponse? get locationApiResult => _locationApiResult;

  // Stores action output result for [Backend Call - API (paymentlinks)] action in Button widget.
  ApiCallResponse? _squareApiResult;
  set squareApiResult(ApiCallResponse? value) {
    _squareApiResult = value;
    debugLogWidgetClass(this);
  }

  ApiCallResponse? get squareApiResult => _squareApiResult;

  final Map<String, DebugDataField> debugGeneratorVariables = {};
  final Map<String, DebugDataField> debugBackendQueries = {};
  final Map<String, FlutterFlowModel> widgetBuilderComponents = {};
  @override
  void initState(BuildContext context) {
    nameFTextControllerValidator = _nameFTextControllerValidator;
    cardNumberFTextControllerValidator = _cardNumberFTextControllerValidator;
    expDateFTextControllerValidator = _expDateFTextControllerValidator;
    cvvFTextControllerValidator = _cvvFTextControllerValidator;

    debugLogWidgetClass(this);
  }

  @override
  void dispose() {
    nameFFocusNode?.dispose();
    nameFTextController?.dispose();

    cardNumberFFocusNode?.dispose();
    cardNumberFTextController?.dispose();

    expDateFFocusNode?.dispose();
    expDateFTextController?.dispose();

    cvvFFocusNode?.dispose();
    cvvFTextController?.dispose();
  }

  @override
  WidgetClassDebugData toWidgetClassDebugData() => WidgetClassDebugData(
        widgetParameters: {
          'amount': debugSerializeParam(
            widget?.amount,
            ParamType.String,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=CreditCardPage',
            searchReference:
                'reference=ShgKEAoGYW1vdW50EgZ6bmY3YmZyBAgDIAFQAVoGYW1vdW50',
            name: 'String',
            nullable: true,
          )
        }.withoutNulls,
        widgetStates: {
          'nameFText': debugSerializeParam(
            nameFTextController?.text,
            ParamType.String,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=CreditCardPage',
            name: 'String',
            nullable: true,
          ),
          'cardNumberFText': debugSerializeParam(
            cardNumberFTextController?.text,
            ParamType.String,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=CreditCardPage',
            name: 'String',
            nullable: true,
          ),
          'expDateFText': debugSerializeParam(
            expDateFTextController?.text,
            ParamType.String,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=CreditCardPage',
            name: 'String',
            nullable: true,
          ),
          'cvvFText': debugSerializeParam(
            cvvFTextController?.text,
            ParamType.String,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=CreditCardPage',
            name: 'String',
            nullable: true,
          )
        },
        actionOutputs: {
          'locationApiResult': debugSerializeParam(
            locationApiResult,
            ParamType.ApiResponse,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=CreditCardPage',
            name: 'ApiCallResponse',
            nullable: true,
          ),
          'squareApiResult': debugSerializeParam(
            squareApiResult,
            ParamType.ApiResponse,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=CreditCardPage',
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
            'https://app.flutterflow.io/project/pasargad-82dm1q/tab=uiBuilder&page=CreditCardPage',
        searchReference:
            'reference=Og5DcmVkaXRDYXJkUGFnZVABWg5DcmVkaXRDYXJkUGFnZQ==',
        widgetClassName: 'CreditCardPage',
      );
}
