import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'add_address_page_widget.dart' show AddAddressPageWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class AddAddressPageModel extends FlutterFlowModel<AddAddressPageWidget> {
  ///  Local state fields for this page.

  dynamic _address;
  set address(dynamic value) {
    _address = value;
    debugLogWidgetClass(this);
  }

  dynamic get address => _address;

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // Stores action output result for [Backend Call - API (userAddresses)] action in AddAddressPage widget.
  ApiCallResponse? _apiResultp1h;
  set apiResultp1h(ApiCallResponse? value) {
    _apiResultp1h = value;
    debugLogWidgetClass(this);
  }

  ApiCallResponse? get apiResultp1h => _apiResultp1h;

  // Stores action output result for [Custom Action - getBillingAddress] action in AddAddressPage widget.
  dynamic? _billingAddress;
  set billingAddress(dynamic? value) {
    _billingAddress = value;
    debugLogWidgetClass(this);
  }

  dynamic? get billingAddress => _billingAddress;

  // Stores action output result for [Custom Action - getShippingAddress] action in AddAddressPage widget.
  dynamic? _shippingAddress;
  set shippingAddress(dynamic? value) {
    _shippingAddress = value;
    debugLogWidgetClass(this);
  }

  dynamic? get shippingAddress => _shippingAddress;

  // State field(s) for streetF widget.
  FocusNode? streetFFocusNode;
  TextEditingController? streetFTextController;
  String? Function(BuildContext, String?)? streetFTextControllerValidator;
  String? _streetFTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Street is required';
    }

    if (val.length < 1) {
      return 'Street is required';
    }

    return null;
  }

  // State field(s) for cityF widget.
  FocusNode? cityFFocusNode;
  TextEditingController? cityFTextController;
  String? Function(BuildContext, String?)? cityFTextControllerValidator;
  String? _cityFTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'City is required';
    }

    if (val.length < 1) {
      return 'City is required';
    }

    return null;
  }

  // State field(s) for stateF widget.
  FocusNode? stateFFocusNode;
  TextEditingController? stateFTextController;
  String? Function(BuildContext, String?)? stateFTextControllerValidator;
  String? _stateFTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'State is required';
    }

    if (val.length < 1) {
      return 'State is required';
    }

    return null;
  }

  // State field(s) for postCodeF widget.
  FocusNode? postCodeFFocusNode;
  TextEditingController? postCodeFTextController;
  String? Function(BuildContext, String?)? postCodeFTextControllerValidator;
  String? _postCodeFTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Post Code is required';
    }

    if (val.length < 1) {
      return 'Post Code is required';
    }

    return null;
  }

  // State field(s) for countryF widget.
  FocusNode? countryFFocusNode;
  TextEditingController? countryFTextController;
  String? Function(BuildContext, String?)? countryFTextControllerValidator;
  String? _countryFTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Country is required';
    }

    if (val.length < 1) {
      return 'Country is required';
    }

    return null;
  }

  // State field(s) for phoneF widget.
  FocusNode? phoneFFocusNode;
  TextEditingController? phoneFTextController;
  late MaskTextInputFormatter phoneFMask;
  String? Function(BuildContext, String?)? phoneFTextControllerValidator;
  String? _phoneFTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Phone is required';
    }

    if (!RegExp('^\\+?\\s*(\\(?\\d{3}\\)?[\\s-]?\\d{3}[\\s-]?\\d{4})\$')
        .hasMatch(val)) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  // Stores action output result for [Validate Form] action in Button widget.
  bool? _isFormValid;
  set isFormValid(bool? value) {
    _isFormValid = value;
    debugLogWidgetClass(this);
  }

  bool? get isFormValid => _isFormValid;

  // Stores action output result for [Backend Call - API (checkoutBilling)] action in Button widget.
  ApiCallResponse? _apiResultc85;
  set apiResultc85(ApiCallResponse? value) {
    _apiResultc85 = value;
    debugLogWidgetClass(this);
  }

  ApiCallResponse? get apiResultc85 => _apiResultc85;

  // Stores action output result for [Backend Call - API (checkoutShipping)] action in Button widget.
  ApiCallResponse? _shippingCheckout;
  set shippingCheckout(ApiCallResponse? value) {
    _shippingCheckout = value;
    debugLogWidgetClass(this);
  }

  ApiCallResponse? get shippingCheckout => _shippingCheckout;

  final Map<String, DebugDataField> debugGeneratorVariables = {};
  final Map<String, DebugDataField> debugBackendQueries = {};
  final Map<String, FlutterFlowModel> widgetBuilderComponents = {};
  @override
  void initState(BuildContext context) {
    streetFTextControllerValidator = _streetFTextControllerValidator;
    cityFTextControllerValidator = _cityFTextControllerValidator;
    stateFTextControllerValidator = _stateFTextControllerValidator;
    postCodeFTextControllerValidator = _postCodeFTextControllerValidator;
    countryFTextControllerValidator = _countryFTextControllerValidator;
    phoneFTextControllerValidator = _phoneFTextControllerValidator;

    debugLogWidgetClass(this);
  }

  @override
  void dispose() {
    streetFFocusNode?.dispose();
    streetFTextController?.dispose();

    cityFFocusNode?.dispose();
    cityFTextController?.dispose();

    stateFFocusNode?.dispose();
    stateFTextController?.dispose();

    postCodeFFocusNode?.dispose();
    postCodeFTextController?.dispose();

    countryFFocusNode?.dispose();
    countryFTextController?.dispose();

    phoneFFocusNode?.dispose();
    phoneFTextController?.dispose();
  }

  @override
  WidgetClassDebugData toWidgetClassDebugData() => WidgetClassDebugData(
        widgetParameters: {
          'isBilling': debugSerializeParam(
            widget?.isBilling,
            ParamType.bool,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=AddAddressPage',
            searchReference:
                'reference=SiQKEwoJaXNCaWxsaW5nEgZuc3hsbWUqBxIFZmFsc2VyBAgFIAFQAVoJaXNCaWxsaW5n',
            name: 'bool',
            nullable: false,
          ),
          'amount': debugSerializeParam(
            widget?.amount,
            ParamType.String,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=AddAddressPage',
            searchReference:
                'reference=ShgKEAoGYW1vdW50EgZ2dnA5cGlyBAgDIAFQAVoGYW1vdW50',
            name: 'String',
            nullable: true,
          )
        }.withoutNulls,
        localStates: {
          'address': debugSerializeParam(
            address,
            ParamType.JSON,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=AddAddressPage',
            searchReference:
                'reference=QhYKEAoHYWRkcmVzcxIFZGZ2dTJyAggJUAFaB2FkZHJlc3NiDkFkZEFkZHJlc3NQYWdl',
            name: 'dynamic',
            nullable: true,
          )
        },
        widgetStates: {
          'streetFText': debugSerializeParam(
            streetFTextController?.text,
            ParamType.String,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=AddAddressPage',
            name: 'String',
            nullable: true,
          ),
          'cityFText': debugSerializeParam(
            cityFTextController?.text,
            ParamType.String,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=AddAddressPage',
            name: 'String',
            nullable: true,
          ),
          'stateFText': debugSerializeParam(
            stateFTextController?.text,
            ParamType.String,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=AddAddressPage',
            name: 'String',
            nullable: true,
          ),
          'postCodeFText': debugSerializeParam(
            postCodeFTextController?.text,
            ParamType.String,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=AddAddressPage',
            name: 'String',
            nullable: true,
          ),
          'countryFText': debugSerializeParam(
            countryFTextController?.text,
            ParamType.String,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=AddAddressPage',
            name: 'String',
            nullable: true,
          ),
          'phoneFText': debugSerializeParam(
            phoneFTextController?.text,
            ParamType.String,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=AddAddressPage',
            name: 'String',
            nullable: true,
          )
        },
        actionOutputs: {
          'apiResultp1h': debugSerializeParam(
            apiResultp1h,
            ParamType.ApiResponse,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=AddAddressPage',
            name: 'ApiCallResponse',
            nullable: true,
          ),
          'billingAddress': debugSerializeParam(
            billingAddress,
            ParamType.JSON,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=AddAddressPage',
            name: 'dynamic',
            nullable: true,
          ),
          'shippingAddress': debugSerializeParam(
            shippingAddress,
            ParamType.JSON,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=AddAddressPage',
            name: 'dynamic',
            nullable: true,
          ),
          'isFormValid': debugSerializeParam(
            isFormValid,
            ParamType.bool,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=AddAddressPage',
            name: 'bool',
            nullable: true,
          ),
          'apiResultc85': debugSerializeParam(
            apiResultc85,
            ParamType.ApiResponse,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=AddAddressPage',
            name: 'ApiCallResponse',
            nullable: true,
          ),
          'shippingCheckout': debugSerializeParam(
            shippingCheckout,
            ParamType.ApiResponse,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=AddAddressPage',
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
            'https://app.flutterflow.io/project/pasargad-82dm1q/tab=uiBuilder&page=AddAddressPage',
        searchReference:
            'reference=Og5BZGRBZGRyZXNzUGFnZVABWg5BZGRBZGRyZXNzUGFnZQ==',
        widgetClassName: 'AddAddressPage',
      );
}
