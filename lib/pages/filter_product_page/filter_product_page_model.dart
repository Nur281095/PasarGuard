import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_radio_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import 'filter_product_page_widget.dart' show FilterProductPageWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class FilterProductPageModel extends FlutterFlowModel<FilterProductPageWidget> {
  ///  Local state fields for this page.

  late LoggableList<int> _cats = LoggableList([]);
  set cats(List<int> value) {
    if (value != null) {
      _cats = LoggableList(value);
    }

    debugLogWidgetClass(this);
  }

  List<int> get cats => _cats?..logger = () => debugLogWidgetClass(this);
  void addToCats(int item) => cats.add(item);
  void removeFromCats(int item) => cats.remove(item);
  void removeAtIndexFromCats(int index) => cats.removeAt(index);
  void insertAtIndexInCats(int index, int item) => cats.insert(index, item);
  void updateCatsAtIndex(int index, Function(int) updateFn) =>
      cats[index] = updateFn(cats[index]);

  ///  State fields for stateful widgets in this page.

  // State field(s) for RadioButton widget.
  FormFieldController<String>? radioButtonValueController1;
  // State field(s) for RadioButton widget.
  FormFieldController<String>? radioButtonValueController2;
  // State field(s) for RadioButton widget.
  FormFieldController<String>? radioButtonValueController3;
  // State field(s) for RadioButton widget.
  FormFieldController<String>? radioButtonValueController4;
  // State field(s) for RadioButton widget.
  FormFieldController<String>? radioButtonValueController5;

  final Map<String, DebugDataField> debugGeneratorVariables = {};
  final Map<String, DebugDataField> debugBackendQueries = {};
  final Map<String, FlutterFlowModel> widgetBuilderComponents = {};
  @override
  void initState(BuildContext context) {
    debugLogWidgetClass(this);
  }

  @override
  void dispose() {}

  /// Additional helper methods.
  String? get radioButtonValue1 => radioButtonValueController1?.value;
  String? get radioButtonValue2 => radioButtonValueController2?.value;
  String? get radioButtonValue3 => radioButtonValueController3?.value;
  String? get radioButtonValue4 => radioButtonValueController4?.value;
  String? get radioButtonValue5 => radioButtonValueController5?.value;
  @override
  WidgetClassDebugData toWidgetClassDebugData() => WidgetClassDebugData(
        widgetParameters: {
          'categories': debugSerializeParam(
            widget?.categories,
            ParamType.JSON,
            isList: true,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=FilterProductPage',
            searchReference:
                'reference=Sh4KFAoKY2F0ZWdvcmllcxIGajZnNmgxcgYSAggJIABQAVoKY2F0ZWdvcmllcw==',
            name: 'dynamic',
            nullable: true,
          ),
          'collections': debugSerializeParam(
            widget?.collections,
            ParamType.JSON,
            isList: true,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=FilterProductPage',
            searchReference:
                'reference=Sh8KFQoLY29sbGVjdGlvbnMSBjdsM3ZvYnIGEgIICSAAUAFaC2NvbGxlY3Rpb25z',
            name: 'dynamic',
            nullable: true,
          ),
          'styles': debugSerializeParam(
            widget?.styles,
            ParamType.JSON,
            isList: true,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=FilterProductPage',
            searchReference:
                'reference=ShoKEAoGc3R5bGVzEgZ5dTljdWdyBhICCAkgAFABWgZzdHlsZXM=',
            name: 'dynamic',
            nullable: true,
          ),
          'colors': debugSerializeParam(
            widget?.colors,
            ParamType.JSON,
            isList: true,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=FilterProductPage',
            searchReference:
                'reference=ShoKEAoGY29sb3JzEgZndXIyaHpyBhICCAkgAFABWgZjb2xvcnM=',
            name: 'dynamic',
            nullable: true,
          ),
          'materials': debugSerializeParam(
            widget?.materials,
            ParamType.JSON,
            isList: true,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=FilterProductPage',
            searchReference:
                'reference=Sh0KEwoJbWF0ZXJpYWxzEgZrdGdwd2lyBhICCAkgAFABWgltYXRlcmlhbHM=',
            name: 'dynamic',
            nullable: true,
          ),
          'types': debugSerializeParam(
            widget?.types,
            ParamType.JSON,
            isList: true,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=FilterProductPage',
            searchReference:
                'reference=ShkKDwoFdHlwZXMSBmh4ZGFiOXIGEgIICSAAUAFaBXR5cGVz',
            name: 'dynamic',
            nullable: true,
          ),
          'shapes': debugSerializeParam(
            widget?.shapes,
            ParamType.JSON,
            isList: true,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=FilterProductPage',
            searchReference:
                'reference=ShoKEAoGc2hhcGVzEgYzOGkyeTNyBhICCAkgAFABWgZzaGFwZXM=',
            name: 'dynamic',
            nullable: true,
          )
        }.withoutNulls,
        localStates: {
          'cats': debugSerializeParam(
            cats,
            ParamType.int,
            isList: true,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=FilterProductPage',
            searchReference:
                'reference=QhcKDQoEY2F0cxIFZmZqOGhyBhICCAEgAVABWgRjYXRzYhFGaWx0ZXJQcm9kdWN0UGFnZQ==',
            name: 'int',
            nullable: false,
          )
        },
        widgetStates: {
          'radioButtonValue1': debugSerializeParam(
            radioButtonValue1,
            ParamType.String,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=FilterProductPage',
            name: 'String',
            nullable: true,
          ),
          'radioButtonValue2': debugSerializeParam(
            radioButtonValue2,
            ParamType.String,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=FilterProductPage',
            name: 'String',
            nullable: true,
          ),
          'radioButtonValue3': debugSerializeParam(
            radioButtonValue3,
            ParamType.String,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=FilterProductPage',
            name: 'String',
            nullable: true,
          ),
          'radioButtonValue4': debugSerializeParam(
            radioButtonValue4,
            ParamType.String,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=FilterProductPage',
            name: 'String',
            nullable: true,
          ),
          'radioButtonValue5': debugSerializeParam(
            radioButtonValue5,
            ParamType.String,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=FilterProductPage',
            name: 'String',
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
            'https://app.flutterflow.io/project/pasargad-82dm1q/tab=uiBuilder&page=FilterProductPage',
        searchReference:
            'reference=OhFGaWx0ZXJQcm9kdWN0UGFnZVABWhFGaWx0ZXJQcm9kdWN0UGFnZQ==',
        widgetClassName: 'FilterProductPage',
      );
}
