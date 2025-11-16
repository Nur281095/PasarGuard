import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_radio_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import 'filter_products_component_widget.dart'
    show FilterProductsComponentWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class FilterProductsComponentModel
    extends FlutterFlowModel<FilterProductsComponentWidget> {
  ///  Local state fields for this component.

  int? _cat;
  set cat(int? value) {
    _cat = value;
    debugLogWidgetClass(this);
  }

  int? get cat => _cat;

  int? _collection;
  set collection(int? value) {
    _collection = value;
    debugLogWidgetClass(this);
  }

  int? get collection => _collection;

  int? _style;
  set style(int? value) {
    _style = value;
    debugLogWidgetClass(this);
  }

  int? get style => _style;

  int? _material;
  set material(int? value) {
    _material = value;
    debugLogWidgetClass(this);
  }

  int? get material => _material;

  int? _weave;
  set weave(int? value) {
    _weave = value;
    debugLogWidgetClass(this);
  }

  int? get weave => _weave;

  int? _type;
  set type(int? value) {
    _type = value;
    debugLogWidgetClass(this);
  }

  int? get type => _type;

  ///  State fields for stateful widgets in this component.

  // State field(s) for CatRadioButton widget.
  FormFieldController<String>? catRadioButtonValueController;
  // Stores action output result for [Custom Action - findIDofJson] action in CatRadioButton widget.
  int? _catId;
  set catId(int? value) {
    _catId = value;
    debugLogWidgetClass(this);
  }

  int? get catId => _catId;

  // State field(s) for ColRadioButton widget.
  FormFieldController<String>? colRadioButtonValueController;
  // Stores action output result for [Custom Action - findIDofJson] action in ColRadioButton widget.
  int? _colId;
  set colId(int? value) {
    _colId = value;
    debugLogWidgetClass(this);
  }

  int? get colId => _colId;

  // State field(s) for StyleRadioButton widget.
  FormFieldController<String>? styleRadioButtonValueController;
  // Stores action output result for [Custom Action - findIDofJson] action in StyleRadioButton widget.
  int? _styleId;
  set styleId(int? value) {
    _styleId = value;
    debugLogWidgetClass(this);
  }

  int? get styleId => _styleId;

  // State field(s) for MtRadioButton widget.
  FormFieldController<String>? mtRadioButtonValueController;
  // Stores action output result for [Custom Action - findIDofJson] action in MtRadioButton widget.
  int? _matId;
  set matId(int? value) {
    _matId = value;
    debugLogWidgetClass(this);
  }

  int? get matId => _matId;

  // State field(s) for WevRadioButton widget.
  FormFieldController<String>? wevRadioButtonValueController;
  // Stores action output result for [Custom Action - findIDofJson] action in WevRadioButton widget.
  int? _weveId;
  set weveId(int? value) {
    _weveId = value;
    debugLogWidgetClass(this);
  }

  int? get weveId => _weveId;

  // State field(s) for TypeRadioButton widget.
  FormFieldController<String>? typeRadioButtonValueController;
  // Stores action output result for [Custom Action - findIDofJson] action in TypeRadioButton widget.
  int? _typeId;
  set typeId(int? value) {
    _typeId = value;
    debugLogWidgetClass(this);
  }

  int? get typeId => _typeId;

  final Map<String, DebugDataField> debugGeneratorVariables = {};
  final Map<String, DebugDataField> debugBackendQueries = {};
  final Map<String, FlutterFlowModel> widgetBuilderComponents = {};
  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}

  /// Additional helper methods.
  String? get catRadioButtonValue => catRadioButtonValueController?.value;
  String? get colRadioButtonValue => colRadioButtonValueController?.value;
  String? get styleRadioButtonValue => styleRadioButtonValueController?.value;
  String? get mtRadioButtonValue => mtRadioButtonValueController?.value;
  String? get wevRadioButtonValue => wevRadioButtonValueController?.value;
  String? get typeRadioButtonValue => typeRadioButtonValueController?.value;
  @override
  WidgetClassDebugData toWidgetClassDebugData() => WidgetClassDebugData(
        widgetParameters: {
          'categories': debugSerializeParam(
            widget?.categories,
            ParamType.JSON,
            isList: true,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=FilterProductsComponent',
            searchReference:
                'reference=Sh4KFAoKY2F0ZWdvcmllcxIGamUyMXd5cgYSAggJIAFQAFoKY2F0ZWdvcmllcw==',
            name: 'dynamic',
            nullable: true,
          ),
          'collections': debugSerializeParam(
            widget?.collections,
            ParamType.JSON,
            isList: true,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=FilterProductsComponent',
            searchReference:
                'reference=Sh8KFQoLY29sbGVjdGlvbnMSBnZ0bThwaXIGEgIICSABUABaC2NvbGxlY3Rpb25z',
            name: 'dynamic',
            nullable: true,
          ),
          'styles': debugSerializeParam(
            widget?.styles,
            ParamType.JSON,
            isList: true,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=FilterProductsComponent',
            searchReference:
                'reference=ShoKEAoGc3R5bGVzEgZoeWhobXFyBhICCAkgAVAAWgZzdHlsZXM=',
            name: 'dynamic',
            nullable: true,
          ),
          'materials': debugSerializeParam(
            widget?.materials,
            ParamType.JSON,
            isList: true,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=FilterProductsComponent',
            searchReference:
                'reference=Sh0KEwoJbWF0ZXJpYWxzEgYwbXo0dHNyBhICCAkgAVAAWgltYXRlcmlhbHM=',
            name: 'dynamic',
            nullable: true,
          ),
          'types': debugSerializeParam(
            widget?.types,
            ParamType.JSON,
            isList: true,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=FilterProductsComponent',
            searchReference:
                'reference=ShkKDwoFdHlwZXMSBjhtY3hzaHIGEgIICSABUABaBXR5cGVz',
            name: 'dynamic',
            nullable: true,
          ),
          'weaves': debugSerializeParam(
            widget?.weaves,
            ParamType.JSON,
            isList: true,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=FilterProductsComponent',
            searchReference:
                'reference=ShoKEAoGd2VhdmVzEgZ1cXlrcHFyBhICCAkgAVAAWgZ3ZWF2ZXM=',
            name: 'dynamic',
            nullable: true,
          )
        }.withoutNulls,
        localStates: {
          'cat': debugSerializeParam(
            cat,
            ParamType.int,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=FilterProductsComponent',
            searchReference:
                'reference=QhIKDAoDY2F0EgV5ZGl3M3ICCAFQAFoDY2F0YhdGaWx0ZXJQcm9kdWN0c0NvbXBvbmVudA==',
            name: 'int',
            nullable: true,
          ),
          'collection': debugSerializeParam(
            collection,
            ParamType.int,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=FilterProductsComponent',
            searchReference:
                'reference=QhkKEwoKY29sbGVjdGlvbhIFMzVpemRyAggBUABaCmNvbGxlY3Rpb25iF0ZpbHRlclByb2R1Y3RzQ29tcG9uZW50',
            name: 'int',
            nullable: true,
          ),
          'style': debugSerializeParam(
            style,
            ParamType.int,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=FilterProductsComponent',
            searchReference:
                'reference=QhQKDgoFc3R5bGUSBW5naDBmcgIIAVAAWgVzdHlsZWIXRmlsdGVyUHJvZHVjdHNDb21wb25lbnQ=',
            name: 'int',
            nullable: true,
          ),
          'material': debugSerializeParam(
            material,
            ParamType.int,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=FilterProductsComponent',
            searchReference:
                'reference=QhcKEQoIbWF0ZXJpYWwSBTJqcmxvcgIIAVAAWghtYXRlcmlhbGIXRmlsdGVyUHJvZHVjdHNDb21wb25lbnQ=',
            name: 'int',
            nullable: true,
          ),
          'weave': debugSerializeParam(
            weave,
            ParamType.int,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=FilterProductsComponent',
            searchReference:
                'reference=QhQKDgoFd2VhdmUSBWEwNGcxcgIIAVAAWgV3ZWF2ZWIXRmlsdGVyUHJvZHVjdHNDb21wb25lbnQ=',
            name: 'int',
            nullable: true,
          ),
          'type': debugSerializeParam(
            type,
            ParamType.int,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=FilterProductsComponent',
            searchReference:
                'reference=QhMKDQoEdHlwZRIFcDk3bTJyAggBUABaBHR5cGViF0ZpbHRlclByb2R1Y3RzQ29tcG9uZW50',
            name: 'int',
            nullable: true,
          )
        },
        widgetStates: {
          'catRadioButtonValue': debugSerializeParam(
            catRadioButtonValue,
            ParamType.String,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=FilterProductsComponent',
            name: 'String',
            nullable: true,
          ),
          'colRadioButtonValue': debugSerializeParam(
            colRadioButtonValue,
            ParamType.String,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=FilterProductsComponent',
            name: 'String',
            nullable: true,
          ),
          'styleRadioButtonValue': debugSerializeParam(
            styleRadioButtonValue,
            ParamType.String,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=FilterProductsComponent',
            name: 'String',
            nullable: true,
          ),
          'mtRadioButtonValue': debugSerializeParam(
            mtRadioButtonValue,
            ParamType.String,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=FilterProductsComponent',
            name: 'String',
            nullable: true,
          ),
          'wevRadioButtonValue': debugSerializeParam(
            wevRadioButtonValue,
            ParamType.String,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=FilterProductsComponent',
            name: 'String',
            nullable: true,
          ),
          'typeRadioButtonValue': debugSerializeParam(
            typeRadioButtonValue,
            ParamType.String,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=FilterProductsComponent',
            name: 'String',
            nullable: true,
          )
        },
        actionOutputs: {
          'catId': debugSerializeParam(
            catId,
            ParamType.int,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=FilterProductsComponent',
            name: 'int',
            nullable: true,
          ),
          'colId': debugSerializeParam(
            colId,
            ParamType.int,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=FilterProductsComponent',
            name: 'int',
            nullable: true,
          ),
          'styleId': debugSerializeParam(
            styleId,
            ParamType.int,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=FilterProductsComponent',
            name: 'int',
            nullable: true,
          ),
          'matId': debugSerializeParam(
            matId,
            ParamType.int,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=FilterProductsComponent',
            name: 'int',
            nullable: true,
          ),
          'weveId': debugSerializeParam(
            weveId,
            ParamType.int,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=FilterProductsComponent',
            name: 'int',
            nullable: true,
          ),
          'typeId': debugSerializeParam(
            typeId,
            ParamType.int,
            link:
                'https://app.flutterflow.io/project/pasargad-82dm1q?tab=uiBuilder&page=FilterProductsComponent',
            name: 'int',
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
            'https://app.flutterflow.io/project/pasargad-82dm1q/tab=uiBuilder&page=FilterProductsComponent',
        searchReference:
            'reference=OhdGaWx0ZXJQcm9kdWN0c0NvbXBvbmVudFAAWhdGaWx0ZXJQcm9kdWN0c0NvbXBvbmVudA==',
        widgetClassName: 'FilterProductsComponent',
      );
}
