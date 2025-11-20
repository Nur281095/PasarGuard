import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'home_page_model.dart';
export 'home_page_model.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({super.key});

  static String routeName = 'HomePage';
  static String routePath = '/homePage';

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> with RouteAware {
  late HomePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomePageModel());

    _model.searchFTextController ??= TextEditingController()
      ..addListener(() {
        debugLogWidgetClass(_model);
      });
    _model.searchFFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);

    _model.dispose();

    super.dispose();
  }

  @override
  void didUpdateWidget(HomePageWidget oldWidget) {
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

    return FutureBuilder<ApiCallResponse>(
      future: PasargadrugsGroup.homeCall.call(),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: Colors.white,
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
        final homePageHomeResponse = snapshot.data!;
        _model.debugBackendQueries[
        'PasargadrugsGroup.homeCall_statusCode_Scaffold_105brrlb'] =
            debugSerializeParam(
              homePageHomeResponse.statusCode,
              ParamType.int,
              link:
              'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=HomePage',
              name: 'int',
              nullable: false,
            );
        _model.debugBackendQueries[
        'PasargadrugsGroup.homeCall_responseBody_Scaffold_105brrlb'] =
            debugSerializeParam(
              homePageHomeResponse.bodyText,
              ParamType.String,
              link:
              'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=HomePage',
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
            backgroundColor: Colors.white,
            body: SafeArea(
              top: true,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: double.infinity,
                    height: 0.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).primaryText,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(-1.0, 0.0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                10.0, 0.0, 10.0, 0.0),
                            child: Icon(
                              Icons.chevron_left_rounded,
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              size: 24.0,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            width: 100.0,
                            height: 100.0,
                            decoration: BoxDecoration(),
                            child: Align(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  GoRouter.of(context).prepareAuthEvent();
                                  await authManager.signOut();
                                  GoRouter.of(context).clearRedirectLocation();

                                  context.goNamedAuth(
                                      SignInPageWidget.routeName,
                                      context.mounted);
                                },
                                child: Text(
                                  'We are following CDC safety',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    font: GoogleFonts.inter(
                                      fontWeight:
                                      FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle:
                                      FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    fontSize: 12.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(-1.0, 0.0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                10.0, 0.0, 10.0, 0.0),
                            child: Icon(
                              Icons.keyboard_arrow_right_sharp,
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              size: 24.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 70.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              15.0, 0.0, 0.0, 0.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset(
                              'assets/images/1.splash.png',
                              width: 150.0,
                              height: 40.0,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 10.0, 0.0),
                          child: Container(
                            width: 130.0,
                            child: Stack(
                              children: [
                                Align(
                                  alignment: AlignmentDirectional(-1.0, 0.0),
                                  child: FlutterFlowIconButton(
                                    borderRadius: 8.0,
                                    buttonSize: 40.0,
                                    fillColor: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    icon: Icon(
                                      Icons.person_rounded,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      size: 24.0,
                                    ),
                                    onPressed: () async {
                                      context.pushNamed(
                                          ProfilePageWidget.routeName);
                                    },
                                  ),
                                ),
                                Align(
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                  child: FlutterFlowIconButton(
                                    borderRadius: 8.0,
                                    buttonSize: 40.0,
                                    fillColor: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    icon: Icon(
                                      Icons.shopping_cart,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      size: 24.0,
                                    ),
                                    onPressed: () async {
                                      context
                                          .pushNamed(CartPageWidget.routeName);
                                    },
                                  ),
                                ),
                                Align(
                                  alignment: AlignmentDirectional(1.0, 0.0),
                                  child: FlutterFlowIconButton(
                                    borderRadius: 8.0,
                                    buttonSize: 40.0,
                                    fillColor: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    icon: Icon(
                                      Icons.favorite,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      size: 24.0,
                                    ),
                                    onPressed: () async {
                                      context.pushNamed(
                                          FavProductsPageWidget.routeName);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                    EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                      child: TextFormField(
                        controller: _model.searchFTextController,
                        focusNode: _model.searchFFocusNode,
                        autofocus: true,
                        textInputAction: TextInputAction.next,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelStyle:
                          FlutterFlowTheme.of(context).labelMedium.override(
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
                          hintStyle:
                          FlutterFlowTheme.of(context).labelMedium.override(
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
                          errorStyle:
                          FlutterFlowTheme.of(context).bodyMedium.override(
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
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
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
                          color: Color(0xFFF7F7F7),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(0.0),
                            bottomRight: Radius.circular(0.0),
                            topLeft: Radius.circular(24.0),
                            topRight: Radius.circular(24.0),
                          ),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20.0, 20.0, 20.0, 0.0),
                                child: Container(
                                  width: double.infinity,
                                  height: 150.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(12.0),
                                      bottomRight: Radius.circular(12.0),
                                      topLeft: Radius.circular(12.0),
                                      topRight: Radius.circular(12.0),
                                    ),
                                  ),
                                  child: Builder(
                                    builder: (context) {
                                      final slider = PasargadrugsGroup.homeCall
                                          .slider(
                                        homePageHomeResponse.jsonBody,
                                      )
                                          ?.toList() ??
                                          [];
                                      _model.debugGeneratorVariables[
                                      'slider${slider.length > 100 ? ' (first 100)' : ''}'] =
                                          debugSerializeParam(
                                            slider.take(100),
                                            ParamType.JSON,
                                            isList: true,
                                            link:
                                            'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=HomePage',
                                            name: 'dynamic',
                                            nullable: false,
                                          );
                                      debugLogWidgetClass(_model);

                                      // If API returned no slider items, just show an empty placeholder
                                      if (slider.isEmpty) {
                                        // You can also return SizedBox.shrink() if you want nothing.
                                        return Container(
                                          width: double.infinity,
                                          height: 150.0,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(12.0),
                                            color: FlutterFlowTheme.of(context).secondaryBackground,
                                          ),
                                          child: const SizedBox.shrink(),
                                        );
                                      }

                                      // Safe initial page: 0 if only one item, 1 if 2+ items
                                      final initialPage = slider.length > 1 ? 1 : 0;

                                      return Container(
                                        width: double.infinity,
                                        height: 150.0,
                                        child: CarouselSlider.builder(
                                          itemCount: slider.length,
                                          itemBuilder: (context, sliderIndex, _) {
                                            final sliderItem = slider[sliderIndex];

                                            final imageUrl = valueOrDefault<String>(
                                              getJsonField(
                                                sliderItem,
                                                r'''$.image''',
                                              )?.toString(),
                                              'https://fakeimg.pl/1280x720', // fallback
                                            );

                                            return Builder(
                                              builder: (context) {
                                                // Cache theme colors to prevent crashes
                                                final alternateColor = FlutterFlowTheme.of(context).alternate;
                                                final secondaryTextColor = FlutterFlowTheme.of(context).secondaryText;
                                                final primaryColor = FlutterFlowTheme.of(context).primary;

                                                return ClipRRect(
                                                  borderRadius: BorderRadius.circular(8.0),
                                                  child: Image.network(
                                                    imageUrl,
                                                    width: 200.0,
                                                    height: 200.0,
                                                    fit: BoxFit.cover,
                                                    errorBuilder: (context, error, stackTrace) {
                                                      return Container(
                                                        width: 200.0,
                                                        height: 200.0,
                                                        color: alternateColor,
                                                        child: Icon(
                                                          Icons.image_not_supported,
                                                          color: secondaryTextColor,
                                                          size: 40.0,
                                                        ),
                                                      );
                                                    },
                                                    loadingBuilder: (context, child, loadingProgress) {
                                                      if (loadingProgress == null) return child;
                                                      return Container(
                                                        width: 200.0,
                                                        height: 200.0,
                                                        color: alternateColor,
                                                        child: Center(
                                                          child: CircularProgressIndicator(
                                                            value: loadingProgress.expectedTotalBytes != null
                                                                ? loadingProgress.cumulativeBytesLoaded /
                                                                    loadingProgress.expectedTotalBytes!
                                                                : null,
                                                            color: primaryColor,
                                                            strokeWidth: 2.0,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          carouselController:
                                          _model.carouselController ??= CarouselSliderController(),
                                          options: CarouselOptions(
                                            initialPage: initialPage,
                                            viewportFraction: 0.65,
                                            disableCenter: true,
                                            enlargeCenterPage: true,
                                            enlargeFactor: 0.25,
                                            enableInfiniteScroll: true,
                                            scrollDirection: Axis.horizontal,
                                            autoPlay: true,
                                            autoPlayAnimationDuration: const Duration(milliseconds: 800),
                                            autoPlayInterval: const Duration(milliseconds: 4800),
                                            autoPlayCurve: Curves.linear,
                                            pauseAutoPlayInFiniteScroll: true,
                                            onPageChanged: (index, _) =>
                                            _model.carouselCurrentIndex = index,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20.0, 20.0, 20.0, 0.0),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(),
                                  child: Text(
                                    'Top Trending Rug Size',
                                    style: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .override(
                                      font: GoogleFonts.interTight(
                                        fontWeight:
                                        FlutterFlowTheme.of(context)
                                            .titleMedium
                                            .fontWeight,
                                        fontStyle:
                                        FlutterFlowTheme.of(context)
                                            .titleMedium
                                            .fontStyle,
                                      ),
                                      letterSpacing: 0.0,
                                      fontWeight:
                                      FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontWeight,
                                      fontStyle:
                                      FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontStyle,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20.0, 10.0, 20.0, 20.0),
                                child: Builder(
                                  builder: (context) {
                                    final shopBySize = PasargadrugsGroup.homeCall
                                        .shopBySize(
                                      homePageHomeResponse.jsonBody,
                                    )
                                        ?.withoutNulls
                                        .toList() ??
                                        [];
                                    _model.debugGeneratorVariables[
                                    'shopBySize${shopBySize.length > 100 ? ' (first 100)' : ''}'] =
                                        debugSerializeParam(
                                          shopBySize.take(100),
                                          ParamType.JSON,
                                          isList: true,
                                          link:
                                          'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=HomePage',
                                          name: 'dynamic',
                                          nullable: false,
                                        );
                                    debugLogWidgetClass(_model);

                                    if (shopBySize.isEmpty) {
                                      return const SizedBox.shrink();
                                    }

                                    return GridView.builder(
                                      padding: EdgeInsets.zero,
                                      gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        crossAxisSpacing: 12.0,
                                        mainAxisSpacing: 12.0,
                                        childAspectRatio: 2.5,
                                      ),
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemCount: shopBySize.length,
                                      itemBuilder: (context, sizeIndex) {
                                        final sizeItem = shopBySize[sizeIndex];
                                        return InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            // Navigate to products page with size filter
                                            context.pushNamed(
                                              CategoriesItemsPageWidget.routeName,
                                              queryParameters: {
                                                'catID': serializeParam(
                                                  null,
                                                  ParamType.int,
                                                ),
                                                'navTitle': serializeParam(
                                                  'Size: $sizeItem',
                                                  ParamType.String,
                                                ),
                                                'filter': serializeParam(
                                                  {
                                                    'size': sizeItem,
                                                    'type': 'rug',
                                                  },
                                                  ParamType.JSON,
                                                ),
                                              }.withoutNulls,
                                            );
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFF5F5F5), // Light grey background
                                              borderRadius: BorderRadius.circular(10.0),
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 2.0,
                                                  color: const Color(0x33000000),
                                                  offset: const Offset(0.0, 1.0),
                                                )
                                              ],
                                            ),
                                            child: Center(
                                              child: Padding(
                                                padding: const EdgeInsetsDirectional.fromSTEB(
                                                    8.0, 12.0, 8.0, 12.0),
                                                child: Text(
                                                  sizeItem,
                                                  style: FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                    font: GoogleFonts.inter(
                                                      fontWeight: FontWeight.w600,
                                                      fontStyle:
                                                      FlutterFlowTheme.of(context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                    ),
                                                    color: const Color(0xFF1E3A8A), // Dark blue text
                                                    fontSize: 14.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w600,
                                                    fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20.0, 20.0, 20.0, 0.0),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(),
                                  child: Text(
                                    'Shop by Sizes',
                                    style: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .override(
                                      font: GoogleFonts.interTight(
                                        fontWeight:
                                        FlutterFlowTheme.of(context)
                                            .titleMedium
                                            .fontWeight,
                                        fontStyle:
                                        FlutterFlowTheme.of(context)
                                            .titleMedium
                                            .fontStyle,
                                      ),
                                      letterSpacing: 0.0,
                                      fontWeight:
                                      FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontWeight,
                                      fontStyle:
                                      FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontStyle,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20.0, 10.0, 0.0, 20.0),
                                child: Container(
                                  width: double.infinity,
                                  height: 100.0,
                                  decoration: BoxDecoration(),
                                  child: Builder(
                                    builder: (context) {
                                      final product = PasargadrugsGroup.homeCall
                                          .products(
                                        homePageHomeResponse.jsonBody,
                                      )
                                          ?.toList() ??
                                          [];
                                      _model.debugGeneratorVariables[
                                      'product${product.length > 100 ? ' (first 100)' : ''}'] =
                                          debugSerializeParam(
                                            product.take(100),
                                            ParamType.JSON,
                                            isList: true,
                                            link:
                                            'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=HomePage',
                                            name: 'dynamic',
                                            nullable: false,
                                          );
                                      debugLogWidgetClass(_model);

                                      return SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: List.generate(
                                              product.length, (productIndex) {
                                            final productItem =
                                            product[productIndex];
                                            return InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                              Colors.transparent,
                                              onTap: () async {
                                                context.pushNamed(
                                                  ProductDetailPageWidget
                                                      .routeName,
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
                                                width: 100.0,
                                                height: 100.0,
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
                                                child: Stack(
                                                  alignment:
                                                  AlignmentDirectional(
                                                      0.0, 0.0),
                                                  children: [
                                                    Container(
                                                      width: 100.0,
                                                      height: 100.0,
                                                      decoration: BoxDecoration(
                                                        color: FlutterFlowTheme
                                                            .of(context)
                                                            .secondaryBackground,
                                                        boxShadow: [
                                                          BoxShadow(
                                                            blurRadius: 4.0,
                                                            color: Color(
                                                                0x33000000),
                                                            offset: Offset(
                                                              0.0,
                                                              2.0,
                                                            ),
                                                          )
                                                        ],
                                                        borderRadius:
                                                        BorderRadius.only(
                                                          bottomLeft:
                                                          Radius.circular(
                                                              8.0),
                                                          bottomRight:
                                                          Radius.circular(
                                                              8.0),
                                                          topLeft:
                                                          Radius.circular(
                                                              8.0),
                                                          topRight:
                                                          Radius.circular(
                                                              8.0),
                                                        ),
                                                      ),
                                                      child: Builder(
                                                        builder: (context) {
                                                          // Cache theme colors
                                                          final alternateColor = FlutterFlowTheme.of(context).alternate;
                                                          final secondaryTextColor = FlutterFlowTheme.of(context).secondaryText;
                                                          final primaryColor = FlutterFlowTheme.of(context).primary;

                                                          return ClipRRect(
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                            child: Image.network(
                                                              valueOrDefault<
                                                                  String>(
                                                                getJsonField(
                                                                  productItem,
                                                                  r'''$.images[0]''',
                                                                )?.toString(),
                                                                'https://picsum.photos/seed/530/600',
                                                              ),
                                                              width: 100.0,
                                                              height: 100.0,
                                                              fit: BoxFit.cover,
                                                              errorBuilder: (context, error, stackTrace) {
                                                                return Container(
                                                                  width: 100.0,
                                                                  height: 100.0,
                                                                  color: alternateColor,
                                                                  child: Icon(
                                                                    Icons.image_not_supported,
                                                                    color: secondaryTextColor,
                                                                    size: 32.0,
                                                                  ),
                                                                );
                                                              },
                                                              loadingBuilder: (context, child, loadingProgress) {
                                                                if (loadingProgress == null) return child;
                                                                return Container(
                                                                  width: 100.0,
                                                                  height: 100.0,
                                                                  color: alternateColor,
                                                                  child: Center(
                                                                    child: CircularProgressIndicator(
                                                                      value: loadingProgress.expectedTotalBytes != null
                                                                          ? loadingProgress.cumulativeBytesLoaded /
                                                                              loadingProgress.expectedTotalBytes!
                                                                          : null,
                                                                      color: primaryColor,
                                                                      strokeWidth: 2.0,
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                    Container(
                                                      width: 100.0,
                                                      height: 100.0,
                                                      decoration: BoxDecoration(
                                                        gradient:
                                                        LinearGradient(
                                                          colors: [
                                                            Colors.transparent,
                                                            Colors.transparent,
                                                            FlutterFlowTheme.of(
                                                                context)
                                                                .primaryText
                                                          ],
                                                          stops: [
                                                            0.0,
                                                            0.3,
                                                            1.0
                                                          ],
                                                          begin:
                                                          AlignmentDirectional(
                                                              0.0, -1.0),
                                                          end:
                                                          AlignmentDirectional(
                                                              0, 1.0),
                                                        ),
                                                        borderRadius:
                                                        BorderRadius.only(
                                                          bottomLeft:
                                                          Radius.circular(
                                                              8.0),
                                                          bottomRight:
                                                          Radius.circular(
                                                              8.0),
                                                          topLeft:
                                                          Radius.circular(
                                                              8.0),
                                                          topRight:
                                                          Radius.circular(
                                                              8.0),
                                                        ),
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                      AlignmentDirectional(
                                                          0.0, 1.0),
                                                      child: Container(
                                                        width: 90.0,
                                                        decoration:
                                                        BoxDecoration(),
                                                        child: Padding(
                                                          padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                              0.0,
                                                              0.0,
                                                              0.0,
                                                              6.0),
                                                          child: Text(
                                                            getJsonField(
                                                              productItem,
                                                              r'''$.name''',
                                                            ).toString(),
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: FlutterFlowTheme
                                                                .of(context)
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
                                                              color: FlutterFlowTheme.of(
                                                                  context)
                                                                  .secondaryBackground,
                                                              fontSize:
                                                              12.0,
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
                                                  ],
                                                ),
                                              ),
                                            );
                                          }).divide(SizedBox(width: 12.0)),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20.0, 0.0, 20.0, 0.0),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(),
                                  child: Text(
                                    'Shop By Categories',
                                    style: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .override(
                                      font: GoogleFonts.interTight(
                                        fontWeight:
                                        FlutterFlowTheme.of(context)
                                            .titleMedium
                                            .fontWeight,
                                        fontStyle:
                                        FlutterFlowTheme.of(context)
                                            .titleMedium
                                            .fontStyle,
                                      ),
                                      letterSpacing: 0.0,
                                      fontWeight:
                                      FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontWeight,
                                      fontStyle:
                                      FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontStyle,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20.0, 10.0, 0.0, 30.0),
                                child: Container(
                                  width: double.infinity,
                                  height: 100.0,
                                  decoration: BoxDecoration(),
                                  child: Builder(
                                    builder: (context) {
                                      final category =
                                          PasargadrugsGroup.homeCall
                                              .categories(
                                            homePageHomeResponse
                                                .jsonBody,
                                          )
                                              ?.toList() ??
                                              [];
                                      _model.debugGeneratorVariables[
                                      'category${category.length > 100 ? ' (first 100)' : ''}'] =
                                          debugSerializeParam(
                                            category.take(100),
                                            ParamType.DataStruct,
                                            isList: true,
                                            link:
                                            'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=HomePage',
                                            name: 'FilterObject',
                                            nullable: false,
                                          );
                                      debugLogWidgetClass(_model);

                                      return SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: List.generate(
                                              category.length, (categoryIndex) {
                                            final categoryItem =
                                            category[categoryIndex];
                                            return InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                              Colors.transparent,
                                              onTap: () async {
                                                context.pushNamed(
                                                  CategoriesItemsPageWidget
                                                      .routeName,
                                                  queryParameters: {
                                                    'catID': serializeParam(
                                                      categoryItem.id,
                                                      ParamType.int,
                                                    ),
                                                    'navTitle': serializeParam(
                                                      categoryItem.name,
                                                      ParamType.String,
                                                    ),
                                                    'filter': serializeParam(
                                                      PasargadrugsGroup.homeCall
                                                          .filters(
                                                        homePageHomeResponse
                                                            .jsonBody,
                                                      ),
                                                      ParamType.JSON,
                                                    ),
                                                  }.withoutNulls,
                                                );
                                              },
                                              child: Container(
                                                width: 100.0,
                                                height: 100.0,
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
                                                child: Stack(
                                                  alignment:
                                                  AlignmentDirectional(
                                                      0.0, 0.0),
                                                  children: [
                                                    Container(
                                                      width: 100.0,
                                                      height: 100.0,
                                                      decoration: BoxDecoration(
                                                        color: FlutterFlowTheme
                                                            .of(context)
                                                            .secondaryBackground,
                                                        boxShadow: [
                                                          BoxShadow(
                                                            blurRadius: 4.0,
                                                            color: Color(
                                                                0x33000000),
                                                            offset: Offset(
                                                              0.0,
                                                              2.0,
                                                            ),
                                                          )
                                                        ],
                                                        borderRadius:
                                                        BorderRadius.only(
                                                          bottomLeft:
                                                          Radius.circular(
                                                              8.0),
                                                          bottomRight:
                                                          Radius.circular(
                                                              8.0),
                                                          topLeft:
                                                          Radius.circular(
                                                              8.0),
                                                          topRight:
                                                          Radius.circular(
                                                              8.0),
                                                        ),
                                                      ),
                                                      child: Builder(
                                                        builder: (context) {
                                                          // Cache theme colors
                                                          final alternateColor = FlutterFlowTheme.of(context).alternate;
                                                          final secondaryTextColor = FlutterFlowTheme.of(context).secondaryText;
                                                          final primaryColor = FlutterFlowTheme.of(context).primary;

                                                          return ClipRRect(
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                            child: Image.network(
                                                              categoryItem.image,
                                                              width: 100.0,
                                                              height: 100.0,
                                                              fit: BoxFit.cover,
                                                              errorBuilder: (context, error, stackTrace) {
                                                                return Container(
                                                                  width: 100.0,
                                                                  height: 100.0,
                                                                  color: alternateColor,
                                                                  child: Icon(
                                                                    Icons.image_not_supported,
                                                                    color: secondaryTextColor,
                                                                    size: 32.0,
                                                                  ),
                                                                );
                                                              },
                                                              loadingBuilder: (context, child, loadingProgress) {
                                                                if (loadingProgress == null) return child;
                                                                return Container(
                                                                  width: 100.0,
                                                                  height: 100.0,
                                                                  color: alternateColor,
                                                                  child: Center(
                                                                    child: CircularProgressIndicator(
                                                                      value: loadingProgress.expectedTotalBytes != null
                                                                          ? loadingProgress.cumulativeBytesLoaded /
                                                                              loadingProgress.expectedTotalBytes!
                                                                          : null,
                                                                      color: primaryColor,
                                                                      strokeWidth: 2.0,
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                    Container(
                                                      width: 100.0,
                                                      height: 100.0,
                                                      decoration: BoxDecoration(
                                                        gradient:
                                                        LinearGradient(
                                                          colors: [
                                                            Colors.transparent,
                                                            Colors.transparent,
                                                            FlutterFlowTheme.of(
                                                                context)
                                                                .primaryText
                                                          ],
                                                          stops: [
                                                            0.0,
                                                            0.3,
                                                            1.0
                                                          ],
                                                          begin:
                                                          AlignmentDirectional(
                                                              0.0, -1.0),
                                                          end:
                                                          AlignmentDirectional(
                                                              0, 1.0),
                                                        ),
                                                        borderRadius:
                                                        BorderRadius.only(
                                                          bottomLeft:
                                                          Radius.circular(
                                                              8.0),
                                                          bottomRight:
                                                          Radius.circular(
                                                              8.0),
                                                          topLeft:
                                                          Radius.circular(
                                                              8.0),
                                                          topRight:
                                                          Radius.circular(
                                                              8.0),
                                                        ),
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                      AlignmentDirectional(
                                                          0.0, 1.0),
                                                      child: Container(
                                                        width: 90.0,
                                                        decoration:
                                                        BoxDecoration(
                                                          borderRadius:
                                                          BorderRadius.only(
                                                            bottomLeft:
                                                            Radius.circular(
                                                                0.0),
                                                            bottomRight:
                                                            Radius.circular(
                                                                0.0),
                                                            topLeft:
                                                            Radius.circular(
                                                                0.0),
                                                            topRight:
                                                            Radius.circular(
                                                                0.0),
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                              0.0,
                                                              0.0,
                                                              0.0,
                                                              6.0),
                                                          child: Text(
                                                            categoryItem.name,
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: FlutterFlowTheme
                                                                .of(context)
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
                                                              color: FlutterFlowTheme.of(
                                                                  context)
                                                                  .secondaryBackground,
                                                              fontSize:
                                                              12.0,
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
                                                  ],
                                                ),
                                              ),
                                            );
                                          }).divide(SizedBox(width: 12.0)),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20.0, 0.0, 20.0, 0.0),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(),
                                  child: Text(
                                    'Collections',
                                    style: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .override(
                                      font: GoogleFonts.interTight(
                                        fontWeight:
                                        FlutterFlowTheme.of(context)
                                            .titleMedium
                                            .fontWeight,
                                        fontStyle:
                                        FlutterFlowTheme.of(context)
                                            .titleMedium
                                            .fontStyle,
                                      ),
                                      letterSpacing: 0.0,
                                      fontWeight:
                                      FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontWeight,
                                      fontStyle:
                                      FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontStyle,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20.0, 10.0, 0.0, 30.0),
                                child: Container(
                                  width: double.infinity,
                                  height: 100.0,
                                  decoration: BoxDecoration(),
                                  child: Builder(
                                    builder: (context) {
                                      final collection =
                                          PasargadrugsGroup.homeCall
                                              .collections(
                                            homePageHomeResponse
                                                .jsonBody,
                                          )
                                              ?.toList() ??
                                              [];
                                      _model.debugGeneratorVariables[
                                      'collection${collection.length > 100 ? ' (first 100)' : ''}'] =
                                          debugSerializeParam(
                                            collection.take(100),
                                            ParamType.DataStruct,
                                            isList: true,
                                            link:
                                            'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=HomePage',
                                            name: 'FilterObject',
                                            nullable: false,
                                          );
                                      debugLogWidgetClass(_model);

                                      return SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children:
                                          List.generate(collection.length,
                                                  (collectionIndex) {
                                                final collectionItem =
                                                collection[collectionIndex];
                                                return InkWell(
                                                  splashColor: Colors.transparent,
                                                  focusColor: Colors.transparent,
                                                  hoverColor: Colors.transparent,
                                                  highlightColor:
                                                  Colors.transparent,
                                                  onTap: () async {
                                                    context.pushNamed(
                                                      ProductDetailPageWidget
                                                          .routeName,
                                                      queryParameters: {
                                                        'prodID': serializeParam(
                                                          collectionItem.id,
                                                          ParamType.int,
                                                        ),
                                                      }.withoutNulls,
                                                    );
                                                  },
                                                  child: Container(
                                                    width: 100.0,
                                                    height: 100.0,
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
                                                    child: Stack(
                                                      alignment:
                                                      AlignmentDirectional(
                                                          0.0, 0.0),
                                                      children: [
                                                        Container(
                                                          width: 100.0,
                                                          height: 100.0,
                                                          decoration: BoxDecoration(
                                                            color: FlutterFlowTheme
                                                                .of(context)
                                                                .secondaryBackground,
                                                            boxShadow: [
                                                              BoxShadow(
                                                                blurRadius: 4.0,
                                                                color: Color(
                                                                    0x33000000),
                                                                offset: Offset(
                                                                  0.0,
                                                                  2.0,
                                                                ),
                                                              )
                                                            ],
                                                            borderRadius:
                                                            BorderRadius.only(
                                                              bottomLeft:
                                                              Radius.circular(
                                                                  8.0),
                                                              bottomRight:
                                                              Radius.circular(
                                                                  8.0),
                                                              topLeft:
                                                              Radius.circular(
                                                                  8.0),
                                                              topRight:
                                                              Radius.circular(
                                                                  8.0),
                                                            ),
                                                          ),
                                                          child: Builder(
                                                            builder: (context) {
                                                              // Cache theme colors
                                                              final alternateColor = FlutterFlowTheme.of(context).alternate;
                                                              final secondaryTextColor = FlutterFlowTheme.of(context).secondaryText;
                                                              final primaryColor = FlutterFlowTheme.of(context).primary;

                                                              return ClipRRect(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(8.0),
                                                                child: Image.network(
                                                                  valueOrDefault<
                                                                      String>(
                                                                    collectionItem
                                                                        .image,
                                                                    'https://picsum.photos/seed/530/600',
                                                                  ),
                                                                  width: 100.0,
                                                                  height: 100.0,
                                                                  fit: BoxFit.cover,
                                                                  errorBuilder: (context, error, stackTrace) {
                                                                    return Container(
                                                                      width: 100.0,
                                                                      height: 100.0,
                                                                      color: alternateColor,
                                                                      child: Icon(
                                                                        Icons.image_not_supported,
                                                                        color: secondaryTextColor,
                                                                        size: 32.0,
                                                                      ),
                                                                    );
                                                                  },
                                                                  loadingBuilder: (context, child, loadingProgress) {
                                                                    if (loadingProgress == null) return child;
                                                                    return Container(
                                                                      width: 100.0,
                                                                      height: 100.0,
                                                                      color: alternateColor,
                                                                      child: Center(
                                                                        child: CircularProgressIndicator(
                                                                          value: loadingProgress.expectedTotalBytes != null
                                                                              ? loadingProgress.cumulativeBytesLoaded /
                                                                                  loadingProgress.expectedTotalBytes!
                                                                              : null,
                                                                          color: primaryColor,
                                                                          strokeWidth: 2.0,
                                                                        ),
                                                                      ),
                                                                    );
                                                                  },
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 100.0,
                                                          height: 100.0,
                                                          decoration: BoxDecoration(
                                                            gradient:
                                                            LinearGradient(
                                                              colors: [
                                                                Colors.transparent,
                                                                Colors.transparent,
                                                                FlutterFlowTheme.of(
                                                                    context)
                                                                    .primaryText
                                                              ],
                                                              stops: [
                                                                0.0,
                                                                0.3,
                                                                1.0
                                                              ],
                                                              begin:
                                                              AlignmentDirectional(
                                                                  0.0, -1.0),
                                                              end:
                                                              AlignmentDirectional(
                                                                  0, 1.0),
                                                            ),
                                                            borderRadius:
                                                            BorderRadius.only(
                                                              bottomLeft:
                                                              Radius.circular(
                                                                  8.0),
                                                              bottomRight:
                                                              Radius.circular(
                                                                  8.0),
                                                              topLeft:
                                                              Radius.circular(
                                                                  8.0),
                                                              topRight:
                                                              Radius.circular(
                                                                  8.0),
                                                            ),
                                                          ),
                                                        ),
                                                        Align(
                                                          alignment:
                                                          AlignmentDirectional(
                                                              0.0, 1.0),
                                                          child: Container(
                                                            width: 90.0,
                                                            decoration:
                                                            BoxDecoration(),
                                                            child: Padding(
                                                              padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  0.0,
                                                                  6.0),
                                                              child: Text(
                                                                collectionItem.name,
                                                                textAlign: TextAlign
                                                                    .center,
                                                                style: FlutterFlowTheme
                                                                    .of(context)
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
                                                                  color: FlutterFlowTheme.of(
                                                                      context)
                                                                      .secondaryBackground,
                                                                  fontSize:
                                                                  12.0,
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
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }).divide(SizedBox(width: 12.0)),
                                        ),
                                      );
                                    },
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
        );
      },
    );
  }
}