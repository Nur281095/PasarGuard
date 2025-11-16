import 'package:flutter/material.dart';
import '/backend/schema/structs/index.dart';
import '/backend/api_requests/api_manager.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:csv/csv.dart';
import 'package:synchronized/synchronized.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    secureStorage = FlutterSecureStorage();
    await _safeInitAsync(() async {
      if (await secureStorage.read(key: 'ff_user') != null) {
        try {
          final serializedData =
              await secureStorage.getString('ff_user') ?? '{}';
          _user = UserStruct.fromSerializableMap(jsonDecode(serializedData));
        } catch (e) {
          print("Can't decode persisted data type. Error: $e.");
        }
      }
    });
    await _safeInitAsync(() async {
      _token = await secureStorage.getString('ff_token') ?? _token;
    });
    await _safeInitAsync(() async {
      _cartId = await secureStorage.getString('ff_cartId') ?? _cartId;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late FlutterSecureStorage secureStorage;

  UserStruct _user = UserStruct.fromSerializableMap(jsonDecode('{}'));
  UserStruct get user => _user?..logger = () => debugLogAppState(this);
  set user(UserStruct value) {
    _user = value;
    secureStorage.setString('ff_user', value.serialize());
    debugLogAppState(this);
  }

  void deleteUser() {
    secureStorage.delete(key: 'ff_user');
  }

  void updateUserStruct(Function(UserStruct) updateFn) {
    updateFn(_user);
    secureStorage.setString('ff_user', _user.serialize());
    debugLogAppState(this);
  }

  String _token = '';
  String get token => _token;
  set token(String value) {
    _token = value;
    secureStorage.setString('ff_token', value);
    debugLogAppState(this);
  }

  void deleteToken() {
    secureStorage.delete(key: 'ff_token');
  }

  String _cartId = '';
  String get cartId => _cartId;
  set cartId(String value) {
    _cartId = value;
    secureStorage.setString('ff_cartId', value);
    debugLogAppState(this);
  }

  void deleteCartId() {
    secureStorage.delete(key: 'ff_cartId');
  }

  Map<String, DebugDataField> toDebugSerializableMap() => {
        'user': debugSerializeParam(
          user,
          ParamType.DataStruct,
          link:
              'https://app.flutterflow.io/project/pasargad-82dm1q?tab=appValues&appValuesTab=state',
          searchReference:
              'reference=CikKEAoEdXNlchIIczM4bnI3MmtyEwgUKg8SDQoEVXNlchIFMGY1azl6AFoEdXNlcg==',
          name: 'User',
          nullable: false,
        ),
        'token': debugSerializeParam(
          token,
          ParamType.String,
          link:
              'https://app.flutterflow.io/project/pasargad-82dm1q?tab=appValues&appValuesTab=state',
          searchReference:
              'reference=ChkKEQoFdG9rZW4SCHpkcXIzaXl3cgIIA3oAWgV0b2tlbg==',
          name: 'String',
          nullable: false,
        ),
        'cartId': debugSerializeParam(
          cartId,
          ParamType.String,
          link:
              'https://app.flutterflow.io/project/pasargad-82dm1q?tab=appValues&appValuesTab=state',
          searchReference:
              'reference=ChoKEgoGY2FydElkEghrbTdtbDVjdXICCAN6AFoGY2FydElk',
          name: 'String',
          nullable: false,
        )
      };
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}

extension FlutterSecureStorageExtensions on FlutterSecureStorage {
  static final _lock = Lock();

  Future<void> writeSync({required String key, String? value}) async =>
      await _lock.synchronized(() async {
        await write(key: key, value: value);
      });

  void remove(String key) => delete(key: key);

  Future<String?> getString(String key) async => await read(key: key);
  Future<void> setString(String key, String value) async =>
      await writeSync(key: key, value: value);

  Future<bool?> getBool(String key) async => (await read(key: key)) == 'true';
  Future<void> setBool(String key, bool value) async =>
      await writeSync(key: key, value: value.toString());

  Future<int?> getInt(String key) async =>
      int.tryParse(await read(key: key) ?? '');
  Future<void> setInt(String key, int value) async =>
      await writeSync(key: key, value: value.toString());

  Future<double?> getDouble(String key) async =>
      double.tryParse(await read(key: key) ?? '');
  Future<void> setDouble(String key, double value) async =>
      await writeSync(key: key, value: value.toString());

  Future<List<String>?> getStringList(String key) async =>
      await read(key: key).then((result) {
        if (result == null || result.isEmpty) {
          return null;
        }
        return CsvToListConverter()
            .convert(result)
            .first
            .map((e) => e.toString())
            .toList();
      });
  Future<void> setStringList(String key, List<String> value) async =>
      await writeSync(key: key, value: ListToCsvConverter().convert([value]));
}
