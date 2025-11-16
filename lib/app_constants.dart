import 'package:flutter/material.dart';
import 'flutter_flow/flutter_flow_util.dart';

abstract class FFAppConstants {

  //==========SANDBOX===============
  // static const String SquareAccessToken =
  //     'EAAAl1VQ_t0YB3GiTi70FthgjHE2c4VYJqvZJkRtt3_lE_6e2nxDf8IhfZKQkAjO';
  // static const String SquareAppID = 'sandbox-sq0idb-kImYDmSyTf6Vr5T3XAZr3w';

  //==========PROD===============
  static const String SquareAccessToken =
      'EAAAlzWZzd_IAhWXQ95__mD1xSl3_4KjbRupnpBe2z8KOew0WhEziLfS54s7-2If';
  static const String SquareAppID = 'sq0idp-mO-6zxcVUKmgBsIpA6JqbA';
  static Map<String, DebugDataField> toDebugSerializableMap() => {
    'SquareAccessToken': debugSerializeParam(
      SquareAccessToken,
      ParamType.String,
      link:
      'https://app.flutterflow.io/project/pasargad-82dm1q?tab=appValues&appValuesTab=constant',
      searchReference:
      'reference=EiMKGwoRU3F1YXJlQWNjZXNzVG9rZW4SBnBtbWoyNnICCAN6AFoRU3F1YXJlQWNjZXNzVG9rZW4=',
      name: 'String',
      nullable: false,
    ),
    'SquareAppID': debugSerializeParam(
      SquareAppID,
      ParamType.String,
      link:
      'https://app.flutterflow.io/project/pasargad-82dm1q?tab=appValues&appValuesTab=constant',
      searchReference:
      'reference=Eh0KFQoLU3F1YXJlQXBwSUQSBjd3OXk5N3ICCAN6AFoLU3F1YXJlQXBwSUQ=',
      name: 'String',
      nullable: false,
    )
  };
}

