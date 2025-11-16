import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/random_data_util.dart' as random_data;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'credit_card_page_model.dart';
export 'credit_card_page_model.dart';

class CreditCardPageWidget extends StatefulWidget {
  const CreditCardPageWidget({
    super.key,
    required this.amount,
  });

  final String? amount;

  static String routeName = 'CreditCardPage';
  static String routePath = '/creditCardPage';

  @override
  State<CreditCardPageWidget> createState() => _CreditCardPageWidgetState();
}

class _CreditCardPageWidgetState extends State<CreditCardPageWidget>
    with RouteAware {
  late CreditCardPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CreditCardPageModel());

    _model.nameFTextController ??= TextEditingController()
      ..addListener(() {
        debugLogWidgetClass(_model);
      });
    _model.nameFFocusNode ??= FocusNode();

    _model.cardNumberFTextController ??= TextEditingController()
      ..addListener(() {
        debugLogWidgetClass(_model);
      });
    _model.cardNumberFFocusNode ??= FocusNode();

    _model.cardNumberFMask =
        MaskTextInputFormatter(mask: '#### #### #### ####');
    _model.expDateFTextController ??= TextEditingController()
      ..addListener(() {
        debugLogWidgetClass(_model);
      });
    _model.expDateFFocusNode ??= FocusNode();

    _model.expDateFMask = MaskTextInputFormatter(mask: '##/##/####');
    _model.cvvFTextController ??= TextEditingController()
      ..addListener(() {
        debugLogWidgetClass(_model);
      });
    _model.cvvFFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);

    _model.dispose();

    super.dispose();
  }

  @override
  void didUpdateWidget(CreditCardPageWidget oldWidget) {
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
            'Credit Card',
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
                                        controller: _model.nameFTextController,
                                        focusNode: _model.nameFFocusNode,
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
                                          hintText: 'Name',
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
                                            .nameFTextControllerValidator
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
                                        _model.cardNumberFTextController,
                                        focusNode: _model.cardNumberFFocusNode,
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
                                          hintText: 'Card Number',
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
                                        keyboardType: TextInputType.number,
                                        validator: _model
                                            .cardNumberFTextControllerValidator
                                            .asValidator(context),
                                        inputFormatters: [
                                          _model.cardNumberFMask
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20.0, 20.0, 20.0, 0.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color:
                                              FlutterFlowTheme.of(context)
                                                  .secondaryBackground,
                                            ),
                                            child: TextFormField(
                                              controller:
                                              _model.expDateFTextController,
                                              focusNode:
                                              _model.expDateFFocusNode,
                                              autofocus: true,
                                              textInputAction:
                                              TextInputAction.next,
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                labelStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .override(
                                                  font: GoogleFonts
                                                      .robotoFlex(
                                                    fontWeight:
                                                    FontWeight.bold,
                                                    fontStyle:
                                                    FlutterFlowTheme.of(
                                                        context)
                                                        .labelMedium
                                                        .fontStyle,
                                                  ),
                                                  color:
                                                  Color(0xFF344054),
                                                  fontSize: 15.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                  FontWeight.bold,
                                                  fontStyle:
                                                  FlutterFlowTheme.of(
                                                      context)
                                                      .labelMedium
                                                      .fontStyle,
                                                ),
                                                hintText: 'Exp. Date',
                                                hintStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .override(
                                                  font:
                                                  GoogleFonts.inter(
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
                                                errorStyle: FlutterFlowTheme.of(
                                                    context)
                                                    .bodyMedium
                                                    .override(
                                                  font: GoogleFonts
                                                      .robotoFlex(
                                                    fontWeight:
                                                    FontWeight.normal,
                                                    fontStyle:
                                                    FlutterFlowTheme.of(
                                                        context)
                                                        .bodyMedium
                                                        .fontStyle,
                                                  ),
                                                  color:
                                                  FlutterFlowTheme.of(
                                                      context)
                                                      .error,
                                                  fontSize: 10.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                  FontWeight.normal,
                                                  fontStyle:
                                                  FlutterFlowTheme.of(
                                                      context)
                                                      .bodyMedium
                                                      .fontStyle,
                                                ),
                                                enabledBorder:
                                                OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                        context)
                                                        .alternate,
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      25.0),
                                                ),
                                                focusedBorder:
                                                OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                        context)
                                                        .primary,
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      25.0),
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                        context)
                                                        .error,
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      25.0),
                                                ),
                                                focusedErrorBorder:
                                                OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                        context)
                                                        .error,
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      25.0),
                                                ),
                                                contentPadding:
                                                EdgeInsetsDirectional
                                                    .fromSTEB(20.0, 0.0,
                                                    20.0, 0.0),
                                              ),
                                              style: FlutterFlowTheme.of(
                                                  context)
                                                  .bodyMedium
                                                  .override(
                                                font:
                                                GoogleFonts.robotoFlex(
                                                  fontWeight:
                                                  FontWeight.bold,
                                                  fontStyle:
                                                  FlutterFlowTheme.of(
                                                      context)
                                                      .bodyMedium
                                                      .fontStyle,
                                                ),
                                                color: Color(0xFF344054),
                                                fontSize: 15.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.bold,
                                                fontStyle:
                                                FlutterFlowTheme.of(
                                                    context)
                                                    .bodyMedium
                                                    .fontStyle,
                                              ),
                                              keyboardType:
                                              TextInputType.datetime,
                                              validator: _model
                                                  .expDateFTextControllerValidator
                                                  .asValidator(context),
                                              inputFormatters: [
                                                _model.expDateFMask
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color:
                                              FlutterFlowTheme.of(context)
                                                  .secondaryBackground,
                                            ),
                                            child: TextFormField(
                                              controller:
                                              _model.cvvFTextController,
                                              focusNode: _model.cvvFFocusNode,
                                              autofocus: true,
                                              textInputAction:
                                              TextInputAction.next,
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                labelStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .override(
                                                  font: GoogleFonts
                                                      .robotoFlex(
                                                    fontWeight:
                                                    FontWeight.bold,
                                                    fontStyle:
                                                    FlutterFlowTheme.of(
                                                        context)
                                                        .labelMedium
                                                        .fontStyle,
                                                  ),
                                                  color:
                                                  Color(0xFF344054),
                                                  fontSize: 15.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                  FontWeight.bold,
                                                  fontStyle:
                                                  FlutterFlowTheme.of(
                                                      context)
                                                      .labelMedium
                                                      .fontStyle,
                                                ),
                                                hintText: 'CVV',
                                                hintStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .override(
                                                  font:
                                                  GoogleFonts.inter(
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
                                                errorStyle: FlutterFlowTheme.of(
                                                    context)
                                                    .bodyMedium
                                                    .override(
                                                  font: GoogleFonts
                                                      .robotoFlex(
                                                    fontWeight:
                                                    FontWeight.normal,
                                                    fontStyle:
                                                    FlutterFlowTheme.of(
                                                        context)
                                                        .bodyMedium
                                                        .fontStyle,
                                                  ),
                                                  color:
                                                  FlutterFlowTheme.of(
                                                      context)
                                                      .error,
                                                  fontSize: 10.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                  FontWeight.normal,
                                                  fontStyle:
                                                  FlutterFlowTheme.of(
                                                      context)
                                                      .bodyMedium
                                                      .fontStyle,
                                                ),
                                                enabledBorder:
                                                OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                        context)
                                                        .alternate,
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      25.0),
                                                ),
                                                focusedBorder:
                                                OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                        context)
                                                        .primary,
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      25.0),
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                        context)
                                                        .error,
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      25.0),
                                                ),
                                                focusedErrorBorder:
                                                OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                        context)
                                                        .error,
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      25.0),
                                                ),
                                                contentPadding:
                                                EdgeInsetsDirectional
                                                    .fromSTEB(20.0, 0.0,
                                                    20.0, 0.0),
                                              ),
                                              style: FlutterFlowTheme.of(
                                                  context)
                                                  .bodyMedium
                                                  .override(
                                                font:
                                                GoogleFonts.robotoFlex(
                                                  fontWeight:
                                                  FontWeight.bold,
                                                  fontStyle:
                                                  FlutterFlowTheme.of(
                                                      context)
                                                      .bodyMedium
                                                      .fontStyle,
                                                ),
                                                color: Color(0xFF344054),
                                                fontSize: 15.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.bold,
                                                fontStyle:
                                                FlutterFlowTheme.of(
                                                    context)
                                                    .bodyMedium
                                                    .fontStyle,
                                              ),
                                              maxLength: 4,
                                              maxLengthEnforcement:
                                              MaxLengthEnforcement.enforced,
                                              buildCounter: (context,
                                                  {required currentLength,
                                                    required isFocused,
                                                    maxLength}) =>
                                              null,
                                              keyboardType:
                                              TextInputType.number,
                                              validator: _model
                                                  .cvvFTextControllerValidator
                                                  .asValidator(context),
                                            ),
                                          ),
                                        ),
                                      ].divide(SizedBox(width: 15.0)),
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
                              child: Container(
                                height: 120.0,
                                child: Stack(
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                  children: [
                                    Align(
                                      alignment:
                                      AlignmentDirectional(0.0, -1.0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            20.0, 0.0, 20.0, 0.0),
                                        child: FFButtonWidget(
                                          onPressed: () async {},
                                          text: 'Continue with Paypal',
                                          icon: FaIcon(
                                            FontAwesomeIcons.paypal,
                                            size: 22.0,
                                          ),
                                          options: FFButtonOptions(
                                            width: double.infinity,
                                            height: 50.0,
                                            padding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                16.0, 0.0, 16.0, 0.0),
                                            iconPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                0.0, 0.0, 0.0, 0.0),
                                            color: Colors.black,
                                            textStyle: FlutterFlowTheme.of(
                                                context)
                                                .titleSmall
                                                .override(
                                              font: GoogleFonts.interTight(
                                                fontWeight:
                                                FlutterFlowTheme.of(
                                                    context)
                                                    .titleSmall
                                                    .fontWeight,
                                                fontStyle:
                                                FlutterFlowTheme.of(
                                                    context)
                                                    .titleSmall
                                                    .fontStyle,
                                              ),
                                              color: Colors.white,
                                              letterSpacing: 0.0,
                                              fontWeight:
                                              FlutterFlowTheme.of(
                                                  context)
                                                  .titleSmall
                                                  .fontWeight,
                                              fontStyle:
                                              FlutterFlowTheme.of(
                                                  context)
                                                  .titleSmall
                                                  .fontStyle,
                                            ),
                                            elevation: 0.0,
                                            borderRadius:
                                            BorderRadius.circular(25.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: AlignmentDirectional(0.0, 1.0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            20.0, 0.0, 20.0, 0.0),
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            var _shouldSetState = false;
                                            try {
                                              // 1) Get Square Location (no dialogs)
                                              _model.locationApiResult = await SquarePaymentGroup.locationCall.call();
                                              _shouldSetState = true;

                                              final locOk = _model.locationApiResult?.succeeded ?? false;
                                              if (!locOk) {
                                                debugPrint('❌ Square locationCall failed: ${_model.locationApiResult?.bodyText}');
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  SnackBar(
                                                    content: Text('Unable to initialize Square. Please try again.'),
                                                    duration: Duration(seconds: 3),
                                                  ),
                                                );
                                                if (_shouldSetState) safeSetState(() {});
                                                return;
                                              }

                                              final locationId = SquarePaymentGroup.locationCall.locationId(
                                                (_model.locationApiResult?.jsonBody ?? ''),
                                              );
                                              if (locationId == null || locationId.toString().isEmpty) {
                                                debugPrint('❌ Square locationId missing.');
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  SnackBar(
                                                    content: Text('Square location not configured.'),
                                                    duration: Duration(seconds: 3),
                                                  ),
                                                );
                                                if (_shouldSetState) safeSetState(() {});
                                                return;
                                              }

                                              // 2) Create payment link (no dialogs)
                                              final amountMinorUnits = (functions.toInt(widget.amount!) ?? 0) * 100;
                                              debugPrint('ℹ️ Square start: cartId=${FFAppState().cartId}, amount_minor=$amountMinorUnits, locationId=$locationId');

                                              _model.squareApiResult = await SquarePaymentGroup.paymentlinksCall.call(
                                                idempKey: random_data.randomString(10, 15, true, true, true),
                                                cartId: FFAppState().cartId,
                                                amount: amountMinorUnits,
                                                locationId: locationId,
                                              );
                                              _shouldSetState = true;

                                              final payOk = _model.squareApiResult?.succeeded ?? false;
                                              if (!payOk) {
                                                debugPrint('❌ Square paymentlinksCall failed: ${_model.squareApiResult?.bodyText}');
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  SnackBar(
                                                    content: Text('Could not start payment. Please try again.'),
                                                    duration: Duration(seconds: 3),
                                                  ),
                                                );
                                                if (_shouldSetState) safeSetState(() {});
                                                return;
                                              }

                                              final payUrl = SquarePaymentGroup.paymentlinksCall.payUrl(
                                                (_model.squareApiResult?.jsonBody ?? ''),
                                              );

                                              if (payUrl == null || payUrl.isEmpty) {
                                                debugPrint('❌ payUrl not present in response.');
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  SnackBar(
                                                    content: Text('Payment link missing. Try again.'),
                                                    duration: Duration(seconds: 3),
                                                  ),
                                                );
                                                if (_shouldSetState) safeSetState(() {});
                                                return;
                                              }

                                              // 3) Launch the payment URL (no dialogs)
                                              debugPrint('✅ Launching Square payment URL: $payUrl');
                                              await launchURL(payUrl);
                                            } catch (e, st) {
                                              debugPrint('❌ Square payment exception: $e\n$st');
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(
                                                  content: Text('Unexpected error. Please try again.'),
                                                  duration: Duration(seconds: 3),
                                                ),
                                              );
                                            } finally {
                                              if (_shouldSetState) safeSetState(() {});
                                            }
                                          },
                                          text: 'Continue with Square',
                                          options: FFButtonOptions(
                                            width: double.infinity,
                                            height: 50.0,
                                            padding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                16.0, 0.0, 16.0, 0.0),
                                            iconPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                0.0, 0.0, 0.0, 0.0),
                                            color: Colors.black,
                                            textStyle: FlutterFlowTheme.of(
                                                context)
                                                .titleSmall
                                                .override(
                                              font: GoogleFonts.interTight(
                                                fontWeight:
                                                FlutterFlowTheme.of(
                                                    context)
                                                    .titleSmall
                                                    .fontWeight,
                                                fontStyle:
                                                FlutterFlowTheme.of(
                                                    context)
                                                    .titleSmall
                                                    .fontStyle,
                                              ),
                                              color: Colors.white,
                                              letterSpacing: 0.0,
                                              fontWeight:
                                              FlutterFlowTheme.of(
                                                  context)
                                                  .titleSmall
                                                  .fontWeight,
                                              fontStyle:
                                              FlutterFlowTheme.of(
                                                  context)
                                                  .titleSmall
                                                  .fontStyle,
                                            ),
                                            elevation: 0.0,
                                            borderRadius:
                                            BorderRadius.circular(25.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
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
