// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SliderStruct extends BaseStruct {
  SliderStruct({
    int? id,
    String? type,
    String? embedId,
    String? image,
  })  : _id = id,
        _type = type,
        _embedId = embedId,
        _image = image;

  // "id" field.
  int? _id;
  int get id => _id ?? 0;
  set id(int? val) {
    _id = val;
    debugLog();
  }

  void incrementId(int amount) => id = id + amount;

  bool hasId() => _id != null;

  // "type" field.
  String? _type;
  String get type => _type ?? '';
  set type(String? val) {
    _type = val;
    debugLog();
  }

  bool hasType() => _type != null;

  // "embed_id" field.
  String? _embedId;
  String get embedId => _embedId ?? '';
  set embedId(String? val) {
    _embedId = val;
    debugLog();
  }

  bool hasEmbedId() => _embedId != null;

  // "image" field.
  String? _image;
  String get image => _image ?? '';
  set image(String? val) {
    _image = val;
    debugLog();
  }

  bool hasImage() => _image != null;

  static SliderStruct fromMap(Map<String, dynamic> data) => SliderStruct(
        id: castToType<int>(data['id']),
        type: data['type'] as String?,
        embedId: data['embed_id'] as String?,
        image: data['image'] as String?,
      );

  static SliderStruct? maybeFromMap(dynamic data) =>
      data is Map ? SliderStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'type': _type,
        'embed_id': _embedId,
        'image': _image,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.int,
        ),
        'type': serializeParam(
          _type,
          ParamType.String,
        ),
        'embed_id': serializeParam(
          _embedId,
          ParamType.String,
        ),
        'image': serializeParam(
          _image,
          ParamType.String,
        ),
      }.withoutNulls;

  static SliderStruct fromSerializableMap(Map<String, dynamic> data) =>
      SliderStruct(
        id: deserializeParam(
          data['id'],
          ParamType.int,
          false,
        ),
        type: deserializeParam(
          data['type'],
          ParamType.String,
          false,
        ),
        embedId: deserializeParam(
          data['embed_id'],
          ParamType.String,
          false,
        ),
        image: deserializeParam(
          data['image'],
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
        'type': debugSerializeParam(
          type,
          ParamType.String,
          name: 'String',
          nullable: false,
        ),
        'embed_id': debugSerializeParam(
          embedId,
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
      };

  @override
  String toString() => 'SliderStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is SliderStruct &&
        id == other.id &&
        type == other.type &&
        embedId == other.embedId &&
        image == other.image;
  }

  @override
  int get hashCode => const ListEquality().hash([id, type, embedId, image]);
}

SliderStruct createSliderStruct({
  int? id,
  String? type,
  String? embedId,
  String? image,
}) =>
    SliderStruct(
      id: id,
      type: type,
      embedId: embedId,
      image: image,
    );
