import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'product_detail_page_model.dart';

class ProductDetailPageWidget extends StatefulWidget {
  const ProductDetailPageWidget({
    super.key,
    required this.prodID,
  });

  final int? prodID;

  static String routeName = 'ProductDetailPage';
  static String routePath = '/productDetailPage';

  @override
  State<ProductDetailPageWidget> createState() =>
      _ProductDetailPageWidgetState();
}

class _ProductDetailPageWidgetState extends State<ProductDetailPageWidget>
    with RouteAware {
  late ProductDetailPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  /// Selected image index for gallery (0 = first)
  int _selectedImageIndex = 0;

  /// Safely convert any JSON image value to a usable URL,
  /// or return a placeholder URL if it's empty/invalid.
  String _safeImageUrl(dynamic value) {
    final s = value?.toString() ?? '';
    if (s.isEmpty || s.toLowerCase() == 'null') {
      // Placeholder URL – change if you want
      return 'https://fakeimg.pl/600x400?text=No+Image';
    }
    if (s.startsWith('//')) {
      // Protocol-relative URL
      return 'https:$s';
    }
    return s;
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProductDetailPageModel());
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    _model.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(ProductDetailPageWidget oldWidget) {
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

    return FutureBuilder<ApiCallResponse>(
      future: PasargadrugsGroup.productDetailCall.call(
        id: widget.prodID?.toString(),
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
            body: Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).primary,
                  ),
                ),
              ),
            ),
          );
        }
        final productDetailPageProductDetailResponse = snapshot.data!;
        _model.debugBackendQueries[
        'PasargadrugsGroup.productDetailCall_statusCode_Scaffold_z7t39y2f'] =
            debugSerializeParam(
              productDetailPageProductDetailResponse.statusCode,
              ParamType.int,
              link:
              'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=ProductDetailPage',
              name: 'int',
              nullable: false,
            );
        _model.debugBackendQueries[
        'PasargadrugsGroup.productDetailCall_responseBody_Scaffold_z7t39y2f'] =
            debugSerializeParam(
              productDetailPageProductDetailResponse.bodyText,
              ParamType.String,
              link:
              'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=ProductDetailPage',
              name: 'String',
              nullable: false,
            );
        debugLogWidgetClass(_model);

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
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
                  color: FlutterFlowTheme.of(context).primaryText,
                  size: 30.0,
                ),
                onPressed: () async {
                  context.pop();
                },
              ),
              actions: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 5.0, 0.0),
                  child: FlutterFlowIconButton(
                    borderRadius: 8.0,
                    buttonSize: 40.0,
                    fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                    icon: Icon(
                      Icons.favorite_border,
                      color: PasargadrugsGroup.productDetailCall.isFavourite(
                        productDetailPageProductDetailResponse.jsonBody,
                      ) ==
                          0
                          ? FlutterFlowTheme.of(context).primaryText
                          : FlutterFlowTheme.of(context).error,
                      size: 24.0,
                    ),
                    onPressed: () {
                      print('IconButton pressed ...');
                    },
                  ),
                ),
              ],
              centerTitle: true,
              elevation: 0.0,
            ),
            body: SafeArea(
              top: true,
              child: Stack(
                children: [
                  Align(
                    alignment: AlignmentDirectional(0.0, -1.0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            /// === MAIN IMAGE (top) ===
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 20.0, 0.0, 0.0),
                              child: Container(
                                width: MediaQuery.sizeOf(context).width * 0.8,
                                height: 200.0,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                ),
                                child: Builder(
                                  builder: (context) {
                                    final imagesJson =
                                    getJsonField(
                                      PasargadrugsGroup.productDetailCall
                                          .product(
                                        productDetailPageProductDetailResponse
                                            .jsonBody,
                                      ),
                                      r'''$.images''',
                                    );
                                    final List<dynamic> images =
                                    (imagesJson is List)
                                        ? imagesJson
                                        : <dynamic>[];

                                    // Clamp selected index
                                    final currentIndex = (images.isNotEmpty &&
                                        _selectedImageIndex <
                                            images.length)
                                        ? _selectedImageIndex
                                        : 0;

                                    final mainImageUrl = images.isNotEmpty
                                        ? _safeImageUrl(
                                      images[currentIndex],
                                    )
                                        : _safeImageUrl(null);

                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.network(
                                        mainImageUrl,
                                        width: double.infinity,
                                        height: 200.0,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          // Fallback placeholder instead of crash
                                          return Container(
                                            width: double.infinity,
                                            height: 200.0,
                                            color: FlutterFlowTheme.of(context)
                                                .alternate,
                                            alignment: Alignment.center,
                                            child: Icon(
                                              Icons.image_not_supported,
                                              color:
                                              FlutterFlowTheme.of(context)
                                                  .secondaryText,
                                              size: 40.0,
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),

                            /// === THUMBNAILS ROW ===
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  20.0, 20.0, 20.0, 0.0),
                              child: Builder(
                                builder: (context) {
                                  final imagesJson =
                                  getJsonField(
                                    PasargadrugsGroup.productDetailCall
                                        .product(
                                      productDetailPageProductDetailResponse
                                          .jsonBody,
                                    ),
                                    r'''$.images''',
                                  );
                                  final List<dynamic> image =
                                  (imagesJson is List)
                                      ? imagesJson
                                      : <dynamic>[];

                                  _model.debugGeneratorVariables[
                                  'image${image.length > 100 ? ' (first 100)' : ''}'] =
                                      debugSerializeParam(
                                        image.take(100),
                                        ParamType.JSON,
                                        isList: true,
                                        link:
                                        'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=ProductDetailPage',
                                        name: 'dynamic',
                                        nullable: false,
                                      );
                                  debugLogWidgetClass(_model);

                                  return SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: List.generate(
                                          image.length, (imageIndex) {
                                        final imageItem = image[imageIndex];
                                        final isSelected =
                                            imageIndex == _selectedImageIndex;

                                        return InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () {
                                            setState(() {
                                              _selectedImageIndex =
                                                  imageIndex;
                                            });
                                          },
                                          child: Container(
                                            width: 80.0,
                                            height: 80.0,
                                            decoration: BoxDecoration(
                                              color:
                                              FlutterFlowTheme.of(context)
                                                  .secondaryBackground,
                                              borderRadius:
                                              BorderRadius.circular(8.0),
                                              border: Border.all(
                                                color: isSelected
                                                    ? FlutterFlowTheme.of(
                                                    context)
                                                    .primary
                                                    : Colors.transparent,
                                                width: 2.0,
                                              ),
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                              BorderRadius.circular(6.0),
                                              child: Image.network(
                                                _safeImageUrl(imageItem),
                                                width: 200.0,
                                                height: 200.0,
                                                fit: BoxFit.cover,
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return Container(
                                                    color:
                                                    FlutterFlowTheme.of(
                                                        context)
                                                        .alternate,
                                                    alignment: Alignment.center,
                                                    child: Icon(
                                                      Icons
                                                          .image_not_supported,
                                                      color:
                                                      FlutterFlowTheme.of(
                                                          context)
                                                          .secondaryText,
                                                      size: 32.0,
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        );
                                      }).divide(const SizedBox(width: 10.0)),
                                    ),
                                  );
                                },
                              ),
                            ),

                            /// === DETAILS CARD ===
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 20.0, 0.0, 50.0),
                              child: Container(
                                width: MediaQuery.sizeOf(context).width * 1.0,
                                decoration: BoxDecoration(
                                  color: Color(0xA6FFFFFF),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(0.0),
                                    bottomRight: Radius.circular(0.0),
                                    topLeft: Radius.circular(24.0),
                                    topRight: Radius.circular(24.0),
                                  ),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          20.0, 15.0, 20.0, 0.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                  0.0, 0.0, 20.0, 0.0),
                                              child: Container(
                                                decoration: BoxDecoration(),
                                                child: Text(
                                                  getJsonField(
                                                    PasargadrugsGroup
                                                        .productDetailCall
                                                        .product(
                                                      productDetailPageProductDetailResponse
                                                          .jsonBody,
                                                    ),
                                                    r'''$.name''',
                                                  ).toString(),
                                                  style: FlutterFlowTheme.of(
                                                      context)
                                                      .bodyMedium
                                                      .override(
                                                    font: GoogleFonts.inter(
                                                      fontWeight:
                                                      FontWeight.w600,
                                                      fontStyle:
                                                      FlutterFlowTheme.of(
                                                          context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                    ),
                                                    fontSize: 18.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                    FontWeight.w600,
                                                    fontStyle:
                                                    FlutterFlowTheme.of(
                                                        context)
                                                        .bodyMedium
                                                        .fontStyle,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Icon(
                                                  Icons.star,
                                                  color: FlutterFlowTheme.of(
                                                      context)
                                                      .warning,
                                                  size: 24.0,
                                                ),
                                                Text(
                                                  valueOrDefault<String>(
                                                    PasargadrugsGroup
                                                        .productDetailCall
                                                        .avgRating(
                                                      productDetailPageProductDetailResponse
                                                          .jsonBody,
                                                    )
                                                        ?.toString(),
                                                    '0',
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                      context)
                                                      .bodyMedium
                                                      .override(
                                                    font: GoogleFonts.inter(
                                                      fontWeight:
                                                      FontWeight.w600,
                                                      fontStyle:
                                                      FlutterFlowTheme.of(
                                                          context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                    ),
                                                    fontSize: 16.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                    FontWeight.w600,
                                                    fontStyle:
                                                    FlutterFlowTheme.of(
                                                        context)
                                                        .bodyMedium
                                                        .fontStyle,
                                                  ),
                                                ),
                                              ].divide(SizedBox(width: 5.0)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (PasargadrugsGroup.productDetailCall
                                        .isSale(
                                      productDetailPageProductDetailResponse
                                          .jsonBody,
                                    ) ==
                                        1)
                                      Align(
                                        alignment:
                                        AlignmentDirectional(-1.0, 0.0),
                                        child: Padding(
                                          padding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              20.0, 20.0, 0.0, 0.0),
                                          child: Text(
                                            'Sale: ${PasargadrugsGroup.productDetailCall.saleValue(
                                              productDetailPageProductDetailResponse
                                                  .jsonBody,
                                            )?.toString()}%',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                              font: GoogleFonts.inter(
                                                fontWeight: FontWeight.bold,
                                                fontStyle:
                                                FlutterFlowTheme.of(
                                                    context)
                                                    .bodyMedium
                                                    .fontStyle,
                                              ),
                                              color: Color(0xFFE00D1A),
                                              fontSize: 20.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.bold,
                                              fontStyle:
                                              FlutterFlowTheme.of(
                                                  context)
                                                  .bodyMedium
                                                  .fontStyle,
                                            ),
                                          ),
                                        ),
                                      ),
                                    Align(
                                      alignment:
                                      AlignmentDirectional(-1.0, 0.0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            20.0, 30.0, 20.0, 0.0),
                                        child: Stack(
                                          alignment:
                                          AlignmentDirectional(0.0, 0.0),
                                          children: [
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  -1.0, 0.0),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                    0.0, 0.0, 60.0, 0.0),
                                                child: Container(
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(),
                                                  child: Text(
                                                    getJsonField(
                                                      PasargadrugsGroup
                                                          .productDetailCall
                                                          .product(
                                                        productDetailPageProductDetailResponse
                                                            .jsonBody,
                                                      ),
                                                      r'''$.detail''',
                                                    ).toString(),
                                                    style: FlutterFlowTheme.of(
                                                        context)
                                                        .bodyMedium
                                                        .override(
                                                      font:
                                                      GoogleFonts.inter(
                                                        fontWeight:
                                                        FontWeight.w500,
                                                        fontStyle:
                                                        FlutterFlowTheme.of(
                                                            context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                      ),
                                                      fontSize: 16.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                      FontWeight.w500,
                                                      fontStyle:
                                                      FlutterFlowTheme.of(
                                                          context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  1.0, 0.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                      blurRadius: 4.0,
                                                      color: Color(0x33000000),
                                                      offset: Offset(
                                                        0.0,
                                                        2.0,
                                                      ),
                                                    )
                                                  ],
                                                  borderRadius:
                                                  BorderRadius.only(
                                                    bottomLeft:
                                                    Radius.circular(8.0),
                                                    bottomRight:
                                                    Radius.circular(8.0),
                                                    topLeft:
                                                    Radius.circular(8.0),
                                                    topRight:
                                                    Radius.circular(8.0),
                                                  ),
                                                ),
                                                child: FlutterFlowIconButton(
                                                  borderRadius: 8.0,
                                                  buttonSize: 40.0,
                                                  fillColor:
                                                  FlutterFlowTheme.of(
                                                      context)
                                                      .secondaryBackground,
                                                  icon: Icon(
                                                    Icons
                                                        .remove_red_eye_outlined,
                                                    color: FlutterFlowTheme.of(
                                                        context)
                                                        .primaryText,
                                                    size: 24.0,
                                                  ),
                                                  onPressed: () async {
                                                    context.pushNamed(
                                                      ProductMoreDetailPageWidget
                                                          .routeName,
                                                      queryParameters: {
                                                        'productID':
                                                        serializeParam(
                                                          widget.prodID,
                                                          ParamType.int,
                                                        ),
                                                      }.withoutNulls,
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          20.0, 30.0, 20.0, 60.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Color:',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                              font: GoogleFonts.inter(
                                                fontWeight: FontWeight.w500,
                                                fontStyle:
                                                FlutterFlowTheme.of(
                                                    context)
                                                    .bodyMedium
                                                    .fontStyle,
                                              ),
                                              fontSize: 16.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w500,
                                              fontStyle:
                                              FlutterFlowTheme.of(
                                                  context)
                                                  .bodyMedium
                                                  .fontStyle,
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                  20.0, 0.0, 0.0, 0.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.only(
                                                    bottomLeft:
                                                    Radius.circular(8.0),
                                                    bottomRight:
                                                    Radius.circular(8.0),
                                                    topLeft:
                                                    Radius.circular(8.0),
                                                    topRight:
                                                    Radius.circular(8.0),
                                                  ),
                                                ),
                                                child: Builder(
                                                  builder: (context) {
                                                    final color =
                                                        PasargadrugsGroup
                                                            .productDetailCall
                                                            .color(
                                                          productDetailPageProductDetailResponse
                                                              .jsonBody,
                                                        )
                                                            ?.toList() ??
                                                            [];
                                                    _model.debugGeneratorVariables[
                                                    'color${color.length > 100 ? ' (first 100)' : ''}'] =
                                                        debugSerializeParam(
                                                          color.take(100),
                                                          ParamType.JSON,
                                                          isList: true,
                                                          link:
                                                          'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=ProductDetailPage',
                                                          name: 'dynamic',
                                                          nullable: false,
                                                        );
                                                    debugLogWidgetClass(_model);

                                                    return Row(
                                                      mainAxisSize:
                                                      MainAxisSize.max,
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                      children: List.generate(
                                                          color.length,
                                                              (colorIndex) {
                                                            final colorItem =
                                                            color[colorIndex];
                                                            return Container(
                                                              width: 30.0,
                                                              height: 30.0,
                                                              decoration:
                                                              BoxDecoration(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .only(
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                      15.0),
                                                                  bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                      15.0),
                                                                  topLeft: Radius
                                                                      .circular(
                                                                      15.0),
                                                                  topRight: Radius
                                                                      .circular(
                                                                      15.0),
                                                                ),
                                                                border: Border.all(
                                                                  color: functions
                                                                      .hexOrRGBToColor(
                                                                      getJsonField(
                                                                        colorItem,
                                                                        r'''$.name''',
                                                                      ).toString()),
                                                                  width: 2.0,
                                                                ),
                                                              ),
                                                              child: Padding(
                                                                padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                    2.0,
                                                                    2.0,
                                                                    2.0,
                                                                    2.0),
                                                                child: Container(
                                                                  width: double
                                                                      .infinity,
                                                                  height: double
                                                                      .infinity,
                                                                  decoration:
                                                                  BoxDecoration(
                                                                    color: functions
                                                                        .hexOrRGBToColor(
                                                                        getJsonField(
                                                                          colorItem,
                                                                          r'''$.name''',
                                                                        ).toString()),
                                                                    borderRadius:
                                                                    BorderRadius
                                                                        .only(
                                                                      bottomLeft: Radius
                                                                          .circular(
                                                                          14.0),
                                                                      bottomRight: Radius
                                                                          .circular(
                                                                          14.0),
                                                                      topLeft: Radius
                                                                          .circular(
                                                                          14.0),
                                                                      topRight: Radius
                                                                          .circular(
                                                                          14.0),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          }).divide(SizedBox(
                                                          width: 20.0)),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  /// === BOTTOM BAR (PRICE + ADD TO CART) ===
                  Align(
                    alignment: AlignmentDirectional(0.0, 1.0),
                    child: Container(
                      width: double.infinity,
                      height: 100.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(0.0),
                          bottomRight: Radius.circular(0.0),
                          topLeft: Radius.circular(24.0),
                          topRight: Radius.circular(24.0),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 0.0, 20.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Align(
                              alignment: AlignmentDirectional(-1.0, 0.0),
                              child: Text(
                                '\$${getJsonField(
                                  PasargadrugsGroup.productDetailCall.product(
                                    productDetailPageProductDetailResponse
                                        .jsonBody,
                                  ),
                                  r'''$.price''',
                                ).toString()}',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                                  color: FlutterFlowTheme.of(context)
                                      .primaryText,
                                  fontSize: 24.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                              ),
                            ),
                            FFButtonWidget(
                              onPressed: () async {
                                var _shouldSetState = false;
                                _model.addCartResult =
                                await PasargadrugsGroup.addCartCall.call(
                                  productId: widget.prodID,
                                  quantity: 1,
                                  cartId: FFAppState().cartId,
                                );

                                _shouldSetState = true;

                                if ((_model.addCartResult?.succeeded ??
                                    true)) {
                                  // Save cartId from API
                                  FFAppState().cartId =
                                  PasargadrugsGroup.addCartCall.cartID(
                                    (_model.addCartResult?.jsonBody ?? ''),
                                  )!;

                                  safeSetState(() {});

                                  // Show success message
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        PasargadrugsGroup.addCartCall.message(
                                          (_model.addCartResult?.jsonBody ??
                                              ''),
                                        )!,
                                        style: TextStyle(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                        ),
                                      ),
                                      duration:
                                      const Duration(milliseconds: 4000),
                                      backgroundColor:
                                      FlutterFlowTheme.of(context)
                                          .secondary,
                                    ),
                                  );

                                  // Go directly to Cart page
                                  context
                                      .pushNamed(CartPageWidget.routeName);

                                  if (_shouldSetState) safeSetState(() {});
                                  return;
                                } else {
                                  // Error case – keep your existing behaviour
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        PasargadrugsGroup.addCartCall.message(
                                          (_model.addCartResult?.jsonBody ??
                                              ''),
                                        )!,
                                        style: TextStyle(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                        ),
                                      ),
                                      duration:
                                      const Duration(milliseconds: 4000),
                                      backgroundColor:
                                      FlutterFlowTheme.of(context)
                                          .secondary,
                                    ),
                                  );

                                  // Get cartId from API (could be int or String depending on your API helper)
                                  final apiCartId =
                                  PasargadrugsGroup.addCartCall.cartID(
                                    _model.addCartResult?.jsonBody,
                                  );

                                  // If current cartId is null/empty, set it to the API value (stringified) or "".
                                  final current = FFAppState().cartId;
                                  final isEmptyCurrent = current == null ||
                                      (current is String && current.isEmpty);

                                  FFAppState().cartId = isEmptyCurrent
                                      ? (apiCartId == null
                                      ? ''
                                      : apiCartId.toString())
                                      : current;

                                  safeSetState(() {});
                                  if (_shouldSetState) safeSetState(() {});
                                  return;
                                }
                              },
                              text: 'Add to cart',
                              icon: const Icon(
                                Icons.shopping_cart_outlined,
                                size: 24.0,
                              ),
                              options: FFButtonOptions(
                                height: 50.0,
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    20.0, 0.0, 20.0, 0.0),
                                iconPadding:
                                const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 8.0, 0.0),
                                iconColor:
                                FlutterFlowTheme.of(context).primaryText,
                                color:
                                FlutterFlowTheme.of(context).alternate,
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                  font: GoogleFonts.interTight(
                                    fontWeight:
                                    FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontStyle,
                                  ),
                                  color: FlutterFlowTheme.of(context)
                                      .primaryText,
                                  letterSpacing: 0.0,
                                ),
                                elevation: 0.0,
                                borderRadius: BorderRadius.circular(25.0),
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
      },
    );
  }
}
