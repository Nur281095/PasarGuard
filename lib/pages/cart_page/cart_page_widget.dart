import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/components/no_data_found_component_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'cart_page_model.dart';
export 'cart_page_model.dart';
import 'dart:convert'; // <-- for jsonEncode in debug logs

class CartPageWidget extends StatefulWidget {
  const CartPageWidget({super.key});

  static String routeName = 'CartPage';
  static String routePath = '/cartPage';

  @override
  State<CartPageWidget> createState() => _CartPageWidgetState();
}

class _CartPageWidgetState extends State<CartPageWidget> with RouteAware {
  late CartPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  // Loading flag for getCart API call
  bool _isLoadingCart = false;

  // Loading states for individual cart items
  // Key: cart_item_id, Value: loading operation type ('update', 'remove')
  final Map<String, String> _itemLoadingStates = {};

  // --- Helpers: robust JSON → int / String casting ---
  int _asInt(dynamic v, {int fallback = 0}) {
    if (v == null) return fallback;
    if (v is num) return v.toInt();
    if (v is String) return int.tryParse(v) ?? fallback;
    return fallback;
  }

  String _asString(dynamic v, {String fallback = ''}) {
    if (v == null) return fallback;
    return v.toString();
  }

  int _itemQty(dynamic item) =>
      _asInt(getJsonField(item, r'''$.quantity'''));
  String _itemIdStr(dynamic item) =>
      _asString(getJsonField(item, r'''$.cart_item_id'''));
  String _itemIdForRemove(dynamic item) =>
      _asString(getJsonField(item, r'''$.cart_item_id'''));

  // --- Cart total calculation helpers ---
  double _d(double? v) => v ?? 0.0;
  String _fmt(double v) => v.toStringAsFixed(2);

  double get _grandTotal => _d(_model.cartTotal); // already includes shipping/discounts
  double get _shipping => _d(_model.cartShipping);
  double get _discount => _d(_model.cartDiscount);

  // derive item subtotal = grandTotal - shipping - discount (never negative)
  double get _itemsSubtotal {
    final x = _grandTotal - _shipping - _discount;
    return x.isFinite && x > 0 ? x : 0.0;
  }

  // ===== DEBUG HELPERS =====

  void _logApi(String label, ApiCallResponse? resp) {
    debugPrint('================= $label =================');
    if (resp == null) {
      debugPrint('Response is NULL');
      return;
    }
    debugPrint('succeeded: ${resp.succeeded}');
    debugPrint('statusCode: ${resp.statusCode}');
    try {
      debugPrint('jsonBody: ${jsonEncode(resp.jsonBody)}');
    } catch (e) {
      debugPrint('jsonBody (raw): ${resp.jsonBody}');
      debugPrint('jsonEncode error: $e');
    }
  }

  void _logHydratedCart(String label) {
    debugPrint('----- $label (hydrated cart) -----');
    debugPrint('cartItems length: ${_model.cartItems.length}');
    debugPrint('cartTotal: ${_model.cartTotal}');
    debugPrint('cartDiscount: ${_model.cartDiscount}');
    debugPrint('cartShipping: ${_model.cartShipping}');
  }

  void _logItemImage(dynamic item, String imageUrl, int index) {
    debugPrint('>>> Cart item #$index imageUrl = $imageUrl');
    try {
      debugPrint('item JSON: ${jsonEncode(item)}');
    } catch (e) {
      debugPrint('item (raw): $item');
      debugPrint('item jsonEncode error: $e');
    }
  }

