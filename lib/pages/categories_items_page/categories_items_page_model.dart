import '/backend/api_requests/api_calls.dart';
import '/components/filter_products_component_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/index.dart';
import 'categories_items_page_widget.dart' show CategoriesItemsPageWidget;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class CategoriesItemsPageModel
    extends FlutterFlowModel<CategoriesItemsPageWidget> {
  ///  Local state fields for this page.

  late LoggableList<dynamic> _products = LoggableList([]);
  set products(List<dynamic> value) {
    if (value != null) {
      _products = LoggableList(value);
    }

    debugLogWidgetClass(this);
  }

  List<dynamic> get products =>
      _products?..logger = () => debugLogWidgetClass(this);
  void addToProducts(dynamic item) => products.add(item);
  void removeFromProducts(dynamic item) => products.remove(item);
  void removeAtIndexFromProducts(int index) => products.removeAt(index);
  void insertAtIndexInProducts(int index, dynamic item) =>
      products.insert(index, item);
  void updateProductsAtIndex(int index, Function(dynamic) updateFn) =>
      products[index] = updateFn(products[index]);

  bool _isLoading = false;
  set isLoading(bool value) {
    _isLoading = value;
    debugLogWidgetClass(this);
  }

  bool get isLoading => _isLoading;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (products)] action in CategoriesItemsPage widget.
  ApiCallResponse? _productApiResult;
  set productApiResult(ApiCallResponse? value) {
    _productApiResult = value;
    debugLogWidgetClass(this);
  }

  ApiCallResponse? get productApiResult => _productApiResult;

  // State field(s) for searchF widget.
  FocusNode? searchFFocusNode;
  TextEditingController? searchFTextController;
  String? Function(BuildContext, String?)? searchFTextControllerValidator;
  // Stores action output result for [Backend Call - API (products)] action in searchF widget.
  ApiCallResponse? _productSearchResult;
  set productSearchResult(ApiCallResponse? value) {
    _productSearchResult = value;
    debugLogWidgetClass(this);
  }

  ApiCallResponse? get productSearchResult => _productSearchResult;

  // Stores action output result for [Backend Call - API (products)] action in searchF widget.
  ApiCallResponse? _productResults;
  set productResults(ApiCallResponse? value) {
    _productResults = value;
    debugLogWidgetClass(this);
  }

  ApiCallResponse? get productResults => _productResults;

  // Stores action output result for [Bottom Sheet - FilterProductsComponent] action in IconButton widget.
  dynamic? _filters;
  set filters(dynamic? value) {
    _filters = value;
    debugLogWidgetClass(this);
  }

  dynamic? get filters => _filters;

  // Stores action output result for [Backend Call - API (products)] action in IconButton widget.
  ApiCallResponse? _filteredApiResult;
  set filteredApiResult(ApiCallResponse? value) {
    _filteredApiResult = value;
    debugLogWidgetClass(this);
  }

  ApiCallResponse? get filteredApiResult => _filteredApiResult;

  final Map<String, DebugDataField> debugGeneratorVariables = {};
  final Map<String, DebugDataField> debugBackendQueries = {};
  final Map<String, FlutterFlowModel> widgetBuilderComponents = {};
  @override
  void initState(BuildContext context) {
    debugLogWidgetClass(this);
  }

  @override
  void dispose() {
    searchFFocusNode?.dispose();
    searchFTextController?.dispose();
  }

  @override
  WidgetClassDebugData toWidgetClassDebugData() => WidgetClassDebugData(
        widgetParameters: {
          'catID': debugSerializeParam(
            widget?.catID,
            ParamType.int,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=CategoriesItemsPage',
            searchReference:
                'reference=ShcKDwoFY2F0SUQSBndmZXE5b3IECAEgAVABWgVjYXRJRA==',
            name: 'int',
            nullable: true,
          ),
          'navTitle': debugSerializeParam(
            widget?.navTitle,
            ParamType.String,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=CategoriesItemsPage',
            searchReference:
                'reference=ShoKEgoIbmF2VGl0bGUSBjFqZGlyY3IECAMgAVABWghuYXZUaXRsZQ==',
            name: 'String',
            nullable: true,
          ),
          'filter': debugSerializeParam(
            widget?.filter,
            ParamType.JSON,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=CategoriesItemsPage',
            searchReference:
                'reference=ShgKEAoGZmlsdGVyEgZ2cTI2OG5yBAgJIABQAVoGZmlsdGVy',
            name: 'dynamic',
            nullable: true,
          )
        }.withoutNulls,
        localStates: {
          'products': debugSerializeParam(
            products,
            ParamType.JSON,
            isList: true,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=CategoriesItemsPage',
            searchReference:
                'reference=QhkKEQoIcHJvZHVjdHMSBTRtenM0cgQSAggJUAFaCHByb2R1Y3RzYhNDYXRlZ29yaWVzSXRlbXNQYWdl',
            name: 'dynamic',
            nullable: false,
          ),
          'isLoading': debugSerializeParam(
            isLoading,
            ParamType.bool,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=CategoriesItemsPage',
            searchReference:
                'reference=QiMKEgoJaXNMb2FkaW5nEgVwZ3ZtYioHEgVmYWxzZXIECAUgAVABWglpc0xvYWRpbmdiE0NhdGVnb3JpZXNJdGVtc1BhZ2U=',
            name: 'bool',
            nullable: false,
          )
        },
        widgetStates: {
          'searchFText': debugSerializeParam(
            searchFTextController?.text,
            ParamType.String,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=CategoriesItemsPage',
            name: 'String',
            nullable: true,
          )
        },
        actionOutputs: {
          'productApiResult': debugSerializeParam(
            productApiResult,
            ParamType.ApiResponse,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=CategoriesItemsPage',
            name: 'ApiCallResponse',
            nullable: true,
          ),
          'productSearchResult': debugSerializeParam(
            productSearchResult,
            ParamType.ApiResponse,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=CategoriesItemsPage',
            name: 'ApiCallResponse',
            nullable: true,
          ),
          'productResults': debugSerializeParam(
            productResults,
            ParamType.ApiResponse,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=CategoriesItemsPage',
            name: 'ApiCallResponse',
            nullable: true,
          ),
          'filters': debugSerializeParam(
            filters,
            ParamType.JSON,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=CategoriesItemsPage',
            name: 'dynamic',
            nullable: true,
          ),
          'filteredApiResult': debugSerializeParam(
            filteredApiResult,
            ParamType.ApiResponse,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=CategoriesItemsPage',
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
            'https://app.flutterflow.io/project/pasargad-82dm1q/tab=uiBuilder&page=CategoriesItemsPage',
        searchReference:
            'reference=OhNDYXRlZ29yaWVzSXRlbXNQYWdlUAFaE0NhdGVnb3JpZXNJdGVtc1BhZ2U=',
        widgetClassName: 'CategoriesItemsPage',
      );
}
