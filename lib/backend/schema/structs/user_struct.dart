// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UserStruct extends BaseStruct {
  UserStruct({
    int? id,
    String? firstName,
    String? lastName,
    String? email,
    int? status,
    String? fullName,
    String? cartId,
  })  : _id = id,
        _firstName = firstName,
        _lastName = lastName,
        _email = email,
        _status = status,
        _fullName = fullName,
        _cartId = cartId;

  // "id" field.
  int? _id;
  int get id => _id ?? 0;
  set id(int? val) {
    _id = val;
    debugLog();
  }

  void incrementId(int amount) => id = id + amount;

  bool hasId() => _id != null;

  // "first_name" field.
  String? _firstName;
  String get firstName => _firstName ?? '';
  set firstName(String? val) {
    _firstName = val;
    debugLog();
  }

  bool hasFirstName() => _firstName != null;

  // "last_name" field.
  String? _lastName;
  String get lastName => _lastName ?? '';
  set lastName(String? val) {
    _lastName = val;
    debugLog();
  }

  bool hasLastName() => _lastName != null;

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  set email(String? val) {
    _email = val;
    debugLog();
  }

  bool hasEmail() => _email != null;

  // "status" field.
  int? _status;
  int get status => _status ?? 0;
  set status(int? val) {
    _status = val;
    debugLog();
  }

  void incrementStatus(int amount) => status = status + amount;

  bool hasStatus() => _status != null;

  // "full_name" field.
  String? _fullName;
  String get fullName => _fullName ?? '';
  set fullName(String? val) {
    _fullName = val;
    debugLog();
  }

  bool hasFullName() => _fullName != null;

  // "cart_id" field.
  String? _cartId;
  String get cartId => _cartId ?? '';
  set cartId(String? val) {
    _cartId = val;
    debugLog();
  }

  bool hasCartId() => _cartId != null;

  static UserStruct fromMap(Map<String, dynamic> data) => UserStruct(
        id: castToType<int>(data['id']),
        firstName: data['first_name'] as String?,
        lastName: data['last_name'] as String?,
        email: data['email'] as String?,
        status: castToType<int>(data['status']),
        fullName: data['full_name'] as String?,
        cartId: data['cart_id'] as String?,
      );

  static UserStruct? maybeFromMap(dynamic data) =>
      data is Map ? UserStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'first_name': _firstName,
        'last_name': _lastName,
        'email': _email,
        'status': _status,
        'full_name': _fullName,
        'cart_id': _cartId,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.int,
        ),
        'first_name': serializeParam(
          _firstName,
          ParamType.String,
        ),
        'last_name': serializeParam(
          _lastName,
          ParamType.String,
        ),
        'email': serializeParam(
          _email,
          ParamType.String,
        ),
        'status': serializeParam(
          _status,
          ParamType.int,
        ),
        'full_name': serializeParam(
          _fullName,
          ParamType.String,
        ),
        'cart_id': serializeParam(
          _cartId,
          ParamType.String,
        ),
      }.withoutNulls;

  static UserStruct fromSerializableMap(Map<String, dynamic> data) =>
      UserStruct(
        id: deserializeParam(
          data['id'],
          ParamType.int,
          false,
        ),
        firstName: deserializeParam(
          data['first_name'],
          ParamType.String,
          false,
        ),
        lastName: deserializeParam(
          data['last_name'],
          ParamType.String,
          false,
        ),
        email: deserializeParam(
          data['email'],
          ParamType.String,
          false,
        ),
        status: deserializeParam(
          data['status'],
          ParamType.int,
          false,
        ),
        fullName: deserializeParam(
          data['full_name'],
          ParamType.String,
          false,
        ),
        cartId: deserializeParam(
          data['cart_id'],
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
        'first_name': debugSerializeParam(
          firstName,
          ParamType.String,
          name: 'String',
          nullable: false,
        ),
        'last_name': debugSerializeParam(
          lastName,
          ParamType.String,
          name: 'String',
          nullable: false,
        ),
        'email': debugSerializeParam(
          email,
          ParamType.String,
          name: 'String',
          nullable: false,
        ),
        'status': debugSerializeParam(
          status,
          ParamType.int,
          name: 'int',
          nullable: false,
        ),
        'full_name': debugSerializeParam(
          fullName,
          ParamType.String,
          name: 'String',
          nullable: false,
        ),
        'cart_id': debugSerializeParam(
          cartId,
          ParamType.String,
          name: 'String',
          nullable: false,
        ),
      };

  @override
  String toString() => 'UserStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is UserStruct &&
        id == other.id &&
        firstName == other.firstName &&
        lastName == other.lastName &&
        email == other.email &&
        status == other.status &&
        fullName == other.fullName &&
        cartId == other.cartId;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([id, firstName, lastName, email, status, fullName, cartId]);
}

UserStruct createUserStruct({
  int? id,
  String? firstName,
  String? lastName,
  String? email,
  int? status,
  String? fullName,
  String? cartId,
}) =>
    UserStruct(
      id: id,
      firstName: firstName,
      lastName: lastName,
      email: email,
      status: status,
      fullName: fullName,
      cartId: cartId,
    );
