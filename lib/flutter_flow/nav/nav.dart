import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '/backend/schema/structs/index.dart';

import '/auth/custom_auth/custom_auth_user_provider.dart';

import '/main.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/lat_lng.dart';
import '/flutter_flow/place.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'serialization_util.dart';

import '/index.dart';

export 'package:go_router/go_router.dart';
export 'serialization_util.dart';

const kTransitionInfoKey = '__transition_info__';

GlobalKey<NavigatorState> appNavigatorKey = GlobalKey<NavigatorState>();

const debugRouteLinkMap = {
  '/homePage':
      'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=HomePage',
  '/splashPage':
      'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=SplashPage',
  '/signInPage':
      'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=SignInPage',
  '/signupPage':
      'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=SignupPage',
  '/myOrdersPage':
      'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=MyOrdersPage',
  '/categoriesItemsPage':
      'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=CategoriesItemsPage',
  '/productDetailPage':
      'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=ProductDetailPage',
  '/productMoreDetailPage':
      'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=ProductMoreDetailPage',
  '/filterProductPage':
      'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=FilterProductPage',
  '/cartPage':
      'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=CartPage',
  '/addAddressPage':
      'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=AddAddressPage',
  '/contactUsPage':
      'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=ContactUsPage',
  '/creditCardPage':
      'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=CreditCardPage',
  '/notificationPage':
      'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=NotificationPage',
  '/morePage':
      'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=MorePage',
  '/profilePage':
      'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=ProfilePage',
  '/settingsPage':
      'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=SettingsPage',
  '/changePasswordPage':
      'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=ChangePasswordPage',
  '/orderDetailPage':
      'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=OrderDetailPage',
  '/favProductsPage':
      'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=FavProductsPage',
  '/webViewPage':
      'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=WebViewPage'
};

class AppStateNotifier extends ChangeNotifier {
  AppStateNotifier._();

  static AppStateNotifier? _instance;
  static AppStateNotifier get instance => _instance ??= AppStateNotifier._();

  PasargadrugsAuthUser? initialUser;
  PasargadrugsAuthUser? user;
  bool showSplashImage = true;
  String? _redirectLocation;

  /// Determines whether the app will refresh and build again when a sign
  /// in or sign out happens. This is useful when the app is launched or
  /// on an unexpected logout. However, this must be turned off when we
  /// intend to sign in/out and then navigate or perform any actions after.
  /// Otherwise, this will trigger a refresh and interrupt the action(s).
  bool notifyOnAuthChange = true;

  bool get loading => user == null || showSplashImage;
  bool get loggedIn => user?.loggedIn ?? false;
  bool get initiallyLoggedIn => initialUser?.loggedIn ?? false;
  bool get shouldRedirect => loggedIn && _redirectLocation != null;

  String getRedirectLocation() => _redirectLocation!;
  bool hasRedirect() => _redirectLocation != null;
  void setRedirectLocationIfUnset(String loc) => _redirectLocation ??= loc;
  void clearRedirectLocation() => _redirectLocation = null;

  /// Mark as not needing to notify on a sign in / out when we intend
  /// to perform subsequent actions (such as navigation) afterwards.
  void updateNotifyOnAuthChange(bool notify) => notifyOnAuthChange = notify;

  void update(PasargadrugsAuthUser newUser) {
    final shouldUpdate =
        user?.uid == null || newUser.uid == null || user?.uid != newUser.uid;
    initialUser ??= newUser;
    user = newUser;
    // Refresh the app on auth change unless explicitly marked otherwise.
    // No need to update unless the user has changed.
    if (notifyOnAuthChange && shouldUpdate) {
      notifyListeners();
    }
    // Once again mark the notifier as needing to update on auth change
    // (in order to catch sign in / out events).
    updateNotifyOnAuthChange(true);
  }

  void stopShowingSplashImage() {
    showSplashImage = false;
    notifyListeners();
  }
}