  void _showSnackBar({
    required ScaffoldMessengerState? messenger,
    required Color backgroundColor,
    required Color textColor,
    required String message,
    Duration duration = const Duration(milliseconds: 4000),
  }) {
    if (messenger == null) {
      return;
    }

    messenger.showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            color: textColor,
          ),
        ),
        duration: duration,
        backgroundColor: backgroundColor,
      ),
    );
  }

  // --- Image URL resolver for cart item ---
  // If image URL has any space, it will be replaced with %20
  String _cartItemImageUrl(dynamic item) {
    // Using a network placeholder that will be handled by errorBuilder
    const String fallback =
        'https://fakeimg.pl/1280x720'; // placeholder (will use asset placeholder on error)

    dynamic _field(dynamic source, String key) {
      if (source is Map) return source[key];
      return null;
    }

    String? _extractUrl(dynamic candidate) {
      if (candidate == null) return null;
      if (candidate is String && candidate.trim().isNotEmpty) {
        return candidate.trim();
      }
      if (candidate is Map) {
        for (final key in ['src', 'url', 'image_url']) {
          final v = candidate[key];
          if (v is String && v.trim().isNotEmpty) {
            return v.trim();
          }
        }
      }
      return null;
    }

    try {
      // 1) image at root (string or object)
      String? url = _extractUrl(_field(item, 'image'));

      // 2) product.image / product.images[0]
      if (url == null) {
        final product = _field(item, 'product');
        if (product != null) {
          url = _extractUrl(_field(product, 'image'));
          if (url == null) {
            final images = _field(product, 'images');
            if (images is List && images.isNotEmpty) {
              url = _extractUrl(images.first);
            }
          }
        }
      }

      // 3) images[0] at root
      if (url == null) {
        final images = _field(item, 'images');
        if (images is List && images.isNotEmpty) {
          url = _extractUrl(images.first);
        }
      }

      // 4) fallback to configured $.image JSONPath (if any)
      if (url == null) {
        final raw = getJsonField(item, r'''$.image''');
        url = _extractUrl(raw);
      }

      if (url != null && url.isNotEmpty) {
        var u = url.trim();

        // protocol-relative URL
        if (u.startsWith('//')) {
          u = 'https:$u';
        }

        // Replace spaces with %20 as requested
        u = u.replaceAll(' ', '%20');

        return u;
      }
    } catch (_) {
      // ignore and fall back
    }

    return fallback;
  }

  // --- Hydrate model from UPDATE CART response ---
  void _hydrateFromUpdateCart(ApiCallResponse resp) {
    final body = resp.jsonBody;
    _model.cartItems = PasargadrugsGroup.updateCartCall
        .cartItems(body)!
        .toList()
        .cast<dynamic>();
    _model.cartTotal = PasargadrugsGroup.updateCartCall.cartTotla(body);
    _model.cartPromos = PasargadrugsGroup.updateCartCall
        .promors(body)!
        .toList()
        .cast<dynamic>();
    _model.cartDiscount =
        PasargadrugsGroup.updateCartCall.discount(body)?.toDouble();
    _model.cartShipping =
        PasargadrugsGroup.updateCartCall.shippingFee(body);
    _model.billingAddress =
        PasargadrugsGroup.updateCartCall.billingAddress(body);
    _model.shippingAddress =
        PasargadrugsGroup.updateCartCall.shippingAddress(body);

    _logHydratedCart('updateCartCall');
  }

  // --- Hydrate model from REMOVE CART response ---
  void _hydrateFromRemoveCart(ApiCallResponse resp) {
    final body = resp.jsonBody;
    _model.cartItems = PasargadrugsGroup.removeCartCall
        .cartItems(body)!
        .toList()
        .cast<dynamic>();
    _model.cartTotal = PasargadrugsGroup.removeCartCall.cartTotla(body);
    _model.cartPromos = PasargadrugsGroup.removeCartCall
        .promors(body)!
        .toList()
        .cast<dynamic>();
    _model.cartDiscount =
        PasargadrugsGroup.removeCartCall.discount(body)?.toDouble();
    _model.cartShipping =
        PasargadrugsGroup.removeCartCall.shippingFee(body);
    _model.billingAddress =
        PasargadrugsGroup.removeCartCall.billingAddress(body);
    _model.shippingAddress =
        PasargadrugsGroup.removeCartCall.shippingAddress(body);
    _logHydratedCart('removeCartCall');
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CartPageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (FFAppState().cartId == null || FFAppState().cartId == '') {
        return;
      }

      if (!mounted) return;

      final messenger = ScaffoldMessenger.maybeOf(context);
      final theme = FlutterFlowTheme.of(context);
      final snackTextColor = theme.primaryText;
      final snackBackgroundColor = theme.secondary;

      setState(() {
        _isLoadingCart = true;
      });

      debugPrint('>>> Calling getCartCall with cartId=${FFAppState().cartId}');

      _model.cartxyz = await PasargadrugsGroup.getCartCall.call(
        cartId: FFAppState().cartId,
        token: currentAuthenticationToken,
      );
      _logApi('getCartCall', _model.cartxyz);

      if (!mounted) return;

      if ((_model.cartxyz?.succeeded ?? false)) {
        _model.cartItems = PasargadrugsGroup.getCartCall
            .cartItems(
          (_model.cartxyz?.jsonBody ?? ''),
        )!
            .toList()
            .cast<dynamic>();
        _model.cartTotal = PasargadrugsGroup.getCartCall.cartTotal(
          (_model.cartxyz?.jsonBody ?? ''),
        );
        _model.cartPromos = PasargadrugsGroup.getCartCall
            .promos(
          (_model.cartxyz?.jsonBody ?? ''),
        )!
            .toList()
            .cast<dynamic>();
        _model.cartDiscount = PasargadrugsGroup.getCartCall
            .discounts(
          (_model.cartxyz?.jsonBody ?? ''),
        )
            ?.toDouble();
        _model.cartShipping = PasargadrugsGroup.getCartCall.shippingFee(
          (_model.cartxyz?.jsonBody ?? ''),
        );
        _model.billingAddress = PasargadrugsGroup.getCartCall.billingAddress(
          (_model.cartxyz?.jsonBody ?? ''),
        );
        _model.shippingAddress =
            PasargadrugsGroup.getCartCall.shippingAddress(
              (_model.cartxyz?.jsonBody ?? ''),
            );
        safeSetState(() {});
      } else {
        _showSnackBar(
          messenger: messenger,
          backgroundColor: snackBackgroundColor,
          textColor: snackTextColor,
          message: PasargadrugsGroup.getCartCall.message(
                (_model.cartxyz?.jsonBody ?? ''),
              ) ??
              'Failed to load cart.',
        );
      }

      if (mounted) {
        setState(() {
          _isLoadingCart = false;
        });
      }
    });
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    _model.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(CartPageWidget oldWidget) {
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
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.black,
              size: 30.0,
            ),
            onPressed: () async {
              context.pop();
            },
          ),
          title: Text(
            'Cart',
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
          actions: const [],
          centerTitle: true,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF9F9F9),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(0.0),
                      bottomRight: Radius.circular(0.0),
                      topLeft: Radius.circular(24.0),
                      topRight: Radius.circular(24.0),
                    ),
                  ),
                  child: _isLoadingCart
                      ? Center(
                    child: SizedBox(
                      width: 50.0,
                      height: 50.0,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          FlutterFlowTheme.of(context).primary,
                        ),
                      ),
                    ),
                  )
                      : Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        0.0, 10.0, 0.0, 20.0),
                    child: Builder(
                      builder: (context) {
                        final cartItem = _model.cartItems.toList();
                        if (cartItem.isEmpty) {
                          return const Center(
                            child: NoDataFoundComponentWidget(
                              message: 'Cart is empty.',
                            ),
                          );
                        }
                        _model.debugGeneratorVariables[
                        'cartItem${cartItem.length > 100 ? ' (first 100)' : ''}'] =
                            debugSerializeParam(
                              cartItem.take(100),
                              ParamType.JSON,
                              isList: true,
                              link:
                              'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=CartPage',
                              name: 'dynamic',
                              nullable: false,
                            );
                        debugLogWidgetClass(_model);

                        return SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: List.generate(
                                cartItem.length, (cartItemIndex) {
                              final cartItemItem =
                              cartItem[cartItemIndex];
                              final imageUrl =
                              _cartItemImageUrl(cartItemItem);
                              _logItemImage(
                                  cartItemItem, imageUrl, cartItemIndex);

                              final itemId = _itemIdStr(cartItemItem);
                              final isItemLoading = _itemLoadingStates.containsKey(itemId);

                              return Padding(
                                padding:
                                const EdgeInsetsDirectional.fromSTEB(
                                    20.0, 0.0, 20.0, 0.0),
                                child: Stack(
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      height: 100.0,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        boxShadow: const [
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
                                        const BorderRadius.only(
                                          bottomLeft: Radius.circular(10.0),
                                          bottomRight: Radius.circular(10.0),
                                          topLeft: Radius.circular(10.0),
                                          topRight: Radius.circular(10.0),
                                        ),
                                      ),
                                      child: Opacity(
                                        opacity: isItemLoading ? 0.6 : 1.0,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding:
                                              const EdgeInsetsDirectional
                                                  .fromSTEB(
                                                  12.0, 0.0, 0.0, 0.0),
                                              child: Container(
                                                width: 80.0,
                                                height: 80.0,
                                                decoration:
                                                const BoxDecoration(),
                                                child: ClipRRect(
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      0.0),
                                                  child: Image.network(
                                                    imageUrl,
                                                    key: ValueKey(imageUrl),
                                                    width: 80.0,
                                                    height: 80.0,
                                                    fit: BoxFit.cover,
                                                    errorBuilder: (context,
                                                        error, stackTrace) {
                                                      if (!mounted) {
                                                        return const SizedBox(
                                                          width: 80.0,
                                                          height: 80.0,
                                                        );
                                                      }
                                                      // Use placeholder image from assets
                                                      return Container(
                                                        width: 80.0,
                                                        height: 80.0,
                                                        decoration:
                                                        BoxDecoration(
                                                          color:
                                                          FlutterFlowTheme.of(
                                                              context)
                                                              .alternate,
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                              0.0),
                                                        ),
                                                        child: Image.asset(
                                                          'assets/images/placeholder.jpg',
                                                          width: 80.0,
                                                          height: 80.0,
                                                          fit: BoxFit.cover,
                                                          errorBuilder: (context, error, stackTrace) {
                                                            // Fallback to icon if asset also fails
                                                            return Icon(
                                                              Icons
                                                                  .image_not_supported,
                                                              color: FlutterFlowTheme
                                                                  .of(context)
                                                                  .secondaryText,
                                                              size: 40.0,
                                                            );
                                                          },
                                                        ),
                                                      );
                                                    },
                                                    loadingBuilder: (context,
                                                        child,
                                                        loadingProgress) {
                                                      if (!mounted) {
                                                        return const SizedBox(
                                                          width: 80.0,
                                                          height: 80.0,
                                                        );
                                                      }
                                                      if (loadingProgress ==
                                                          null) {
                                                        return child;
                                                      }
                                                      return Container(
                                                        width: 80.0,
                                                        height: 80.0,
                                                        decoration:
                                                        BoxDecoration(
                                                          color:
                                                          FlutterFlowTheme.of(
                                                              context)
                                                              .alternate,
                                                        ),
                                                        child: Center(
                                                          child:
                                                          CircularProgressIndicator(
                                                            value: loadingProgress
                                                                .expectedTotalBytes !=
                                                                null
                                                                ? loadingProgress
                                                                .cumulativeBytesLoaded /
                                                                loadingProgress
                                                                    .expectedTotalBytes!
                                                                : null,
                                                            color:
                                                            FlutterFlowTheme.of(
                                                                context)
                                                                .primary,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    cacheWidth: 80,
                                                    cacheHeight: 80,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                const EdgeInsetsDirectional
                                                    .fromSTEB(10.0, 10.0,
                                                    10.0, 10.0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color:
                                                    FlutterFlowTheme.of(
                                                        context)
                                                        .secondaryBackground,
                                                  ),
                                                  child: Column(
                                                    mainAxisSize:
                                                    MainAxisSize.max,
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      Container(
                                                        decoration:
                                                        const BoxDecoration(),
                                                        child: Text(
                                                          getJsonField(
                                                            cartItemItem,
                                                            r'''$.name''',
                                                          ).toString(),
                                                          maxLines: 3,
                                                          style: FlutterFlowTheme
                                                              .of(context)
                                                              .bodyMedium
                                                              .override(
                                                            font: GoogleFonts
                                                                .inter(
                                                              fontWeight:
                                                              FlutterFlowTheme.of(
                                                                  context)
                                                                  .bodyMedium
                                                                  .fontWeight,
                                                              fontStyle: FlutterFlowTheme.of(
                                                                  context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                            ),
                                                            letterSpacing:
                                                            0.0,
                                                            fontWeight:
                                                            FlutterFlowTheme.of(
                                                                context)
                                                                .bodyMedium
                                                                .fontWeight,
                                                            fontStyle:
                                                            FlutterFlowTheme.of(
                                                                context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        '\$${getJsonField(
                                                          cartItemItem,
                                                          r'''$.subtotal''',
                                                        ).toString()}',
                                                        style:
                                                        FlutterFlowTheme.of(
                                                            context)
                                                            .bodyMedium
                                                            .override(
                                                          font: GoogleFonts
                                                              .inter(
                                                            fontWeight:
                                                            FontWeight
                                                                .w600,
                                                            fontStyle:
                                                            FlutterFlowTheme.of(
                                                                context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                          ),
                                                          color:
                                                          FlutterFlowTheme.of(
                                                              context)
                                                              .secondaryText,
                                                          letterSpacing:
                                                          0.0,
                                                          fontWeight:
                                                          FontWeight
                                                              .w600,
                                                          fontStyle:
                                                          FlutterFlowTheme.of(
                                                              context)
                                                              .bodyMedium
                                                              .fontStyle,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceAround,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                              children: [
                                                Padding(
                                                  padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(0.0, 0.0,
                                                      10.0, 0.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                    MainAxisSize.max,
                                                    children: [
                                                      InkWell(
                                                        splashColor:
                                                        Colors.transparent,
                                                        focusColor:
                                                        Colors.transparent,
                                                        hoverColor:
                                                        Colors.transparent,
                                                        highlightColor:
                                                        Colors.transparent,
                                                      onTap: () async {
                                                        if (_itemLoadingStates.containsKey(_itemIdStr(cartItemItem))) {
                                                          return; // Prevent multiple simultaneous calls
                                                        }

                                                        var _shouldSetState =
                                                        false;

                                                        if (!mounted) {
                                                          return;
                                                        }

                                                        final messenger =
                                                            ScaffoldMessenger
                                                                .maybeOf(
                                                                    context);
                                                        final theme =
                                                            FlutterFlowTheme.of(
                                                                context);
                                                        final snackTextColor =
                                                            theme.primaryText;
                                                        final snackBackgroundColor =
                                                            theme.secondary;

                                                        // Compute safe new quantity
                                                        final currentQty =
                                                        _itemQty(
                                                            cartItemItem);
                                                          final newQty =
                                                          (currentQty > 0)
                                                              ? (currentQty -
                                                              1)
                                                              : 0;
                                                          debugPrint(
                                                              '>>> updateCartCall (DEC) cartItemId=${_itemIdStr(cartItemItem)}, newQty=$newQty');

                                                          final itemId = _itemIdStr(cartItemItem);
                                                          setState(() {
                                                            _itemLoadingStates[itemId] = 'update';
                                                          });

                                                          try {
                                                            _model.decCartResult =
                                                            await PasargadrugsGroup
                                                                .updateCartCall
                                                                .call(
                                                              cartItemId: itemId,
                                                              token:
                                                              currentAuthenticationToken,
                                                              cartId:
                                                              FFAppState()
                                                                  .cartId,
                                                              quantity: newQty,
                                                            );
                                                            _logApi(
                                                                'updateCartCall DEC',
                                                                _model
                                                                    .decCartResult);
                                                        } catch (e) {
                                                          debugPrint('Error in updateCartCall (DEC): $e');
                                                          if (mounted) {
                                                            _showSnackBar(
                                                              messenger:
                                                                  messenger,
                                                              backgroundColor:
                                                                  snackBackgroundColor,
                                                              textColor:
                                                                  snackTextColor,
                                                              message:
                                                                  'Failed to update cart. Please try again.',
                                                            );
                                                          }
                                                        } finally {
                                                          if (mounted) {
                                                            setState(() {
                                                                _itemLoadingStates.remove(itemId);
                                                              });
                                                            }
                                                          }

                                                          if (!mounted) {
                                                            return;
                                                          }

                                                          _shouldSetState =
                                                          true;

                                                          if ((_model
                                                              .decCartResult
                                                              ?.succeeded ??
                                                              false)) {
                                                            _hydrateFromUpdateCart(
                                                                _model
                                                                    .decCartResult!);
                                                            if (mounted) {
                                                              safeSetState(
                                                                      () {});
                                                            }
                                                            return;
                                                          } else {
                                                            if (mounted) {
                                                              _showSnackBar(
                                                                messenger:
                                                                    messenger,
                                                                backgroundColor:
                                                                    snackBackgroundColor,
                                                                textColor:
                                                                    snackTextColor,
                                                                message:
                                                                    PasargadrugsGroup
                                                                        .updateCartCall
                                                                        .message(
                                                                      (_model.decCartResult?.jsonBody ??
                                                                              ''),
                                                                    ) ??
                                                                    'Failed to update cart.',
                                                              );
                                                            }
                                                          }

                                                          if (_shouldSetState &&
                                                              mounted) {
                                                            safeSetState(
                                                                    () {});
                                                          }
                                                        },
                                                        child: Container(
                                                          width: 24.0,
                                                          height: 24.0,
                                                          decoration:
                                                          BoxDecoration(
                                                            color:
                                                            FlutterFlowTheme.of(
                                                                context)
                                                                .secondaryBackground,
                                                            boxShadow: const [
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
                                                            const BorderRadius
                                                                .only(
                                                              bottomLeft: Radius
                                                                  .circular(
                                                                  12.0),
                                                              bottomRight:
                                                              Radius
                                                                  .circular(
                                                                  12.0),
                                                              topLeft: Radius
                                                                  .circular(
                                                                  12.0),
                                                              topRight: Radius
                                                                  .circular(
                                                                  12.0),
                                                            ),
                                                          ),
                                                          child: _itemLoadingStates[_itemIdStr(cartItemItem)] == 'update'
                                                              ? SizedBox(
                                                            width: 18.0,
                                                            height: 18.0,
                                                            child: CircularProgressIndicator(
                                                              strokeWidth: 2.0,
                                                              valueColor: AlwaysStoppedAnimation<Color>(
                                                                FlutterFlowTheme.of(context).primary,
                                                              ),
                                                            ),
                                                          )
                                                              : Align(
                                                            alignment:
                                                            const AlignmentDirectional(
                                                                0.0, 0.0),
                                                            child: FaIcon(
                                                              FontAwesomeIcons
                                                                  .minus,
                                                              color: FlutterFlowTheme
                                                                  .of(context)
                                                                  .primaryText,
                                                              size: 18.0,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        '${_itemQty(cartItemItem)}',
                                                        style:
                                                        FlutterFlowTheme.of(
                                                            context)
                                                            .bodyMedium
                                                            .override(
                                                          font: GoogleFonts
                                                              .inter(
                                                            fontWeight:
                                                            FontWeight
                                                                .w500,
                                                            fontStyle:
                                                            FlutterFlowTheme.of(
                                                                context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                          ),
                                                          fontSize: 16.0,
                                                          letterSpacing:
                                                          0.0,
                                                          fontWeight:
                                                          FontWeight
                                                              .w500,
                                                          fontStyle:
                                                          FlutterFlowTheme.of(
                                                              context)
                                                              .bodyMedium
                                                              .fontStyle,
                                                        ),
                                                      ),
                                                      InkWell(
                                                        splashColor:
                                                        Colors.transparent,
                                                        focusColor:
                                                        Colors.transparent,
                                                        hoverColor:
                                                        Colors.transparent,
                                                        highlightColor:
                                                        Colors.transparent,
                                                      onTap: () async {
                                                        if (_itemLoadingStates.containsKey(_itemIdStr(cartItemItem))) {
                                                          return; // Prevent multiple simultaneous calls
                                                        }

                                                        var _shouldSetState =
                                                        false;

                                                        if (!mounted) {
                                                          return;
                                                        }

                                                        final messenger =
                                                            ScaffoldMessenger
                                                                .maybeOf(
                                                                    context);
                                                        final theme =
                                                            FlutterFlowTheme.of(
                                                                context);
                                                        final snackTextColor =
                                                            theme.primaryText;
                                                        final snackBackgroundColor =
                                                            theme.secondary;

                                                        final currentQty =
                                                        _itemQty(
                                                            cartItemItem);
                                                          final newQty =
                                                              currentQty + 1;
                                                          debugPrint(
                                                              '>>> updateCartCall (INC) cartItemId=${_itemIdStr(cartItemItem)}, newQty=$newQty');

                                                          final itemId = _itemIdStr(cartItemItem);
                                                          setState(() {
                                                            _itemLoadingStates[itemId] = 'update';
                                                          });

                                                          try {
                                                            _model.incrementCartResult =
                                                            await PasargadrugsGroup
                                                                .updateCartCall
                                                                .call(
                                                              cartItemId: itemId,
                                                              token:
                                                              currentAuthenticationToken,
                                                              cartId:
                                                              FFAppState()
                                                                  .cartId,
                                                              quantity: newQty,
                                                            );
                                                            _logApi(
                                                                'updateCartCall INC',
                                                                _model
                                                                    .incrementCartResult);
                                                        } catch (e) {
                                                          debugPrint('Error in updateCartCall (INC): $e');
                                                          if (mounted) {
                                                            _showSnackBar(
                                                              messenger:
                                                                  messenger,
                                                              backgroundColor:
                                                                  snackBackgroundColor,
                                                              textColor:
                                                                  snackTextColor,
                                                              message:
                                                                  'Failed to update cart. Please try again.',
                                                            );
                                                          }
                                                        } finally {
                                                          if (mounted) {
                                                            setState(() {
                                                                _itemLoadingStates.remove(itemId);
                                                              });
                                                            }
                                                          }

                                                          if (!mounted) {
                                                            return;
                                                          }

                                                          _shouldSetState =
                                                          true;

                                                          if ((_model
                                                              .incrementCartResult
                                                              ?.succeeded ??
                                                              false)) {
                                                            _hydrateFromUpdateCart(
                                                                _model
                                                                    .incrementCartResult!);
                                                            if (mounted) {
                                                              safeSetState(
                                                                      () {});
                                                            }
                                                            return;
                                                          } else {
                                                            if (mounted) {
                                                              _showSnackBar(
                                                                messenger:
                                                                    messenger,
                                                                backgroundColor:
                                                                    snackBackgroundColor,
                                                                textColor:
                                                                    snackTextColor,
                                                                message:
                                                                    PasargadrugsGroup
                                                                        .updateCartCall
                                                                        .message(
                                                                      (_model.incrementCartResult?.jsonBody ??
                                                                              ''),
                                                                    ) ??
                                                                    'Failed to update cart.',
                                                              );
                                                            }
                                                          }

                                                          if (_shouldSetState &&
                                                              mounted) {
                                                            safeSetState(
                                                                    () {});
                                                          }
                                                        },
                                                        child: Container(
                                                          width: 24.0,
                                                          height: 24.0,
                                                          decoration:
                                                          BoxDecoration(
                                                            color:
                                                            FlutterFlowTheme.of(
                                                                context)
                                                                .primaryText,
                                                            boxShadow: const [
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
                                                            const BorderRadius
                                                                .only(
                                                              bottomLeft: Radius
                                                                  .circular(
                                                                  12.0),
                                                              bottomRight:
                                                              Radius
                                                                  .circular(
                                                                  12.0),
                                                              topLeft: Radius
                                                                  .circular(
                                                                  12.0),
                                                              topRight: Radius
                                                                  .circular(
                                                                  12.0),
                                                            ),
                                                          ),
                                                          child: _itemLoadingStates[_itemIdStr(cartItemItem)] == 'update'
                                                              ? SizedBox(
                                                            width: 18.0,
                                                            height: 18.0,
                                                            child: CircularProgressIndicator(
                                                              strokeWidth: 2.0,
                                                              valueColor: AlwaysStoppedAnimation<Color>(
                                                                FlutterFlowTheme.of(context).secondaryBackground,
                                                              ),
                                                            ),
                                                          )
                                                              : Align(
                                                            alignment:
                                                            const AlignmentDirectional(
                                                                0.0, 0.0),
                                                            child: Icon(
                                                              Icons.add,
                                                              color: FlutterFlowTheme
                                                                  .of(context)
                                                                  .secondaryBackground,
                                                              size: 18.0,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ].divide(const SizedBox(
                                                        width: 10.0)),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(0.0, 0.0,
                                                      10.0, 0.0),
                                                  child: InkWell(
                                                    splashColor:
                                                    Colors.transparent,
                                                    focusColor:
                                                    Colors.transparent,
                                                    hoverColor:
                                                    Colors.transparent,
                                                    highlightColor:
                                                    Colors.transparent,
                                                    onTap: () async {
                                                      if (_itemLoadingStates.containsKey(_itemIdForRemove(cartItemItem))) {
                                                        return; // Prevent multiple simultaneous calls
                                                      }

                                                      var _shouldSetState =
                                                      false;
                                                      if (!mounted) {
                                                        return;
                                                      }

                                                      final messenger =
                                                          ScaffoldMessenger
                                                              .maybeOf(
                                                                  context);
                                                      final theme =
                                                          FlutterFlowTheme.of(
                                                              context);
                                                      final snackTextColor =
                                                          theme.primaryText;
                                                      final snackBackgroundColor =
                                                          theme.secondary;
                                                      debugPrint(
                                                          '>>> removeCartCall cartItemId=${_itemIdForRemove(cartItemItem)}');

                                                      final itemId = _itemIdForRemove(cartItemItem);
                                                      setState(() {
                                                        _itemLoadingStates[itemId] = 'remove';
                                                      });

                                                      try {
                                                        _model.apiResult1ux =
                                                        await PasargadrugsGroup
                                                            .removeCartCall
                                                            .call(
                                                          cartItemId: itemId,
                                                          token:
                                                          currentAuthenticationToken,
                                                          cartId: FFAppState()
                                                              .cartId,
                                                        );
                                                        _logApi(
                                                            'removeCartCall',
                                                            _model.apiResult1ux);
                                                      } catch (e) {
                                                        debugPrint('Error in removeCartCall: $e');
                                                        if (mounted) {
                                                          _showSnackBar(
                                                            messenger:
                                                                messenger,
                                                            backgroundColor:
                                                                snackBackgroundColor,
                                                            textColor:
                                                                snackTextColor,
                                                            message:
                                                                'Failed to remove item. Please try again.',
                                                          );
                                                        }
                                                      } finally {
                                                        if (mounted) {
                                                          setState(() {
                                                            _itemLoadingStates.remove(itemId);
                                                          });
                                                        }
                                                      }

                                                      if (!mounted) {
                                                        return;
                                                      }

                                                      _shouldSetState = true;

                                                      if ((_model.apiResult1ux
                                                          ?.succeeded ??
                                                          false)) {
                                                        _hydrateFromRemoveCart(
                                                            _model
                                                                .apiResult1ux!);
                                                        if (mounted) {
                                                          safeSetState(() {});
                                                        }
                                                        return;
                                                      } else {
                                                        if (mounted) {
                                                          _showSnackBar(
                                                            messenger:
                                                                messenger,
                                                            backgroundColor:
                                                                snackBackgroundColor,
                                                            textColor:
                                                                snackTextColor,
                                                            message:
                                                                PasargadrugsGroup
                                                                    .removeCartCall
                                                                    .message(
                                                                  (_model.apiResult1ux
                                                                              ?.jsonBody ??
                                                                          ''),
                                                                ) ??
                                                                'Failed to remove item.',
                                                          );
                                                        }
                                                      }

                                                      if (_shouldSetState &&
                                                          mounted) {
                                                        safeSetState(() {});
                                                      }
                                                    },
                                                    child: Container(
                                                      width: 34.0,
                                                      height: 34.0,
                                                      decoration: BoxDecoration(
                                                        color:
                                                        FlutterFlowTheme.of(
                                                            context)
                                                            .primaryText,
                                                        borderRadius:
                                                        const BorderRadius
                                                            .only(
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
                                                      child: _itemLoadingStates[_itemIdForRemove(cartItemItem)] == 'remove'
                                                          ? SizedBox(
                                                        width: 20.0,
                                                        height: 20.0,
                                                        child: CircularProgressIndicator(
                                                          strokeWidth: 2.0,
                                                          valueColor: AlwaysStoppedAnimation<Color>(
                                                            FlutterFlowTheme.of(context).secondaryBackground,
                                                          ),
                                                        ),
                                                      )
                                                          : Icon(
                                                        Icons.delete,
                                                        color:
                                                        FlutterFlowTheme.of(
                                                            context)
                                                            .secondaryBackground,
                                                        size: 24.0,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    if (isItemLoading)
                                      Positioned.fill(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Color.fromRGBO(255, 255, 255, 0.3),
                                            borderRadius: const BorderRadius.only(
                                              bottomLeft: Radius.circular(10.0),
                                              bottomRight: Radius.circular(10.0),
                                              topLeft: Radius.circular(10.0),
                                              topRight: Radius.circular(10.0),
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              );
                            })
                                .divide(const SizedBox(height: 10.0))
                                .addToStart(
                                const SizedBox(height: 10.0))
                                .addToEnd(const SizedBox(height: 10.0)),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                    0.0, 0.0, 0.0, 20.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color:
                    FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        20.0, 0.0, 20.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          textScaler:
                          MediaQuery.of(context).textScaler,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Subtotal:  ',
                                style: FlutterFlowTheme.of(context)
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
                                  color: const Color(0x9C57636C),
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
                              TextSpan(
                                text:
                                '\$${_fmt(_itemsSubtotal)}',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                  font: GoogleFonts.inter(
                                    fontWeight:
                                    FontWeight.bold,
                                    fontStyle:
                                    FlutterFlowTheme.of(
                                        context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                                  fontSize: 16.0,
                                  letterSpacing: 0.0,
                                  fontWeight:
                                  FontWeight.bold,
                                  fontStyle:
                                  FlutterFlowTheme.of(
                                      context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                              )
                            ],
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                              font: GoogleFonts.inter(
                                fontWeight:
                                FlutterFlowTheme.of(
                                    context)
                                    .bodyMedium
                                    .fontWeight,
                                fontStyle:
                                FlutterFlowTheme.of(
                                    context)
                                    .bodyMedium
                                    .fontStyle,
                              ),
                              letterSpacing: 0.0,
                              fontWeight:
                              FlutterFlowTheme.of(
                                  context)
                                  .bodyMedium
                                  .fontWeight,
                              fontStyle:
                              FlutterFlowTheme.of(
                                  context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                          ),
                        ),
                        RichText(
                          textScaler:
                          MediaQuery.of(context).textScaler,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Total:  ',
                                style: FlutterFlowTheme.of(context)
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
                                  color: const Color(0x9C57636C),
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
                              TextSpan(
                                text:
                                '\$${_fmt(_grandTotal)}',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                  font: GoogleFonts.inter(
                                    fontWeight:
                                    FontWeight.bold,
                                    fontStyle:
                                    FlutterFlowTheme.of(
                                        context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                                  fontSize: 16.0,
                                  letterSpacing: 0.0,
                                  fontWeight:
                                  FontWeight.bold,
                                  fontStyle:
                                  FlutterFlowTheme.of(
                                      context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                              )
                            ],
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                              font: GoogleFonts.inter(
                                fontWeight:
                                FlutterFlowTheme.of(
                                    context)
                                    .bodyMedium
                                    .fontWeight,
                                fontStyle:
                                FlutterFlowTheme.of(
                                    context)
                                    .bodyMedium
                                    .fontStyle,
                              ),
                              letterSpacing: 0.0,
                              fontWeight:
                              FlutterFlowTheme.of(
                                  context)
                                  .bodyMedium
                                  .fontWeight,
                              fontStyle:
                              FlutterFlowTheme.of(
                                  context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 100.0,
                decoration: BoxDecoration(
                  color:
                  FlutterFlowTheme.of(context).secondaryBackground,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(0.0),
                    bottomRight: Radius.circular(0.0),
                    topLeft: Radius.circular(24.0),
                    topRight: Radius.circular(24.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                      20.0, 0.0, 20.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment:
                        const AlignmentDirectional(-1.0, 0.0),
                        child: Text(
                          '\$${_fmt(_grandTotal)}',
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                            font: GoogleFonts.inter(
                              fontWeight: FontWeight.bold,
                              fontStyle:
                              FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                            color:
                            FlutterFlowTheme.of(context)
                                .primaryText,
                            fontSize: 24.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.bold,
                            fontStyle:
                            FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                        ),
                      ),
                      FFButtonWidget(
                        onPressed: () async {
                          context.pushNamed(
                            AddAddressPageWidget.routeName,
                            queryParameters: {
                              'isBilling': serializeParam(
                                true,
                                ParamType.bool,
                              ),
                              'amount': serializeParam(
                                _fmt(_grandTotal),
                                ParamType.String,
                              ),
                            }.withoutNulls,
                          );
                        },
                        text: 'Checkout',
                        options: FFButtonOptions(
                          height: 50.0,
                          padding:
                          const EdgeInsetsDirectional.fromSTEB(
                              20.0, 0.0, 20.0, 0.0),
                          iconPadding:
                          const EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 8.0, 0.0),
                          color: FlutterFlowTheme.of(context)
                              .primaryText,
                          textStyle: FlutterFlowTheme.of(context)
                              .titleSmall
                              .override(
                            font: GoogleFonts.interTight(
                              fontWeight: FontWeight.w600,
                              fontStyle:
                              FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .fontStyle,
                            ),
                            color:
                            FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w600,
                            fontStyle:
                            FlutterFlowTheme.of(context)
                                .titleSmall
                                .fontStyle,
                          ),
                          elevation: 0.0,
                          borderRadius:
                          BorderRadius.circular(25.0),
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
    );
  }
}
