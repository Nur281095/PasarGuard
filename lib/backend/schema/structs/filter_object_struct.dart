// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class FilterObjectStruct extends BaseStruct {
  FilterObjectStruct({
    int? id,
    String? name,
    String? image,
    String? hexCode,
    String? category,
  })  : _id = id,
        _name = name,
        _image = image,
        _hexCode = hexCode,
        _category = category;

  // "id" field.
  int? _id;
  int get id => _id ?? 0;
  set id(int? val) {
    _id = val;
    debugLog();
  }

  void incrementId(int amount) => id = id + amount;

  bool hasId() => _id != null;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) {
    _name = val;
    debugLog();
  }

  bool hasName() => _name != null;

  // "image" field.
  String? _image;
  String get image => _image ?? '';
  set image(String? val) {
    _image = val;
    debugLog();
  }

  bool hasImage() => _image != null;

  // "hex_code" field.
  String? _hexCode;
  String get hexCode => _hexCode ?? '';
  set hexCode(String? val) {
    _hexCode = val;
    debugLog();
  }

  bool hasHexCode() => _hexCode != null;

  // "category" field.
  String? _category;
  String get category => _category ?? '';
  set category(String? val) {
    _category = val;
    debugLog();
  }

  bool hasCategory() => _category != null;

  static FilterObjectStruct fromMap(Map<String, dynamic> data) =>
      FilterObjectStruct(
        id: castToType<int>(data['id']),
        name: data['name'] as String?,
        image: data['image'] as String?,
        hexCode: data['hex_code'] as String?,
        category: data['category'] as String?,
      );

  static FilterObjectStruct? maybeFromMap(dynamic data) => data is Map
      ? FilterObjectStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'name': _name,
        'image': _image,
        'hex_code': _hexCode,
        'category': _category,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.int,
        ),
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'image': serializeParam(
          _image,
          ParamType.String,
        ),
        'hex_code': serializeParam(
          _hexCode,
          ParamType.String,
        ),
        'category': serializeParam(
          _category,
          ParamType.String,
        ),
      }.withoutNulls;

  static FilterObjectStruct fromSerializableMap(Map<String, dynamic> data) =>
      FilterObjectStruct(
        id: deserializeParam(
          data['id'],
          ParamType.int,
          false,
        ),
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        image: deserializeParam(
          data['image'],
          ParamType.String,
          false,
        ),
        hexCode: deserializeParam(
          data['hex_code'],
          ParamType.String,
          false,
        ),
        category: deserializeParam(
          data['category'],
          ParamType.String,
          false,
        ),
      );
  @override
  Map<String, DebugDataField> toDebugSerializableMap() => {
        'id': debugSerializeParam(
          id,
          ParamType.int,
          name: 'int',
          nullable: false,
        ),
        'name': debugSerializeParam(
          name,
          ParamType.String,
          name: 'String',
          nullable: false,
        ),
        'image': debugSerializeParam(
          image,
          ParamType.String,
          name: 'String',
          nullable: false,
        ),
        'hex_code': debugSerializeParam(
          hexCode,
          ParamType.String,
          name: 'String',
          nullable: false,
        ),
        'category': debugSerializeParam(
          category,
          ParamType.String,
          name: 'String',
          nullable: false,
        ),
      };

  @override
  String toString() => 'FilterObjectStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is FilterObjectStruct &&
        id == other.id &&
        name == other.name &&
        image == other.image &&
        hexCode == other.hexCode &&
        category == other.category;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([id, name, image, hexCode, category]);
}

FilterObjectStruct createFilterObjectStruct({
  int? id,
  String? name,
  String? image,
  String? hexCode,
  String? category,
}) =>
    FilterObjectStruct(
      id: id,
      name: name,
      image: image,
      hexCode: hexCode,
      category: category,
    );