GoRouter createRouter(AppStateNotifier appStateNotifier) => GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: true,
      refreshListenable: appStateNotifier,
      navigatorKey: appNavigatorKey,
      errorBuilder: (context, state) =>
          appStateNotifier.loggedIn ? NavBarPage() : SignInPageWidget(),
      routes: [
        FFRoute(
          name: '_initialize',
          path: '/',
          builder: (context, _) =>
              appStateNotifier.loggedIn ? NavBarPage() : SignInPageWidget(),
        ),
        FFRoute(
          name: HomePageWidget.routeName,
          path: HomePageWidget.routePath,
          builder: (context, params) => params.isEmpty
              ? NavBarPage(initialPage: 'HomePage')
              : HomePageWidget(),
        ),
        FFRoute(
          name: SplashPageWidget.routeName,
          path: SplashPageWidget.routePath,
          builder: (context, params) => SplashPageWidget(),
        ),
        FFRoute(
          name: SignInPageWidget.routeName,
          path: SignInPageWidget.routePath,
          builder: (context, params) => SignInPageWidget(),
        ),
        FFRoute(
          name: SignupPageWidget.routeName,
          path: SignupPageWidget.routePath,
          builder: (context, params) => SignupPageWidget(),
        ),
        FFRoute(
          name: MyOrdersPageWidget.routeName,
          path: MyOrdersPageWidget.routePath,
          builder: (context, params) => params.isEmpty
              ? NavBarPage(initialPage: 'MyOrdersPage')
              : MyOrdersPageWidget(),
        ),
        FFRoute(
          name: CategoriesItemsPageWidget.routeName,
          path: CategoriesItemsPageWidget.routePath,
          builder: (context, params) => CategoriesItemsPageWidget(
            catID: params.getParam(
              'catID',
              ParamType.int,
            ),
            navTitle: params.getParam(
              'navTitle',
              ParamType.String,
            ),
            filter: params.getParam(
              'filter',
              ParamType.JSON,
            ),
          ),
        ),
        FFRoute(
          name: ProductDetailPageWidget.routeName,
          path: ProductDetailPageWidget.routePath,
          builder: (context, params) => ProductDetailPageWidget(
            prodID: params.getParam(
              'prodID',
              ParamType.int,
            ),
          ),
        ),
        FFRoute(
          name: ProductMoreDetailPageWidget.routeName,
          path: ProductMoreDetailPageWidget.routePath,
          builder: (context, params) => ProductMoreDetailPageWidget(
            productID: params.getParam(
              'productID',
              ParamType.int,
            ),
          ),
        ),
        FFRoute(
          name: FilterProductPageWidget.routeName,
          path: FilterProductPageWidget.routePath,
          builder: (context, params) => FilterProductPageWidget(
            categories: params.getParam<dynamic>(
              'categories',
              ParamType.JSON,
              isList: true,
            ),
            collections: params.getParam<dynamic>(
              'collections',
              ParamType.JSON,
              isList: true,
            ),
            styles: params.getParam<dynamic>(
              'styles',
              ParamType.JSON,
              isList: true,
            ),
            colors: params.getParam<dynamic>(
              'colors',
              ParamType.JSON,
              isList: true,
            ),
            materials: params.getParam<dynamic>(
              'materials',
              ParamType.JSON,
              isList: true,
            ),
            types: params.getParam<dynamic>(
              'types',
              ParamType.JSON,
              isList: true,
            ),
            shapes: params.getParam<dynamic>(
              'shapes',
              ParamType.JSON,
              isList: true,
            ),
          ),
        ),
        FFRoute(
          name: CartPageWidget.routeName,
          path: CartPageWidget.routePath,
          builder: (context, params) => CartPageWidget(),
        ),
        FFRoute(
          name: AddAddressPageWidget.routeName,
          path: AddAddressPageWidget.routePath,
          builder: (context, params) => AddAddressPageWidget(
            isBilling: params.getParam(
              'isBilling',
              ParamType.bool,
            ),
            amount: params.getParam(
              'amount',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: ContactUsPageWidget.routeName,
          path: ContactUsPageWidget.routePath,
          builder: (context, params) => ContactUsPageWidget(),
        ),
        FFRoute(
          name: CreditCardPageWidget.routeName,
          path: CreditCardPageWidget.routePath,
          builder: (context, params) => CreditCardPageWidget(
            amount: params.getParam(
              'amount',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: NotificationPageWidget.routeName,
          path: NotificationPageWidget.routePath,
          builder: (context, params) => params.isEmpty
              ? NavBarPage(initialPage: 'NotificationPage')
              : NotificationPageWidget(),
        ),
        FFRoute(
          name: MorePageWidget.routeName,
          path: MorePageWidget.routePath,
          builder: (context, params) => params.isEmpty
              ? NavBarPage(initialPage: 'MorePage')
              : MorePageWidget(),
        ),
        FFRoute(
          name: ProfilePageWidget.routeName,
          path: ProfilePageWidget.routePath,
          builder: (context, params) => ProfilePageWidget(),
        ),
        FFRoute(
          name: SettingsPageWidget.routeName,
          path: SettingsPageWidget.routePath,
          builder: (context, params) => SettingsPageWidget(),
        ),
        FFRoute(
          name: ChangePasswordPageWidget.routeName,
          path: ChangePasswordPageWidget.routePath,
          builder: (context, params) => ChangePasswordPageWidget(),
        ),
        FFRoute(
          name: OrderDetailPageWidget.routeName,
          path: OrderDetailPageWidget.routePath,
          builder: (context, params) => OrderDetailPageWidget(
            id: params.getParam(
              'id',
              ParamType.int,
            ),
          ),
        ),
        FFRoute(
          name: FavProductsPageWidget.routeName,
          path: FavProductsPageWidget.routePath,
          builder: (context, params) => FavProductsPageWidget(),
        ),
        FFRoute(
          name: WebViewPageWidget.routeName,
          path: WebViewPageWidget.routePath,
          builder: (context, params) => WebViewPageWidget(
            urlToOpen: params.getParam(
              'urlToOpen',
              ParamType.String,
            ),
          ),
        )
      ].map((r) => r.toRoute(appStateNotifier)).toList(),
      observers: [routeObserver],
    );

extension NavParamExtensions on Map<String, String?> {
  Map<String, String> get withoutNulls => Map.fromEntries(
        entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
}

extension NavigationExtensions on BuildContext {
  void goNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : goNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void pushNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : pushNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void safePop() {
    // If there is only one route on the stack, navigate to the initial
    // page instead of popping.
    if (canPop()) {
      pop();
    } else {
      go('/');
    }
  }
}

extension GoRouterExtensions on GoRouter {
  AppStateNotifier get appState => AppStateNotifier.instance;
  void prepareAuthEvent([bool ignoreRedirect = false]) =>
      appState.hasRedirect() && !ignoreRedirect
          ? null
          : appState.updateNotifyOnAuthChange(false);
  bool shouldRedirect(bool ignoreRedirect) =>
      !ignoreRedirect && appState.hasRedirect();
  void clearRedirectLocation() => appState.clearRedirectLocation();
  void setRedirectLocationIfUnset(String location) =>
      appState.updateNotifyOnAuthChange(false);
}

extension _GoRouterStateExtensions on GoRouterState {
  Map<String, dynamic> get extraMap =>
      extra != null ? extra as Map<String, dynamic> : {};
  Map<String, dynamic> get allParams => <String, dynamic>{}
    ..addAll(pathParameters)
    ..addAll(uri.queryParameters)
    ..addAll(extraMap);
  TransitionInfo get transitionInfo => extraMap.containsKey(kTransitionInfoKey)
      ? extraMap[kTransitionInfoKey] as TransitionInfo
      : TransitionInfo.appDefault();
}

class FFParameters {
  FFParameters(this.state, [this.asyncParams = const {}]);

  final GoRouterState state;
  final Map<String, Future<dynamic> Function(String)> asyncParams;

  Map<String, dynamic> futureParamValues = {};

  // Parameters are empty if the params map is empty or if the only parameter
  // present is the special extra parameter reserved for the transition info.
  bool get isEmpty =>
      state.allParams.isEmpty ||
      (state.allParams.length == 1 &&
          state.extraMap.containsKey(kTransitionInfoKey));
  bool isAsyncParam(MapEntry<String, dynamic> param) =>
      asyncParams.containsKey(param.key) && param.value is String;
  bool get hasFutures => state.allParams.entries.any(isAsyncParam);
  Future<bool> completeFutures() => Future.wait(
        state.allParams.entries.where(isAsyncParam).map(
          (param) async {
            final doc = await asyncParams[param.key]!(param.value)
                .onError((_, __) => null);
            if (doc != null) {
              futureParamValues[param.key] = doc;
              return true;
            }
            return false;
          },
        ),
      ).onError((_, __) => [false]).then((v) => v.every((e) => e));

  dynamic getParam<T>(
    String paramName,
    ParamType type, {
    bool isList = false,
    StructBuilder<T>? structBuilder,
  }) {
    if (futureParamValues.containsKey(paramName)) {
      return futureParamValues[paramName];
    }
    if (!state.allParams.containsKey(paramName)) {
      return null;
    }
    final param = state.allParams[paramName];
    // Got parameter from `extras`, so just directly return it.
    if (param is! String) {
      return param;
    }
    // Return serialized value.
    return deserializeParam<T>(
      param,
      type,
      isList,
      structBuilder: structBuilder,
    );
  }
}

class FFRoute {
  const FFRoute({
    required this.name,
    required this.path,
    required this.builder,
    this.requireAuth = false,
    this.asyncParams = const {},
    this.routes = const [],
  });

  final String name;
  final String path;
  final bool requireAuth;
  final Map<String, Future<dynamic> Function(String)> asyncParams;
  final Widget Function(BuildContext, FFParameters) builder;
  final List<GoRoute> routes;

  GoRoute toRoute(AppStateNotifier appStateNotifier) => GoRoute(
        name: name,
        path: path,
        redirect: (context, state) {
          if (appStateNotifier.shouldRedirect) {
            final redirectLocation = appStateNotifier.getRedirectLocation();
            appStateNotifier.clearRedirectLocation();
            return redirectLocation;
          }

          if (requireAuth && !appStateNotifier.loggedIn) {
            appStateNotifier.setRedirectLocationIfUnset(state.uri.toString());
            return '/signInPage';
          }
          return null;
        },
        pageBuilder: (context, state) {
          fixStatusBarOniOS16AndBelow(context);
          final ffParams = FFParameters(state, asyncParams);
          final page = ffParams.hasFutures
              ? FutureBuilder(
                  future: ffParams.completeFutures(),
                  builder: (context, _) => builder(context, ffParams),
                )
              : builder(context, ffParams);
          final child = appStateNotifier.loading
              ? Container(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  child: Center(
                    child: Image.asset(
                      'assets/images/1.splash.png',
                      width: MediaQuery.sizeOf(context).width * 0.7,
                      fit: BoxFit.contain,
                    ),
                  ),
                )
              : page;

          final transitionInfo = state.transitionInfo;
          return transitionInfo.hasTransition
              ? CustomTransitionPage(
                  key: state.pageKey,
                  child: child,
                  transitionDuration: transitionInfo.duration,
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          PageTransition(
                    type: transitionInfo.transitionType,
                    duration: transitionInfo.duration,
                    reverseDuration: transitionInfo.duration,
                    alignment: transitionInfo.alignment,
                    child: child,
                  ).buildTransitions(
                    context,
                    animation,
                    secondaryAnimation,
                    child,
                  ),
                )
              : MaterialPage(key: state.pageKey, child: child);
        },
        routes: routes,
      );
}

class TransitionInfo {
  const TransitionInfo({
    required this.hasTransition,
    this.transitionType = PageTransitionType.fade,
    this.duration = const Duration(milliseconds: 300),
    this.alignment,
  });

  final bool hasTransition;
  final PageTransitionType transitionType;
  final Duration duration;
  final Alignment? alignment;

  static TransitionInfo appDefault() => TransitionInfo(hasTransition: false);
}

class RootPageContext {
  const RootPageContext(this.isRootPage, [this.errorRoute]);
  final bool isRootPage;
  final String? errorRoute;

  static bool isInactiveRootPage(BuildContext context) {
    final rootPageContext = context.read<RootPageContext?>();
    final isRootPage = rootPageContext?.isRootPage ?? false;
    final location = GoRouterState.of(context).uri.toString();
    return isRootPage &&
        location != '/' &&
        location != rootPageContext?.errorRoute;
  }

  static Widget wrap(Widget child, {String? errorRoute}) => Provider.value(
        value: RootPageContext(true, errorRoute),
        child: child,
      );
}

extension GoRouterLocationExtension on GoRouter {
  String getCurrentLocation() {
    final RouteMatch lastMatch = routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : routerDelegate.currentConfiguration;
    return matchList.uri.toString();
  }
}
