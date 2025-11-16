import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'dart:convert'; // <-- add this for pretty JSON logs
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'add_address_page_model.dart';
export 'add_address_page_model.dart';

class AddAddressPageWidget extends StatefulWidget {
  const AddAddressPageWidget({
    super.key,
    bool? isBilling,
    required this.amount,
  }) : this.isBilling = isBilling ?? false;

  final bool isBilling;
  final String? amount;

  static String routeName = 'AddAddressPage';
  static String routePath = '/addAddressPage';

  @override
  State<AddAddressPageWidget> createState() => _AddAddressPageWidgetState();
}

class _AddAddressPageWidgetState extends State<AddAddressPageWidget>
    with RouteAware {
  late AddAddressPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  // ---------- Simple API log helpers ----------
  void _logApiSuccess(String name, ApiCallResponse res, {Map<String, Object?> extra = const {}}) {
    final enc = const JsonEncoder.withIndent('  ');
    final body = res.jsonBody ?? res.bodyText ?? {};
    debugPrint('✅ API [$name] SUCCESS');
    try {
      debugPrint(enc.convert({'extra': extra, 'body': body}));
    } catch (_) {
      debugPrint(body.toString());
    }
  }

  void _logApiError(String name, {ApiCallResponse? res, Object? error, StackTrace? stack, Map<String, Object?> extra = const {}}) {
    final enc = const JsonEncoder.withIndent('  ');
    debugPrint('❌ API [$name] ERROR');
    if (error != null) debugPrint('error: $error');
    if (stack != null) debugPrint(stack.toString());
    if (res != null) {
      final body = res.jsonBody ?? res.bodyText ?? {};
      try {
        debugPrint(enc.convert({'extra': extra, 'body': body}));
      } catch (_) {
        debugPrint(body.toString());
      }
    } else if (extra.isNotEmpty) {
      debugPrint(enc.convert({'extra': extra}));
    }
  }

  String _safeStr(dynamic v) {
    if (v == null) return '';
    final s = v.toString();
    return (s == 'null') ? '' : s;
  }

  // Helper methods
  String _s(dynamic v) => v == null ? '' : v.toString();

  String _joinNonEmpty(List<String?> parts) =>
      parts.where((p) => (p?.trim().isNotEmpty ?? false)).join(', ');

  void _prefillFromAddress(dynamic address) {
    safeSetState(() {
      _model.address = address;
      _model.streetFTextController?.text = _s(getJsonField(address, r'$.street'));
      _model.cityFTextController?.text = _s(getJsonField(address, r'$.city'));
      _model.stateFTextController?.text = _s(getJsonField(address, r'$.state'));
      _model.postCodeFTextController?.text = _s(getJsonField(address, r'$.postal_code'));
      _model.countryFTextController?.text = _s(getJsonField(address, r'$.country'));
      _model.phoneFTextController?.text = _s(getJsonField(address, r'$.phone'));
      _model.phoneFMask.updateMask(
        newValue: TextEditingValue(text: _model.phoneFTextController!.text),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AddAddressPageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      try {
        // Fetch user addresses
        final resp = await PasargadrugsGroup.userAddressesCall.call(
          token: currentAuthenticationToken,
        );
        _model.apiResultp1h = resp;

        final msg = PasargadrugsGroup.userAddressesCall.message(resp.jsonBody) ?? '';
        final addresses = PasargadrugsGroup.userAddressesCall
            .addresses(resp.jsonBody)
            ?.toList() ??
            [];

        if (resp.succeeded) {
          _logApiSuccess('userAddresses', resp, extra: {
            'message': msg,
            'addresses_count': addresses.length,
          });

          // Choose which address to use and prefill fields
          if (widget.isBilling) {
            _model.billingAddress = await actions.getBillingAddress(addresses);
            _model.address = _model.billingAddress;
          } else {
            _model.shippingAddress = await actions.getShippingAddress(addresses);
            _model.address = _model.shippingAddress;
          }
          safeSetState(() {});

          // Prefill (guard against "null" showing up)
          safeSetState(() {
            _model.streetFTextController?.text =
                _safeStr(getJsonField(_model.address, r'$.street'));
            _model.cityFTextController?.text =
                _safeStr(getJsonField(_model.address, r'$.city'));
            _model.stateFTextController?.text =
                _safeStr(getJsonField(_model.address, r'$.state'));
            _model.postCodeFTextController?.text =
                _safeStr(getJsonField(_model.address, r'$.postal_code'));
            _model.countryFTextController?.text =
                _safeStr(getJsonField(_model.address, r'$.country'));
            _model.phoneFTextController?.text =
                _safeStr(getJsonField(_model.address, r'$.phone'));
            _model.phoneFMask.updateMask(
              newValue: TextEditingValue(text: _model.phoneFTextController!.text),
            );
          });
        } else {
          _logApiError('userAddresses', res: resp, extra: {
            'message': msg,
          });
        }
      } catch (e, st) {
        _logApiError('userAddresses', error: e, stack: st);
      }
    });

    _model.streetFTextController ??= TextEditingController(text: '')
      ..addListener(() {
        debugLogWidgetClass(_model);
      });
    _model.streetFFocusNode ??= FocusNode();

    _model.cityFTextController ??= TextEditingController(text: '')
      ..addListener(() {
        debugLogWidgetClass(_model);
      });
    _model.cityFFocusNode ??= FocusNode();

    _model.stateFTextController ??= TextEditingController(text: '')
      ..addListener(() {
        debugLogWidgetClass(_model);
      });
    _model.stateFFocusNode ??= FocusNode();

    _model.postCodeFTextController ??= TextEditingController(text: '')
      ..addListener(() {
        debugLogWidgetClass(_model);
      });
    _model.postCodeFFocusNode ??= FocusNode();

    _model.countryFTextController ??= TextEditingController(text: '')
      ..addListener(() {
        debugLogWidgetClass(_model);
      });
    _model.countryFFocusNode ??= FocusNode();

    _model.phoneFTextController ??= TextEditingController(text: '')
      ..addListener(() {
        debugLogWidgetClass(_model);
      });
    _model.phoneFFocusNode ??= FocusNode();

    _model.phoneFMask = MaskTextInputFormatter(mask: '(###) ###-####');
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);

    _model.dispose();

    super.dispose();
  }

  @override
  void didUpdateWidget(AddAddressPageWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _model.widget = widget;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final route = DebugModalRoute.of(context);
    if (route != null) {
      routeObserver.subscribe(this, route);
    }
    debugLogGlobalProperty(context);
  }

  @override
  void didPopNext() {
    if (mounted && DebugFlutterFlowModelContext.maybeOf(context) == null) {
      setState(() => _model.isRouteVisible = true);
      debugLogWidgetClass(_model);
    }
  }

  @override
  void didPush() {
    if (mounted && DebugFlutterFlowModelContext.maybeOf(context) == null) {
      setState(() => _model.isRouteVisible = true);
      debugLogWidgetClass(_model);
    }
  }

  @override
  void didPop() {
    _model.isRouteVisible = false;
  }

  @override
  void didPushNext() {
    _model.isRouteVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    DebugFlutterFlowModelContext.maybeOf(context)
        ?.parentModelCallback
        ?.call(_model);
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: Icon(
              Icons.arrow_back_rounded,
              color: Colors.black,
              size: 30.0,
            ),
            onPressed: () async {
              context.pop();
            },
          ),
          title: Text(
            widget.isBilling ? 'Add Billing Address' : 'Add Shipping Address',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
              font: GoogleFonts.interTight(
                fontWeight:
                FlutterFlowTheme.of(context).headlineMedium.fontWeight,
                fontStyle:
                FlutterFlowTheme.of(context).headlineMedium.fontStyle,
              ),
              color: Colors.black,
              fontSize: 22.0,
              letterSpacing: 0.0,
              fontWeight:
              FlutterFlowTheme.of(context).headlineMedium.fontWeight,
              fontStyle:
              FlutterFlowTheme.of(context).headlineMedium.fontStyle,
            ),
          ),
          actions: [],
          centerTitle: true,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xFFF9F9F9),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(0.0),
                        bottomRight: Radius.circular(0.0),
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                    ),
                    child: Stack(
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 30.0, 0.0, 0.0),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(),
                            child: Form(
                              key: _model.formKey,
                              autovalidateMode: AutovalidateMode.disabled,
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20.0, 20.0, 20.0, 0.0),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                      ),
                                      child: TextFormField(
                                        controller:
                                        _model.streetFTextController,
                                        focusNode: _model.streetFFocusNode,
                                        autofocus: true,
                                        textInputAction: TextInputAction.next,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelStyle: FlutterFlowTheme.of(
                                              context)
                                              .labelMedium
                                              .override(
                                            font: GoogleFonts.robotoFlex(
                                              fontWeight: FontWeight.bold,
                                              fontStyle:
                                              FlutterFlowTheme.of(
                                                  context)
                                                  .labelMedium
                                                  .fontStyle,
                                            ),
                                            color: Color(0xFF344054),
                                            fontSize: 15.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.bold,
                                            fontStyle:
                                            FlutterFlowTheme.of(context)
                                                .labelMedium
                                                .fontStyle,
                                          ),
                                          hintText: 'Street',
                                          hintStyle: FlutterFlowTheme.of(
                                              context)
                                              .labelMedium
                                              .override(
                                            font: GoogleFonts.inter(
                                              fontWeight:
                                              FlutterFlowTheme.of(
                                                  context)
                                                  .labelMedium
                                                  .fontWeight,
                                              fontStyle:
                                              FlutterFlowTheme.of(
                                                  context)
                                                  .labelMedium
                                                  .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight:
                                            FlutterFlowTheme.of(context)
                                                .labelMedium
                                                .fontWeight,
                                            fontStyle:
                                            FlutterFlowTheme.of(context)
                                                .labelMedium
                                                .fontStyle,
                                          ),
                                          errorStyle: FlutterFlowTheme.of(
                                              context)
                                              .bodyMedium
                                              .override(
                                            font: GoogleFonts.robotoFlex(
                                              fontWeight: FontWeight.normal,
                                              fontStyle:
                                              FlutterFlowTheme.of(
                                                  context)
                                                  .bodyMedium
                                                  .fontStyle,
                                            ),
                                            color:
                                            FlutterFlowTheme.of(context)
                                                .error,
                                            fontSize: 10.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.normal,
                                            fontStyle:
                                            FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .fontStyle,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                              FlutterFlowTheme.of(context)
                                                  .alternate,
                                              width: 2.0,
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(25.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                              FlutterFlowTheme.of(context)
                                                  .primary,
                                              width: 2.0,
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(25.0),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                              FlutterFlowTheme.of(context)
                                                  .error,
                                              width: 2.0,
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(25.0),
                                          ),
                                          focusedErrorBorder:
                                          OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                              FlutterFlowTheme.of(context)
                                                  .error,
                                              width: 2.0,
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(25.0),
                                          ),
                                          contentPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              20.0, 0.0, 20.0, 0.0),
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                          font: GoogleFonts.robotoFlex(
                                            fontWeight: FontWeight.bold,
                                            fontStyle:
                                            FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .fontStyle,
                                          ),
                                          color: Color(0xFF344054),
                                          fontSize: 15.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.bold,
                                          fontStyle:
                                          FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .fontStyle,
                                        ),
                                        validator: _model
                                            .streetFTextControllerValidator
                                            .asValidator(context),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20.0, 20.0, 20.0, 0.0),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                      ),
                                      child: TextFormField(
                                        controller: _model.cityFTextController,
                                        focusNode: _model.cityFFocusNode,
                                        autofocus: true,
                                        textInputAction: TextInputAction.next,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelStyle: FlutterFlowTheme.of(
                                              context)
                                              .labelMedium
                                              .override(
                                            font: GoogleFonts.robotoFlex(
                                              fontWeight: FontWeight.bold,
                                              fontStyle:
                                              FlutterFlowTheme.of(
                                                  context)
                                                  .labelMedium
                                                  .fontStyle,
                                            ),
                                            color: Color(0xFF344054),
                                            fontSize: 15.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.bold,
                                            fontStyle:
                                            FlutterFlowTheme.of(context)
                                                .labelMedium
                                                .fontStyle,
                                          ),
                                          hintText: 'City',
                                          hintStyle: FlutterFlowTheme.of(
                                              context)
                                              .labelMedium
                                              .override(
                                            font: GoogleFonts.inter(
                                              fontWeight:
                                              FlutterFlowTheme.of(
                                                  context)
                                                  .labelMedium
                                                  .fontWeight,
                                              fontStyle:
                                              FlutterFlowTheme.of(
                                                  context)
                                                  .labelMedium
                                                  .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight:
                                            FlutterFlowTheme.of(context)
                                                .labelMedium
                                                .fontWeight,
                                            fontStyle:
                                            FlutterFlowTheme.of(context)
                                                .labelMedium
                                                .fontStyle,
                                          ),
                                          errorStyle: FlutterFlowTheme.of(
                                              context)
                                              .bodyMedium
                                              .override(
                                            font: GoogleFonts.robotoFlex(
                                              fontWeight: FontWeight.normal,
                                              fontStyle:
                                              FlutterFlowTheme.of(
                                                  context)
                                                  .bodyMedium
                                                  .fontStyle,
                                            ),
                                            color:
                                            FlutterFlowTheme.of(context)
                                                .error,
                                            fontSize: 10.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.normal,
                                            fontStyle:
                                            FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .fontStyle,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                              FlutterFlowTheme.of(context)
                                                  .alternate,
                                              width: 2.0,
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(25.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                              FlutterFlowTheme.of(context)
                                                  .primary,
                                              width: 2.0,
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(25.0),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                              FlutterFlowTheme.of(context)
                                                  .error,
                                              width: 2.0,
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(25.0),
                                          ),
                                          focusedErrorBorder:
                                          OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                              FlutterFlowTheme.of(context)
                                                  .error,
                                              width: 2.0,
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(25.0),
                                          ),
                                          contentPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              20.0, 0.0, 20.0, 0.0),
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                          font: GoogleFonts.robotoFlex(
                                            fontWeight: FontWeight.bold,
                                            fontStyle:
                                            FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .fontStyle,
                                          ),
                                          color: Color(0xFF344054),
                                          fontSize: 15.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.bold,
                                          fontStyle:
                                          FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .fontStyle,
                                        ),
                                        validator: _model
                                            .cityFTextControllerValidator
                                            .asValidator(context),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20.0, 20.0, 20.0, 0.0),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                      ),
                                      child: TextFormField(
                                        controller: _model.stateFTextController,
                                        focusNode: _model.stateFFocusNode,
                                        autofocus: true,
                                        textInputAction: TextInputAction.next,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelStyle: FlutterFlowTheme.of(
                                              context)
                                              .labelMedium
                                              .override(
                                            font: GoogleFonts.robotoFlex(
                                              fontWeight: FontWeight.bold,
                                              fontStyle:
                                              FlutterFlowTheme.of(
                                                  context)
                                                  .labelMedium
                                                  .fontStyle,
                                            ),
                                            color: Color(0xFF344054),
                                            fontSize: 15.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.bold,
                                            fontStyle:
                                            FlutterFlowTheme.of(context)
                                                .labelMedium
                                                .fontStyle,
                                          ),
                                          hintText: 'State',
                                          hintStyle: FlutterFlowTheme.of(
                                              context)
                                              .labelMedium
                                              .override(
                                            font: GoogleFonts.inter(
                                              fontWeight:
                                              FlutterFlowTheme.of(
                                                  context)
                                                  .labelMedium
                                                  .fontWeight,
                                              fontStyle:
                                              FlutterFlowTheme.of(
                                                  context)
                                                  .labelMedium
                                                  .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight:
                                            FlutterFlowTheme.of(context)
                                                .labelMedium
                                                .fontWeight,
                                            fontStyle:
                                            FlutterFlowTheme.of(context)
                                                .labelMedium
                                                .fontStyle,
                                          ),
                                          errorStyle: FlutterFlowTheme.of(
                                              context)
                                              .bodyMedium
                                              .override(
                                            font: GoogleFonts.robotoFlex(
                                              fontWeight: FontWeight.normal,
                                              fontStyle:
                                              FlutterFlowTheme.of(
                                                  context)
                                                  .bodyMedium
                                                  .fontStyle,
                                            ),
                                            color:
                                            FlutterFlowTheme.of(context)
                                                .error,
                                            fontSize: 10.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.normal,
                                            fontStyle:
                                            FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .fontStyle,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                              FlutterFlowTheme.of(context)
                                                  .alternate,
                                              width: 2.0,
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(25.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                              FlutterFlowTheme.of(context)
                                                  .primary,
                                              width: 2.0,
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(25.0),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                              FlutterFlowTheme.of(context)
                                                  .error,
                                              width: 2.0,
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(25.0),
                                          ),
                                          focusedErrorBorder:
                                          OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                              FlutterFlowTheme.of(context)
                                                  .error,
                                              width: 2.0,
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(25.0),
                                          ),
                                          contentPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              20.0, 0.0, 20.0, 0.0),
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                          font: GoogleFonts.robotoFlex(
                                            fontWeight: FontWeight.bold,
                                            fontStyle:
                                            FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .fontStyle,
                                          ),
                                          color: Color(0xFF344054),
                                          fontSize: 15.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.bold,
                                          fontStyle:
                                          FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .fontStyle,
                                        ),
                                        validator: _model
                                            .stateFTextControllerValidator
                                            .asValidator(context),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20.0, 20.0, 20.0, 0.0),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                      ),
                                      child: TextFormField(
                                        controller:
                                        _model.postCodeFTextController,
                                        focusNode: _model.postCodeFFocusNode,
                                        autofocus: true,
                                        textInputAction: TextInputAction.next,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelStyle: FlutterFlowTheme.of(
                                              context)
                                              .labelMedium
                                              .override(
                                            font: GoogleFonts.robotoFlex(
                                              fontWeight: FontWeight.bold,
                                              fontStyle:
                                              FlutterFlowTheme.of(
                                                  context)
                                                  .labelMedium
                                                  .fontStyle,
                                            ),
                                            color: Color(0xFF344054),
                                            fontSize: 15.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.bold,
                                            fontStyle:
                                            FlutterFlowTheme.of(context)
                                                .labelMedium
                                                .fontStyle,
                                          ),
                                          hintText: 'Post Code',
                                          hintStyle: FlutterFlowTheme.of(
                                              context)
                                              .labelMedium
                                              .override(
                                            font: GoogleFonts.inter(
                                              fontWeight:
                                              FlutterFlowTheme.of(
                                                  context)
                                                  .labelMedium
                                                  .fontWeight,
                                              fontStyle:
                                              FlutterFlowTheme.of(
                                                  context)
                                                  .labelMedium
                                                  .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight:
                                            FlutterFlowTheme.of(context)
                                                .labelMedium
                                                .fontWeight,
                                            fontStyle:
                                            FlutterFlowTheme.of(context)
                                                .labelMedium
                                                .fontStyle,
                                          ),
                                          errorStyle: FlutterFlowTheme.of(
                                              context)
                                              .bodyMedium
                                              .override(
                                            font: GoogleFonts.robotoFlex(
                                              fontWeight: FontWeight.normal,
                                              fontStyle:
                                              FlutterFlowTheme.of(
                                                  context)
                                                  .bodyMedium
                                                  .fontStyle,
                                            ),
                                            color:
                                            FlutterFlowTheme.of(context)
                                                .error,
                                            fontSize: 10.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.normal,
                                            fontStyle:
                                            FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .fontStyle,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                              FlutterFlowTheme.of(context)
                                                  .alternate,
                                              width: 2.0,
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(25.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                              FlutterFlowTheme.of(context)
                                                  .primary,
                                              width: 2.0,
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(25.0),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                              FlutterFlowTheme.of(context)
                                                  .error,
                                              width: 2.0,
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(25.0),
                                          ),
                                          focusedErrorBorder:
                                          OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                              FlutterFlowTheme.of(context)
                                                  .error,
                                              width: 2.0,
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(25.0),
                                          ),
                                          contentPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              20.0, 0.0, 20.0, 0.0),
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                          font: GoogleFonts.robotoFlex(
                                            fontWeight: FontWeight.bold,
                                            fontStyle:
                                            FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .fontStyle,
                                          ),
                                          color: Color(0xFF344054),
                                          fontSize: 15.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.bold,
                                          fontStyle:
                                          FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .fontStyle,
                                        ),
                                        validator: _model
                                            .postCodeFTextControllerValidator
                                            .asValidator(context),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20.0, 20.0, 20.0, 0.0),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                      ),
                                      child: TextFormField(
                                        controller:
                                        _model.countryFTextController,
                                        focusNode: _model.countryFFocusNode,
                                        autofocus: true,
                                        textInputAction: TextInputAction.next,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelStyle: FlutterFlowTheme.of(
                                              context)
                                              .labelMedium
                                              .override(
                                            font: GoogleFonts.robotoFlex(
                                              fontWeight: FontWeight.bold,
                                              fontStyle:
                                              FlutterFlowTheme.of(
                                                  context)
                                                  .labelMedium
                                                  .fontStyle,
                                            ),
                                            color: Color(0xFF344054),
                                            fontSize: 15.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.bold,
                                            fontStyle:
                                            FlutterFlowTheme.of(context)
                                                .labelMedium
                                                .fontStyle,
                                          ),
                                          hintText: 'Country',
                                          hintStyle: FlutterFlowTheme.of(
                                              context)
                                              .labelMedium
                                              .override(
                                            font: GoogleFonts.inter(
                                              fontWeight:
                                              FlutterFlowTheme.of(
                                                  context)
                                                  .labelMedium
                                                  .fontWeight,
                                              fontStyle:
                                              FlutterFlowTheme.of(
                                                  context)
                                                  .labelMedium
                                                  .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight:
                                            FlutterFlowTheme.of(context)
                                                .labelMedium
                                                .fontWeight,
                                            fontStyle:
                                            FlutterFlowTheme.of(context)
                                                .labelMedium
                                                .fontStyle,
                                          ),
                                          errorStyle: FlutterFlowTheme.of(
                                              context)
                                              .bodyMedium
                                              .override(
                                            font: GoogleFonts.robotoFlex(
                                              fontWeight: FontWeight.normal,
                                              fontStyle:
                                              FlutterFlowTheme.of(
                                                  context)
                                                  .bodyMedium
                                                  .fontStyle,
                                            ),
                                            color:
                                            FlutterFlowTheme.of(context)
                                                .error,
                                            fontSize: 10.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.normal,
                                            fontStyle:
                                            FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .fontStyle,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                              FlutterFlowTheme.of(context)
                                                  .alternate,
                                              width: 2.0,
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(25.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                              FlutterFlowTheme.of(context)
                                                  .primary,
                                              width: 2.0,
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(25.0),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                              FlutterFlowTheme.of(context)
                                                  .error,
                                              width: 2.0,
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(25.0),
                                          ),
                                          focusedErrorBorder:
                                          OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                              FlutterFlowTheme.of(context)
                                                  .error,
                                              width: 2.0,
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(25.0),
                                          ),
                                          contentPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              20.0, 0.0, 20.0, 0.0),
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                          font: GoogleFonts.robotoFlex(
                                            fontWeight: FontWeight.bold,
                                            fontStyle:
                                            FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .fontStyle,
                                          ),
                                          color: Color(0xFF344054),
                                          fontSize: 15.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.bold,
                                          fontStyle:
                                          FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .fontStyle,
                                        ),
                                        validator: _model
                                            .countryFTextControllerValidator
                                            .asValidator(context),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20.0, 20.0, 20.0, 0.0),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                      ),
                                      child: TextFormField(
                                        controller: _model.phoneFTextController,
                                        focusNode: _model.phoneFFocusNode,
                                        autofocus: true,
                                        textInputAction: TextInputAction.next,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelStyle: FlutterFlowTheme.of(
                                              context)
                                              .labelMedium
                                              .override(
                                            font: GoogleFonts.robotoFlex(
                                              fontWeight: FontWeight.bold,
                                              fontStyle:
                                              FlutterFlowTheme.of(
                                                  context)
                                                  .labelMedium
                                                  .fontStyle,
                                            ),
                                            color: Color(0xFF344054),
                                            fontSize: 15.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.bold,
                                            fontStyle:
                                            FlutterFlowTheme.of(context)
                                                .labelMedium
                                                .fontStyle,
                                          ),
                                          hintText: 'Phone',
                                          hintStyle: FlutterFlowTheme.of(
                                              context)
                                              .labelMedium
                                              .override(
                                            font: GoogleFonts.inter(
                                              fontWeight:
                                              FlutterFlowTheme.of(
                                                  context)
                                                  .labelMedium
                                                  .fontWeight,
                                              fontStyle:
                                              FlutterFlowTheme.of(
                                                  context)
                                                  .labelMedium
                                                  .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight:
                                            FlutterFlowTheme.of(context)
                                                .labelMedium
                                                .fontWeight,
                                            fontStyle:
                                            FlutterFlowTheme.of(context)
                                                .labelMedium
                                                .fontStyle,
                                          ),
                                          errorStyle: FlutterFlowTheme.of(
                                              context)
                                              .bodyMedium
                                              .override(
                                            font: GoogleFonts.robotoFlex(
                                              fontWeight: FontWeight.normal,
                                              fontStyle:
                                              FlutterFlowTheme.of(
                                                  context)
                                                  .bodyMedium
                                                  .fontStyle,
                                            ),
                                            color:
                                            FlutterFlowTheme.of(context)
                                                .error,
                                            fontSize: 10.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.normal,
                                            fontStyle:
                                            FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .fontStyle,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                              FlutterFlowTheme.of(context)
                                                  .alternate,
                                              width: 2.0,
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(25.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                              FlutterFlowTheme.of(context)
                                                  .primary,
                                              width: 2.0,
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(25.0),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                              FlutterFlowTheme.of(context)
                                                  .error,
                                              width: 2.0,
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(25.0),
                                          ),
                                          focusedErrorBorder:
                                          OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                              FlutterFlowTheme.of(context)
                                                  .error,
                                              width: 2.0,
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(25.0),
                                          ),
                                          contentPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              20.0, 0.0, 20.0, 0.0),
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                          font: GoogleFonts.robotoFlex(
                                            fontWeight: FontWeight.bold,
                                            fontStyle:
                                            FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .fontStyle,
                                          ),
                                          color: Color(0xFF344054),
                                          fontSize: 15.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.bold,
                                          fontStyle:
                                          FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .fontStyle,
                                        ),
                                        validator: _model
                                            .phoneFTextControllerValidator
                                            .asValidator(context),
                                        inputFormatters: [_model.phoneFMask],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(0.0, 1.0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 30.0),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20.0, 0.0, 20.0, 0.0),
                                child: FFButtonWidget(
                                  onPressed: () async {
                                    var _shouldSetState = false;
                                    _model.isFormValid = true;

                                    if (_model.formKey.currentState == null || !_model.formKey.currentState!.validate()) {
                                      safeSetState(() => _model.isFormValid = false);
                                      return;
                                    }
                                    _shouldSetState = true;

                                    if (!_model.isFormValid!) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Please enter all fields information to continue.',
                                            style: TextStyle(color: FlutterFlowTheme.of(context).primaryText),
                                          ),
                                          duration: Duration(milliseconds: 4000),
                                          backgroundColor: FlutterFlowTheme.of(context).secondary,
                                        ),
                                      );
                                      if (_shouldSetState) safeSetState(() {});
                                      return;
                                    }

                                    if (widget.isBilling) {
                                      // ---------- BILLING SAVE ----------
                                      try {
                                        final resp = await PasargadrugsGroup.checkoutBillingCall.call(
                                          cartId: FFAppState().cartId,
                                          firstName: FFAppState().user.firstName,
                                          lastName: FFAppState().user.lastName,
                                          email: FFAppState().user.email,
                                          address:
                                          '${_model.streetFTextController?.text ?? ''}, ${_model.cityFTextController?.text ?? ''}, ${_model.stateFTextController?.text ?? ''}, ${_model.countryFTextController?.text ?? ''}',
                                          street: _model.streetFTextController?.text ?? '',
                                          city: _model.cityFTextController?.text ?? '',
                                          token: currentAuthenticationToken,
                                          postalCode: _model.postCodeFTextController?.text ?? '',
                                          phone: _model.phoneFTextController?.text ?? '',
                                          state: _model.stateFTextController?.text ?? '',
                                        );
                                        _model.apiResultc85 = resp;

                                        final msg = PasargadrugsGroup.checkoutBillingCall.message(resp.jsonBody) ?? '';
                                        final data = PasargadrugsGroup.checkoutBillingCall.data(resp.jsonBody);

                                        if (resp.succeeded) {
                                          _logApiSuccess('checkoutBilling', resp, extra: {
                                            'message': msg,
                                          });

                                          // Go to Shipping step next (kept same flow you had)
                                          context.pushNamed(
                                            AddAddressPageWidget.routeName,
                                            queryParameters: {
                                              'isBilling': serializeParam(false, ParamType.bool),
                                              'amount': serializeParam(widget.amount, ParamType.String),
                                            }.withoutNulls,
                                          );
                                          if (_shouldSetState) safeSetState(() {});
                                          return;
                                        } else {
                                          _logApiError('checkoutBilling', res: resp, extra: {
                                            'message': msg,
                                          });
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                msg.isNotEmpty ? msg : 'Billing save failed.',
                                                style: TextStyle(color: FlutterFlowTheme.of(context).primaryText),
                                              ),
                                              duration: Duration(milliseconds: 4000),
                                              backgroundColor: FlutterFlowTheme.of(context).secondary,
                                            ),
                                          );
                                          if (_shouldSetState) safeSetState(() {});
                                          return;
                                        }
                                      } catch (e, st) {
                                        _logApiError('checkoutBilling', error: e, stack: st);
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Billing save error. Please try again.',
                                              style: TextStyle(color: FlutterFlowTheme.of(context).primaryText),
                                            ),
                                            duration: Duration(milliseconds: 4000),
                                            backgroundColor: FlutterFlowTheme.of(context).secondary,
                                          ),
                                        );
                                        if (_shouldSetState) safeSetState(() {});
                                        return;
                                      }
                                    } else {
                                      // ---------- SHIPPING SAVE ----------
                                      try {
                                        final resp = await PasargadrugsGroup.checkoutShippingCall.call(
                                          token: currentAuthenticationToken,
                                          cartId: FFAppState().cartId,
                                          firstName: FFAppState().user.firstName,
                                          lastName: FFAppState().user.lastName,
                                          email: FFAppState().user.email,
                                          address:
                                          '${_model.streetFTextController?.text ?? ''}, ${_model.cityFTextController?.text ?? ''}, ${_model.stateFTextController?.text ?? ''}, ${_model.countryFTextController?.text ?? ''}',
                                          street: _model.streetFTextController?.text ?? '',
                                          city: _model.cityFTextController?.text ?? '',
                                          postalCode: _model.postCodeFTextController?.text ?? '',
                                          phone: _model.phoneFTextController?.text ?? '',
                                          state: _model.stateFTextController?.text ?? '',
                                        );
                                        _model.shippingCheckout = resp;

                                        final msg = PasargadrugsGroup.checkoutShippingCall.message(resp.jsonBody) ?? '';
                                        final data = PasargadrugsGroup.checkoutShippingCall.data(resp.jsonBody);

                                        if (resp.succeeded) {
                                          _logApiSuccess('checkoutShipping', resp, extra: {
                                            'message': msg,
                                          });

                                          // Move to payment as before
                                          context.pushNamed(
                                            CreditCardPageWidget.routeName,
                                            queryParameters: {
                                              'amount': serializeParam(widget.amount, ParamType.String),
                                            }.withoutNulls,
                                          );
                                          if (_shouldSetState) safeSetState(() {});
                                          return;
                                        } else {
                                          _logApiError('checkoutShipping', res: resp, extra: {
                                            'message': msg,
                                          });
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                msg.isNotEmpty ? msg : 'Shipping save failed.',
                                                style: TextStyle(color: FlutterFlowTheme.of(context).primaryText),
                                              ),
                                              duration: Duration(milliseconds: 4000),
                                              backgroundColor: FlutterFlowTheme.of(context).secondary,
                                            ),
                                          );
                                          if (_shouldSetState) safeSetState(() {});
                                          return;
                                        }
                                      } catch (e, st) {
                                        _logApiError('checkoutShipping', error: e, stack: st);
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Shipping save error. Please try again.',
                                              style: TextStyle(color: FlutterFlowTheme.of(context).primaryText),
                                            ),
                                            duration: Duration(milliseconds: 4000),
                                            backgroundColor: FlutterFlowTheme.of(context).secondary,
                                          ),
                                        );
                                        if (_shouldSetState) safeSetState(() {});
                                        return;
                                      }
                                    }
                                  },
                                  text:
                                  _model.address != null ? 'Update' : 'Add',
                                  options: FFButtonOptions(
                                    height: 50.0,
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16.0, 0.0, 16.0, 0.0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    color: Colors.black,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                      font: GoogleFonts.interTight(
                                        fontWeight:
                                        FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .fontWeight,
                                        fontStyle:
                                        FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .fontStyle,
                                      ),
                                      color: Colors.white,
                                      letterSpacing: 0.0,
                                      fontWeight:
                                      FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontWeight,
                                      fontStyle:
                                      FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontStyle,
                                    ),
                                    elevation: 0.0,
                                    borderRadius: BorderRadius.circular(25.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
