// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ProductStruct extends BaseStruct {
  ProductStruct({
    int? id,
    String? name,
    String? type,
    String? detail,
    String? brand,
    String? shape,
    int? categoryId,
    String? category,
    int? subcategoryId,
    String? sku,
    int? isSoldOut,
    String? price,
    int? salePrice,
    List<String>? images,
  })  : _id = id,
        _name = name,
        _type = type,
        _detail = detail,
        _brand = brand,
        _shape = shape,
        _categoryId = categoryId,
        _category = category,
        _subcategoryId = subcategoryId,
        _sku = sku,
        _isSoldOut = isSoldOut,
        _price = price,
        _salePrice = salePrice,
        _images = images != null ? LoggableList(images) : null;

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

  // "type" field.
  String? _type;
  String get type => _type ?? '';
  set type(String? val) {
    _type = val;
    debugLog();
  }

  bool hasType() => _type != null;

  // "detail" field.
  String? _detail;
  String get detail => _detail ?? '';
  set detail(String? val) {
    _detail = val;
    debugLog();
  }

  bool hasDetail() => _detail != null;

  // "brand" field.
  String? _brand;
  String get brand => _brand ?? '';
  set brand(String? val) {
    _brand = val;
    debugLog();
  }

  bool hasBrand() => _brand != null;

  // "shape" field.
  String? _shape;
  String get shape => _shape ?? '';
  set shape(String? val) {
    _shape = val;
    debugLog();
  }

  bool hasShape() => _shape != null;

  // "category_id" field.
  int? _categoryId;
  int get categoryId => _categoryId ?? 0;
  set categoryId(int? val) {
    _categoryId = val;
    debugLog();
  }

  void incrementCategoryId(int amount) => categoryId = categoryId + amount;

  bool hasCategoryId() => _categoryId != null;

  // "category" field.
  String? _category;
  String get category => _category ?? '';
  set category(String? val) {
    _category = val;
    debugLog();
  }

  bool hasCategory() => _category != null;

  // "subcategory_id" field.
  int? _subcategoryId;
  int get subcategoryId => _subcategoryId ?? 0;
  set subcategoryId(int? val) {
    _subcategoryId = val;
    debugLog();
  }

  void incrementSubcategoryId(int amount) =>
      subcategoryId = subcategoryId + amount;

  bool hasSubcategoryId() => _subcategoryId != null;

  // "sku" field.
  String? _sku;
  String get sku => _sku ?? '';
  set sku(String? val) {
    _sku = val;
    debugLog();
  }

  bool hasSku() => _sku != null;

  // "is_sold_out" field.
  int? _isSoldOut;
  int get isSoldOut => _isSoldOut ?? 0;
  set isSoldOut(int? val) {
    _isSoldOut = val;
    debugLog();
  }

  void incrementIsSoldOut(int amount) => isSoldOut = isSoldOut + amount;

  bool hasIsSoldOut() => _isSoldOut != null;

  // "price" field.
  String? _price;
  String get price => _price ?? '';
  set price(String? val) {
    _price = val;
    debugLog();
  }

  bool hasPrice() => _price != null;

  // "sale_price" field.
  int? _salePrice;
  int get salePrice => _salePrice ?? 0;
  set salePrice(int? val) {
    _salePrice = val;
    debugLog();
  }

  void incrementSalePrice(int amount) => salePrice = salePrice + amount;

  bool hasSalePrice() => _salePrice != null;

  // "images" field.
  LoggableList<String>? _images;
  List<String> get images =>
      (_images ?? LoggableList(const []))..logger = logger;
  set images(List<String>? val) {
    if (val != null) {
      _images = LoggableList(val);
    } else {
      _images = null;
    }
    debugLog();
  }

  void updateImages(Function(List<String>) updateFn) {
    updateFn(_images ??= LoggableList([]));
    debugLog();
  }

  bool hasImages() => _images != null;

  static ProductStruct fromMap(Map<String, dynamic> data) => ProductStruct(
        id: castToType<int>(data['id']),
        name: data['name'] as String?,
        type: data['type'] as String?,
        detail: data['detail'] as String?,
        brand: data['brand'] as String?,
        shape: data['shape'] as String?,
        categoryId: castToType<int>(data['category_id']),
        category: data['category'] as String?,
        subcategoryId: castToType<int>(data['subcategory_id']),
        sku: data['sku'] as String?,
        isSoldOut: castToType<int>(data['is_sold_out']),
        price: data['price'] as String?,
        salePrice: castToType<int>(data['sale_price']),
        images: getDataList(data['images']),
      );

  static ProductStruct? maybeFromMap(dynamic data) =>
      data is Map ? ProductStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'name': _name,
        'type': _type,
        'detail': _detail,
        'brand': _brand,
        'shape': _shape,
        'category_id': _categoryId,
        'category': _category,
        'subcategory_id': _subcategoryId,
        'sku': _sku,
        'is_sold_out': _isSoldOut,
        'price': _price,
        'sale_price': _salePrice,
        'images': _images,
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
        'type': serializeParam(
          _type,
          ParamType.String,
        ),
        'detail': serializeParam(
          _detail,
          ParamType.String,
        ),
        'brand': serializeParam(
          _brand,
          ParamType.String,
        ),
        'shape': serializeParam(
          _shape,
          ParamType.String,
        ),
        'category_id': serializeParam(
          _categoryId,
          ParamType.int,
        ),
        'category': serializeParam(
          _category,
          ParamType.String,
        ),
        'subcategory_id': serializeParam(
          _subcategoryId,
          ParamType.int,
        ),
        'sku': serializeParam(
          _sku,
          ParamType.String,
        ),
        'is_sold_out': serializeParam(
          _isSoldOut,
          ParamType.int,
        ),
        'price': serializeParam(
          _price,
          ParamType.String,
        ),
        'sale_price': serializeParam(
          _salePrice,
          ParamType.int,
        ),
        'images': serializeParam(
          _images,
          ParamType.String,
          isList: true,
        ),
      }.withoutNulls;

  static ProductStruct fromSerializableMap(Map<String, dynamic> data) =>
      ProductStruct(
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
        type: deserializeParam(
          data['type'],
          ParamType.String,
          false,
        ),
        detail: deserializeParam(
          data['detail'],
          ParamType.String,
          false,
        ),
        brand: deserializeParam(
          data['brand'],
          ParamType.String,
          false,
        ),
        shape: deserializeParam(
          data['shape'],
          ParamType.String,
          false,
        ),
        categoryId: deserializeParam(
          data['category_id'],
          ParamType.int,
          false,
        ),
        category: deserializeParam(
          data['category'],
          ParamType.String,
          false,
        ),
        subcategoryId: deserializeParam(
          data['subcategory_id'],
          ParamType.int,
          false,
        ),
        sku: deserializeParam(
          data['sku'],
          ParamType.String,
          false,
        ),
        isSoldOut: deserializeParam(
          data['is_sold_out'],
          ParamType.int,
          false,
        ),
        price: deserializeParam(
          data['price'],
          ParamType.String,
          false,
        ),
        salePrice: deserializeParam(
          data['sale_price'],
          ParamType.int,
          false,
        ),
        images: deserializeParam<String>(
          data['images'],
          ParamType.String,
          true,
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
        'type': debugSerializeParam(
          type,
          ParamType.String,
          name: 'String',
          nullable: false,
        ),
        'detail': debugSerializeParam(
          detail,
          ParamType.String,
          name: 'String',
          nullable: false,
        ),
        'brand': debugSerializeParam(
          brand,
          ParamType.String,
          name: 'String',
          nullable: false,
        ),
        'shape': debugSerializeParam(
          shape,
          ParamType.String,
          name: 'String',
          nullable: false,
        ),
        'category_id': debugSerializeParam(
          categoryId,
          ParamType.int,
          name: 'int',
          nullable: false,
        ),
        'category': debugSerializeParam(
          category,
          ParamType.String,
          name: 'String',
          nullable: false,
        ),
        'subcategory_id': debugSerializeParam(
          subcategoryId,
          ParamType.int,
          name: 'int',
          nullable: false,
        ),
        'sku': debugSerializeParam(
          sku,
          ParamType.String,
          name: 'String',
          nullable: false,
        ),
        'is_sold_out': debugSerializeParam(
          isSoldOut,
          ParamType.int,
          name: 'int',
          nullable: false,
        ),
        'price': debugSerializeParam(
          price,
          ParamType.String,
          name: 'String',
          nullable: false,
        ),
        'sale_price': debugSerializeParam(
          salePrice,
          ParamType.int,
          name: 'int',
          nullable: false,
        ),
        'images': debugSerializeParam(
          _images,
          ParamType.String,
          isList: true,
          name: 'String',
          nullable: false,
        ),
      };

  @override
  String toString() => 'ProductStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is ProductStruct &&
        id == other.id &&
        name == other.name &&
        type == other.type &&
        detail == other.detail &&
        brand == other.brand &&
        shape == other.shape &&
        categoryId == other.categoryId &&
        category == other.category &&
        subcategoryId == other.subcategoryId &&
        sku == other.sku &&
        isSoldOut == other.isSoldOut &&
        price == other.price &&
        salePrice == other.salePrice &&
        listEquality.equals(images, other.images);
  }

  @override
  int get hashCode => const ListEquality().hash([
        id,
        name,
        type,
        detail,
        brand,
        shape,
        categoryId,
        category,
        subcategoryId,
        sku,
        isSoldOut,
        price,
        salePrice,
        images
      ]);
}

ProductStruct createProductStruct({
  int? id,
  String? name,
  String? type,
  String? detail,
  String? brand,
  String? shape,
  int? categoryId,
  String? category,
  int? subcategoryId,
  String? sku,
  int? isSoldOut,
  String? price,
  int? salePrice,
}) =>
    ProductStruct(
      id: id,
      name: name,
      type: type,
      detail: detail,
      brand: brand,
      shape: shape,
      categoryId: categoryId,
      category: category,
      subcategoryId: subcategoryId,
      sku: sku,
      isSoldOut: isSoldOut,
      price: price,
      salePrice: salePrice,
    );
