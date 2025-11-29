import '/backend/api_requests/api_calls.dart';
import '/components/filter_products_component_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/app_network_image.dart';
import 'dart:ui';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/index.dart';
import '/core/services/user_journey_tracker.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'categories_items_page_model.dart';
import 'dart:async';
import 'package:flutter/scheduler.dart';
import '/flutter_flow/price_helpers.dart';

class CategoriesItemsPageWidget extends StatefulWidget {
  const CategoriesItemsPageWidget({
    super.key,
    required this.catID,
    required this.navTitle,
    this.filter,
  });

  final int? catID;
  final String? navTitle;
  final dynamic filter;

  static String routeName = 'CategoriesItemsPage';
  static String routePath = '/categoriesItemsPage';

  @override
  State<CategoriesItemsPageWidget> createState() =>
      _CategoriesItemsPageWidgetState();
}

class _CategoriesItemsPageWidgetState extends State<CategoriesItemsPageWidget>
    with RouteAware {
  late CategoriesItemsPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isLoadingCart = false;
  bool get _isSalePage => (widget.navTitle?.toLowerCase() == 'sale');

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CategoriesItemsPageModel());
    setState(() {
      _isLoadingCart = true;
    });
    // On page load action.
    _scheduleInitialProductsLoad();

    _model.searchFTextController ??= TextEditingController()
      ..addListener(() {
        debugLogWidgetClass(_model);
      });
    _model.searchFFocusNode ??= FocusNode();
  }

  Future<void> _scheduleInitialProductsLoad() async {
    // Optional small delay – mirror cart load behavior
    await Future.delayed(const Duration(milliseconds: 400));

    final completer = Completer<void>();

    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) {
        if (!completer.isCompleted) completer.complete();
        return;
      }

      // Cache widget values immediately after mounted check
      final filterJson = widget.filter;
      final catId = widget.catID;

      _model.isLoading = true;
      safeSetState(() {});

      // Initialize filters with size, type, and colID from widget.filter if provided
      if (filterJson != null) {
        final sizeFromWidget =
        castToType<String>(getJsonField(filterJson, r'''$.size'''));
        final typeFromWidget =
        castToType<String>(getJsonField(filterJson, r'''$.type'''));
        final colIDFromWidget =
        getJsonField(filterJson, r'''$.colID''');

        if (sizeFromWidget != null ||
            typeFromWidget != null ||
            colIDFromWidget != null) {
          final initialFilters = <String, dynamic>{};

          if (sizeFromWidget != null) {
            initialFilters['size'] = sizeFromWidget;
          }
          if (typeFromWidget != null) {
            initialFilters['type'] = typeFromWidget;
          }
          if (colIDFromWidget != null) {
            initialFilters['colID'] = colIDFromWidget;
          }

          _model.filters = initialFilters;
        }
      }

      // Extract filter parameters if provided
      final shapeFilter = filterJson != null
          ? castToType<String>(getJsonField(filterJson, r'''$.shape'''))
          : null;
      final sizeFilter = filterJson != null
          ? castToType<String>(getJsonField(filterJson, r'''$.size'''))
          : null;
      final typeFilter = filterJson != null
          ? castToType<String>(getJsonField(filterJson, r'''$.type'''))
          : null;
      final collectionFilter = filterJson != null
          ? getJsonField(filterJson, r'''$.colID''')
          : null;
      final searchFilter = filterJson != null
          ? (castToType<String>(getJsonField(filterJson, r'''$.search''')) ?? '')
          : '';
      debugPrint('>>> productsCall params:');
      debugPrint('  categories: $catId');
      debugPrint('  shape: ${shapeFilter ?? ''}');
      debugPrint('  size: ${sizeFilter ?? ''}');
      debugPrint('  type: ${typeFilter ?? ''}');
      debugPrint('  collection: ${collectionFilter != null ? collectionFilter.toString() : 'null'}');
      debugPrint('  search: $searchFilter');
      // Call API
      _model.productApiResult = await _makeProductsCall(
        categories: catId,
        shape: shapeFilter ?? '',
        size: sizeFilter ?? '',
        type: typeFilter ?? '',
        collection: collectionFilter,
        search: searchFilter,
      );

      if (!mounted) {
        _model.isLoading = false;
        if (!completer.isCompleted) completer.complete();
        return;
      }

      if ((_model.productApiResult?.succeeded ?? true)) {
        _model.products = _extractProducts(_model.productApiResult);

        _model.isLoading = false;
        safeSetState(() {});
      } else {
        _model.isLoading = false;
        safeSetState(() {});
      }
      if (mounted) {
        setState(() {
          _isLoadingCart = false;
        });
      }
      if (!completer.isCompleted) {
        completer.complete();
      }
    });

    return completer.future;
  }

  Future<ApiCallResponse> _makeProductsCall({
    int? categories,
    int? style,
    String? shape,
    int? collection,
    int? material,
    int? color,
    String? type,
    String? search,
    String? size,
  }) {
    if (_isSalePage) {
      return PasargadrugsGroup.saleProductsCall.call(
        categories: categories,
        style: style,
        shape: shape ?? '',
        collection: collection,
        material: material,
        color: color,
        type: type ?? '',
        search: search ?? '',
        size: size ?? '',
      );
    }

    return PasargadrugsGroup.productsCall.call(
      categories: categories,
      style: style,
      shape: shape ?? '',
      collection: collection,
      material: material,
      color: color,
      type: type ?? '',
      search: search ?? '',
      size: size ?? '',
    );
  }

  List<dynamic> _extractProducts(ApiCallResponse? response) {
    if (response == null) return [];

    final products = _isSalePage
        ? PasargadrugsGroup.saleProductsCall.products(response.jsonBody)
        : PasargadrugsGroup.productsCall.products(response.jsonBody);

    return (products ?? <dynamic>[]).toList().cast<dynamic>();
  }


  @override
  void dispose() {
    routeObserver.unsubscribe(this);

    _model.dispose();

    super.dispose();
  }

  @override
  void didUpdateWidget(CategoriesItemsPageWidget oldWidget) {
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
      
      // Track screen visit
      UserJourneyTracker.trackScreenVisit(
        'CategoriesItems',
        screenClass: 'CategoriesItemsPageWidget',
      );
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
              color: Colors.black,
              size: 30.0,
            ),
            onPressed: () async {
              if (!_isLoadingCart)
              context.pop();
            },
          ),
          title: Text(
            valueOrDefault<String>(
              widget!.navTitle,
              'Home Accessories',
            ),
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
          actions: widget.navTitle == "Sale"
              ? []
              : [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 8.0, 0.0),
              child: FlutterFlowIconButton(
                borderRadius: 8.0,
                buttonSize: 40.0,
                fillColor: Colors.white,
                icon: Icon(
                  Icons.filter_list_rounded,
                  color: FlutterFlowTheme.of(context).primaryText,
                  size: 30.0,
                ),
                onPressed: () async {
                  var _shouldSetState = false;
                  await showModalBottomSheet(
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    enableDrag: false,
                    context: context,
                    builder: (context) {
                      return WebViewAware(
                        child: GestureDetector(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                          child: Padding(
                            padding: MediaQuery.viewInsetsOf(context),
                            child: Container(
                              height: MediaQuery.sizeOf(context).height * 0.9,
                              child: FilterProductsComponentWidget(
                                categories: widget.filter != null
                                    ? (getJsonField(
                                  widget.filter,
                                  r'''$.cateogries''',
                                  true,
                                ) ??
                                    [])
                                    : [],
                                collections: widget.filter != null
                                    ? (getJsonField(
                                  widget.filter,
                                  r'''$.collections''',
                                  true,
                                ) ??
                                    [])
                                    : [],
                                styles: widget.filter != null
                                    ? (getJsonField(
                                  widget.filter,
                                  r'''$.styles''',
                                  true,
                                ) ??
                                    [])
                                    : [],
                                materials: widget.filter != null
                                    ? (getJsonField(
                                  widget.filter,
                                  r'''$.materials''',
                                  true,
                                ) ??
                                    [])
                                    : [],
                                types: widget.filter != null
                                    ? (getJsonField(
                                  widget.filter,
                                  r'''$.types''',
                                  true,
                                ) ??
                                    [])
                                    : [],
                                weaves: widget.filter != null
                                    ? (getJsonField(
                                  widget.filter,
                                  r'''$.weaves''',
                                  true,
                                ) ??
                                    [])
                                    : [],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ).then((value) {
                    // Merge size, type, and colID from widget.filter if they exist
                    if (value != null && widget.filter != null) {
                      final sizeFromWidget = castToType<String>(getJsonField(
                        widget.filter,
                        r'''$.size''',
                      ));
                      final typeFromWidget = castToType<String>(getJsonField(
                        widget.filter,
                        r'''$.type''',
                      ));
                      final colIDFromWidget = getJsonField(
                        widget.filter,
                        r'''$.colID''',
                      );
                      if (sizeFromWidget != null || typeFromWidget != null || colIDFromWidget != null) {
                        final mergedFilters = Map<String, dynamic>.from(value);
                        if (sizeFromWidget != null) {
                          mergedFilters['size'] = sizeFromWidget;
                        }
                        if (typeFromWidget != null) {
                          mergedFilters['type'] = typeFromWidget;
                        }
                        if (colIDFromWidget != null) {
                          mergedFilters['colID'] = colIDFromWidget;
                        }
                        safeSetState(() => _model.filters = mergedFilters);
                      } else {
                        safeSetState(() => _model.filters = value);
                      }
                    } else {
                      safeSetState(() => _model.filters = value);
                    }
                  });

                  _shouldSetState = true;
                  _model.isLoading = true;
                  safeSetState(() {});
                  
                  // Extract filter parameters (preserve size, type, colID from initial navigation)
                  final sizeFromFilter = castToType<String>(getJsonField(
                    _model.filters,
                    r'''$.size''',
                  ));
                  final typeFromFilter = castToType<String>(getJsonField(
                    _model.filters,
                    r'''$.type''',
                  ));
                  final colIDFromFilter = getJsonField(
                    _model.filters,
                    r'''$.colID''',
                  );

                  _model.filteredApiResult =
                  await _makeProductsCall(
                    categories: getJsonField(
                      _model.filters,
                      r'''$.catID''',
                    ),
                    style: getJsonField(
                      _model.filters,
                      r'''$.styleID''',
                    ),
                    collection: colIDFromFilter ?? getJsonField(
                      _model.filters,
                      r'''$.colID''',
                    ),
                    material: getJsonField(
                      _model.filters,
                      r'''$.matID''',
                    ),
                    type: typeFromFilter ??
                        getJsonField(
                          _model.filters,
                          r'''$.typeID''',
                        ).toString(),
                    shape: castToType<String>(getJsonField(
                      _model.filters,
                      r'''$.shape''',
                    )) ??
                        '',
                    size: sizeFromFilter ?? '',
                    search: _model.searchFTextController.text.isNotEmpty
                        ? _model.searchFTextController.text
                        : (castToType<String>(getJsonField(
                      _model.filters,
                      r'''$.search''',
                    )) ??
                        ''),
                  );

                  _shouldSetState = true;
                  if ((_model.filteredApiResult?.succeeded ?? true)) {
                    _model.products = _extractProducts(_model.filteredApiResult);
                    _model.isLoading = false;
                    safeSetState(() {});
                    if (_shouldSetState) safeSetState(() {});
                    return;
                  } else {
                    _model.isLoading = false;
                    safeSetState(() {});
                    if (_shouldSetState) safeSetState(() {});
                    return;
                  }

                  if (_shouldSetState) safeSetState(() {});
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
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 2.0, 0.0, 0.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding:
                      EdgeInsetsDirectional.fromSTEB(20.0, 10.0, 20.0, 0.0),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color:
                          FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: TextFormField(
                          controller: _model.searchFTextController,
                          focusNode: _model.searchFFocusNode,
                          autofocus: false,
                          onChanged: (_) => EasyDebounce.debounce(
                            '_model.searchFTextController',
                            Duration(milliseconds: 2000),
                                () async {
                              var _shouldSetState = false;
                              if (_model.searchFTextController.text == null ||
                                  _model.searchFTextController.text == '') {
                                _model.isLoading = true;
                                safeSetState(() {});
                                _model.productResults =
                                await _makeProductsCall();

                                _shouldSetState = true;
                                if ((_model.productResults?.succeeded ??
                                    true)) {
                                  _model.products = _extractProducts(_model.productResults);
                                  _model.isLoading = false;
                                  safeSetState(() {});
                                  if (_shouldSetState) safeSetState(() {});
                                  return;
                                } else {
                                  _model.isLoading = false;
                                  safeSetState(() {});
                                  if (_shouldSetState) safeSetState(() {});
                                  return;
                                }
                              } else {
                                if (_shouldSetState) safeSetState(() {});
                                return;
                              }

                              if (_shouldSetState) safeSetState(() {});
                            },
                          ),
                          onFieldSubmitted: (_) async {
                            var _shouldSetState = false;
                            _model.isLoading = true;
                            safeSetState(() {});
                            _model.productSearchResult =
                            await _makeProductsCall(
                              search: _model.searchFTextController.text,
                            );

                            _shouldSetState = true;
                            if ((_model.productSearchResult?.succeeded ??
                                true)) {
                              _model.products = _extractProducts(_model.productSearchResult);
                              _model.isLoading = false;
                              safeSetState(() {});
                              if (_shouldSetState) safeSetState(() {});
                              return;
                            } else {
                              _model.isLoading = false;
                              safeSetState(() {});
                              if (_shouldSetState) safeSetState(() {});
                              return;
                            }

                            if (_shouldSetState) safeSetState(() {});
                          },
                          textInputAction: TextInputAction.next,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                              font: GoogleFonts.robotoFlex(
                                fontWeight: FontWeight.bold,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .fontStyle,
                              ),
                              color: Color(0xFF344054),
                              fontSize: 15.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.bold,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .fontStyle,
                            ),
                            hintText: 'Search',
                            hintStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                              font: GoogleFonts.inter(
                                fontWeight: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .fontStyle,
                              ),
                              letterSpacing: 0.0,
                              fontWeight: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .fontStyle,
                            ),
                            errorStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                              font: GoogleFonts.robotoFlex(
                                fontWeight: FontWeight.normal,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontStyle,
                              ),
                              color: FlutterFlowTheme.of(context).error,
                              fontSize: 10.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.normal,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).alternate,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).primary,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            contentPadding: EdgeInsetsDirectional.fromSTEB(
                                15.0, 0.0, 15.0, 0.0),
                            suffixIcon: Icon(
                              Icons.search_outlined,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              size: 24.0,
                            ),
                          ),
                          style:
                          FlutterFlowTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.robotoFlex(
                              fontWeight: FontWeight.bold,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                            color: Color(0xFF344054),
                            fontSize: 15.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.bold,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                          validator: _model.searchFTextControllerValidator
                              .asValidator(context),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                          child: Builder(
                            builder: (context) {
                              final product = _model.products.toList();
                              _model.debugGeneratorVariables[
                              'product${product.length > 100 ? ' (first 100)' : ''}'] =
                                  debugSerializeParam(
                                    product.take(100),
                                    ParamType.JSON,
                                    isList: true,
                                    link:
                                    'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=CategoriesItemsPage',
                                    name: 'dynamic',
                                    nullable: false,
                                  );
                              debugLogWidgetClass(_model);

                              return SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: List.generate(product.length,
                                          (productIndex) {
                                        final productItem = product[productIndex];
                                        return Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(
                                              20.0, 0.0, 20.0, 0.0),
                                          child: InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              context.pushNamed(
                                                ProductDetailPageWidget.routeName,
                                                queryParameters: {
                                                  'prodID': serializeParam(
                                                    getJsonField(
                                                      productItem,
                                                      r'''$.id''',
                                                    ),
                                                    ParamType.int,
                                                  ),
                                                }.withoutNulls,
                                              );
                                            },
                                            child: Container(
                                              width: double.infinity,
                                              height: 150.0,
                                              decoration: BoxDecoration(
                                                color: FlutterFlowTheme.of(context)
                                                    .secondaryBackground,
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
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft: Radius.circular(12.0),
                                                  bottomRight:
                                                  Radius.circular(12.0),
                                                  topLeft: Radius.circular(12.0),
                                                  topRight: Radius.circular(12.0),
                                                ),
                                              ),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Container(
                                                    width: double.infinity,
                                                    height: 110.0,
                                                    decoration: BoxDecoration(
                                                      color: FlutterFlowTheme.of(
                                                          context)
                                                          .secondaryBackground,
                                                    ),
                                                    child: Padding(
                                                      padding: EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          0.0, 10.0, 0.0, 0.0),
                                                      child: Row(
                                                        mainAxisSize:
                                                        MainAxisSize.max,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                20.0,
                                                                0.0,
                                                                15.0,
                                                                0.0),
                                                            child: Container(
                                                              width: 100.0,
                                                              height: 100.0,
                                                              decoration:
                                                              BoxDecoration(
                                                                color: FlutterFlowTheme
                                                                    .of(context)
                                                                    .secondaryBackground,
                                                              ),
                                                              child: Stack(
                                                                children: [
                                                                  AppNetworkImage(
                                                                    imageUrl: getJsonField(
                                                                      productItem,
                                                                      r'''$.images[0]''',
                                                                    )?.toString(),
                                                                    width: 100.0,
                                                                    height: 100.0,
                                                                    fit: BoxFit.cover,
                                                                    borderRadius: BorderRadius.circular(8.0),
                                                                    placeholderColor: FlutterFlowTheme.of(context).alternate,
                                                                    errorIconColor: FlutterFlowTheme.of(context).secondaryText,
                                                                    errorIconSize: 32.0,
                                                                  ),
                                                                  if (getJsonField(
                                                                    productItem,
                                                                    r'''$.is_sale''',
                                                                  ) !=
                                                                      null)
                                                                    Align(
                                                                      alignment:
                                                                      AlignmentDirectional(
                                                                          -1.0,
                                                                          -1.0),
                                                                      child:
                                                                      Container(
                                                                        width: 60.0,
                                                                        height:
                                                                        20.0,
                                                                        child:
                                                                        Stack(
                                                                          children: [
                                                                            Align(
                                                                              alignment: AlignmentDirectional(
                                                                                  -1.0,
                                                                                  0.0),
                                                                              child:
                                                                              ClipRRect(
                                                                                borderRadius:
                                                                                BorderRadius.circular(8.0),
                                                                                child:
                                                                                Image.asset(
                                                                                  'assets/images/tag_ico.png',
                                                                                  width: double.infinity,
                                                                                  fit: BoxFit.cover,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Align(
                                                                              alignment: AlignmentDirectional(
                                                                                  -1.0,
                                                                                  0.0),
                                                                              child:
                                                                              Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(
                                                                                    7.0,
                                                                                    0.0,
                                                                                    0.0,
                                                                                    0.0),
                                                                                child:
                                                                                Text(
                                                                                  '${getJsonField(
                                                                                    productItem,
                                                                                    r'''$.sale_value''',
                                                                                  ).toString()}%',
                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    font: GoogleFonts.inter(
                                                                                      fontWeight: FontWeight.w500,
                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                    ),
                                                                                    color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                    fontSize: 12.0,
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FontWeight.w500,
                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                  ),
                                                                                ),
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
                                                          Expanded(
                                                            child: Align(
                                                              alignment:
                                                              AlignmentDirectional(
                                                                  0.0, 1.0),
                                                              child: Container(
                                                                height: 40.0,
                                                                decoration:
                                                                BoxDecoration(
                                                                  color: FlutterFlowTheme
                                                                      .of(context)
                                                                      .secondaryBackground,
                                                                ),
                                                                child: Builder(
                                                                  builder:
                                                                      (context) {
                                                                    final image =
                                                                    getJsonField(
                                                                      productItem,
                                                                      r'''$.images''',
                                                                    ).toList();
                                                                    _model.debugGeneratorVariables[
                                                                    'image${image.length > 100 ? ' (first 100)' : ''}'] =
                                                                        debugSerializeParam(
                                                                          image.take(
                                                                              100),
                                                                          ParamType
                                                                              .JSON,
                                                                          isList: true,
                                                                          link:
                                                                          'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=CategoriesItemsPage',
                                                                          name:
                                                                          'dynamic',
                                                                          nullable:
                                                                          false,
                                                                        );
                                                                    debugLogWidgetClass(
                                                                        _model);

                                                                    return SingleChildScrollView(
                                                                      scrollDirection:
                                                                      Axis.horizontal,
                                                                      child: Row(
                                                                        mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                        mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                        children: List.generate(
                                                                            image
                                                                                .length,
                                                                                (imageIndex) {
                                                                              final imageItem =
                                                                              image[
                                                                              imageIndex];
                                                                              return Align(
                                                                                alignment: AlignmentDirectional(
                                                                                    -1.0,
                                                                                    0.0),
                                                                                child:
                                                                                Container(
                                                                                  width:
                                                                                  30.0,
                                                                                  height:
                                                                                  30.0,
                                                                                  decoration:
                                                                                  BoxDecoration(
                                                                                    color:
                                                                                    FlutterFlowTheme.of(context).secondaryBackground,
                                                                                  ),
                                                                            child: AppNetworkImage(
                                                                              imageUrl: imageItem.toString(),
                                                                              width: 30.0,
                                                                              height: 30.0,
                                                                              fit: BoxFit.cover,
                                                                              borderRadius: BorderRadius.circular(8.0),
                                                                              placeholderColor: FlutterFlowTheme.of(context).alternate,
                                                                              errorIconColor: FlutterFlowTheme.of(context).secondaryText,
                                                                              errorIconSize: 16.0,
                                                                            ),
                                                                                ),
                                                                              );
                                                                            }).divide(SizedBox(
                                                                            width:
                                                                            4.0)),
                                                                      ),
                                                                    );
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Padding(
                                                              padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                  15.0,
                                                                  0.0,
                                                                  10.0,
                                                                  0.0),
                                                              child: Container(
                                                                width: 100.0,
                                                                height: 100.0,
                                                                decoration:
                                                                BoxDecoration(
                                                                  color: FlutterFlowTheme
                                                                      .of(context)
                                                                      .secondaryBackground,
                                                                ),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                                  children: [
                                                                    if (false)
                                                                      Align(
                                                                        alignment:
                                                                        AlignmentDirectional(
                                                                            1.0,
                                                                            -1.0),
                                                                        child:
                                                                        FlutterFlowIconButton(
                                                                          borderRadius:
                                                                          8.0,
                                                                          buttonSize:
                                                                          40.0,
                                                                          fillColor:
                                                                          FlutterFlowTheme.of(context)
                                                                              .secondaryBackground,
                                                                          icon:
                                                                          Icon(
                                                                            Icons
                                                                                .favorite_border,
                                                                            color: FlutterFlowTheme.of(context)
                                                                                .primaryText,
                                                                            size:
                                                                            26.0,
                                                                          ),
                                                                          onPressed:
                                                                              () {
                                                                            print(
                                                                                'IconButton pressed ...');
                                                                          },
                                                                        ),
                                                                      ),
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          5.0),
                                                                      child:
                                                                      Container(
                                                                        width: double
                                                                            .infinity,
                                                                        decoration:
                                                                        BoxDecoration(
                                                                          color: FlutterFlowTheme.of(
                                                                              context)
                                                                              .secondaryBackground,
                                                                        ),
                                                                        child:
                                                                        Column(
                                                                          mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                          children:
                                                                          [
                                                                            Align(
                                                                              alignment: AlignmentDirectional(
                                                                                  1.0,
                                                                                  1.0),
                                                                              child: Builder(
                                                                                builder: (context) {
                                                                                  if (_isSalePage) {
                                                                                    final salePrice = PriceHelpers.parsePrice(
                                                                                      getJsonField(productItem, r'''$.sale_price'''),
                                                                                    );
                                                                                    final originalPriceValue = PriceHelpers.parsePrice(
                                                                                      getJsonField(productItem, r'''$.original_price'''),
                                                                                    );
                                                                                    final comparePrice = originalPriceValue > 0 ? originalPriceValue : null;
                                                                                    final displayPrice = salePrice > 0 ? salePrice : originalPriceValue;

                                                                                    return PriceDisplay(
                                                                                      currentPrice: comparePrice ?? displayPrice,
                                                                                      originalPrice: comparePrice != null ? displayPrice : null,
                                                                                      currentPriceStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                        font: GoogleFonts.inter(
                                                                                          fontWeight: FontWeight.w600,
                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                        ),
                                                                                        color: FlutterFlowTheme.of(context).primaryText,
                                                                                        fontSize: 16.0,
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FontWeight.w600,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                      ),
                                                                                      originalPriceStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                        font: GoogleFonts.inter(
                                                                                          fontWeight: FontWeight.w400,
                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                        ),
                                                                                        color: FlutterFlowTheme.of(context).secondaryText,
                                                                                        fontSize: 13.0,
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FontWeight.w400,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                      ),
                                                                                      spacing: 6.0,
                                                                                      axis: Axis.vertical,
                                                                                    );
                                                                                  }

                                                                                  final currentPrice = PriceHelpers.parsePrice(
                                                                                    getJsonField(productItem, r'''$.price'''),
                                                                                  );
                                                                                  
                                                                                  final isSale = PriceHelpers.isOnSale(
                                                                                    getJsonField(productItem, r'''$.is_sale'''),
                                                                                  );
                                                                                  
                                                                                  final saleValue = PriceHelpers.parseInt(
                                                                                    getJsonField(productItem, r'''$.sale_value'''),
                                                                                  ).toDouble();
                                                                                  
                                                                                  final originalPrice = (isSale && saleValue > 0)
                                                                                      ? PriceHelpers.calculateOriginalPrice(currentPrice, saleValue)
                                                                                      : null;
                                                                                  
                                                                                  return PriceDisplay(
                                                                                    currentPrice: currentPrice,
                                                                                    originalPrice: originalPrice,
                                                                                    currentPriceStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                      font: GoogleFonts.inter(
                                                                                        fontWeight: FontWeight.w600,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                      ),
                                                                                      color: FlutterFlowTheme.of(context).primaryText,
                                                                                      fontSize: 16.0,
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FontWeight.w600,
                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                    ),
                                                                                    originalPriceStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                      font: GoogleFonts.inter(
                                                                                        fontWeight: FontWeight.w400,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                      ),
                                                                                      color: FlutterFlowTheme.of(context).secondaryText,
                                                                                      fontSize: 13.0,
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FontWeight.w400,
                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                    ),
                                                                                    spacing: 6.0,
                                                                                    axis: Axis.vertical,
                                                                                  );
                                                                                },
                                                                              ),
                                                                            ),
                                                                            Align(
                                                                              alignment: AlignmentDirectional(
                                                                                  1.0,
                                                                                  1.0),
                                                                              child:
                                                                              Text(
                                                                                getJsonField(
                                                                                  productItem,
                                                                                  r'''$.sku''',
                                                                                ).toString(),
                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                  font: GoogleFonts.inter(
                                                                                    fontWeight: FontWeight.normal,
                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                  ),
                                                                                  color: FlutterFlowTheme.of(context).secondaryText,
                                                                                  fontSize: 10.0,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FontWeight.normal,
                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ].divide(SizedBox(
                                                                              height: 4.0)),
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
                                                  Expanded(
                                                    child: Padding(
                                                      padding: EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          20.0, 0.0, 20.0, 0.0),
                                                      child: Container(
                                                        width: double.infinity,
                                                        decoration: BoxDecoration(
                                                          color: FlutterFlowTheme
                                                              .of(context)
                                                              .secondaryBackground,
                                                        ),
                                                        child: Align(
                                                          alignment:
                                                          AlignmentDirectional(
                                                              -1.0, 0.0),
                                                          child: Text(
                                                            getJsonField(
                                                              productItem,
                                                              r'''$.name''',
                                                            ).toString(),
                                                            style:
                                                            FlutterFlowTheme.of(
                                                                context)
                                                                .bodyMedium
                                                                .override(
                                                              font:
                                                              GoogleFonts
                                                                  .inter(
                                                                fontWeight:
                                                                FontWeight
                                                                    .w600,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                    context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                              ),
                                                              letterSpacing:
                                                              0.0,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w600,
                                                              fontStyle: FlutterFlowTheme.of(
                                                                  context)
                                                                  .bodyMedium
                                                                  .fontStyle,
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
                                        );
                                      }).divide(SizedBox(height: 10.0)),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (_model.isLoading)
                Align(
                  alignment: AlignmentDirectional(0.0, 0.0),
                  child: Container(
                    width: 100.0,
                    height: 100.0,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                    ),
                    child: Container(
                      width: 40.0,
                      height: 40.0,
                      child: custom_widgets.MyCircularProgressIndicator(
                        width: 40.0,
                        height: 40.0,
                        size: 40.0,
                        color: FlutterFlowTheme.of(context).secondaryText,
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
