// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ProductsTable extends Products with TableInfo<$ProductsTable, Product> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _productUuidMeta = const VerificationMeta(
    'productUuid',
  );
  @override
  late final GeneratedColumn<String> productUuid = GeneratedColumn<String>(
    'product_uuid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _serialNumberMeta = const VerificationMeta(
    'serialNumber',
  );
  @override
  late final GeneratedColumn<String> serialNumber = GeneratedColumn<String>(
    'serial_number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _brandMeta = const VerificationMeta('brand');
  @override
  late final GeneratedColumn<String> brand = GeneratedColumn<String>(
    'brand',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _modelMeta = const VerificationMeta('model');
  @override
  late final GeneratedColumn<String> model = GeneratedColumn<String>(
    'model',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<String> color = GeneratedColumn<String>(
    'color',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _materialMeta = const VerificationMeta(
    'material',
  );
  @override
  late final GeneratedColumn<String> material = GeneratedColumn<String>(
    'material',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _purchaseDateMeta = const VerificationMeta(
    'purchaseDate',
  );
  @override
  late final GeneratedColumn<DateTime> purchaseDate = GeneratedColumn<DateTime>(
    'purchase_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _originalPriceMeta = const VerificationMeta(
    'originalPrice',
  );
  @override
  late final GeneratedColumn<double> originalPrice = GeneratedColumn<double>(
    'original_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _discountedPriceMeta = const VerificationMeta(
    'discountedPrice',
  );
  @override
  late final GeneratedColumn<double> discountedPrice = GeneratedColumn<double>(
    'discounted_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _discountStartDateMeta = const VerificationMeta(
    'discountStartDate',
  );
  @override
  late final GeneratedColumn<DateTime> discountStartDate =
      GeneratedColumn<DateTime>(
        'discount_start_date',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _discountEndDateMeta = const VerificationMeta(
    'discountEndDate',
  );
  @override
  late final GeneratedColumn<DateTime> discountEndDate =
      GeneratedColumn<DateTime>(
        'discount_end_date',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _currentStockMeta = const VerificationMeta(
    'currentStock',
  );
  @override
  late final GeneratedColumn<int> currentStock = GeneratedColumn<int>(
    'current_stock',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _reorderPointMeta = const VerificationMeta(
    'reorderPoint',
  );
  @override
  late final GeneratedColumn<int> reorderPoint = GeneratedColumn<int>(
    'reorder_point',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastStockUpdateMeta = const VerificationMeta(
    'lastStockUpdate',
  );
  @override
  late final GeneratedColumn<DateTime> lastStockUpdate =
      GeneratedColumn<DateTime>(
        'last_stock_update',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _avgBuyPriceMeta = const VerificationMeta(
    'avgBuyPrice',
  );
  @override
  late final GeneratedColumn<double> avgBuyPrice = GeneratedColumn<double>(
    'avg_buy_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _minMarginPercentMeta = const VerificationMeta(
    'minMarginPercent',
  );
  @override
  late final GeneratedColumn<int> minMarginPercent = GeneratedColumn<int>(
    'min_margin_percent',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(20),
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<int> syncStatus = GeneratedColumn<int>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _baseCurrencyCodeMeta = const VerificationMeta(
    'baseCurrencyCode',
  );
  @override
  late final GeneratedColumn<String> baseCurrencyCode = GeneratedColumn<String>(
    'base_currency_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('IRR'),
  );
  static const VerificationMeta _costExchangeRateMeta = const VerificationMeta(
    'costExchangeRate',
  );
  @override
  late final GeneratedColumn<double> costExchangeRate = GeneratedColumn<double>(
    'cost_exchange_rate',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _minPriceMeta = const VerificationMeta(
    'minPrice',
  );
  @override
  late final GeneratedColumn<double> minPrice = GeneratedColumn<double>(
    'min_price',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sellingPriceMeta = const VerificationMeta(
    'sellingPrice',
  );
  @override
  late final GeneratedColumn<double> sellingPrice = GeneratedColumn<double>(
    'selling_price',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _maxPriceMeta = const VerificationMeta(
    'maxPrice',
  );
  @override
  late final GeneratedColumn<double> maxPrice = GeneratedColumn<double>(
    'max_price',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    productUuid,
    name,
    serialNumber,
    description,
    brand,
    model,
    color,
    material,
    purchaseDate,
    originalPrice,
    discountedPrice,
    discountStartDate,
    discountEndDate,
    currentStock,
    reorderPoint,
    lastStockUpdate,
    avgBuyPrice,
    minMarginPercent,
    syncStatus,
    baseCurrencyCode,
    costExchangeRate,
    minPrice,
    sellingPrice,
    maxPrice,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'products';
  @override
  VerificationContext validateIntegrity(
    Insertable<Product> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('product_uuid')) {
      context.handle(
        _productUuidMeta,
        productUuid.isAcceptableOrUnknown(
          data['product_uuid']!,
          _productUuidMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_productUuidMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('serial_number')) {
      context.handle(
        _serialNumberMeta,
        serialNumber.isAcceptableOrUnknown(
          data['serial_number']!,
          _serialNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_serialNumberMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('brand')) {
      context.handle(
        _brandMeta,
        brand.isAcceptableOrUnknown(data['brand']!, _brandMeta),
      );
    } else if (isInserting) {
      context.missing(_brandMeta);
    }
    if (data.containsKey('model')) {
      context.handle(
        _modelMeta,
        model.isAcceptableOrUnknown(data['model']!, _modelMeta),
      );
    } else if (isInserting) {
      context.missing(_modelMeta);
    }
    if (data.containsKey('color')) {
      context.handle(
        _colorMeta,
        color.isAcceptableOrUnknown(data['color']!, _colorMeta),
      );
    } else if (isInserting) {
      context.missing(_colorMeta);
    }
    if (data.containsKey('material')) {
      context.handle(
        _materialMeta,
        material.isAcceptableOrUnknown(data['material']!, _materialMeta),
      );
    } else if (isInserting) {
      context.missing(_materialMeta);
    }
    if (data.containsKey('purchase_date')) {
      context.handle(
        _purchaseDateMeta,
        purchaseDate.isAcceptableOrUnknown(
          data['purchase_date']!,
          _purchaseDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_purchaseDateMeta);
    }
    if (data.containsKey('original_price')) {
      context.handle(
        _originalPriceMeta,
        originalPrice.isAcceptableOrUnknown(
          data['original_price']!,
          _originalPriceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_originalPriceMeta);
    }
    if (data.containsKey('discounted_price')) {
      context.handle(
        _discountedPriceMeta,
        discountedPrice.isAcceptableOrUnknown(
          data['discounted_price']!,
          _discountedPriceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_discountedPriceMeta);
    }
    if (data.containsKey('discount_start_date')) {
      context.handle(
        _discountStartDateMeta,
        discountStartDate.isAcceptableOrUnknown(
          data['discount_start_date']!,
          _discountStartDateMeta,
        ),
      );
    }
    if (data.containsKey('discount_end_date')) {
      context.handle(
        _discountEndDateMeta,
        discountEndDate.isAcceptableOrUnknown(
          data['discount_end_date']!,
          _discountEndDateMeta,
        ),
      );
    }
    if (data.containsKey('current_stock')) {
      context.handle(
        _currentStockMeta,
        currentStock.isAcceptableOrUnknown(
          data['current_stock']!,
          _currentStockMeta,
        ),
      );
    }
    if (data.containsKey('reorder_point')) {
      context.handle(
        _reorderPointMeta,
        reorderPoint.isAcceptableOrUnknown(
          data['reorder_point']!,
          _reorderPointMeta,
        ),
      );
    }
    if (data.containsKey('last_stock_update')) {
      context.handle(
        _lastStockUpdateMeta,
        lastStockUpdate.isAcceptableOrUnknown(
          data['last_stock_update']!,
          _lastStockUpdateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastStockUpdateMeta);
    }
    if (data.containsKey('avg_buy_price')) {
      context.handle(
        _avgBuyPriceMeta,
        avgBuyPrice.isAcceptableOrUnknown(
          data['avg_buy_price']!,
          _avgBuyPriceMeta,
        ),
      );
    }
    if (data.containsKey('min_margin_percent')) {
      context.handle(
        _minMarginPercentMeta,
        minMarginPercent.isAcceptableOrUnknown(
          data['min_margin_percent']!,
          _minMarginPercentMeta,
        ),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('base_currency_code')) {
      context.handle(
        _baseCurrencyCodeMeta,
        baseCurrencyCode.isAcceptableOrUnknown(
          data['base_currency_code']!,
          _baseCurrencyCodeMeta,
        ),
      );
    }
    if (data.containsKey('cost_exchange_rate')) {
      context.handle(
        _costExchangeRateMeta,
        costExchangeRate.isAcceptableOrUnknown(
          data['cost_exchange_rate']!,
          _costExchangeRateMeta,
        ),
      );
    }
    if (data.containsKey('min_price')) {
      context.handle(
        _minPriceMeta,
        minPrice.isAcceptableOrUnknown(data['min_price']!, _minPriceMeta),
      );
    }
    if (data.containsKey('selling_price')) {
      context.handle(
        _sellingPriceMeta,
        sellingPrice.isAcceptableOrUnknown(
          data['selling_price']!,
          _sellingPriceMeta,
        ),
      );
    }
    if (data.containsKey('max_price')) {
      context.handle(
        _maxPriceMeta,
        maxPrice.isAcceptableOrUnknown(data['max_price']!, _maxPriceMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {productUuid};
  @override
  Product map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Product(
      productUuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_uuid'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      serialNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}serial_number'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      brand: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}brand'],
      )!,
      model: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}model'],
      )!,
      color: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}color'],
      )!,
      material: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}material'],
      )!,
      purchaseDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}purchase_date'],
      )!,
      originalPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}original_price'],
      )!,
      discountedPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}discounted_price'],
      )!,
      discountStartDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}discount_start_date'],
      ),
      discountEndDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}discount_end_date'],
      ),
      currentStock: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}current_stock'],
      )!,
      reorderPoint: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reorder_point'],
      )!,
      lastStockUpdate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_stock_update'],
      )!,
      avgBuyPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}avg_buy_price'],
      )!,
      minMarginPercent: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}min_margin_percent'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sync_status'],
      )!,
      baseCurrencyCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}base_currency_code'],
      )!,
      costExchangeRate: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}cost_exchange_rate'],
      ),
      minPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}min_price'],
      ),
      sellingPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}selling_price'],
      ),
      maxPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}max_price'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ProductsTable createAlias(String alias) {
    return $ProductsTable(attachedDatabase, alias);
  }
}

class Product extends DataClass implements Insertable<Product> {
  final String productUuid;
  final String name;
  final String serialNumber;
  final String description;
  final String brand;
  final String model;
  final String color;
  final String material;
  final DateTime purchaseDate;
  final double originalPrice;
  final double discountedPrice;
  final DateTime? discountStartDate;
  final DateTime? discountEndDate;
  final int currentStock;
  final int reorderPoint;
  final DateTime lastStockUpdate;
  final double avgBuyPrice;
  final int minMarginPercent;
  final int syncStatus;
  final String baseCurrencyCode;
  final double? costExchangeRate;
  final double? minPrice;
  final double? sellingPrice;
  final double? maxPrice;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Product({
    required this.productUuid,
    required this.name,
    required this.serialNumber,
    required this.description,
    required this.brand,
    required this.model,
    required this.color,
    required this.material,
    required this.purchaseDate,
    required this.originalPrice,
    required this.discountedPrice,
    this.discountStartDate,
    this.discountEndDate,
    required this.currentStock,
    required this.reorderPoint,
    required this.lastStockUpdate,
    required this.avgBuyPrice,
    required this.minMarginPercent,
    required this.syncStatus,
    required this.baseCurrencyCode,
    this.costExchangeRate,
    this.minPrice,
    this.sellingPrice,
    this.maxPrice,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['product_uuid'] = Variable<String>(productUuid);
    map['name'] = Variable<String>(name);
    map['serial_number'] = Variable<String>(serialNumber);
    map['description'] = Variable<String>(description);
    map['brand'] = Variable<String>(brand);
    map['model'] = Variable<String>(model);
    map['color'] = Variable<String>(color);
    map['material'] = Variable<String>(material);
    map['purchase_date'] = Variable<DateTime>(purchaseDate);
    map['original_price'] = Variable<double>(originalPrice);
    map['discounted_price'] = Variable<double>(discountedPrice);
    if (!nullToAbsent || discountStartDate != null) {
      map['discount_start_date'] = Variable<DateTime>(discountStartDate);
    }
    if (!nullToAbsent || discountEndDate != null) {
      map['discount_end_date'] = Variable<DateTime>(discountEndDate);
    }
    map['current_stock'] = Variable<int>(currentStock);
    map['reorder_point'] = Variable<int>(reorderPoint);
    map['last_stock_update'] = Variable<DateTime>(lastStockUpdate);
    map['avg_buy_price'] = Variable<double>(avgBuyPrice);
    map['min_margin_percent'] = Variable<int>(minMarginPercent);
    map['sync_status'] = Variable<int>(syncStatus);
    map['base_currency_code'] = Variable<String>(baseCurrencyCode);
    if (!nullToAbsent || costExchangeRate != null) {
      map['cost_exchange_rate'] = Variable<double>(costExchangeRate);
    }
    if (!nullToAbsent || minPrice != null) {
      map['min_price'] = Variable<double>(minPrice);
    }
    if (!nullToAbsent || sellingPrice != null) {
      map['selling_price'] = Variable<double>(sellingPrice);
    }
    if (!nullToAbsent || maxPrice != null) {
      map['max_price'] = Variable<double>(maxPrice);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ProductsCompanion toCompanion(bool nullToAbsent) {
    return ProductsCompanion(
      productUuid: Value(productUuid),
      name: Value(name),
      serialNumber: Value(serialNumber),
      description: Value(description),
      brand: Value(brand),
      model: Value(model),
      color: Value(color),
      material: Value(material),
      purchaseDate: Value(purchaseDate),
      originalPrice: Value(originalPrice),
      discountedPrice: Value(discountedPrice),
      discountStartDate: discountStartDate == null && nullToAbsent
          ? const Value.absent()
          : Value(discountStartDate),
      discountEndDate: discountEndDate == null && nullToAbsent
          ? const Value.absent()
          : Value(discountEndDate),
      currentStock: Value(currentStock),
      reorderPoint: Value(reorderPoint),
      lastStockUpdate: Value(lastStockUpdate),
      avgBuyPrice: Value(avgBuyPrice),
      minMarginPercent: Value(minMarginPercent),
      syncStatus: Value(syncStatus),
      baseCurrencyCode: Value(baseCurrencyCode),
      costExchangeRate: costExchangeRate == null && nullToAbsent
          ? const Value.absent()
          : Value(costExchangeRate),
      minPrice: minPrice == null && nullToAbsent
          ? const Value.absent()
          : Value(minPrice),
      sellingPrice: sellingPrice == null && nullToAbsent
          ? const Value.absent()
          : Value(sellingPrice),
      maxPrice: maxPrice == null && nullToAbsent
          ? const Value.absent()
          : Value(maxPrice),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Product.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Product(
      productUuid: serializer.fromJson<String>(json['productUuid']),
      name: serializer.fromJson<String>(json['name']),
      serialNumber: serializer.fromJson<String>(json['serialNumber']),
      description: serializer.fromJson<String>(json['description']),
      brand: serializer.fromJson<String>(json['brand']),
      model: serializer.fromJson<String>(json['model']),
      color: serializer.fromJson<String>(json['color']),
      material: serializer.fromJson<String>(json['material']),
      purchaseDate: serializer.fromJson<DateTime>(json['purchaseDate']),
      originalPrice: serializer.fromJson<double>(json['originalPrice']),
      discountedPrice: serializer.fromJson<double>(json['discountedPrice']),
      discountStartDate: serializer.fromJson<DateTime?>(
        json['discountStartDate'],
      ),
      discountEndDate: serializer.fromJson<DateTime?>(json['discountEndDate']),
      currentStock: serializer.fromJson<int>(json['currentStock']),
      reorderPoint: serializer.fromJson<int>(json['reorderPoint']),
      lastStockUpdate: serializer.fromJson<DateTime>(json['lastStockUpdate']),
      avgBuyPrice: serializer.fromJson<double>(json['avgBuyPrice']),
      minMarginPercent: serializer.fromJson<int>(json['minMarginPercent']),
      syncStatus: serializer.fromJson<int>(json['syncStatus']),
      baseCurrencyCode: serializer.fromJson<String>(json['baseCurrencyCode']),
      costExchangeRate: serializer.fromJson<double?>(json['costExchangeRate']),
      minPrice: serializer.fromJson<double?>(json['minPrice']),
      sellingPrice: serializer.fromJson<double?>(json['sellingPrice']),
      maxPrice: serializer.fromJson<double?>(json['maxPrice']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'productUuid': serializer.toJson<String>(productUuid),
      'name': serializer.toJson<String>(name),
      'serialNumber': serializer.toJson<String>(serialNumber),
      'description': serializer.toJson<String>(description),
      'brand': serializer.toJson<String>(brand),
      'model': serializer.toJson<String>(model),
      'color': serializer.toJson<String>(color),
      'material': serializer.toJson<String>(material),
      'purchaseDate': serializer.toJson<DateTime>(purchaseDate),
      'originalPrice': serializer.toJson<double>(originalPrice),
      'discountedPrice': serializer.toJson<double>(discountedPrice),
      'discountStartDate': serializer.toJson<DateTime?>(discountStartDate),
      'discountEndDate': serializer.toJson<DateTime?>(discountEndDate),
      'currentStock': serializer.toJson<int>(currentStock),
      'reorderPoint': serializer.toJson<int>(reorderPoint),
      'lastStockUpdate': serializer.toJson<DateTime>(lastStockUpdate),
      'avgBuyPrice': serializer.toJson<double>(avgBuyPrice),
      'minMarginPercent': serializer.toJson<int>(minMarginPercent),
      'syncStatus': serializer.toJson<int>(syncStatus),
      'baseCurrencyCode': serializer.toJson<String>(baseCurrencyCode),
      'costExchangeRate': serializer.toJson<double?>(costExchangeRate),
      'minPrice': serializer.toJson<double?>(minPrice),
      'sellingPrice': serializer.toJson<double?>(sellingPrice),
      'maxPrice': serializer.toJson<double?>(maxPrice),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Product copyWith({
    String? productUuid,
    String? name,
    String? serialNumber,
    String? description,
    String? brand,
    String? model,
    String? color,
    String? material,
    DateTime? purchaseDate,
    double? originalPrice,
    double? discountedPrice,
    Value<DateTime?> discountStartDate = const Value.absent(),
    Value<DateTime?> discountEndDate = const Value.absent(),
    int? currentStock,
    int? reorderPoint,
    DateTime? lastStockUpdate,
    double? avgBuyPrice,
    int? minMarginPercent,
    int? syncStatus,
    String? baseCurrencyCode,
    Value<double?> costExchangeRate = const Value.absent(),
    Value<double?> minPrice = const Value.absent(),
    Value<double?> sellingPrice = const Value.absent(),
    Value<double?> maxPrice = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Product(
    productUuid: productUuid ?? this.productUuid,
    name: name ?? this.name,
    serialNumber: serialNumber ?? this.serialNumber,
    description: description ?? this.description,
    brand: brand ?? this.brand,
    model: model ?? this.model,
    color: color ?? this.color,
    material: material ?? this.material,
    purchaseDate: purchaseDate ?? this.purchaseDate,
    originalPrice: originalPrice ?? this.originalPrice,
    discountedPrice: discountedPrice ?? this.discountedPrice,
    discountStartDate: discountStartDate.present
        ? discountStartDate.value
        : this.discountStartDate,
    discountEndDate: discountEndDate.present
        ? discountEndDate.value
        : this.discountEndDate,
    currentStock: currentStock ?? this.currentStock,
    reorderPoint: reorderPoint ?? this.reorderPoint,
    lastStockUpdate: lastStockUpdate ?? this.lastStockUpdate,
    avgBuyPrice: avgBuyPrice ?? this.avgBuyPrice,
    minMarginPercent: minMarginPercent ?? this.minMarginPercent,
    syncStatus: syncStatus ?? this.syncStatus,
    baseCurrencyCode: baseCurrencyCode ?? this.baseCurrencyCode,
    costExchangeRate: costExchangeRate.present
        ? costExchangeRate.value
        : this.costExchangeRate,
    minPrice: minPrice.present ? minPrice.value : this.minPrice,
    sellingPrice: sellingPrice.present ? sellingPrice.value : this.sellingPrice,
    maxPrice: maxPrice.present ? maxPrice.value : this.maxPrice,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Product copyWithCompanion(ProductsCompanion data) {
    return Product(
      productUuid: data.productUuid.present
          ? data.productUuid.value
          : this.productUuid,
      name: data.name.present ? data.name.value : this.name,
      serialNumber: data.serialNumber.present
          ? data.serialNumber.value
          : this.serialNumber,
      description: data.description.present
          ? data.description.value
          : this.description,
      brand: data.brand.present ? data.brand.value : this.brand,
      model: data.model.present ? data.model.value : this.model,
      color: data.color.present ? data.color.value : this.color,
      material: data.material.present ? data.material.value : this.material,
      purchaseDate: data.purchaseDate.present
          ? data.purchaseDate.value
          : this.purchaseDate,
      originalPrice: data.originalPrice.present
          ? data.originalPrice.value
          : this.originalPrice,
      discountedPrice: data.discountedPrice.present
          ? data.discountedPrice.value
          : this.discountedPrice,
      discountStartDate: data.discountStartDate.present
          ? data.discountStartDate.value
          : this.discountStartDate,
      discountEndDate: data.discountEndDate.present
          ? data.discountEndDate.value
          : this.discountEndDate,
      currentStock: data.currentStock.present
          ? data.currentStock.value
          : this.currentStock,
      reorderPoint: data.reorderPoint.present
          ? data.reorderPoint.value
          : this.reorderPoint,
      lastStockUpdate: data.lastStockUpdate.present
          ? data.lastStockUpdate.value
          : this.lastStockUpdate,
      avgBuyPrice: data.avgBuyPrice.present
          ? data.avgBuyPrice.value
          : this.avgBuyPrice,
      minMarginPercent: data.minMarginPercent.present
          ? data.minMarginPercent.value
          : this.minMarginPercent,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      baseCurrencyCode: data.baseCurrencyCode.present
          ? data.baseCurrencyCode.value
          : this.baseCurrencyCode,
      costExchangeRate: data.costExchangeRate.present
          ? data.costExchangeRate.value
          : this.costExchangeRate,
      minPrice: data.minPrice.present ? data.minPrice.value : this.minPrice,
      sellingPrice: data.sellingPrice.present
          ? data.sellingPrice.value
          : this.sellingPrice,
      maxPrice: data.maxPrice.present ? data.maxPrice.value : this.maxPrice,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Product(')
          ..write('productUuid: $productUuid, ')
          ..write('name: $name, ')
          ..write('serialNumber: $serialNumber, ')
          ..write('description: $description, ')
          ..write('brand: $brand, ')
          ..write('model: $model, ')
          ..write('color: $color, ')
          ..write('material: $material, ')
          ..write('purchaseDate: $purchaseDate, ')
          ..write('originalPrice: $originalPrice, ')
          ..write('discountedPrice: $discountedPrice, ')
          ..write('discountStartDate: $discountStartDate, ')
          ..write('discountEndDate: $discountEndDate, ')
          ..write('currentStock: $currentStock, ')
          ..write('reorderPoint: $reorderPoint, ')
          ..write('lastStockUpdate: $lastStockUpdate, ')
          ..write('avgBuyPrice: $avgBuyPrice, ')
          ..write('minMarginPercent: $minMarginPercent, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('baseCurrencyCode: $baseCurrencyCode, ')
          ..write('costExchangeRate: $costExchangeRate, ')
          ..write('minPrice: $minPrice, ')
          ..write('sellingPrice: $sellingPrice, ')
          ..write('maxPrice: $maxPrice, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    productUuid,
    name,
    serialNumber,
    description,
    brand,
    model,
    color,
    material,
    purchaseDate,
    originalPrice,
    discountedPrice,
    discountStartDate,
    discountEndDate,
    currentStock,
    reorderPoint,
    lastStockUpdate,
    avgBuyPrice,
    minMarginPercent,
    syncStatus,
    baseCurrencyCode,
    costExchangeRate,
    minPrice,
    sellingPrice,
    maxPrice,
    createdAt,
    updatedAt,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Product &&
          other.productUuid == this.productUuid &&
          other.name == this.name &&
          other.serialNumber == this.serialNumber &&
          other.description == this.description &&
          other.brand == this.brand &&
          other.model == this.model &&
          other.color == this.color &&
          other.material == this.material &&
          other.purchaseDate == this.purchaseDate &&
          other.originalPrice == this.originalPrice &&
          other.discountedPrice == this.discountedPrice &&
          other.discountStartDate == this.discountStartDate &&
          other.discountEndDate == this.discountEndDate &&
          other.currentStock == this.currentStock &&
          other.reorderPoint == this.reorderPoint &&
          other.lastStockUpdate == this.lastStockUpdate &&
          other.avgBuyPrice == this.avgBuyPrice &&
          other.minMarginPercent == this.minMarginPercent &&
          other.syncStatus == this.syncStatus &&
          other.baseCurrencyCode == this.baseCurrencyCode &&
          other.costExchangeRate == this.costExchangeRate &&
          other.minPrice == this.minPrice &&
          other.sellingPrice == this.sellingPrice &&
          other.maxPrice == this.maxPrice &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ProductsCompanion extends UpdateCompanion<Product> {
  final Value<String> productUuid;
  final Value<String> name;
  final Value<String> serialNumber;
  final Value<String> description;
  final Value<String> brand;
  final Value<String> model;
  final Value<String> color;
  final Value<String> material;
  final Value<DateTime> purchaseDate;
  final Value<double> originalPrice;
  final Value<double> discountedPrice;
  final Value<DateTime?> discountStartDate;
  final Value<DateTime?> discountEndDate;
  final Value<int> currentStock;
  final Value<int> reorderPoint;
  final Value<DateTime> lastStockUpdate;
  final Value<double> avgBuyPrice;
  final Value<int> minMarginPercent;
  final Value<int> syncStatus;
  final Value<String> baseCurrencyCode;
  final Value<double?> costExchangeRate;
  final Value<double?> minPrice;
  final Value<double?> sellingPrice;
  final Value<double?> maxPrice;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const ProductsCompanion({
    this.productUuid = const Value.absent(),
    this.name = const Value.absent(),
    this.serialNumber = const Value.absent(),
    this.description = const Value.absent(),
    this.brand = const Value.absent(),
    this.model = const Value.absent(),
    this.color = const Value.absent(),
    this.material = const Value.absent(),
    this.purchaseDate = const Value.absent(),
    this.originalPrice = const Value.absent(),
    this.discountedPrice = const Value.absent(),
    this.discountStartDate = const Value.absent(),
    this.discountEndDate = const Value.absent(),
    this.currentStock = const Value.absent(),
    this.reorderPoint = const Value.absent(),
    this.lastStockUpdate = const Value.absent(),
    this.avgBuyPrice = const Value.absent(),
    this.minMarginPercent = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.baseCurrencyCode = const Value.absent(),
    this.costExchangeRate = const Value.absent(),
    this.minPrice = const Value.absent(),
    this.sellingPrice = const Value.absent(),
    this.maxPrice = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProductsCompanion.insert({
    required String productUuid,
    required String name,
    required String serialNumber,
    required String description,
    required String brand,
    required String model,
    required String color,
    required String material,
    required DateTime purchaseDate,
    required double originalPrice,
    required double discountedPrice,
    this.discountStartDate = const Value.absent(),
    this.discountEndDate = const Value.absent(),
    this.currentStock = const Value.absent(),
    this.reorderPoint = const Value.absent(),
    required DateTime lastStockUpdate,
    this.avgBuyPrice = const Value.absent(),
    this.minMarginPercent = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.baseCurrencyCode = const Value.absent(),
    this.costExchangeRate = const Value.absent(),
    this.minPrice = const Value.absent(),
    this.sellingPrice = const Value.absent(),
    this.maxPrice = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : productUuid = Value(productUuid),
       name = Value(name),
       serialNumber = Value(serialNumber),
       description = Value(description),
       brand = Value(brand),
       model = Value(model),
       color = Value(color),
       material = Value(material),
       purchaseDate = Value(purchaseDate),
       originalPrice = Value(originalPrice),
       discountedPrice = Value(discountedPrice),
       lastStockUpdate = Value(lastStockUpdate),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Product> custom({
    Expression<String>? productUuid,
    Expression<String>? name,
    Expression<String>? serialNumber,
    Expression<String>? description,
    Expression<String>? brand,
    Expression<String>? model,
    Expression<String>? color,
    Expression<String>? material,
    Expression<DateTime>? purchaseDate,
    Expression<double>? originalPrice,
    Expression<double>? discountedPrice,
    Expression<DateTime>? discountStartDate,
    Expression<DateTime>? discountEndDate,
    Expression<int>? currentStock,
    Expression<int>? reorderPoint,
    Expression<DateTime>? lastStockUpdate,
    Expression<double>? avgBuyPrice,
    Expression<int>? minMarginPercent,
    Expression<int>? syncStatus,
    Expression<String>? baseCurrencyCode,
    Expression<double>? costExchangeRate,
    Expression<double>? minPrice,
    Expression<double>? sellingPrice,
    Expression<double>? maxPrice,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (productUuid != null) 'product_uuid': productUuid,
      if (name != null) 'name': name,
      if (serialNumber != null) 'serial_number': serialNumber,
      if (description != null) 'description': description,
      if (brand != null) 'brand': brand,
      if (model != null) 'model': model,
      if (color != null) 'color': color,
      if (material != null) 'material': material,
      if (purchaseDate != null) 'purchase_date': purchaseDate,
      if (originalPrice != null) 'original_price': originalPrice,
      if (discountedPrice != null) 'discounted_price': discountedPrice,
      if (discountStartDate != null) 'discount_start_date': discountStartDate,
      if (discountEndDate != null) 'discount_end_date': discountEndDate,
      if (currentStock != null) 'current_stock': currentStock,
      if (reorderPoint != null) 'reorder_point': reorderPoint,
      if (lastStockUpdate != null) 'last_stock_update': lastStockUpdate,
      if (avgBuyPrice != null) 'avg_buy_price': avgBuyPrice,
      if (minMarginPercent != null) 'min_margin_percent': minMarginPercent,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (baseCurrencyCode != null) 'base_currency_code': baseCurrencyCode,
      if (costExchangeRate != null) 'cost_exchange_rate': costExchangeRate,
      if (minPrice != null) 'min_price': minPrice,
      if (sellingPrice != null) 'selling_price': sellingPrice,
      if (maxPrice != null) 'max_price': maxPrice,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProductsCompanion copyWith({
    Value<String>? productUuid,
    Value<String>? name,
    Value<String>? serialNumber,
    Value<String>? description,
    Value<String>? brand,
    Value<String>? model,
    Value<String>? color,
    Value<String>? material,
    Value<DateTime>? purchaseDate,
    Value<double>? originalPrice,
    Value<double>? discountedPrice,
    Value<DateTime?>? discountStartDate,
    Value<DateTime?>? discountEndDate,
    Value<int>? currentStock,
    Value<int>? reorderPoint,
    Value<DateTime>? lastStockUpdate,
    Value<double>? avgBuyPrice,
    Value<int>? minMarginPercent,
    Value<int>? syncStatus,
    Value<String>? baseCurrencyCode,
    Value<double?>? costExchangeRate,
    Value<double?>? minPrice,
    Value<double?>? sellingPrice,
    Value<double?>? maxPrice,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return ProductsCompanion(
      productUuid: productUuid ?? this.productUuid,
      name: name ?? this.name,
      serialNumber: serialNumber ?? this.serialNumber,
      description: description ?? this.description,
      brand: brand ?? this.brand,
      model: model ?? this.model,
      color: color ?? this.color,
      material: material ?? this.material,
      purchaseDate: purchaseDate ?? this.purchaseDate,
      originalPrice: originalPrice ?? this.originalPrice,
      discountedPrice: discountedPrice ?? this.discountedPrice,
      discountStartDate: discountStartDate ?? this.discountStartDate,
      discountEndDate: discountEndDate ?? this.discountEndDate,
      currentStock: currentStock ?? this.currentStock,
      reorderPoint: reorderPoint ?? this.reorderPoint,
      lastStockUpdate: lastStockUpdate ?? this.lastStockUpdate,
      avgBuyPrice: avgBuyPrice ?? this.avgBuyPrice,
      minMarginPercent: minMarginPercent ?? this.minMarginPercent,
      syncStatus: syncStatus ?? this.syncStatus,
      baseCurrencyCode: baseCurrencyCode ?? this.baseCurrencyCode,
      costExchangeRate: costExchangeRate ?? this.costExchangeRate,
      minPrice: minPrice ?? this.minPrice,
      sellingPrice: sellingPrice ?? this.sellingPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (productUuid.present) {
      map['product_uuid'] = Variable<String>(productUuid.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (serialNumber.present) {
      map['serial_number'] = Variable<String>(serialNumber.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (brand.present) {
      map['brand'] = Variable<String>(brand.value);
    }
    if (model.present) {
      map['model'] = Variable<String>(model.value);
    }
    if (color.present) {
      map['color'] = Variable<String>(color.value);
    }
    if (material.present) {
      map['material'] = Variable<String>(material.value);
    }
    if (purchaseDate.present) {
      map['purchase_date'] = Variable<DateTime>(purchaseDate.value);
    }
    if (originalPrice.present) {
      map['original_price'] = Variable<double>(originalPrice.value);
    }
    if (discountedPrice.present) {
      map['discounted_price'] = Variable<double>(discountedPrice.value);
    }
    if (discountStartDate.present) {
      map['discount_start_date'] = Variable<DateTime>(discountStartDate.value);
    }
    if (discountEndDate.present) {
      map['discount_end_date'] = Variable<DateTime>(discountEndDate.value);
    }
    if (currentStock.present) {
      map['current_stock'] = Variable<int>(currentStock.value);
    }
    if (reorderPoint.present) {
      map['reorder_point'] = Variable<int>(reorderPoint.value);
    }
    if (lastStockUpdate.present) {
      map['last_stock_update'] = Variable<DateTime>(lastStockUpdate.value);
    }
    if (avgBuyPrice.present) {
      map['avg_buy_price'] = Variable<double>(avgBuyPrice.value);
    }
    if (minMarginPercent.present) {
      map['min_margin_percent'] = Variable<int>(minMarginPercent.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<int>(syncStatus.value);
    }
    if (baseCurrencyCode.present) {
      map['base_currency_code'] = Variable<String>(baseCurrencyCode.value);
    }
    if (costExchangeRate.present) {
      map['cost_exchange_rate'] = Variable<double>(costExchangeRate.value);
    }
    if (minPrice.present) {
      map['min_price'] = Variable<double>(minPrice.value);
    }
    if (sellingPrice.present) {
      map['selling_price'] = Variable<double>(sellingPrice.value);
    }
    if (maxPrice.present) {
      map['max_price'] = Variable<double>(maxPrice.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductsCompanion(')
          ..write('productUuid: $productUuid, ')
          ..write('name: $name, ')
          ..write('serialNumber: $serialNumber, ')
          ..write('description: $description, ')
          ..write('brand: $brand, ')
          ..write('model: $model, ')
          ..write('color: $color, ')
          ..write('material: $material, ')
          ..write('purchaseDate: $purchaseDate, ')
          ..write('originalPrice: $originalPrice, ')
          ..write('discountedPrice: $discountedPrice, ')
          ..write('discountStartDate: $discountStartDate, ')
          ..write('discountEndDate: $discountEndDate, ')
          ..write('currentStock: $currentStock, ')
          ..write('reorderPoint: $reorderPoint, ')
          ..write('lastStockUpdate: $lastStockUpdate, ')
          ..write('avgBuyPrice: $avgBuyPrice, ')
          ..write('minMarginPercent: $minMarginPercent, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('baseCurrencyCode: $baseCurrencyCode, ')
          ..write('costExchangeRate: $costExchangeRate, ')
          ..write('minPrice: $minPrice, ')
          ..write('sellingPrice: $sellingPrice, ')
          ..write('maxPrice: $maxPrice, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _userUuidMeta = const VerificationMeta(
    'userUuid',
  );
  @override
  late final GeneratedColumn<String> userUuid = GeneratedColumn<String>(
    'user_uuid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _usernameMeta = const VerificationMeta(
    'username',
  );
  @override
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
    'username',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _passwordMeta = const VerificationMeta(
    'password',
  );
  @override
  late final GeneratedColumn<String> password = GeneratedColumn<String>(
    'password',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
    'role',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nicknameMeta = const VerificationMeta(
    'nickname',
  );
  @override
  late final GeneratedColumn<String> nickname = GeneratedColumn<String>(
    'nickname',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isFirstLoginMeta = const VerificationMeta(
    'isFirstLogin',
  );
  @override
  late final GeneratedColumn<bool> isFirstLogin = GeneratedColumn<bool>(
    'is_first_login',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_first_login" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _loggedInMeta = const VerificationMeta(
    'loggedIn',
  );
  @override
  late final GeneratedColumn<bool> loggedIn = GeneratedColumn<bool>(
    'logged_in',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("logged_in" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    userUuid,
    username,
    password,
    role,
    nickname,
    isFirstLogin,
    loggedIn,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(
    Insertable<User> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('user_uuid')) {
      context.handle(
        _userUuidMeta,
        userUuid.isAcceptableOrUnknown(data['user_uuid']!, _userUuidMeta),
      );
    } else if (isInserting) {
      context.missing(_userUuidMeta);
    }
    if (data.containsKey('username')) {
      context.handle(
        _usernameMeta,
        username.isAcceptableOrUnknown(data['username']!, _usernameMeta),
      );
    } else if (isInserting) {
      context.missing(_usernameMeta);
    }
    if (data.containsKey('password')) {
      context.handle(
        _passwordMeta,
        password.isAcceptableOrUnknown(data['password']!, _passwordMeta),
      );
    } else if (isInserting) {
      context.missing(_passwordMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleMeta,
        role.isAcceptableOrUnknown(data['role']!, _roleMeta),
      );
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('nickname')) {
      context.handle(
        _nicknameMeta,
        nickname.isAcceptableOrUnknown(data['nickname']!, _nicknameMeta),
      );
    } else if (isInserting) {
      context.missing(_nicknameMeta);
    }
    if (data.containsKey('is_first_login')) {
      context.handle(
        _isFirstLoginMeta,
        isFirstLogin.isAcceptableOrUnknown(
          data['is_first_login']!,
          _isFirstLoginMeta,
        ),
      );
    }
    if (data.containsKey('logged_in')) {
      context.handle(
        _loggedInMeta,
        loggedIn.isAcceptableOrUnknown(data['logged_in']!, _loggedInMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {userUuid};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return User(
      userUuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_uuid'],
      )!,
      username: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}username'],
      )!,
      password: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}password'],
      )!,
      role: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role'],
      )!,
      nickname: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nickname'],
      )!,
      isFirstLogin: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_first_login'],
      )!,
      loggedIn: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}logged_in'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class User extends DataClass implements Insertable<User> {
  final String userUuid;
  final String username;
  final String password;
  final String role;
  final String nickname;
  final bool isFirstLogin;
  final bool loggedIn;
  final DateTime createdAt;
  final DateTime updatedAt;
  const User({
    required this.userUuid,
    required this.username,
    required this.password,
    required this.role,
    required this.nickname,
    required this.isFirstLogin,
    required this.loggedIn,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['user_uuid'] = Variable<String>(userUuid);
    map['username'] = Variable<String>(username);
    map['password'] = Variable<String>(password);
    map['role'] = Variable<String>(role);
    map['nickname'] = Variable<String>(nickname);
    map['is_first_login'] = Variable<bool>(isFirstLogin);
    map['logged_in'] = Variable<bool>(loggedIn);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      userUuid: Value(userUuid),
      username: Value(username),
      password: Value(password),
      role: Value(role),
      nickname: Value(nickname),
      isFirstLogin: Value(isFirstLogin),
      loggedIn: Value(loggedIn),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory User.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      userUuid: serializer.fromJson<String>(json['userUuid']),
      username: serializer.fromJson<String>(json['username']),
      password: serializer.fromJson<String>(json['password']),
      role: serializer.fromJson<String>(json['role']),
      nickname: serializer.fromJson<String>(json['nickname']),
      isFirstLogin: serializer.fromJson<bool>(json['isFirstLogin']),
      loggedIn: serializer.fromJson<bool>(json['loggedIn']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'userUuid': serializer.toJson<String>(userUuid),
      'username': serializer.toJson<String>(username),
      'password': serializer.toJson<String>(password),
      'role': serializer.toJson<String>(role),
      'nickname': serializer.toJson<String>(nickname),
      'isFirstLogin': serializer.toJson<bool>(isFirstLogin),
      'loggedIn': serializer.toJson<bool>(loggedIn),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  User copyWith({
    String? userUuid,
    String? username,
    String? password,
    String? role,
    String? nickname,
    bool? isFirstLogin,
    bool? loggedIn,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => User(
    userUuid: userUuid ?? this.userUuid,
    username: username ?? this.username,
    password: password ?? this.password,
    role: role ?? this.role,
    nickname: nickname ?? this.nickname,
    isFirstLogin: isFirstLogin ?? this.isFirstLogin,
    loggedIn: loggedIn ?? this.loggedIn,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  User copyWithCompanion(UsersCompanion data) {
    return User(
      userUuid: data.userUuid.present ? data.userUuid.value : this.userUuid,
      username: data.username.present ? data.username.value : this.username,
      password: data.password.present ? data.password.value : this.password,
      role: data.role.present ? data.role.value : this.role,
      nickname: data.nickname.present ? data.nickname.value : this.nickname,
      isFirstLogin: data.isFirstLogin.present
          ? data.isFirstLogin.value
          : this.isFirstLogin,
      loggedIn: data.loggedIn.present ? data.loggedIn.value : this.loggedIn,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('userUuid: $userUuid, ')
          ..write('username: $username, ')
          ..write('password: $password, ')
          ..write('role: $role, ')
          ..write('nickname: $nickname, ')
          ..write('isFirstLogin: $isFirstLogin, ')
          ..write('loggedIn: $loggedIn, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    userUuid,
    username,
    password,
    role,
    nickname,
    isFirstLogin,
    loggedIn,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.userUuid == this.userUuid &&
          other.username == this.username &&
          other.password == this.password &&
          other.role == this.role &&
          other.nickname == this.nickname &&
          other.isFirstLogin == this.isFirstLogin &&
          other.loggedIn == this.loggedIn &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<String> userUuid;
  final Value<String> username;
  final Value<String> password;
  final Value<String> role;
  final Value<String> nickname;
  final Value<bool> isFirstLogin;
  final Value<bool> loggedIn;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const UsersCompanion({
    this.userUuid = const Value.absent(),
    this.username = const Value.absent(),
    this.password = const Value.absent(),
    this.role = const Value.absent(),
    this.nickname = const Value.absent(),
    this.isFirstLogin = const Value.absent(),
    this.loggedIn = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UsersCompanion.insert({
    required String userUuid,
    required String username,
    required String password,
    required String role,
    required String nickname,
    this.isFirstLogin = const Value.absent(),
    this.loggedIn = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : userUuid = Value(userUuid),
       username = Value(username),
       password = Value(password),
       role = Value(role),
       nickname = Value(nickname),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<User> custom({
    Expression<String>? userUuid,
    Expression<String>? username,
    Expression<String>? password,
    Expression<String>? role,
    Expression<String>? nickname,
    Expression<bool>? isFirstLogin,
    Expression<bool>? loggedIn,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (userUuid != null) 'user_uuid': userUuid,
      if (username != null) 'username': username,
      if (password != null) 'password': password,
      if (role != null) 'role': role,
      if (nickname != null) 'nickname': nickname,
      if (isFirstLogin != null) 'is_first_login': isFirstLogin,
      if (loggedIn != null) 'logged_in': loggedIn,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UsersCompanion copyWith({
    Value<String>? userUuid,
    Value<String>? username,
    Value<String>? password,
    Value<String>? role,
    Value<String>? nickname,
    Value<bool>? isFirstLogin,
    Value<bool>? loggedIn,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return UsersCompanion(
      userUuid: userUuid ?? this.userUuid,
      username: username ?? this.username,
      password: password ?? this.password,
      role: role ?? this.role,
      nickname: nickname ?? this.nickname,
      isFirstLogin: isFirstLogin ?? this.isFirstLogin,
      loggedIn: loggedIn ?? this.loggedIn,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (userUuid.present) {
      map['user_uuid'] = Variable<String>(userUuid.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (password.present) {
      map['password'] = Variable<String>(password.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (nickname.present) {
      map['nickname'] = Variable<String>(nickname.value);
    }
    if (isFirstLogin.present) {
      map['is_first_login'] = Variable<bool>(isFirstLogin.value);
    }
    if (loggedIn.present) {
      map['logged_in'] = Variable<bool>(loggedIn.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('userUuid: $userUuid, ')
          ..write('username: $username, ')
          ..write('password: $password, ')
          ..write('role: $role, ')
          ..write('nickname: $nickname, ')
          ..write('isFirstLogin: $isFirstLogin, ')
          ..write('loggedIn: $loggedIn, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ThemesTable extends Themes with TableInfo<$ThemesTable, Theme> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ThemesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _themeTypeMeta = const VerificationMeta(
    'themeType',
  );
  @override
  late final GeneratedColumn<String> themeType = GeneratedColumn<String>(
    'theme_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, themeType];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'themes';
  @override
  VerificationContext validateIntegrity(
    Insertable<Theme> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('theme_type')) {
      context.handle(
        _themeTypeMeta,
        themeType.isAcceptableOrUnknown(data['theme_type']!, _themeTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_themeTypeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Theme map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Theme(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      themeType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}theme_type'],
      )!,
    );
  }

  @override
  $ThemesTable createAlias(String alias) {
    return $ThemesTable(attachedDatabase, alias);
  }
}

class Theme extends DataClass implements Insertable<Theme> {
  final int id;
  final String themeType;
  const Theme({required this.id, required this.themeType});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['theme_type'] = Variable<String>(themeType);
    return map;
  }

  ThemesCompanion toCompanion(bool nullToAbsent) {
    return ThemesCompanion(id: Value(id), themeType: Value(themeType));
  }

  factory Theme.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Theme(
      id: serializer.fromJson<int>(json['id']),
      themeType: serializer.fromJson<String>(json['themeType']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'themeType': serializer.toJson<String>(themeType),
    };
  }

  Theme copyWith({int? id, String? themeType}) =>
      Theme(id: id ?? this.id, themeType: themeType ?? this.themeType);
  Theme copyWithCompanion(ThemesCompanion data) {
    return Theme(
      id: data.id.present ? data.id.value : this.id,
      themeType: data.themeType.present ? data.themeType.value : this.themeType,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Theme(')
          ..write('id: $id, ')
          ..write('themeType: $themeType')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, themeType);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Theme &&
          other.id == this.id &&
          other.themeType == this.themeType);
}

class ThemesCompanion extends UpdateCompanion<Theme> {
  final Value<int> id;
  final Value<String> themeType;
  const ThemesCompanion({
    this.id = const Value.absent(),
    this.themeType = const Value.absent(),
  });
  ThemesCompanion.insert({
    this.id = const Value.absent(),
    required String themeType,
  }) : themeType = Value(themeType);
  static Insertable<Theme> custom({
    Expression<int>? id,
    Expression<String>? themeType,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (themeType != null) 'theme_type': themeType,
    });
  }

  ThemesCompanion copyWith({Value<int>? id, Value<String>? themeType}) {
    return ThemesCompanion(
      id: id ?? this.id,
      themeType: themeType ?? this.themeType,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (themeType.present) {
      map['theme_type'] = Variable<String>(themeType.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ThemesCompanion(')
          ..write('id: $id, ')
          ..write('themeType: $themeType')
          ..write(')'))
        .toString();
  }
}

class $LanguagesTable extends Languages
    with TableInfo<$LanguagesTable, Language> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LanguagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, code, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'languages';
  @override
  VerificationContext validateIntegrity(
    Insertable<Language> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Language map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Language(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
    );
  }

  @override
  $LanguagesTable createAlias(String alias) {
    return $LanguagesTable(attachedDatabase, alias);
  }
}

class Language extends DataClass implements Insertable<Language> {
  final int id;
  final String code;
  final String name;
  const Language({required this.id, required this.code, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['code'] = Variable<String>(code);
    map['name'] = Variable<String>(name);
    return map;
  }

  LanguagesCompanion toCompanion(bool nullToAbsent) {
    return LanguagesCompanion(
      id: Value(id),
      code: Value(code),
      name: Value(name),
    );
  }

  factory Language.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Language(
      id: serializer.fromJson<int>(json['id']),
      code: serializer.fromJson<String>(json['code']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'code': serializer.toJson<String>(code),
      'name': serializer.toJson<String>(name),
    };
  }

  Language copyWith({int? id, String? code, String? name}) => Language(
    id: id ?? this.id,
    code: code ?? this.code,
    name: name ?? this.name,
  );
  Language copyWithCompanion(LanguagesCompanion data) {
    return Language(
      id: data.id.present ? data.id.value : this.id,
      code: data.code.present ? data.code.value : this.code,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Language(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, code, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Language &&
          other.id == this.id &&
          other.code == this.code &&
          other.name == this.name);
}

class LanguagesCompanion extends UpdateCompanion<Language> {
  final Value<int> id;
  final Value<String> code;
  final Value<String> name;
  const LanguagesCompanion({
    this.id = const Value.absent(),
    this.code = const Value.absent(),
    this.name = const Value.absent(),
  });
  LanguagesCompanion.insert({
    this.id = const Value.absent(),
    required String code,
    required String name,
  }) : code = Value(code),
       name = Value(name);
  static Insertable<Language> custom({
    Expression<int>? id,
    Expression<String>? code,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (code != null) 'code': code,
      if (name != null) 'name': name,
    });
  }

  LanguagesCompanion copyWith({
    Value<int>? id,
    Value<String>? code,
    Value<String>? name,
  }) {
    return LanguagesCompanion(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LanguagesCompanion(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $SalesInvoicesTable extends SalesInvoices
    with TableInfo<$SalesInvoicesTable, SalesInvoice> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SalesInvoicesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _invoiceUuidMeta = const VerificationMeta(
    'invoiceUuid',
  );
  @override
  late final GeneratedColumn<String> invoiceUuid = GeneratedColumn<String>(
    'invoice_uuid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _customerInfoMeta = const VerificationMeta(
    'customerInfo',
  );
  @override
  late final GeneratedColumn<String> customerInfo = GeneratedColumn<String>(
    'customer_info',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _invoiceDateMeta = const VerificationMeta(
    'invoiceDate',
  );
  @override
  late final GeneratedColumn<DateTime> invoiceDate = GeneratedColumn<DateTime>(
    'invoice_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalAmountMeta = const VerificationMeta(
    'totalAmount',
  );
  @override
  late final GeneratedColumn<double> totalAmount = GeneratedColumn<double>(
    'total_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _salesSourceMeta = const VerificationMeta(
    'salesSource',
  );
  @override
  late final GeneratedColumn<String> salesSource = GeneratedColumn<String>(
    'sales_source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('LOCAL'),
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('PENDING'),
  );
  static const VerificationMeta _userUuidMeta = const VerificationMeta(
    'userUuid',
  );
  @override
  late final GeneratedColumn<String> userUuid = GeneratedColumn<String>(
    'user_uuid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES users (user_uuid)',
    ),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<int> syncStatus = GeneratedColumn<int>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    invoiceUuid,
    customerInfo,
    invoiceDate,
    totalAmount,
    salesSource,
    status,
    userUuid,
    notes,
    syncStatus,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sales_invoices';
  @override
  VerificationContext validateIntegrity(
    Insertable<SalesInvoice> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('invoice_uuid')) {
      context.handle(
        _invoiceUuidMeta,
        invoiceUuid.isAcceptableOrUnknown(
          data['invoice_uuid']!,
          _invoiceUuidMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_invoiceUuidMeta);
    }
    if (data.containsKey('customer_info')) {
      context.handle(
        _customerInfoMeta,
        customerInfo.isAcceptableOrUnknown(
          data['customer_info']!,
          _customerInfoMeta,
        ),
      );
    }
    if (data.containsKey('invoice_date')) {
      context.handle(
        _invoiceDateMeta,
        invoiceDate.isAcceptableOrUnknown(
          data['invoice_date']!,
          _invoiceDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_invoiceDateMeta);
    }
    if (data.containsKey('total_amount')) {
      context.handle(
        _totalAmountMeta,
        totalAmount.isAcceptableOrUnknown(
          data['total_amount']!,
          _totalAmountMeta,
        ),
      );
    }
    if (data.containsKey('sales_source')) {
      context.handle(
        _salesSourceMeta,
        salesSource.isAcceptableOrUnknown(
          data['sales_source']!,
          _salesSourceMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('user_uuid')) {
      context.handle(
        _userUuidMeta,
        userUuid.isAcceptableOrUnknown(data['user_uuid']!, _userUuidMeta),
      );
    } else if (isInserting) {
      context.missing(_userUuidMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {invoiceUuid};
  @override
  SalesInvoice map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SalesInvoice(
      invoiceUuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}invoice_uuid'],
      )!,
      customerInfo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}customer_info'],
      ),
      invoiceDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}invoice_date'],
      )!,
      totalAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_amount'],
      )!,
      salesSource: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sales_source'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      userUuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_uuid'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sync_status'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $SalesInvoicesTable createAlias(String alias) {
    return $SalesInvoicesTable(attachedDatabase, alias);
  }
}

class SalesInvoice extends DataClass implements Insertable<SalesInvoice> {
  final String invoiceUuid;
  final String? customerInfo;
  final DateTime invoiceDate;
  final double totalAmount;
  final String salesSource;
  final String status;
  final String userUuid;
  final String? notes;
  final int syncStatus;
  final DateTime createdAt;
  final DateTime updatedAt;
  const SalesInvoice({
    required this.invoiceUuid,
    this.customerInfo,
    required this.invoiceDate,
    required this.totalAmount,
    required this.salesSource,
    required this.status,
    required this.userUuid,
    this.notes,
    required this.syncStatus,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['invoice_uuid'] = Variable<String>(invoiceUuid);
    if (!nullToAbsent || customerInfo != null) {
      map['customer_info'] = Variable<String>(customerInfo);
    }
    map['invoice_date'] = Variable<DateTime>(invoiceDate);
    map['total_amount'] = Variable<double>(totalAmount);
    map['sales_source'] = Variable<String>(salesSource);
    map['status'] = Variable<String>(status);
    map['user_uuid'] = Variable<String>(userUuid);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['sync_status'] = Variable<int>(syncStatus);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  SalesInvoicesCompanion toCompanion(bool nullToAbsent) {
    return SalesInvoicesCompanion(
      invoiceUuid: Value(invoiceUuid),
      customerInfo: customerInfo == null && nullToAbsent
          ? const Value.absent()
          : Value(customerInfo),
      invoiceDate: Value(invoiceDate),
      totalAmount: Value(totalAmount),
      salesSource: Value(salesSource),
      status: Value(status),
      userUuid: Value(userUuid),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      syncStatus: Value(syncStatus),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory SalesInvoice.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SalesInvoice(
      invoiceUuid: serializer.fromJson<String>(json['invoiceUuid']),
      customerInfo: serializer.fromJson<String?>(json['customerInfo']),
      invoiceDate: serializer.fromJson<DateTime>(json['invoiceDate']),
      totalAmount: serializer.fromJson<double>(json['totalAmount']),
      salesSource: serializer.fromJson<String>(json['salesSource']),
      status: serializer.fromJson<String>(json['status']),
      userUuid: serializer.fromJson<String>(json['userUuid']),
      notes: serializer.fromJson<String?>(json['notes']),
      syncStatus: serializer.fromJson<int>(json['syncStatus']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'invoiceUuid': serializer.toJson<String>(invoiceUuid),
      'customerInfo': serializer.toJson<String?>(customerInfo),
      'invoiceDate': serializer.toJson<DateTime>(invoiceDate),
      'totalAmount': serializer.toJson<double>(totalAmount),
      'salesSource': serializer.toJson<String>(salesSource),
      'status': serializer.toJson<String>(status),
      'userUuid': serializer.toJson<String>(userUuid),
      'notes': serializer.toJson<String?>(notes),
      'syncStatus': serializer.toJson<int>(syncStatus),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  SalesInvoice copyWith({
    String? invoiceUuid,
    Value<String?> customerInfo = const Value.absent(),
    DateTime? invoiceDate,
    double? totalAmount,
    String? salesSource,
    String? status,
    String? userUuid,
    Value<String?> notes = const Value.absent(),
    int? syncStatus,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => SalesInvoice(
    invoiceUuid: invoiceUuid ?? this.invoiceUuid,
    customerInfo: customerInfo.present ? customerInfo.value : this.customerInfo,
    invoiceDate: invoiceDate ?? this.invoiceDate,
    totalAmount: totalAmount ?? this.totalAmount,
    salesSource: salesSource ?? this.salesSource,
    status: status ?? this.status,
    userUuid: userUuid ?? this.userUuid,
    notes: notes.present ? notes.value : this.notes,
    syncStatus: syncStatus ?? this.syncStatus,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  SalesInvoice copyWithCompanion(SalesInvoicesCompanion data) {
    return SalesInvoice(
      invoiceUuid: data.invoiceUuid.present
          ? data.invoiceUuid.value
          : this.invoiceUuid,
      customerInfo: data.customerInfo.present
          ? data.customerInfo.value
          : this.customerInfo,
      invoiceDate: data.invoiceDate.present
          ? data.invoiceDate.value
          : this.invoiceDate,
      totalAmount: data.totalAmount.present
          ? data.totalAmount.value
          : this.totalAmount,
      salesSource: data.salesSource.present
          ? data.salesSource.value
          : this.salesSource,
      status: data.status.present ? data.status.value : this.status,
      userUuid: data.userUuid.present ? data.userUuid.value : this.userUuid,
      notes: data.notes.present ? data.notes.value : this.notes,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SalesInvoice(')
          ..write('invoiceUuid: $invoiceUuid, ')
          ..write('customerInfo: $customerInfo, ')
          ..write('invoiceDate: $invoiceDate, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('salesSource: $salesSource, ')
          ..write('status: $status, ')
          ..write('userUuid: $userUuid, ')
          ..write('notes: $notes, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    invoiceUuid,
    customerInfo,
    invoiceDate,
    totalAmount,
    salesSource,
    status,
    userUuid,
    notes,
    syncStatus,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SalesInvoice &&
          other.invoiceUuid == this.invoiceUuid &&
          other.customerInfo == this.customerInfo &&
          other.invoiceDate == this.invoiceDate &&
          other.totalAmount == this.totalAmount &&
          other.salesSource == this.salesSource &&
          other.status == this.status &&
          other.userUuid == this.userUuid &&
          other.notes == this.notes &&
          other.syncStatus == this.syncStatus &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class SalesInvoicesCompanion extends UpdateCompanion<SalesInvoice> {
  final Value<String> invoiceUuid;
  final Value<String?> customerInfo;
  final Value<DateTime> invoiceDate;
  final Value<double> totalAmount;
  final Value<String> salesSource;
  final Value<String> status;
  final Value<String> userUuid;
  final Value<String?> notes;
  final Value<int> syncStatus;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const SalesInvoicesCompanion({
    this.invoiceUuid = const Value.absent(),
    this.customerInfo = const Value.absent(),
    this.invoiceDate = const Value.absent(),
    this.totalAmount = const Value.absent(),
    this.salesSource = const Value.absent(),
    this.status = const Value.absent(),
    this.userUuid = const Value.absent(),
    this.notes = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SalesInvoicesCompanion.insert({
    required String invoiceUuid,
    this.customerInfo = const Value.absent(),
    required DateTime invoiceDate,
    this.totalAmount = const Value.absent(),
    this.salesSource = const Value.absent(),
    this.status = const Value.absent(),
    required String userUuid,
    this.notes = const Value.absent(),
    this.syncStatus = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : invoiceUuid = Value(invoiceUuid),
       invoiceDate = Value(invoiceDate),
       userUuid = Value(userUuid),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<SalesInvoice> custom({
    Expression<String>? invoiceUuid,
    Expression<String>? customerInfo,
    Expression<DateTime>? invoiceDate,
    Expression<double>? totalAmount,
    Expression<String>? salesSource,
    Expression<String>? status,
    Expression<String>? userUuid,
    Expression<String>? notes,
    Expression<int>? syncStatus,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (invoiceUuid != null) 'invoice_uuid': invoiceUuid,
      if (customerInfo != null) 'customer_info': customerInfo,
      if (invoiceDate != null) 'invoice_date': invoiceDate,
      if (totalAmount != null) 'total_amount': totalAmount,
      if (salesSource != null) 'sales_source': salesSource,
      if (status != null) 'status': status,
      if (userUuid != null) 'user_uuid': userUuid,
      if (notes != null) 'notes': notes,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SalesInvoicesCompanion copyWith({
    Value<String>? invoiceUuid,
    Value<String?>? customerInfo,
    Value<DateTime>? invoiceDate,
    Value<double>? totalAmount,
    Value<String>? salesSource,
    Value<String>? status,
    Value<String>? userUuid,
    Value<String?>? notes,
    Value<int>? syncStatus,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return SalesInvoicesCompanion(
      invoiceUuid: invoiceUuid ?? this.invoiceUuid,
      customerInfo: customerInfo ?? this.customerInfo,
      invoiceDate: invoiceDate ?? this.invoiceDate,
      totalAmount: totalAmount ?? this.totalAmount,
      salesSource: salesSource ?? this.salesSource,
      status: status ?? this.status,
      userUuid: userUuid ?? this.userUuid,
      notes: notes ?? this.notes,
      syncStatus: syncStatus ?? this.syncStatus,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (invoiceUuid.present) {
      map['invoice_uuid'] = Variable<String>(invoiceUuid.value);
    }
    if (customerInfo.present) {
      map['customer_info'] = Variable<String>(customerInfo.value);
    }
    if (invoiceDate.present) {
      map['invoice_date'] = Variable<DateTime>(invoiceDate.value);
    }
    if (totalAmount.present) {
      map['total_amount'] = Variable<double>(totalAmount.value);
    }
    if (salesSource.present) {
      map['sales_source'] = Variable<String>(salesSource.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (userUuid.present) {
      map['user_uuid'] = Variable<String>(userUuid.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<int>(syncStatus.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SalesInvoicesCompanion(')
          ..write('invoiceUuid: $invoiceUuid, ')
          ..write('customerInfo: $customerInfo, ')
          ..write('invoiceDate: $invoiceDate, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('salesSource: $salesSource, ')
          ..write('status: $status, ')
          ..write('userUuid: $userUuid, ')
          ..write('notes: $notes, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SalesItemsTable extends SalesItems
    with TableInfo<$SalesItemsTable, SalesItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SalesItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _itemUuidMeta = const VerificationMeta(
    'itemUuid',
  );
  @override
  late final GeneratedColumn<String> itemUuid = GeneratedColumn<String>(
    'item_uuid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _invoiceUuidMeta = const VerificationMeta(
    'invoiceUuid',
  );
  @override
  late final GeneratedColumn<String> invoiceUuid = GeneratedColumn<String>(
    'invoice_uuid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES sales_invoices (invoice_uuid)',
    ),
  );
  static const VerificationMeta _productUuidMeta = const VerificationMeta(
    'productUuid',
  );
  @override
  late final GeneratedColumn<String> productUuid = GeneratedColumn<String>(
    'product_uuid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES products (product_uuid)',
    ),
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitSellPriceMeta = const VerificationMeta(
    'unitSellPrice',
  );
  @override
  late final GeneratedColumn<double> unitSellPrice = GeneratedColumn<double>(
    'unit_sell_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _costAtSaleMeta = const VerificationMeta(
    'costAtSale',
  );
  @override
  late final GeneratedColumn<double> costAtSale = GeneratedColumn<double>(
    'cost_at_sale',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalPriceMeta = const VerificationMeta(
    'totalPrice',
  );
  @override
  late final GeneratedColumn<double> totalPrice = GeneratedColumn<double>(
    'total_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _profitMeta = const VerificationMeta('profit');
  @override
  late final GeneratedColumn<double> profit = GeneratedColumn<double>(
    'profit',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _exchangeRateAtSaleMeta =
      const VerificationMeta('exchangeRateAtSale');
  @override
  late final GeneratedColumn<double> exchangeRateAtSale =
      GeneratedColumn<double>(
        'exchange_rate_at_sale',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _costExchangeRateMeta = const VerificationMeta(
    'costExchangeRate',
  );
  @override
  late final GeneratedColumn<double> costExchangeRate = GeneratedColumn<double>(
    'cost_exchange_rate',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _profitIrrMeta = const VerificationMeta(
    'profitIrr',
  );
  @override
  late final GeneratedColumn<double> profitIrr = GeneratedColumn<double>(
    'profit_irr',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    itemUuid,
    invoiceUuid,
    productUuid,
    quantity,
    unitSellPrice,
    costAtSale,
    totalPrice,
    profit,
    exchangeRateAtSale,
    costExchangeRate,
    profitIrr,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sales_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<SalesItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('item_uuid')) {
      context.handle(
        _itemUuidMeta,
        itemUuid.isAcceptableOrUnknown(data['item_uuid']!, _itemUuidMeta),
      );
    } else if (isInserting) {
      context.missing(_itemUuidMeta);
    }
    if (data.containsKey('invoice_uuid')) {
      context.handle(
        _invoiceUuidMeta,
        invoiceUuid.isAcceptableOrUnknown(
          data['invoice_uuid']!,
          _invoiceUuidMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_invoiceUuidMeta);
    }
    if (data.containsKey('product_uuid')) {
      context.handle(
        _productUuidMeta,
        productUuid.isAcceptableOrUnknown(
          data['product_uuid']!,
          _productUuidMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_productUuidMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('unit_sell_price')) {
      context.handle(
        _unitSellPriceMeta,
        unitSellPrice.isAcceptableOrUnknown(
          data['unit_sell_price']!,
          _unitSellPriceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_unitSellPriceMeta);
    }
    if (data.containsKey('cost_at_sale')) {
      context.handle(
        _costAtSaleMeta,
        costAtSale.isAcceptableOrUnknown(
          data['cost_at_sale']!,
          _costAtSaleMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_costAtSaleMeta);
    }
    if (data.containsKey('total_price')) {
      context.handle(
        _totalPriceMeta,
        totalPrice.isAcceptableOrUnknown(data['total_price']!, _totalPriceMeta),
      );
    } else if (isInserting) {
      context.missing(_totalPriceMeta);
    }
    if (data.containsKey('profit')) {
      context.handle(
        _profitMeta,
        profit.isAcceptableOrUnknown(data['profit']!, _profitMeta),
      );
    } else if (isInserting) {
      context.missing(_profitMeta);
    }
    if (data.containsKey('exchange_rate_at_sale')) {
      context.handle(
        _exchangeRateAtSaleMeta,
        exchangeRateAtSale.isAcceptableOrUnknown(
          data['exchange_rate_at_sale']!,
          _exchangeRateAtSaleMeta,
        ),
      );
    }
    if (data.containsKey('cost_exchange_rate')) {
      context.handle(
        _costExchangeRateMeta,
        costExchangeRate.isAcceptableOrUnknown(
          data['cost_exchange_rate']!,
          _costExchangeRateMeta,
        ),
      );
    }
    if (data.containsKey('profit_irr')) {
      context.handle(
        _profitIrrMeta,
        profitIrr.isAcceptableOrUnknown(data['profit_irr']!, _profitIrrMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {itemUuid};
  @override
  SalesItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SalesItem(
      itemUuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}item_uuid'],
      )!,
      invoiceUuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}invoice_uuid'],
      )!,
      productUuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_uuid'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity'],
      )!,
      unitSellPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}unit_sell_price'],
      )!,
      costAtSale: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}cost_at_sale'],
      )!,
      totalPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_price'],
      )!,
      profit: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}profit'],
      )!,
      exchangeRateAtSale: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}exchange_rate_at_sale'],
      ),
      costExchangeRate: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}cost_exchange_rate'],
      ),
      profitIrr: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}profit_irr'],
      ),
    );
  }

  @override
  $SalesItemsTable createAlias(String alias) {
    return $SalesItemsTable(attachedDatabase, alias);
  }
}

class SalesItem extends DataClass implements Insertable<SalesItem> {
  final String itemUuid;
  final String invoiceUuid;
  final String productUuid;
  final int quantity;
  final double unitSellPrice;
  final double costAtSale;
  final double totalPrice;
  final double profit;
  final double? exchangeRateAtSale;
  final double? costExchangeRate;
  final double? profitIrr;
  const SalesItem({
    required this.itemUuid,
    required this.invoiceUuid,
    required this.productUuid,
    required this.quantity,
    required this.unitSellPrice,
    required this.costAtSale,
    required this.totalPrice,
    required this.profit,
    this.exchangeRateAtSale,
    this.costExchangeRate,
    this.profitIrr,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['item_uuid'] = Variable<String>(itemUuid);
    map['invoice_uuid'] = Variable<String>(invoiceUuid);
    map['product_uuid'] = Variable<String>(productUuid);
    map['quantity'] = Variable<int>(quantity);
    map['unit_sell_price'] = Variable<double>(unitSellPrice);
    map['cost_at_sale'] = Variable<double>(costAtSale);
    map['total_price'] = Variable<double>(totalPrice);
    map['profit'] = Variable<double>(profit);
    if (!nullToAbsent || exchangeRateAtSale != null) {
      map['exchange_rate_at_sale'] = Variable<double>(exchangeRateAtSale);
    }
    if (!nullToAbsent || costExchangeRate != null) {
      map['cost_exchange_rate'] = Variable<double>(costExchangeRate);
    }
    if (!nullToAbsent || profitIrr != null) {
      map['profit_irr'] = Variable<double>(profitIrr);
    }
    return map;
  }

  SalesItemsCompanion toCompanion(bool nullToAbsent) {
    return SalesItemsCompanion(
      itemUuid: Value(itemUuid),
      invoiceUuid: Value(invoiceUuid),
      productUuid: Value(productUuid),
      quantity: Value(quantity),
      unitSellPrice: Value(unitSellPrice),
      costAtSale: Value(costAtSale),
      totalPrice: Value(totalPrice),
      profit: Value(profit),
      exchangeRateAtSale: exchangeRateAtSale == null && nullToAbsent
          ? const Value.absent()
          : Value(exchangeRateAtSale),
      costExchangeRate: costExchangeRate == null && nullToAbsent
          ? const Value.absent()
          : Value(costExchangeRate),
      profitIrr: profitIrr == null && nullToAbsent
          ? const Value.absent()
          : Value(profitIrr),
    );
  }

  factory SalesItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SalesItem(
      itemUuid: serializer.fromJson<String>(json['itemUuid']),
      invoiceUuid: serializer.fromJson<String>(json['invoiceUuid']),
      productUuid: serializer.fromJson<String>(json['productUuid']),
      quantity: serializer.fromJson<int>(json['quantity']),
      unitSellPrice: serializer.fromJson<double>(json['unitSellPrice']),
      costAtSale: serializer.fromJson<double>(json['costAtSale']),
      totalPrice: serializer.fromJson<double>(json['totalPrice']),
      profit: serializer.fromJson<double>(json['profit']),
      exchangeRateAtSale: serializer.fromJson<double?>(
        json['exchangeRateAtSale'],
      ),
      costExchangeRate: serializer.fromJson<double?>(json['costExchangeRate']),
      profitIrr: serializer.fromJson<double?>(json['profitIrr']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'itemUuid': serializer.toJson<String>(itemUuid),
      'invoiceUuid': serializer.toJson<String>(invoiceUuid),
      'productUuid': serializer.toJson<String>(productUuid),
      'quantity': serializer.toJson<int>(quantity),
      'unitSellPrice': serializer.toJson<double>(unitSellPrice),
      'costAtSale': serializer.toJson<double>(costAtSale),
      'totalPrice': serializer.toJson<double>(totalPrice),
      'profit': serializer.toJson<double>(profit),
      'exchangeRateAtSale': serializer.toJson<double?>(exchangeRateAtSale),
      'costExchangeRate': serializer.toJson<double?>(costExchangeRate),
      'profitIrr': serializer.toJson<double?>(profitIrr),
    };
  }

  SalesItem copyWith({
    String? itemUuid,
    String? invoiceUuid,
    String? productUuid,
    int? quantity,
    double? unitSellPrice,
    double? costAtSale,
    double? totalPrice,
    double? profit,
    Value<double?> exchangeRateAtSale = const Value.absent(),
    Value<double?> costExchangeRate = const Value.absent(),
    Value<double?> profitIrr = const Value.absent(),
  }) => SalesItem(
    itemUuid: itemUuid ?? this.itemUuid,
    invoiceUuid: invoiceUuid ?? this.invoiceUuid,
    productUuid: productUuid ?? this.productUuid,
    quantity: quantity ?? this.quantity,
    unitSellPrice: unitSellPrice ?? this.unitSellPrice,
    costAtSale: costAtSale ?? this.costAtSale,
    totalPrice: totalPrice ?? this.totalPrice,
    profit: profit ?? this.profit,
    exchangeRateAtSale: exchangeRateAtSale.present
        ? exchangeRateAtSale.value
        : this.exchangeRateAtSale,
    costExchangeRate: costExchangeRate.present
        ? costExchangeRate.value
        : this.costExchangeRate,
    profitIrr: profitIrr.present ? profitIrr.value : this.profitIrr,
  );
  SalesItem copyWithCompanion(SalesItemsCompanion data) {
    return SalesItem(
      itemUuid: data.itemUuid.present ? data.itemUuid.value : this.itemUuid,
      invoiceUuid: data.invoiceUuid.present
          ? data.invoiceUuid.value
          : this.invoiceUuid,
      productUuid: data.productUuid.present
          ? data.productUuid.value
          : this.productUuid,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      unitSellPrice: data.unitSellPrice.present
          ? data.unitSellPrice.value
          : this.unitSellPrice,
      costAtSale: data.costAtSale.present
          ? data.costAtSale.value
          : this.costAtSale,
      totalPrice: data.totalPrice.present
          ? data.totalPrice.value
          : this.totalPrice,
      profit: data.profit.present ? data.profit.value : this.profit,
      exchangeRateAtSale: data.exchangeRateAtSale.present
          ? data.exchangeRateAtSale.value
          : this.exchangeRateAtSale,
      costExchangeRate: data.costExchangeRate.present
          ? data.costExchangeRate.value
          : this.costExchangeRate,
      profitIrr: data.profitIrr.present ? data.profitIrr.value : this.profitIrr,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SalesItem(')
          ..write('itemUuid: $itemUuid, ')
          ..write('invoiceUuid: $invoiceUuid, ')
          ..write('productUuid: $productUuid, ')
          ..write('quantity: $quantity, ')
          ..write('unitSellPrice: $unitSellPrice, ')
          ..write('costAtSale: $costAtSale, ')
          ..write('totalPrice: $totalPrice, ')
          ..write('profit: $profit, ')
          ..write('exchangeRateAtSale: $exchangeRateAtSale, ')
          ..write('costExchangeRate: $costExchangeRate, ')
          ..write('profitIrr: $profitIrr')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    itemUuid,
    invoiceUuid,
    productUuid,
    quantity,
    unitSellPrice,
    costAtSale,
    totalPrice,
    profit,
    exchangeRateAtSale,
    costExchangeRate,
    profitIrr,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SalesItem &&
          other.itemUuid == this.itemUuid &&
          other.invoiceUuid == this.invoiceUuid &&
          other.productUuid == this.productUuid &&
          other.quantity == this.quantity &&
          other.unitSellPrice == this.unitSellPrice &&
          other.costAtSale == this.costAtSale &&
          other.totalPrice == this.totalPrice &&
          other.profit == this.profit &&
          other.exchangeRateAtSale == this.exchangeRateAtSale &&
          other.costExchangeRate == this.costExchangeRate &&
          other.profitIrr == this.profitIrr);
}

class SalesItemsCompanion extends UpdateCompanion<SalesItem> {
  final Value<String> itemUuid;
  final Value<String> invoiceUuid;
  final Value<String> productUuid;
  final Value<int> quantity;
  final Value<double> unitSellPrice;
  final Value<double> costAtSale;
  final Value<double> totalPrice;
  final Value<double> profit;
  final Value<double?> exchangeRateAtSale;
  final Value<double?> costExchangeRate;
  final Value<double?> profitIrr;
  final Value<int> rowid;
  const SalesItemsCompanion({
    this.itemUuid = const Value.absent(),
    this.invoiceUuid = const Value.absent(),
    this.productUuid = const Value.absent(),
    this.quantity = const Value.absent(),
    this.unitSellPrice = const Value.absent(),
    this.costAtSale = const Value.absent(),
    this.totalPrice = const Value.absent(),
    this.profit = const Value.absent(),
    this.exchangeRateAtSale = const Value.absent(),
    this.costExchangeRate = const Value.absent(),
    this.profitIrr = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SalesItemsCompanion.insert({
    required String itemUuid,
    required String invoiceUuid,
    required String productUuid,
    required int quantity,
    required double unitSellPrice,
    required double costAtSale,
    required double totalPrice,
    required double profit,
    this.exchangeRateAtSale = const Value.absent(),
    this.costExchangeRate = const Value.absent(),
    this.profitIrr = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : itemUuid = Value(itemUuid),
       invoiceUuid = Value(invoiceUuid),
       productUuid = Value(productUuid),
       quantity = Value(quantity),
       unitSellPrice = Value(unitSellPrice),
       costAtSale = Value(costAtSale),
       totalPrice = Value(totalPrice),
       profit = Value(profit);
  static Insertable<SalesItem> custom({
    Expression<String>? itemUuid,
    Expression<String>? invoiceUuid,
    Expression<String>? productUuid,
    Expression<int>? quantity,
    Expression<double>? unitSellPrice,
    Expression<double>? costAtSale,
    Expression<double>? totalPrice,
    Expression<double>? profit,
    Expression<double>? exchangeRateAtSale,
    Expression<double>? costExchangeRate,
    Expression<double>? profitIrr,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (itemUuid != null) 'item_uuid': itemUuid,
      if (invoiceUuid != null) 'invoice_uuid': invoiceUuid,
      if (productUuid != null) 'product_uuid': productUuid,
      if (quantity != null) 'quantity': quantity,
      if (unitSellPrice != null) 'unit_sell_price': unitSellPrice,
      if (costAtSale != null) 'cost_at_sale': costAtSale,
      if (totalPrice != null) 'total_price': totalPrice,
      if (profit != null) 'profit': profit,
      if (exchangeRateAtSale != null)
        'exchange_rate_at_sale': exchangeRateAtSale,
      if (costExchangeRate != null) 'cost_exchange_rate': costExchangeRate,
      if (profitIrr != null) 'profit_irr': profitIrr,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SalesItemsCompanion copyWith({
    Value<String>? itemUuid,
    Value<String>? invoiceUuid,
    Value<String>? productUuid,
    Value<int>? quantity,
    Value<double>? unitSellPrice,
    Value<double>? costAtSale,
    Value<double>? totalPrice,
    Value<double>? profit,
    Value<double?>? exchangeRateAtSale,
    Value<double?>? costExchangeRate,
    Value<double?>? profitIrr,
    Value<int>? rowid,
  }) {
    return SalesItemsCompanion(
      itemUuid: itemUuid ?? this.itemUuid,
      invoiceUuid: invoiceUuid ?? this.invoiceUuid,
      productUuid: productUuid ?? this.productUuid,
      quantity: quantity ?? this.quantity,
      unitSellPrice: unitSellPrice ?? this.unitSellPrice,
      costAtSale: costAtSale ?? this.costAtSale,
      totalPrice: totalPrice ?? this.totalPrice,
      profit: profit ?? this.profit,
      exchangeRateAtSale: exchangeRateAtSale ?? this.exchangeRateAtSale,
      costExchangeRate: costExchangeRate ?? this.costExchangeRate,
      profitIrr: profitIrr ?? this.profitIrr,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (itemUuid.present) {
      map['item_uuid'] = Variable<String>(itemUuid.value);
    }
    if (invoiceUuid.present) {
      map['invoice_uuid'] = Variable<String>(invoiceUuid.value);
    }
    if (productUuid.present) {
      map['product_uuid'] = Variable<String>(productUuid.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (unitSellPrice.present) {
      map['unit_sell_price'] = Variable<double>(unitSellPrice.value);
    }
    if (costAtSale.present) {
      map['cost_at_sale'] = Variable<double>(costAtSale.value);
    }
    if (totalPrice.present) {
      map['total_price'] = Variable<double>(totalPrice.value);
    }
    if (profit.present) {
      map['profit'] = Variable<double>(profit.value);
    }
    if (exchangeRateAtSale.present) {
      map['exchange_rate_at_sale'] = Variable<double>(exchangeRateAtSale.value);
    }
    if (costExchangeRate.present) {
      map['cost_exchange_rate'] = Variable<double>(costExchangeRate.value);
    }
    if (profitIrr.present) {
      map['profit_irr'] = Variable<double>(profitIrr.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SalesItemsCompanion(')
          ..write('itemUuid: $itemUuid, ')
          ..write('invoiceUuid: $invoiceUuid, ')
          ..write('productUuid: $productUuid, ')
          ..write('quantity: $quantity, ')
          ..write('unitSellPrice: $unitSellPrice, ')
          ..write('costAtSale: $costAtSale, ')
          ..write('totalPrice: $totalPrice, ')
          ..write('profit: $profit, ')
          ..write('exchangeRateAtSale: $exchangeRateAtSale, ')
          ..write('costExchangeRate: $costExchangeRate, ')
          ..write('profitIrr: $profitIrr, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PurchaseInvoicesTable extends PurchaseInvoices
    with TableInfo<$PurchaseInvoicesTable, PurchaseInvoice> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PurchaseInvoicesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _purchaseUuidMeta = const VerificationMeta(
    'purchaseUuid',
  );
  @override
  late final GeneratedColumn<String> purchaseUuid = GeneratedColumn<String>(
    'purchase_uuid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _supplierNameMeta = const VerificationMeta(
    'supplierName',
  );
  @override
  late final GeneratedColumn<String> supplierName = GeneratedColumn<String>(
    'supplier_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _purchaseDateMeta = const VerificationMeta(
    'purchaseDate',
  );
  @override
  late final GeneratedColumn<DateTime> purchaseDate = GeneratedColumn<DateTime>(
    'purchase_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalCostMeta = const VerificationMeta(
    'totalCost',
  );
  @override
  late final GeneratedColumn<double> totalCost = GeneratedColumn<double>(
    'total_cost',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _additionalCostsMeta = const VerificationMeta(
    'additionalCosts',
  );
  @override
  late final GeneratedColumn<double> additionalCosts = GeneratedColumn<double>(
    'additional_costs',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _finalTotalMeta = const VerificationMeta(
    'finalTotal',
  );
  @override
  late final GeneratedColumn<double> finalTotal = GeneratedColumn<double>(
    'final_total',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<int> syncStatus = GeneratedColumn<int>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    purchaseUuid,
    supplierName,
    purchaseDate,
    totalCost,
    additionalCosts,
    finalTotal,
    notes,
    syncStatus,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'purchase_invoices';
  @override
  VerificationContext validateIntegrity(
    Insertable<PurchaseInvoice> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('purchase_uuid')) {
      context.handle(
        _purchaseUuidMeta,
        purchaseUuid.isAcceptableOrUnknown(
          data['purchase_uuid']!,
          _purchaseUuidMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_purchaseUuidMeta);
    }
    if (data.containsKey('supplier_name')) {
      context.handle(
        _supplierNameMeta,
        supplierName.isAcceptableOrUnknown(
          data['supplier_name']!,
          _supplierNameMeta,
        ),
      );
    }
    if (data.containsKey('purchase_date')) {
      context.handle(
        _purchaseDateMeta,
        purchaseDate.isAcceptableOrUnknown(
          data['purchase_date']!,
          _purchaseDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_purchaseDateMeta);
    }
    if (data.containsKey('total_cost')) {
      context.handle(
        _totalCostMeta,
        totalCost.isAcceptableOrUnknown(data['total_cost']!, _totalCostMeta),
      );
    }
    if (data.containsKey('additional_costs')) {
      context.handle(
        _additionalCostsMeta,
        additionalCosts.isAcceptableOrUnknown(
          data['additional_costs']!,
          _additionalCostsMeta,
        ),
      );
    }
    if (data.containsKey('final_total')) {
      context.handle(
        _finalTotalMeta,
        finalTotal.isAcceptableOrUnknown(data['final_total']!, _finalTotalMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {purchaseUuid};
  @override
  PurchaseInvoice map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PurchaseInvoice(
      purchaseUuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}purchase_uuid'],
      )!,
      supplierName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}supplier_name'],
      ),
      purchaseDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}purchase_date'],
      )!,
      totalCost: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_cost'],
      )!,
      additionalCosts: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}additional_costs'],
      )!,
      finalTotal: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}final_total'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sync_status'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $PurchaseInvoicesTable createAlias(String alias) {
    return $PurchaseInvoicesTable(attachedDatabase, alias);
  }
}

class PurchaseInvoice extends DataClass implements Insertable<PurchaseInvoice> {
  final String purchaseUuid;
  final String? supplierName;
  final DateTime purchaseDate;
  final double totalCost;
  final double additionalCosts;
  final double finalTotal;
  final String? notes;
  final int syncStatus;
  final DateTime createdAt;
  final DateTime updatedAt;
  const PurchaseInvoice({
    required this.purchaseUuid,
    this.supplierName,
    required this.purchaseDate,
    required this.totalCost,
    required this.additionalCosts,
    required this.finalTotal,
    this.notes,
    required this.syncStatus,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['purchase_uuid'] = Variable<String>(purchaseUuid);
    if (!nullToAbsent || supplierName != null) {
      map['supplier_name'] = Variable<String>(supplierName);
    }
    map['purchase_date'] = Variable<DateTime>(purchaseDate);
    map['total_cost'] = Variable<double>(totalCost);
    map['additional_costs'] = Variable<double>(additionalCosts);
    map['final_total'] = Variable<double>(finalTotal);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['sync_status'] = Variable<int>(syncStatus);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  PurchaseInvoicesCompanion toCompanion(bool nullToAbsent) {
    return PurchaseInvoicesCompanion(
      purchaseUuid: Value(purchaseUuid),
      supplierName: supplierName == null && nullToAbsent
          ? const Value.absent()
          : Value(supplierName),
      purchaseDate: Value(purchaseDate),
      totalCost: Value(totalCost),
      additionalCosts: Value(additionalCosts),
      finalTotal: Value(finalTotal),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      syncStatus: Value(syncStatus),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory PurchaseInvoice.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PurchaseInvoice(
      purchaseUuid: serializer.fromJson<String>(json['purchaseUuid']),
      supplierName: serializer.fromJson<String?>(json['supplierName']),
      purchaseDate: serializer.fromJson<DateTime>(json['purchaseDate']),
      totalCost: serializer.fromJson<double>(json['totalCost']),
      additionalCosts: serializer.fromJson<double>(json['additionalCosts']),
      finalTotal: serializer.fromJson<double>(json['finalTotal']),
      notes: serializer.fromJson<String?>(json['notes']),
      syncStatus: serializer.fromJson<int>(json['syncStatus']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'purchaseUuid': serializer.toJson<String>(purchaseUuid),
      'supplierName': serializer.toJson<String?>(supplierName),
      'purchaseDate': serializer.toJson<DateTime>(purchaseDate),
      'totalCost': serializer.toJson<double>(totalCost),
      'additionalCosts': serializer.toJson<double>(additionalCosts),
      'finalTotal': serializer.toJson<double>(finalTotal),
      'notes': serializer.toJson<String?>(notes),
      'syncStatus': serializer.toJson<int>(syncStatus),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  PurchaseInvoice copyWith({
    String? purchaseUuid,
    Value<String?> supplierName = const Value.absent(),
    DateTime? purchaseDate,
    double? totalCost,
    double? additionalCosts,
    double? finalTotal,
    Value<String?> notes = const Value.absent(),
    int? syncStatus,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => PurchaseInvoice(
    purchaseUuid: purchaseUuid ?? this.purchaseUuid,
    supplierName: supplierName.present ? supplierName.value : this.supplierName,
    purchaseDate: purchaseDate ?? this.purchaseDate,
    totalCost: totalCost ?? this.totalCost,
    additionalCosts: additionalCosts ?? this.additionalCosts,
    finalTotal: finalTotal ?? this.finalTotal,
    notes: notes.present ? notes.value : this.notes,
    syncStatus: syncStatus ?? this.syncStatus,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  PurchaseInvoice copyWithCompanion(PurchaseInvoicesCompanion data) {
    return PurchaseInvoice(
      purchaseUuid: data.purchaseUuid.present
          ? data.purchaseUuid.value
          : this.purchaseUuid,
      supplierName: data.supplierName.present
          ? data.supplierName.value
          : this.supplierName,
      purchaseDate: data.purchaseDate.present
          ? data.purchaseDate.value
          : this.purchaseDate,
      totalCost: data.totalCost.present ? data.totalCost.value : this.totalCost,
      additionalCosts: data.additionalCosts.present
          ? data.additionalCosts.value
          : this.additionalCosts,
      finalTotal: data.finalTotal.present
          ? data.finalTotal.value
          : this.finalTotal,
      notes: data.notes.present ? data.notes.value : this.notes,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PurchaseInvoice(')
          ..write('purchaseUuid: $purchaseUuid, ')
          ..write('supplierName: $supplierName, ')
          ..write('purchaseDate: $purchaseDate, ')
          ..write('totalCost: $totalCost, ')
          ..write('additionalCosts: $additionalCosts, ')
          ..write('finalTotal: $finalTotal, ')
          ..write('notes: $notes, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    purchaseUuid,
    supplierName,
    purchaseDate,
    totalCost,
    additionalCosts,
    finalTotal,
    notes,
    syncStatus,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PurchaseInvoice &&
          other.purchaseUuid == this.purchaseUuid &&
          other.supplierName == this.supplierName &&
          other.purchaseDate == this.purchaseDate &&
          other.totalCost == this.totalCost &&
          other.additionalCosts == this.additionalCosts &&
          other.finalTotal == this.finalTotal &&
          other.notes == this.notes &&
          other.syncStatus == this.syncStatus &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class PurchaseInvoicesCompanion extends UpdateCompanion<PurchaseInvoice> {
  final Value<String> purchaseUuid;
  final Value<String?> supplierName;
  final Value<DateTime> purchaseDate;
  final Value<double> totalCost;
  final Value<double> additionalCosts;
  final Value<double> finalTotal;
  final Value<String?> notes;
  final Value<int> syncStatus;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const PurchaseInvoicesCompanion({
    this.purchaseUuid = const Value.absent(),
    this.supplierName = const Value.absent(),
    this.purchaseDate = const Value.absent(),
    this.totalCost = const Value.absent(),
    this.additionalCosts = const Value.absent(),
    this.finalTotal = const Value.absent(),
    this.notes = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PurchaseInvoicesCompanion.insert({
    required String purchaseUuid,
    this.supplierName = const Value.absent(),
    required DateTime purchaseDate,
    this.totalCost = const Value.absent(),
    this.additionalCosts = const Value.absent(),
    this.finalTotal = const Value.absent(),
    this.notes = const Value.absent(),
    this.syncStatus = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : purchaseUuid = Value(purchaseUuid),
       purchaseDate = Value(purchaseDate),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<PurchaseInvoice> custom({
    Expression<String>? purchaseUuid,
    Expression<String>? supplierName,
    Expression<DateTime>? purchaseDate,
    Expression<double>? totalCost,
    Expression<double>? additionalCosts,
    Expression<double>? finalTotal,
    Expression<String>? notes,
    Expression<int>? syncStatus,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (purchaseUuid != null) 'purchase_uuid': purchaseUuid,
      if (supplierName != null) 'supplier_name': supplierName,
      if (purchaseDate != null) 'purchase_date': purchaseDate,
      if (totalCost != null) 'total_cost': totalCost,
      if (additionalCosts != null) 'additional_costs': additionalCosts,
      if (finalTotal != null) 'final_total': finalTotal,
      if (notes != null) 'notes': notes,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PurchaseInvoicesCompanion copyWith({
    Value<String>? purchaseUuid,
    Value<String?>? supplierName,
    Value<DateTime>? purchaseDate,
    Value<double>? totalCost,
    Value<double>? additionalCosts,
    Value<double>? finalTotal,
    Value<String?>? notes,
    Value<int>? syncStatus,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return PurchaseInvoicesCompanion(
      purchaseUuid: purchaseUuid ?? this.purchaseUuid,
      supplierName: supplierName ?? this.supplierName,
      purchaseDate: purchaseDate ?? this.purchaseDate,
      totalCost: totalCost ?? this.totalCost,
      additionalCosts: additionalCosts ?? this.additionalCosts,
      finalTotal: finalTotal ?? this.finalTotal,
      notes: notes ?? this.notes,
      syncStatus: syncStatus ?? this.syncStatus,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (purchaseUuid.present) {
      map['purchase_uuid'] = Variable<String>(purchaseUuid.value);
    }
    if (supplierName.present) {
      map['supplier_name'] = Variable<String>(supplierName.value);
    }
    if (purchaseDate.present) {
      map['purchase_date'] = Variable<DateTime>(purchaseDate.value);
    }
    if (totalCost.present) {
      map['total_cost'] = Variable<double>(totalCost.value);
    }
    if (additionalCosts.present) {
      map['additional_costs'] = Variable<double>(additionalCosts.value);
    }
    if (finalTotal.present) {
      map['final_total'] = Variable<double>(finalTotal.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<int>(syncStatus.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PurchaseInvoicesCompanion(')
          ..write('purchaseUuid: $purchaseUuid, ')
          ..write('supplierName: $supplierName, ')
          ..write('purchaseDate: $purchaseDate, ')
          ..write('totalCost: $totalCost, ')
          ..write('additionalCosts: $additionalCosts, ')
          ..write('finalTotal: $finalTotal, ')
          ..write('notes: $notes, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PurchaseItemsTable extends PurchaseItems
    with TableInfo<$PurchaseItemsTable, PurchaseItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PurchaseItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _itemUuidMeta = const VerificationMeta(
    'itemUuid',
  );
  @override
  late final GeneratedColumn<String> itemUuid = GeneratedColumn<String>(
    'item_uuid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _purchaseUuidMeta = const VerificationMeta(
    'purchaseUuid',
  );
  @override
  late final GeneratedColumn<String> purchaseUuid = GeneratedColumn<String>(
    'purchase_uuid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES purchase_invoices (purchase_uuid)',
    ),
  );
  static const VerificationMeta _productUuidMeta = const VerificationMeta(
    'productUuid',
  );
  @override
  late final GeneratedColumn<String> productUuid = GeneratedColumn<String>(
    'product_uuid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES products (product_uuid)',
    ),
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitBuyPriceMeta = const VerificationMeta(
    'unitBuyPrice',
  );
  @override
  late final GeneratedColumn<double> unitBuyPrice = GeneratedColumn<double>(
    'unit_buy_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalPriceMeta = const VerificationMeta(
    'totalPrice',
  );
  @override
  late final GeneratedColumn<double> totalPrice = GeneratedColumn<double>(
    'total_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currencyCodeMeta = const VerificationMeta(
    'currencyCode',
  );
  @override
  late final GeneratedColumn<String> currencyCode = GeneratedColumn<String>(
    'currency_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('IRR'),
  );
  static const VerificationMeta _exchangeRateAtPurchaseMeta =
      const VerificationMeta('exchangeRateAtPurchase');
  @override
  late final GeneratedColumn<double> exchangeRateAtPurchase =
      GeneratedColumn<double>(
        'exchange_rate_at_purchase',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _costInBaseCurrencyMeta =
      const VerificationMeta('costInBaseCurrency');
  @override
  late final GeneratedColumn<double> costInBaseCurrency =
      GeneratedColumn<double>(
        'cost_in_base_currency',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    itemUuid,
    purchaseUuid,
    productUuid,
    quantity,
    unitBuyPrice,
    totalPrice,
    currencyCode,
    exchangeRateAtPurchase,
    costInBaseCurrency,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'purchase_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<PurchaseItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('item_uuid')) {
      context.handle(
        _itemUuidMeta,
        itemUuid.isAcceptableOrUnknown(data['item_uuid']!, _itemUuidMeta),
      );
    } else if (isInserting) {
      context.missing(_itemUuidMeta);
    }
    if (data.containsKey('purchase_uuid')) {
      context.handle(
        _purchaseUuidMeta,
        purchaseUuid.isAcceptableOrUnknown(
          data['purchase_uuid']!,
          _purchaseUuidMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_purchaseUuidMeta);
    }
    if (data.containsKey('product_uuid')) {
      context.handle(
        _productUuidMeta,
        productUuid.isAcceptableOrUnknown(
          data['product_uuid']!,
          _productUuidMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_productUuidMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('unit_buy_price')) {
      context.handle(
        _unitBuyPriceMeta,
        unitBuyPrice.isAcceptableOrUnknown(
          data['unit_buy_price']!,
          _unitBuyPriceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_unitBuyPriceMeta);
    }
    if (data.containsKey('total_price')) {
      context.handle(
        _totalPriceMeta,
        totalPrice.isAcceptableOrUnknown(data['total_price']!, _totalPriceMeta),
      );
    } else if (isInserting) {
      context.missing(_totalPriceMeta);
    }
    if (data.containsKey('currency_code')) {
      context.handle(
        _currencyCodeMeta,
        currencyCode.isAcceptableOrUnknown(
          data['currency_code']!,
          _currencyCodeMeta,
        ),
      );
    }
    if (data.containsKey('exchange_rate_at_purchase')) {
      context.handle(
        _exchangeRateAtPurchaseMeta,
        exchangeRateAtPurchase.isAcceptableOrUnknown(
          data['exchange_rate_at_purchase']!,
          _exchangeRateAtPurchaseMeta,
        ),
      );
    }
    if (data.containsKey('cost_in_base_currency')) {
      context.handle(
        _costInBaseCurrencyMeta,
        costInBaseCurrency.isAcceptableOrUnknown(
          data['cost_in_base_currency']!,
          _costInBaseCurrencyMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {itemUuid};
  @override
  PurchaseItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PurchaseItem(
      itemUuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}item_uuid'],
      )!,
      purchaseUuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}purchase_uuid'],
      )!,
      productUuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_uuid'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity'],
      )!,
      unitBuyPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}unit_buy_price'],
      )!,
      totalPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_price'],
      )!,
      currencyCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency_code'],
      )!,
      exchangeRateAtPurchase: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}exchange_rate_at_purchase'],
      ),
      costInBaseCurrency: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}cost_in_base_currency'],
      ),
    );
  }

  @override
  $PurchaseItemsTable createAlias(String alias) {
    return $PurchaseItemsTable(attachedDatabase, alias);
  }
}

class PurchaseItem extends DataClass implements Insertable<PurchaseItem> {
  final String itemUuid;
  final String purchaseUuid;
  final String productUuid;
  final int quantity;
  final double unitBuyPrice;
  final double totalPrice;
  final String currencyCode;
  final double? exchangeRateAtPurchase;
  final double? costInBaseCurrency;
  const PurchaseItem({
    required this.itemUuid,
    required this.purchaseUuid,
    required this.productUuid,
    required this.quantity,
    required this.unitBuyPrice,
    required this.totalPrice,
    required this.currencyCode,
    this.exchangeRateAtPurchase,
    this.costInBaseCurrency,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['item_uuid'] = Variable<String>(itemUuid);
    map['purchase_uuid'] = Variable<String>(purchaseUuid);
    map['product_uuid'] = Variable<String>(productUuid);
    map['quantity'] = Variable<int>(quantity);
    map['unit_buy_price'] = Variable<double>(unitBuyPrice);
    map['total_price'] = Variable<double>(totalPrice);
    map['currency_code'] = Variable<String>(currencyCode);
    if (!nullToAbsent || exchangeRateAtPurchase != null) {
      map['exchange_rate_at_purchase'] = Variable<double>(
        exchangeRateAtPurchase,
      );
    }
    if (!nullToAbsent || costInBaseCurrency != null) {
      map['cost_in_base_currency'] = Variable<double>(costInBaseCurrency);
    }
    return map;
  }

  PurchaseItemsCompanion toCompanion(bool nullToAbsent) {
    return PurchaseItemsCompanion(
      itemUuid: Value(itemUuid),
      purchaseUuid: Value(purchaseUuid),
      productUuid: Value(productUuid),
      quantity: Value(quantity),
      unitBuyPrice: Value(unitBuyPrice),
      totalPrice: Value(totalPrice),
      currencyCode: Value(currencyCode),
      exchangeRateAtPurchase: exchangeRateAtPurchase == null && nullToAbsent
          ? const Value.absent()
          : Value(exchangeRateAtPurchase),
      costInBaseCurrency: costInBaseCurrency == null && nullToAbsent
          ? const Value.absent()
          : Value(costInBaseCurrency),
    );
  }

  factory PurchaseItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PurchaseItem(
      itemUuid: serializer.fromJson<String>(json['itemUuid']),
      purchaseUuid: serializer.fromJson<String>(json['purchaseUuid']),
      productUuid: serializer.fromJson<String>(json['productUuid']),
      quantity: serializer.fromJson<int>(json['quantity']),
      unitBuyPrice: serializer.fromJson<double>(json['unitBuyPrice']),
      totalPrice: serializer.fromJson<double>(json['totalPrice']),
      currencyCode: serializer.fromJson<String>(json['currencyCode']),
      exchangeRateAtPurchase: serializer.fromJson<double?>(
        json['exchangeRateAtPurchase'],
      ),
      costInBaseCurrency: serializer.fromJson<double?>(
        json['costInBaseCurrency'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'itemUuid': serializer.toJson<String>(itemUuid),
      'purchaseUuid': serializer.toJson<String>(purchaseUuid),
      'productUuid': serializer.toJson<String>(productUuid),
      'quantity': serializer.toJson<int>(quantity),
      'unitBuyPrice': serializer.toJson<double>(unitBuyPrice),
      'totalPrice': serializer.toJson<double>(totalPrice),
      'currencyCode': serializer.toJson<String>(currencyCode),
      'exchangeRateAtPurchase': serializer.toJson<double?>(
        exchangeRateAtPurchase,
      ),
      'costInBaseCurrency': serializer.toJson<double?>(costInBaseCurrency),
    };
  }

  PurchaseItem copyWith({
    String? itemUuid,
    String? purchaseUuid,
    String? productUuid,
    int? quantity,
    double? unitBuyPrice,
    double? totalPrice,
    String? currencyCode,
    Value<double?> exchangeRateAtPurchase = const Value.absent(),
    Value<double?> costInBaseCurrency = const Value.absent(),
  }) => PurchaseItem(
    itemUuid: itemUuid ?? this.itemUuid,
    purchaseUuid: purchaseUuid ?? this.purchaseUuid,
    productUuid: productUuid ?? this.productUuid,
    quantity: quantity ?? this.quantity,
    unitBuyPrice: unitBuyPrice ?? this.unitBuyPrice,
    totalPrice: totalPrice ?? this.totalPrice,
    currencyCode: currencyCode ?? this.currencyCode,
    exchangeRateAtPurchase: exchangeRateAtPurchase.present
        ? exchangeRateAtPurchase.value
        : this.exchangeRateAtPurchase,
    costInBaseCurrency: costInBaseCurrency.present
        ? costInBaseCurrency.value
        : this.costInBaseCurrency,
  );
  PurchaseItem copyWithCompanion(PurchaseItemsCompanion data) {
    return PurchaseItem(
      itemUuid: data.itemUuid.present ? data.itemUuid.value : this.itemUuid,
      purchaseUuid: data.purchaseUuid.present
          ? data.purchaseUuid.value
          : this.purchaseUuid,
      productUuid: data.productUuid.present
          ? data.productUuid.value
          : this.productUuid,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      unitBuyPrice: data.unitBuyPrice.present
          ? data.unitBuyPrice.value
          : this.unitBuyPrice,
      totalPrice: data.totalPrice.present
          ? data.totalPrice.value
          : this.totalPrice,
      currencyCode: data.currencyCode.present
          ? data.currencyCode.value
          : this.currencyCode,
      exchangeRateAtPurchase: data.exchangeRateAtPurchase.present
          ? data.exchangeRateAtPurchase.value
          : this.exchangeRateAtPurchase,
      costInBaseCurrency: data.costInBaseCurrency.present
          ? data.costInBaseCurrency.value
          : this.costInBaseCurrency,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PurchaseItem(')
          ..write('itemUuid: $itemUuid, ')
          ..write('purchaseUuid: $purchaseUuid, ')
          ..write('productUuid: $productUuid, ')
          ..write('quantity: $quantity, ')
          ..write('unitBuyPrice: $unitBuyPrice, ')
          ..write('totalPrice: $totalPrice, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('exchangeRateAtPurchase: $exchangeRateAtPurchase, ')
          ..write('costInBaseCurrency: $costInBaseCurrency')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    itemUuid,
    purchaseUuid,
    productUuid,
    quantity,
    unitBuyPrice,
    totalPrice,
    currencyCode,
    exchangeRateAtPurchase,
    costInBaseCurrency,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PurchaseItem &&
          other.itemUuid == this.itemUuid &&
          other.purchaseUuid == this.purchaseUuid &&
          other.productUuid == this.productUuid &&
          other.quantity == this.quantity &&
          other.unitBuyPrice == this.unitBuyPrice &&
          other.totalPrice == this.totalPrice &&
          other.currencyCode == this.currencyCode &&
          other.exchangeRateAtPurchase == this.exchangeRateAtPurchase &&
          other.costInBaseCurrency == this.costInBaseCurrency);
}

class PurchaseItemsCompanion extends UpdateCompanion<PurchaseItem> {
  final Value<String> itemUuid;
  final Value<String> purchaseUuid;
  final Value<String> productUuid;
  final Value<int> quantity;
  final Value<double> unitBuyPrice;
  final Value<double> totalPrice;
  final Value<String> currencyCode;
  final Value<double?> exchangeRateAtPurchase;
  final Value<double?> costInBaseCurrency;
  final Value<int> rowid;
  const PurchaseItemsCompanion({
    this.itemUuid = const Value.absent(),
    this.purchaseUuid = const Value.absent(),
    this.productUuid = const Value.absent(),
    this.quantity = const Value.absent(),
    this.unitBuyPrice = const Value.absent(),
    this.totalPrice = const Value.absent(),
    this.currencyCode = const Value.absent(),
    this.exchangeRateAtPurchase = const Value.absent(),
    this.costInBaseCurrency = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PurchaseItemsCompanion.insert({
    required String itemUuid,
    required String purchaseUuid,
    required String productUuid,
    required int quantity,
    required double unitBuyPrice,
    required double totalPrice,
    this.currencyCode = const Value.absent(),
    this.exchangeRateAtPurchase = const Value.absent(),
    this.costInBaseCurrency = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : itemUuid = Value(itemUuid),
       purchaseUuid = Value(purchaseUuid),
       productUuid = Value(productUuid),
       quantity = Value(quantity),
       unitBuyPrice = Value(unitBuyPrice),
       totalPrice = Value(totalPrice);
  static Insertable<PurchaseItem> custom({
    Expression<String>? itemUuid,
    Expression<String>? purchaseUuid,
    Expression<String>? productUuid,
    Expression<int>? quantity,
    Expression<double>? unitBuyPrice,
    Expression<double>? totalPrice,
    Expression<String>? currencyCode,
    Expression<double>? exchangeRateAtPurchase,
    Expression<double>? costInBaseCurrency,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (itemUuid != null) 'item_uuid': itemUuid,
      if (purchaseUuid != null) 'purchase_uuid': purchaseUuid,
      if (productUuid != null) 'product_uuid': productUuid,
      if (quantity != null) 'quantity': quantity,
      if (unitBuyPrice != null) 'unit_buy_price': unitBuyPrice,
      if (totalPrice != null) 'total_price': totalPrice,
      if (currencyCode != null) 'currency_code': currencyCode,
      if (exchangeRateAtPurchase != null)
        'exchange_rate_at_purchase': exchangeRateAtPurchase,
      if (costInBaseCurrency != null)
        'cost_in_base_currency': costInBaseCurrency,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PurchaseItemsCompanion copyWith({
    Value<String>? itemUuid,
    Value<String>? purchaseUuid,
    Value<String>? productUuid,
    Value<int>? quantity,
    Value<double>? unitBuyPrice,
    Value<double>? totalPrice,
    Value<String>? currencyCode,
    Value<double?>? exchangeRateAtPurchase,
    Value<double?>? costInBaseCurrency,
    Value<int>? rowid,
  }) {
    return PurchaseItemsCompanion(
      itemUuid: itemUuid ?? this.itemUuid,
      purchaseUuid: purchaseUuid ?? this.purchaseUuid,
      productUuid: productUuid ?? this.productUuid,
      quantity: quantity ?? this.quantity,
      unitBuyPrice: unitBuyPrice ?? this.unitBuyPrice,
      totalPrice: totalPrice ?? this.totalPrice,
      currencyCode: currencyCode ?? this.currencyCode,
      exchangeRateAtPurchase:
          exchangeRateAtPurchase ?? this.exchangeRateAtPurchase,
      costInBaseCurrency: costInBaseCurrency ?? this.costInBaseCurrency,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (itemUuid.present) {
      map['item_uuid'] = Variable<String>(itemUuid.value);
    }
    if (purchaseUuid.present) {
      map['purchase_uuid'] = Variable<String>(purchaseUuid.value);
    }
    if (productUuid.present) {
      map['product_uuid'] = Variable<String>(productUuid.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (unitBuyPrice.present) {
      map['unit_buy_price'] = Variable<double>(unitBuyPrice.value);
    }
    if (totalPrice.present) {
      map['total_price'] = Variable<double>(totalPrice.value);
    }
    if (currencyCode.present) {
      map['currency_code'] = Variable<String>(currencyCode.value);
    }
    if (exchangeRateAtPurchase.present) {
      map['exchange_rate_at_purchase'] = Variable<double>(
        exchangeRateAtPurchase.value,
      );
    }
    if (costInBaseCurrency.present) {
      map['cost_in_base_currency'] = Variable<double>(costInBaseCurrency.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PurchaseItemsCompanion(')
          ..write('itemUuid: $itemUuid, ')
          ..write('purchaseUuid: $purchaseUuid, ')
          ..write('productUuid: $productUuid, ')
          ..write('quantity: $quantity, ')
          ..write('unitBuyPrice: $unitBuyPrice, ')
          ..write('totalPrice: $totalPrice, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('exchangeRateAtPurchase: $exchangeRateAtPurchase, ')
          ..write('costInBaseCurrency: $costInBaseCurrency, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $EventsTable extends Events with TableInfo<$EventsTable, Event> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EventsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _eventIdMeta = const VerificationMeta(
    'eventId',
  );
  @override
  late final GeneratedColumn<String> eventId = GeneratedColumn<String>(
    'event_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _eventTypeMeta = const VerificationMeta(
    'eventType',
  );
  @override
  late final GeneratedColumn<String> eventType = GeneratedColumn<String>(
    'event_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entityTypeMeta = const VerificationMeta(
    'entityType',
  );
  @override
  late final GeneratedColumn<String> entityType = GeneratedColumn<String>(
    'entity_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entityIdMeta = const VerificationMeta(
    'entityId',
  );
  @override
  late final GeneratedColumn<String> entityId = GeneratedColumn<String>(
    'entity_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payloadMeta = const VerificationMeta(
    'payload',
  );
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
    'payload',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userUuidMeta = const VerificationMeta(
    'userUuid',
  );
  @override
  late final GeneratedColumn<String> userUuid = GeneratedColumn<String>(
    'user_uuid',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _timestampMeta = const VerificationMeta(
    'timestamp',
  );
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _metadataMeta = const VerificationMeta(
    'metadata',
  );
  @override
  late final GeneratedColumn<String> metadata = GeneratedColumn<String>(
    'metadata',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    eventId,
    eventType,
    entityType,
    entityId,
    payload,
    userUuid,
    timestamp,
    metadata,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'events';
  @override
  VerificationContext validateIntegrity(
    Insertable<Event> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('event_id')) {
      context.handle(
        _eventIdMeta,
        eventId.isAcceptableOrUnknown(data['event_id']!, _eventIdMeta),
      );
    } else if (isInserting) {
      context.missing(_eventIdMeta);
    }
    if (data.containsKey('event_type')) {
      context.handle(
        _eventTypeMeta,
        eventType.isAcceptableOrUnknown(data['event_type']!, _eventTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_eventTypeMeta);
    }
    if (data.containsKey('entity_type')) {
      context.handle(
        _entityTypeMeta,
        entityType.isAcceptableOrUnknown(data['entity_type']!, _entityTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_entityTypeMeta);
    }
    if (data.containsKey('entity_id')) {
      context.handle(
        _entityIdMeta,
        entityId.isAcceptableOrUnknown(data['entity_id']!, _entityIdMeta),
      );
    } else if (isInserting) {
      context.missing(_entityIdMeta);
    }
    if (data.containsKey('payload')) {
      context.handle(
        _payloadMeta,
        payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta),
      );
    } else if (isInserting) {
      context.missing(_payloadMeta);
    }
    if (data.containsKey('user_uuid')) {
      context.handle(
        _userUuidMeta,
        userUuid.isAcceptableOrUnknown(data['user_uuid']!, _userUuidMeta),
      );
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    if (data.containsKey('metadata')) {
      context.handle(
        _metadataMeta,
        metadata.isAcceptableOrUnknown(data['metadata']!, _metadataMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {eventId};
  @override
  Event map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Event(
      eventId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}event_id'],
      )!,
      eventType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}event_type'],
      )!,
      entityType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_type'],
      )!,
      entityId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_id'],
      )!,
      payload: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload'],
      )!,
      userUuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_uuid'],
      ),
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}timestamp'],
      )!,
      metadata: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}metadata'],
      ),
    );
  }

  @override
  $EventsTable createAlias(String alias) {
    return $EventsTable(attachedDatabase, alias);
  }
}

class Event extends DataClass implements Insertable<Event> {
  final String eventId;
  final String eventType;
  final String entityType;
  final String entityId;
  final String payload;
  final String? userUuid;
  final DateTime timestamp;
  final String? metadata;
  const Event({
    required this.eventId,
    required this.eventType,
    required this.entityType,
    required this.entityId,
    required this.payload,
    this.userUuid,
    required this.timestamp,
    this.metadata,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['event_id'] = Variable<String>(eventId);
    map['event_type'] = Variable<String>(eventType);
    map['entity_type'] = Variable<String>(entityType);
    map['entity_id'] = Variable<String>(entityId);
    map['payload'] = Variable<String>(payload);
    if (!nullToAbsent || userUuid != null) {
      map['user_uuid'] = Variable<String>(userUuid);
    }
    map['timestamp'] = Variable<DateTime>(timestamp);
    if (!nullToAbsent || metadata != null) {
      map['metadata'] = Variable<String>(metadata);
    }
    return map;
  }

  EventsCompanion toCompanion(bool nullToAbsent) {
    return EventsCompanion(
      eventId: Value(eventId),
      eventType: Value(eventType),
      entityType: Value(entityType),
      entityId: Value(entityId),
      payload: Value(payload),
      userUuid: userUuid == null && nullToAbsent
          ? const Value.absent()
          : Value(userUuid),
      timestamp: Value(timestamp),
      metadata: metadata == null && nullToAbsent
          ? const Value.absent()
          : Value(metadata),
    );
  }

  factory Event.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Event(
      eventId: serializer.fromJson<String>(json['eventId']),
      eventType: serializer.fromJson<String>(json['eventType']),
      entityType: serializer.fromJson<String>(json['entityType']),
      entityId: serializer.fromJson<String>(json['entityId']),
      payload: serializer.fromJson<String>(json['payload']),
      userUuid: serializer.fromJson<String?>(json['userUuid']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      metadata: serializer.fromJson<String?>(json['metadata']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'eventId': serializer.toJson<String>(eventId),
      'eventType': serializer.toJson<String>(eventType),
      'entityType': serializer.toJson<String>(entityType),
      'entityId': serializer.toJson<String>(entityId),
      'payload': serializer.toJson<String>(payload),
      'userUuid': serializer.toJson<String?>(userUuid),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'metadata': serializer.toJson<String?>(metadata),
    };
  }

  Event copyWith({
    String? eventId,
    String? eventType,
    String? entityType,
    String? entityId,
    String? payload,
    Value<String?> userUuid = const Value.absent(),
    DateTime? timestamp,
    Value<String?> metadata = const Value.absent(),
  }) => Event(
    eventId: eventId ?? this.eventId,
    eventType: eventType ?? this.eventType,
    entityType: entityType ?? this.entityType,
    entityId: entityId ?? this.entityId,
    payload: payload ?? this.payload,
    userUuid: userUuid.present ? userUuid.value : this.userUuid,
    timestamp: timestamp ?? this.timestamp,
    metadata: metadata.present ? metadata.value : this.metadata,
  );
  Event copyWithCompanion(EventsCompanion data) {
    return Event(
      eventId: data.eventId.present ? data.eventId.value : this.eventId,
      eventType: data.eventType.present ? data.eventType.value : this.eventType,
      entityType: data.entityType.present
          ? data.entityType.value
          : this.entityType,
      entityId: data.entityId.present ? data.entityId.value : this.entityId,
      payload: data.payload.present ? data.payload.value : this.payload,
      userUuid: data.userUuid.present ? data.userUuid.value : this.userUuid,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      metadata: data.metadata.present ? data.metadata.value : this.metadata,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Event(')
          ..write('eventId: $eventId, ')
          ..write('eventType: $eventType, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('payload: $payload, ')
          ..write('userUuid: $userUuid, ')
          ..write('timestamp: $timestamp, ')
          ..write('metadata: $metadata')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    eventId,
    eventType,
    entityType,
    entityId,
    payload,
    userUuid,
    timestamp,
    metadata,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Event &&
          other.eventId == this.eventId &&
          other.eventType == this.eventType &&
          other.entityType == this.entityType &&
          other.entityId == this.entityId &&
          other.payload == this.payload &&
          other.userUuid == this.userUuid &&
          other.timestamp == this.timestamp &&
          other.metadata == this.metadata);
}

class EventsCompanion extends UpdateCompanion<Event> {
  final Value<String> eventId;
  final Value<String> eventType;
  final Value<String> entityType;
  final Value<String> entityId;
  final Value<String> payload;
  final Value<String?> userUuid;
  final Value<DateTime> timestamp;
  final Value<String?> metadata;
  final Value<int> rowid;
  const EventsCompanion({
    this.eventId = const Value.absent(),
    this.eventType = const Value.absent(),
    this.entityType = const Value.absent(),
    this.entityId = const Value.absent(),
    this.payload = const Value.absent(),
    this.userUuid = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.metadata = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EventsCompanion.insert({
    required String eventId,
    required String eventType,
    required String entityType,
    required String entityId,
    required String payload,
    this.userUuid = const Value.absent(),
    required DateTime timestamp,
    this.metadata = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : eventId = Value(eventId),
       eventType = Value(eventType),
       entityType = Value(entityType),
       entityId = Value(entityId),
       payload = Value(payload),
       timestamp = Value(timestamp);
  static Insertable<Event> custom({
    Expression<String>? eventId,
    Expression<String>? eventType,
    Expression<String>? entityType,
    Expression<String>? entityId,
    Expression<String>? payload,
    Expression<String>? userUuid,
    Expression<DateTime>? timestamp,
    Expression<String>? metadata,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (eventId != null) 'event_id': eventId,
      if (eventType != null) 'event_type': eventType,
      if (entityType != null) 'entity_type': entityType,
      if (entityId != null) 'entity_id': entityId,
      if (payload != null) 'payload': payload,
      if (userUuid != null) 'user_uuid': userUuid,
      if (timestamp != null) 'timestamp': timestamp,
      if (metadata != null) 'metadata': metadata,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EventsCompanion copyWith({
    Value<String>? eventId,
    Value<String>? eventType,
    Value<String>? entityType,
    Value<String>? entityId,
    Value<String>? payload,
    Value<String?>? userUuid,
    Value<DateTime>? timestamp,
    Value<String?>? metadata,
    Value<int>? rowid,
  }) {
    return EventsCompanion(
      eventId: eventId ?? this.eventId,
      eventType: eventType ?? this.eventType,
      entityType: entityType ?? this.entityType,
      entityId: entityId ?? this.entityId,
      payload: payload ?? this.payload,
      userUuid: userUuid ?? this.userUuid,
      timestamp: timestamp ?? this.timestamp,
      metadata: metadata ?? this.metadata,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (eventId.present) {
      map['event_id'] = Variable<String>(eventId.value);
    }
    if (eventType.present) {
      map['event_type'] = Variable<String>(eventType.value);
    }
    if (entityType.present) {
      map['entity_type'] = Variable<String>(entityType.value);
    }
    if (entityId.present) {
      map['entity_id'] = Variable<String>(entityId.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    if (userUuid.present) {
      map['user_uuid'] = Variable<String>(userUuid.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (metadata.present) {
      map['metadata'] = Variable<String>(metadata.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EventsCompanion(')
          ..write('eventId: $eventId, ')
          ..write('eventType: $eventType, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('payload: $payload, ')
          ..write('userUuid: $userUuid, ')
          ..write('timestamp: $timestamp, ')
          ..write('metadata: $metadata, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ExchangeRateEventsTable extends ExchangeRateEvents
    with TableInfo<$ExchangeRateEventsTable, ExchangeRateEventData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExchangeRateEventsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _currencyCodeMeta = const VerificationMeta(
    'currencyCode',
  );
  @override
  late final GeneratedColumn<String> currencyCode = GeneratedColumn<String>(
    'currency_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _rateMeta = const VerificationMeta('rate');
  @override
  late final GeneratedColumn<double> rate = GeneratedColumn<double>(
    'rate',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _recordedAtMeta = const VerificationMeta(
    'recordedAt',
  );
  @override
  late final GeneratedColumn<DateTime> recordedAt = GeneratedColumn<DateTime>(
    'recorded_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _confidenceMeta = const VerificationMeta(
    'confidence',
  );
  @override
  late final GeneratedColumn<double> confidence = GeneratedColumn<double>(
    'confidence',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(1.0),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _recordedByMeta = const VerificationMeta(
    'recordedBy',
  );
  @override
  late final GeneratedColumn<String> recordedBy = GeneratedColumn<String>(
    'recorded_by',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    currencyCode,
    rate,
    recordedAt,
    source,
    confidence,
    notes,
    recordedBy,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exchange_rate_events';
  @override
  VerificationContext validateIntegrity(
    Insertable<ExchangeRateEventData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('currency_code')) {
      context.handle(
        _currencyCodeMeta,
        currencyCode.isAcceptableOrUnknown(
          data['currency_code']!,
          _currencyCodeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_currencyCodeMeta);
    }
    if (data.containsKey('rate')) {
      context.handle(
        _rateMeta,
        rate.isAcceptableOrUnknown(data['rate']!, _rateMeta),
      );
    } else if (isInserting) {
      context.missing(_rateMeta);
    }
    if (data.containsKey('recorded_at')) {
      context.handle(
        _recordedAtMeta,
        recordedAt.isAcceptableOrUnknown(data['recorded_at']!, _recordedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_recordedAtMeta);
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceMeta);
    }
    if (data.containsKey('confidence')) {
      context.handle(
        _confidenceMeta,
        confidence.isAcceptableOrUnknown(data['confidence']!, _confidenceMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('recorded_by')) {
      context.handle(
        _recordedByMeta,
        recordedBy.isAcceptableOrUnknown(data['recorded_by']!, _recordedByMeta),
      );
    } else if (isInserting) {
      context.missing(_recordedByMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExchangeRateEventData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExchangeRateEventData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      currencyCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency_code'],
      )!,
      rate: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}rate'],
      )!,
      recordedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}recorded_at'],
      )!,
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      )!,
      confidence: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}confidence'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      recordedBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}recorded_by'],
      )!,
    );
  }

  @override
  $ExchangeRateEventsTable createAlias(String alias) {
    return $ExchangeRateEventsTable(attachedDatabase, alias);
  }
}

class ExchangeRateEventData extends DataClass
    implements Insertable<ExchangeRateEventData> {
  /// Auto-increment primary key
  final int id;

  /// Currency code (USD, EUR, AED)
  final String currencyCode;

  /// Exchange rate to base currency (IRR)
  final double rate;

  /// Timestamp when rate was recorded (Immutable 🔒)
  final DateTime recordedAt;

  /// Source of the rate: manual, api_bonbast, api_tgju, market_avg, correction
  final String source;

  /// Confidence score (0.0 to 1.0)
  final double confidence;

  /// Optional notes
  final String? notes;

  /// User UUID who recorded this rate
  final String recordedBy;
  const ExchangeRateEventData({
    required this.id,
    required this.currencyCode,
    required this.rate,
    required this.recordedAt,
    required this.source,
    required this.confidence,
    this.notes,
    required this.recordedBy,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['currency_code'] = Variable<String>(currencyCode);
    map['rate'] = Variable<double>(rate);
    map['recorded_at'] = Variable<DateTime>(recordedAt);
    map['source'] = Variable<String>(source);
    map['confidence'] = Variable<double>(confidence);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['recorded_by'] = Variable<String>(recordedBy);
    return map;
  }

  ExchangeRateEventsCompanion toCompanion(bool nullToAbsent) {
    return ExchangeRateEventsCompanion(
      id: Value(id),
      currencyCode: Value(currencyCode),
      rate: Value(rate),
      recordedAt: Value(recordedAt),
      source: Value(source),
      confidence: Value(confidence),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      recordedBy: Value(recordedBy),
    );
  }

  factory ExchangeRateEventData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExchangeRateEventData(
      id: serializer.fromJson<int>(json['id']),
      currencyCode: serializer.fromJson<String>(json['currencyCode']),
      rate: serializer.fromJson<double>(json['rate']),
      recordedAt: serializer.fromJson<DateTime>(json['recordedAt']),
      source: serializer.fromJson<String>(json['source']),
      confidence: serializer.fromJson<double>(json['confidence']),
      notes: serializer.fromJson<String?>(json['notes']),
      recordedBy: serializer.fromJson<String>(json['recordedBy']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'currencyCode': serializer.toJson<String>(currencyCode),
      'rate': serializer.toJson<double>(rate),
      'recordedAt': serializer.toJson<DateTime>(recordedAt),
      'source': serializer.toJson<String>(source),
      'confidence': serializer.toJson<double>(confidence),
      'notes': serializer.toJson<String?>(notes),
      'recordedBy': serializer.toJson<String>(recordedBy),
    };
  }

  ExchangeRateEventData copyWith({
    int? id,
    String? currencyCode,
    double? rate,
    DateTime? recordedAt,
    String? source,
    double? confidence,
    Value<String?> notes = const Value.absent(),
    String? recordedBy,
  }) => ExchangeRateEventData(
    id: id ?? this.id,
    currencyCode: currencyCode ?? this.currencyCode,
    rate: rate ?? this.rate,
    recordedAt: recordedAt ?? this.recordedAt,
    source: source ?? this.source,
    confidence: confidence ?? this.confidence,
    notes: notes.present ? notes.value : this.notes,
    recordedBy: recordedBy ?? this.recordedBy,
  );
  ExchangeRateEventData copyWithCompanion(ExchangeRateEventsCompanion data) {
    return ExchangeRateEventData(
      id: data.id.present ? data.id.value : this.id,
      currencyCode: data.currencyCode.present
          ? data.currencyCode.value
          : this.currencyCode,
      rate: data.rate.present ? data.rate.value : this.rate,
      recordedAt: data.recordedAt.present
          ? data.recordedAt.value
          : this.recordedAt,
      source: data.source.present ? data.source.value : this.source,
      confidence: data.confidence.present
          ? data.confidence.value
          : this.confidence,
      notes: data.notes.present ? data.notes.value : this.notes,
      recordedBy: data.recordedBy.present
          ? data.recordedBy.value
          : this.recordedBy,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExchangeRateEventData(')
          ..write('id: $id, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('rate: $rate, ')
          ..write('recordedAt: $recordedAt, ')
          ..write('source: $source, ')
          ..write('confidence: $confidence, ')
          ..write('notes: $notes, ')
          ..write('recordedBy: $recordedBy')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    currencyCode,
    rate,
    recordedAt,
    source,
    confidence,
    notes,
    recordedBy,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExchangeRateEventData &&
          other.id == this.id &&
          other.currencyCode == this.currencyCode &&
          other.rate == this.rate &&
          other.recordedAt == this.recordedAt &&
          other.source == this.source &&
          other.confidence == this.confidence &&
          other.notes == this.notes &&
          other.recordedBy == this.recordedBy);
}

class ExchangeRateEventsCompanion
    extends UpdateCompanion<ExchangeRateEventData> {
  final Value<int> id;
  final Value<String> currencyCode;
  final Value<double> rate;
  final Value<DateTime> recordedAt;
  final Value<String> source;
  final Value<double> confidence;
  final Value<String?> notes;
  final Value<String> recordedBy;
  const ExchangeRateEventsCompanion({
    this.id = const Value.absent(),
    this.currencyCode = const Value.absent(),
    this.rate = const Value.absent(),
    this.recordedAt = const Value.absent(),
    this.source = const Value.absent(),
    this.confidence = const Value.absent(),
    this.notes = const Value.absent(),
    this.recordedBy = const Value.absent(),
  });
  ExchangeRateEventsCompanion.insert({
    this.id = const Value.absent(),
    required String currencyCode,
    required double rate,
    required DateTime recordedAt,
    required String source,
    this.confidence = const Value.absent(),
    this.notes = const Value.absent(),
    required String recordedBy,
  }) : currencyCode = Value(currencyCode),
       rate = Value(rate),
       recordedAt = Value(recordedAt),
       source = Value(source),
       recordedBy = Value(recordedBy);
  static Insertable<ExchangeRateEventData> custom({
    Expression<int>? id,
    Expression<String>? currencyCode,
    Expression<double>? rate,
    Expression<DateTime>? recordedAt,
    Expression<String>? source,
    Expression<double>? confidence,
    Expression<String>? notes,
    Expression<String>? recordedBy,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (currencyCode != null) 'currency_code': currencyCode,
      if (rate != null) 'rate': rate,
      if (recordedAt != null) 'recorded_at': recordedAt,
      if (source != null) 'source': source,
      if (confidence != null) 'confidence': confidence,
      if (notes != null) 'notes': notes,
      if (recordedBy != null) 'recorded_by': recordedBy,
    });
  }

  ExchangeRateEventsCompanion copyWith({
    Value<int>? id,
    Value<String>? currencyCode,
    Value<double>? rate,
    Value<DateTime>? recordedAt,
    Value<String>? source,
    Value<double>? confidence,
    Value<String?>? notes,
    Value<String>? recordedBy,
  }) {
    return ExchangeRateEventsCompanion(
      id: id ?? this.id,
      currencyCode: currencyCode ?? this.currencyCode,
      rate: rate ?? this.rate,
      recordedAt: recordedAt ?? this.recordedAt,
      source: source ?? this.source,
      confidence: confidence ?? this.confidence,
      notes: notes ?? this.notes,
      recordedBy: recordedBy ?? this.recordedBy,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (currencyCode.present) {
      map['currency_code'] = Variable<String>(currencyCode.value);
    }
    if (rate.present) {
      map['rate'] = Variable<double>(rate.value);
    }
    if (recordedAt.present) {
      map['recorded_at'] = Variable<DateTime>(recordedAt.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (confidence.present) {
      map['confidence'] = Variable<double>(confidence.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (recordedBy.present) {
      map['recorded_by'] = Variable<String>(recordedBy.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExchangeRateEventsCompanion(')
          ..write('id: $id, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('rate: $rate, ')
          ..write('recordedAt: $recordedAt, ')
          ..write('source: $source, ')
          ..write('confidence: $confidence, ')
          ..write('notes: $notes, ')
          ..write('recordedBy: $recordedBy')
          ..write(')'))
        .toString();
  }
}

class $PricingSettingsTable extends PricingSettings
    with TableInfo<$PricingSettingsTable, PricingSettingsData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PricingSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _minProfitMarginMeta = const VerificationMeta(
    'minProfitMargin',
  );
  @override
  late final GeneratedColumn<double> minProfitMargin = GeneratedColumn<double>(
    'min_profit_margin',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(20.0),
  );
  static const VerificationMeta _defaultProfitMarginMeta =
      const VerificationMeta('defaultProfitMargin');
  @override
  late final GeneratedColumn<double> defaultProfitMargin =
      GeneratedColumn<double>(
        'default_profit_margin',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
        defaultValue: const Constant(30.0),
      );
  static const VerificationMeta _maxProfitMarginMeta = const VerificationMeta(
    'maxProfitMargin',
  );
  @override
  late final GeneratedColumn<double> maxProfitMargin = GeneratedColumn<double>(
    'max_profit_margin',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(50.0),
  );
  static const VerificationMeta _baseCurrencyMeta = const VerificationMeta(
    'baseCurrency',
  );
  @override
  late final GeneratedColumn<String> baseCurrency = GeneratedColumn<String>(
    'base_currency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('IRR'),
  );
  static const VerificationMeta _trackCurrenciesMeta = const VerificationMeta(
    'trackCurrencies',
  );
  @override
  late final GeneratedColumn<String> trackCurrencies = GeneratedColumn<String>(
    'track_currencies',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('["USD","EUR","AED"]'),
  );
  static const VerificationMeta _roundingStepMeta = const VerificationMeta(
    'roundingStep',
  );
  @override
  late final GeneratedColumn<int> roundingStep = GeneratedColumn<int>(
    'rounding_step',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(10000),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedByMeta = const VerificationMeta(
    'updatedBy',
  );
  @override
  late final GeneratedColumn<String> updatedBy = GeneratedColumn<String>(
    'updated_by',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    minProfitMargin,
    defaultProfitMargin,
    maxProfitMargin,
    baseCurrency,
    trackCurrencies,
    roundingStep,
    updatedAt,
    updatedBy,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pricing_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<PricingSettingsData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('min_profit_margin')) {
      context.handle(
        _minProfitMarginMeta,
        minProfitMargin.isAcceptableOrUnknown(
          data['min_profit_margin']!,
          _minProfitMarginMeta,
        ),
      );
    }
    if (data.containsKey('default_profit_margin')) {
      context.handle(
        _defaultProfitMarginMeta,
        defaultProfitMargin.isAcceptableOrUnknown(
          data['default_profit_margin']!,
          _defaultProfitMarginMeta,
        ),
      );
    }
    if (data.containsKey('max_profit_margin')) {
      context.handle(
        _maxProfitMarginMeta,
        maxProfitMargin.isAcceptableOrUnknown(
          data['max_profit_margin']!,
          _maxProfitMarginMeta,
        ),
      );
    }
    if (data.containsKey('base_currency')) {
      context.handle(
        _baseCurrencyMeta,
        baseCurrency.isAcceptableOrUnknown(
          data['base_currency']!,
          _baseCurrencyMeta,
        ),
      );
    }
    if (data.containsKey('track_currencies')) {
      context.handle(
        _trackCurrenciesMeta,
        trackCurrencies.isAcceptableOrUnknown(
          data['track_currencies']!,
          _trackCurrenciesMeta,
        ),
      );
    }
    if (data.containsKey('rounding_step')) {
      context.handle(
        _roundingStepMeta,
        roundingStep.isAcceptableOrUnknown(
          data['rounding_step']!,
          _roundingStepMeta,
        ),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('updated_by')) {
      context.handle(
        _updatedByMeta,
        updatedBy.isAcceptableOrUnknown(data['updated_by']!, _updatedByMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PricingSettingsData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PricingSettingsData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      minProfitMargin: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}min_profit_margin'],
      )!,
      defaultProfitMargin: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}default_profit_margin'],
      )!,
      maxProfitMargin: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}max_profit_margin'],
      )!,
      baseCurrency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}base_currency'],
      )!,
      trackCurrencies: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}track_currencies'],
      )!,
      roundingStep: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rounding_step'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
      updatedBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_by'],
      ),
    );
  }

  @override
  $PricingSettingsTable createAlias(String alias) {
    return $PricingSettingsTable(attachedDatabase, alias);
  }
}

class PricingSettingsData extends DataClass
    implements Insertable<PricingSettingsData> {
  /// Primary key - always 1 (singleton)
  final int id;

  /// Minimum profit margin percentage
  final double minProfitMargin;

  /// Default profit margin percentage
  final double defaultProfitMargin;

  /// Maximum profit margin percentage
  final double maxProfitMargin;

  /// Base currency code (default: IRR)
  final String baseCurrency;

  /// JSON array of tracked currencies (e.g., ["USD","EUR","AED"])
  final String trackCurrencies;

  /// Rounding step for price calculation (default: 10000 = 10,000 Toman)
  final int roundingStep;

  /// Last update timestamp
  final DateTime? updatedAt;

  /// User UUID who last updated settings
  final String? updatedBy;
  const PricingSettingsData({
    required this.id,
    required this.minProfitMargin,
    required this.defaultProfitMargin,
    required this.maxProfitMargin,
    required this.baseCurrency,
    required this.trackCurrencies,
    required this.roundingStep,
    this.updatedAt,
    this.updatedBy,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['min_profit_margin'] = Variable<double>(minProfitMargin);
    map['default_profit_margin'] = Variable<double>(defaultProfitMargin);
    map['max_profit_margin'] = Variable<double>(maxProfitMargin);
    map['base_currency'] = Variable<String>(baseCurrency);
    map['track_currencies'] = Variable<String>(trackCurrencies);
    map['rounding_step'] = Variable<int>(roundingStep);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    if (!nullToAbsent || updatedBy != null) {
      map['updated_by'] = Variable<String>(updatedBy);
    }
    return map;
  }

  PricingSettingsCompanion toCompanion(bool nullToAbsent) {
    return PricingSettingsCompanion(
      id: Value(id),
      minProfitMargin: Value(minProfitMargin),
      defaultProfitMargin: Value(defaultProfitMargin),
      maxProfitMargin: Value(maxProfitMargin),
      baseCurrency: Value(baseCurrency),
      trackCurrencies: Value(trackCurrencies),
      roundingStep: Value(roundingStep),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
      updatedBy: updatedBy == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedBy),
    );
  }

  factory PricingSettingsData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PricingSettingsData(
      id: serializer.fromJson<int>(json['id']),
      minProfitMargin: serializer.fromJson<double>(json['minProfitMargin']),
      defaultProfitMargin: serializer.fromJson<double>(
        json['defaultProfitMargin'],
      ),
      maxProfitMargin: serializer.fromJson<double>(json['maxProfitMargin']),
      baseCurrency: serializer.fromJson<String>(json['baseCurrency']),
      trackCurrencies: serializer.fromJson<String>(json['trackCurrencies']),
      roundingStep: serializer.fromJson<int>(json['roundingStep']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
      updatedBy: serializer.fromJson<String?>(json['updatedBy']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'minProfitMargin': serializer.toJson<double>(minProfitMargin),
      'defaultProfitMargin': serializer.toJson<double>(defaultProfitMargin),
      'maxProfitMargin': serializer.toJson<double>(maxProfitMargin),
      'baseCurrency': serializer.toJson<String>(baseCurrency),
      'trackCurrencies': serializer.toJson<String>(trackCurrencies),
      'roundingStep': serializer.toJson<int>(roundingStep),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
      'updatedBy': serializer.toJson<String?>(updatedBy),
    };
  }

  PricingSettingsData copyWith({
    int? id,
    double? minProfitMargin,
    double? defaultProfitMargin,
    double? maxProfitMargin,
    String? baseCurrency,
    String? trackCurrencies,
    int? roundingStep,
    Value<DateTime?> updatedAt = const Value.absent(),
    Value<String?> updatedBy = const Value.absent(),
  }) => PricingSettingsData(
    id: id ?? this.id,
    minProfitMargin: minProfitMargin ?? this.minProfitMargin,
    defaultProfitMargin: defaultProfitMargin ?? this.defaultProfitMargin,
    maxProfitMargin: maxProfitMargin ?? this.maxProfitMargin,
    baseCurrency: baseCurrency ?? this.baseCurrency,
    trackCurrencies: trackCurrencies ?? this.trackCurrencies,
    roundingStep: roundingStep ?? this.roundingStep,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
    updatedBy: updatedBy.present ? updatedBy.value : this.updatedBy,
  );
  PricingSettingsData copyWithCompanion(PricingSettingsCompanion data) {
    return PricingSettingsData(
      id: data.id.present ? data.id.value : this.id,
      minProfitMargin: data.minProfitMargin.present
          ? data.minProfitMargin.value
          : this.minProfitMargin,
      defaultProfitMargin: data.defaultProfitMargin.present
          ? data.defaultProfitMargin.value
          : this.defaultProfitMargin,
      maxProfitMargin: data.maxProfitMargin.present
          ? data.maxProfitMargin.value
          : this.maxProfitMargin,
      baseCurrency: data.baseCurrency.present
          ? data.baseCurrency.value
          : this.baseCurrency,
      trackCurrencies: data.trackCurrencies.present
          ? data.trackCurrencies.value
          : this.trackCurrencies,
      roundingStep: data.roundingStep.present
          ? data.roundingStep.value
          : this.roundingStep,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      updatedBy: data.updatedBy.present ? data.updatedBy.value : this.updatedBy,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PricingSettingsData(')
          ..write('id: $id, ')
          ..write('minProfitMargin: $minProfitMargin, ')
          ..write('defaultProfitMargin: $defaultProfitMargin, ')
          ..write('maxProfitMargin: $maxProfitMargin, ')
          ..write('baseCurrency: $baseCurrency, ')
          ..write('trackCurrencies: $trackCurrencies, ')
          ..write('roundingStep: $roundingStep, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('updatedBy: $updatedBy')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    minProfitMargin,
    defaultProfitMargin,
    maxProfitMargin,
    baseCurrency,
    trackCurrencies,
    roundingStep,
    updatedAt,
    updatedBy,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PricingSettingsData &&
          other.id == this.id &&
          other.minProfitMargin == this.minProfitMargin &&
          other.defaultProfitMargin == this.defaultProfitMargin &&
          other.maxProfitMargin == this.maxProfitMargin &&
          other.baseCurrency == this.baseCurrency &&
          other.trackCurrencies == this.trackCurrencies &&
          other.roundingStep == this.roundingStep &&
          other.updatedAt == this.updatedAt &&
          other.updatedBy == this.updatedBy);
}

class PricingSettingsCompanion extends UpdateCompanion<PricingSettingsData> {
  final Value<int> id;
  final Value<double> minProfitMargin;
  final Value<double> defaultProfitMargin;
  final Value<double> maxProfitMargin;
  final Value<String> baseCurrency;
  final Value<String> trackCurrencies;
  final Value<int> roundingStep;
  final Value<DateTime?> updatedAt;
  final Value<String?> updatedBy;
  const PricingSettingsCompanion({
    this.id = const Value.absent(),
    this.minProfitMargin = const Value.absent(),
    this.defaultProfitMargin = const Value.absent(),
    this.maxProfitMargin = const Value.absent(),
    this.baseCurrency = const Value.absent(),
    this.trackCurrencies = const Value.absent(),
    this.roundingStep = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.updatedBy = const Value.absent(),
  });
  PricingSettingsCompanion.insert({
    this.id = const Value.absent(),
    this.minProfitMargin = const Value.absent(),
    this.defaultProfitMargin = const Value.absent(),
    this.maxProfitMargin = const Value.absent(),
    this.baseCurrency = const Value.absent(),
    this.trackCurrencies = const Value.absent(),
    this.roundingStep = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.updatedBy = const Value.absent(),
  });
  static Insertable<PricingSettingsData> custom({
    Expression<int>? id,
    Expression<double>? minProfitMargin,
    Expression<double>? defaultProfitMargin,
    Expression<double>? maxProfitMargin,
    Expression<String>? baseCurrency,
    Expression<String>? trackCurrencies,
    Expression<int>? roundingStep,
    Expression<DateTime>? updatedAt,
    Expression<String>? updatedBy,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (minProfitMargin != null) 'min_profit_margin': minProfitMargin,
      if (defaultProfitMargin != null)
        'default_profit_margin': defaultProfitMargin,
      if (maxProfitMargin != null) 'max_profit_margin': maxProfitMargin,
      if (baseCurrency != null) 'base_currency': baseCurrency,
      if (trackCurrencies != null) 'track_currencies': trackCurrencies,
      if (roundingStep != null) 'rounding_step': roundingStep,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (updatedBy != null) 'updated_by': updatedBy,
    });
  }

  PricingSettingsCompanion copyWith({
    Value<int>? id,
    Value<double>? minProfitMargin,
    Value<double>? defaultProfitMargin,
    Value<double>? maxProfitMargin,
    Value<String>? baseCurrency,
    Value<String>? trackCurrencies,
    Value<int>? roundingStep,
    Value<DateTime?>? updatedAt,
    Value<String?>? updatedBy,
  }) {
    return PricingSettingsCompanion(
      id: id ?? this.id,
      minProfitMargin: minProfitMargin ?? this.minProfitMargin,
      defaultProfitMargin: defaultProfitMargin ?? this.defaultProfitMargin,
      maxProfitMargin: maxProfitMargin ?? this.maxProfitMargin,
      baseCurrency: baseCurrency ?? this.baseCurrency,
      trackCurrencies: trackCurrencies ?? this.trackCurrencies,
      roundingStep: roundingStep ?? this.roundingStep,
      updatedAt: updatedAt ?? this.updatedAt,
      updatedBy: updatedBy ?? this.updatedBy,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (minProfitMargin.present) {
      map['min_profit_margin'] = Variable<double>(minProfitMargin.value);
    }
    if (defaultProfitMargin.present) {
      map['default_profit_margin'] = Variable<double>(
        defaultProfitMargin.value,
      );
    }
    if (maxProfitMargin.present) {
      map['max_profit_margin'] = Variable<double>(maxProfitMargin.value);
    }
    if (baseCurrency.present) {
      map['base_currency'] = Variable<String>(baseCurrency.value);
    }
    if (trackCurrencies.present) {
      map['track_currencies'] = Variable<String>(trackCurrencies.value);
    }
    if (roundingStep.present) {
      map['rounding_step'] = Variable<int>(roundingStep.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (updatedBy.present) {
      map['updated_by'] = Variable<String>(updatedBy.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PricingSettingsCompanion(')
          ..write('id: $id, ')
          ..write('minProfitMargin: $minProfitMargin, ')
          ..write('defaultProfitMargin: $defaultProfitMargin, ')
          ..write('maxProfitMargin: $maxProfitMargin, ')
          ..write('baseCurrency: $baseCurrency, ')
          ..write('trackCurrencies: $trackCurrencies, ')
          ..write('roundingStep: $roundingStep, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('updatedBy: $updatedBy')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ProductsTable products = $ProductsTable(this);
  late final $UsersTable users = $UsersTable(this);
  late final $ThemesTable themes = $ThemesTable(this);
  late final $LanguagesTable languages = $LanguagesTable(this);
  late final $SalesInvoicesTable salesInvoices = $SalesInvoicesTable(this);
  late final $SalesItemsTable salesItems = $SalesItemsTable(this);
  late final $PurchaseInvoicesTable purchaseInvoices = $PurchaseInvoicesTable(
    this,
  );
  late final $PurchaseItemsTable purchaseItems = $PurchaseItemsTable(this);
  late final $EventsTable events = $EventsTable(this);
  late final $ExchangeRateEventsTable exchangeRateEvents =
      $ExchangeRateEventsTable(this);
  late final $PricingSettingsTable pricingSettings = $PricingSettingsTable(
    this,
  );
  late final ProductDao productDao = ProductDao(this as AppDatabase);
  late final UserDao userDao = UserDao(this as AppDatabase);
  late final ThemeDao themeDao = ThemeDao(this as AppDatabase);
  late final LanguageDao languageDao = LanguageDao(this as AppDatabase);
  late final SalesDao salesDao = SalesDao(this as AppDatabase);
  late final PurchaseDao purchaseDao = PurchaseDao(this as AppDatabase);
  late final EventDao eventDao = EventDao(this as AppDatabase);
  late final ExchangeRateDao exchangeRateDao = ExchangeRateDao(
    this as AppDatabase,
  );
  late final PricingSettingsDao pricingSettingsDao = PricingSettingsDao(
    this as AppDatabase,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    products,
    users,
    themes,
    languages,
    salesInvoices,
    salesItems,
    purchaseInvoices,
    purchaseItems,
    events,
    exchangeRateEvents,
    pricingSettings,
  ];
}

typedef $$ProductsTableCreateCompanionBuilder =
    ProductsCompanion Function({
      required String productUuid,
      required String name,
      required String serialNumber,
      required String description,
      required String brand,
      required String model,
      required String color,
      required String material,
      required DateTime purchaseDate,
      required double originalPrice,
      required double discountedPrice,
      Value<DateTime?> discountStartDate,
      Value<DateTime?> discountEndDate,
      Value<int> currentStock,
      Value<int> reorderPoint,
      required DateTime lastStockUpdate,
      Value<double> avgBuyPrice,
      Value<int> minMarginPercent,
      Value<int> syncStatus,
      Value<String> baseCurrencyCode,
      Value<double?> costExchangeRate,
      Value<double?> minPrice,
      Value<double?> sellingPrice,
      Value<double?> maxPrice,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$ProductsTableUpdateCompanionBuilder =
    ProductsCompanion Function({
      Value<String> productUuid,
      Value<String> name,
      Value<String> serialNumber,
      Value<String> description,
      Value<String> brand,
      Value<String> model,
      Value<String> color,
      Value<String> material,
      Value<DateTime> purchaseDate,
      Value<double> originalPrice,
      Value<double> discountedPrice,
      Value<DateTime?> discountStartDate,
      Value<DateTime?> discountEndDate,
      Value<int> currentStock,
      Value<int> reorderPoint,
      Value<DateTime> lastStockUpdate,
      Value<double> avgBuyPrice,
      Value<int> minMarginPercent,
      Value<int> syncStatus,
      Value<String> baseCurrencyCode,
      Value<double?> costExchangeRate,
      Value<double?> minPrice,
      Value<double?> sellingPrice,
      Value<double?> maxPrice,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$ProductsTableReferences
    extends BaseReferences<_$AppDatabase, $ProductsTable, Product> {
  $$ProductsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$SalesItemsTable, List<SalesItem>>
  _salesItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.salesItems,
    aliasName: $_aliasNameGenerator(
      db.products.productUuid,
      db.salesItems.productUuid,
    ),
  );

  $$SalesItemsTableProcessedTableManager get salesItemsRefs {
    final manager = $$SalesItemsTableTableManager($_db, $_db.salesItems).filter(
      (f) => f.productUuid.productUuid.sqlEquals(
        $_itemColumn<String>('product_uuid')!,
      ),
    );

    final cache = $_typedResult.readTableOrNull(_salesItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PurchaseItemsTable, List<PurchaseItem>>
  _purchaseItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.purchaseItems,
    aliasName: $_aliasNameGenerator(
      db.products.productUuid,
      db.purchaseItems.productUuid,
    ),
  );

  $$PurchaseItemsTableProcessedTableManager get purchaseItemsRefs {
    final manager = $$PurchaseItemsTableTableManager($_db, $_db.purchaseItems)
        .filter(
          (f) => f.productUuid.productUuid.sqlEquals(
            $_itemColumn<String>('product_uuid')!,
          ),
        );

    final cache = $_typedResult.readTableOrNull(_purchaseItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ProductsTableFilterComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get productUuid => $composableBuilder(
    column: $table.productUuid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get serialNumber => $composableBuilder(
    column: $table.serialNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get brand => $composableBuilder(
    column: $table.brand,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get model => $composableBuilder(
    column: $table.model,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get material => $composableBuilder(
    column: $table.material,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get purchaseDate => $composableBuilder(
    column: $table.purchaseDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get originalPrice => $composableBuilder(
    column: $table.originalPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get discountedPrice => $composableBuilder(
    column: $table.discountedPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get discountStartDate => $composableBuilder(
    column: $table.discountStartDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get discountEndDate => $composableBuilder(
    column: $table.discountEndDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get currentStock => $composableBuilder(
    column: $table.currentStock,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reorderPoint => $composableBuilder(
    column: $table.reorderPoint,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastStockUpdate => $composableBuilder(
    column: $table.lastStockUpdate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get avgBuyPrice => $composableBuilder(
    column: $table.avgBuyPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get minMarginPercent => $composableBuilder(
    column: $table.minMarginPercent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get baseCurrencyCode => $composableBuilder(
    column: $table.baseCurrencyCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get costExchangeRate => $composableBuilder(
    column: $table.costExchangeRate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get minPrice => $composableBuilder(
    column: $table.minPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get sellingPrice => $composableBuilder(
    column: $table.sellingPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get maxPrice => $composableBuilder(
    column: $table.maxPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> salesItemsRefs(
    Expression<bool> Function($$SalesItemsTableFilterComposer f) f,
  ) {
    final $$SalesItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productUuid,
      referencedTable: $db.salesItems,
      getReferencedColumn: (t) => t.productUuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SalesItemsTableFilterComposer(
            $db: $db,
            $table: $db.salesItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> purchaseItemsRefs(
    Expression<bool> Function($$PurchaseItemsTableFilterComposer f) f,
  ) {
    final $$PurchaseItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productUuid,
      referencedTable: $db.purchaseItems,
      getReferencedColumn: (t) => t.productUuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchaseItemsTableFilterComposer(
            $db: $db,
            $table: $db.purchaseItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProductsTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get productUuid => $composableBuilder(
    column: $table.productUuid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get serialNumber => $composableBuilder(
    column: $table.serialNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get brand => $composableBuilder(
    column: $table.brand,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get model => $composableBuilder(
    column: $table.model,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get material => $composableBuilder(
    column: $table.material,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get purchaseDate => $composableBuilder(
    column: $table.purchaseDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get originalPrice => $composableBuilder(
    column: $table.originalPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get discountedPrice => $composableBuilder(
    column: $table.discountedPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get discountStartDate => $composableBuilder(
    column: $table.discountStartDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get discountEndDate => $composableBuilder(
    column: $table.discountEndDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get currentStock => $composableBuilder(
    column: $table.currentStock,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reorderPoint => $composableBuilder(
    column: $table.reorderPoint,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastStockUpdate => $composableBuilder(
    column: $table.lastStockUpdate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get avgBuyPrice => $composableBuilder(
    column: $table.avgBuyPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get minMarginPercent => $composableBuilder(
    column: $table.minMarginPercent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get baseCurrencyCode => $composableBuilder(
    column: $table.baseCurrencyCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get costExchangeRate => $composableBuilder(
    column: $table.costExchangeRate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get minPrice => $composableBuilder(
    column: $table.minPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get sellingPrice => $composableBuilder(
    column: $table.sellingPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get maxPrice => $composableBuilder(
    column: $table.maxPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProductsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get productUuid => $composableBuilder(
    column: $table.productUuid,
    builder: (column) => column,
  );

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get serialNumber => $composableBuilder(
    column: $table.serialNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get brand =>
      $composableBuilder(column: $table.brand, builder: (column) => column);

  GeneratedColumn<String> get model =>
      $composableBuilder(column: $table.model, builder: (column) => column);

  GeneratedColumn<String> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumn<String> get material =>
      $composableBuilder(column: $table.material, builder: (column) => column);

  GeneratedColumn<DateTime> get purchaseDate => $composableBuilder(
    column: $table.purchaseDate,
    builder: (column) => column,
  );

  GeneratedColumn<double> get originalPrice => $composableBuilder(
    column: $table.originalPrice,
    builder: (column) => column,
  );

  GeneratedColumn<double> get discountedPrice => $composableBuilder(
    column: $table.discountedPrice,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get discountStartDate => $composableBuilder(
    column: $table.discountStartDate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get discountEndDate => $composableBuilder(
    column: $table.discountEndDate,
    builder: (column) => column,
  );

  GeneratedColumn<int> get currentStock => $composableBuilder(
    column: $table.currentStock,
    builder: (column) => column,
  );

  GeneratedColumn<int> get reorderPoint => $composableBuilder(
    column: $table.reorderPoint,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastStockUpdate => $composableBuilder(
    column: $table.lastStockUpdate,
    builder: (column) => column,
  );

  GeneratedColumn<double> get avgBuyPrice => $composableBuilder(
    column: $table.avgBuyPrice,
    builder: (column) => column,
  );

  GeneratedColumn<int> get minMarginPercent => $composableBuilder(
    column: $table.minMarginPercent,
    builder: (column) => column,
  );

  GeneratedColumn<int> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<String> get baseCurrencyCode => $composableBuilder(
    column: $table.baseCurrencyCode,
    builder: (column) => column,
  );

  GeneratedColumn<double> get costExchangeRate => $composableBuilder(
    column: $table.costExchangeRate,
    builder: (column) => column,
  );

  GeneratedColumn<double> get minPrice =>
      $composableBuilder(column: $table.minPrice, builder: (column) => column);

  GeneratedColumn<double> get sellingPrice => $composableBuilder(
    column: $table.sellingPrice,
    builder: (column) => column,
  );

  GeneratedColumn<double> get maxPrice =>
      $composableBuilder(column: $table.maxPrice, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> salesItemsRefs<T extends Object>(
    Expression<T> Function($$SalesItemsTableAnnotationComposer a) f,
  ) {
    final $$SalesItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productUuid,
      referencedTable: $db.salesItems,
      getReferencedColumn: (t) => t.productUuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SalesItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.salesItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> purchaseItemsRefs<T extends Object>(
    Expression<T> Function($$PurchaseItemsTableAnnotationComposer a) f,
  ) {
    final $$PurchaseItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productUuid,
      referencedTable: $db.purchaseItems,
      getReferencedColumn: (t) => t.productUuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchaseItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.purchaseItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProductsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProductsTable,
          Product,
          $$ProductsTableFilterComposer,
          $$ProductsTableOrderingComposer,
          $$ProductsTableAnnotationComposer,
          $$ProductsTableCreateCompanionBuilder,
          $$ProductsTableUpdateCompanionBuilder,
          (Product, $$ProductsTableReferences),
          Product,
          PrefetchHooks Function({bool salesItemsRefs, bool purchaseItemsRefs})
        > {
  $$ProductsTableTableManager(_$AppDatabase db, $ProductsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> productUuid = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> serialNumber = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String> brand = const Value.absent(),
                Value<String> model = const Value.absent(),
                Value<String> color = const Value.absent(),
                Value<String> material = const Value.absent(),
                Value<DateTime> purchaseDate = const Value.absent(),
                Value<double> originalPrice = const Value.absent(),
                Value<double> discountedPrice = const Value.absent(),
                Value<DateTime?> discountStartDate = const Value.absent(),
                Value<DateTime?> discountEndDate = const Value.absent(),
                Value<int> currentStock = const Value.absent(),
                Value<int> reorderPoint = const Value.absent(),
                Value<DateTime> lastStockUpdate = const Value.absent(),
                Value<double> avgBuyPrice = const Value.absent(),
                Value<int> minMarginPercent = const Value.absent(),
                Value<int> syncStatus = const Value.absent(),
                Value<String> baseCurrencyCode = const Value.absent(),
                Value<double?> costExchangeRate = const Value.absent(),
                Value<double?> minPrice = const Value.absent(),
                Value<double?> sellingPrice = const Value.absent(),
                Value<double?> maxPrice = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProductsCompanion(
                productUuid: productUuid,
                name: name,
                serialNumber: serialNumber,
                description: description,
                brand: brand,
                model: model,
                color: color,
                material: material,
                purchaseDate: purchaseDate,
                originalPrice: originalPrice,
                discountedPrice: discountedPrice,
                discountStartDate: discountStartDate,
                discountEndDate: discountEndDate,
                currentStock: currentStock,
                reorderPoint: reorderPoint,
                lastStockUpdate: lastStockUpdate,
                avgBuyPrice: avgBuyPrice,
                minMarginPercent: minMarginPercent,
                syncStatus: syncStatus,
                baseCurrencyCode: baseCurrencyCode,
                costExchangeRate: costExchangeRate,
                minPrice: minPrice,
                sellingPrice: sellingPrice,
                maxPrice: maxPrice,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String productUuid,
                required String name,
                required String serialNumber,
                required String description,
                required String brand,
                required String model,
                required String color,
                required String material,
                required DateTime purchaseDate,
                required double originalPrice,
                required double discountedPrice,
                Value<DateTime?> discountStartDate = const Value.absent(),
                Value<DateTime?> discountEndDate = const Value.absent(),
                Value<int> currentStock = const Value.absent(),
                Value<int> reorderPoint = const Value.absent(),
                required DateTime lastStockUpdate,
                Value<double> avgBuyPrice = const Value.absent(),
                Value<int> minMarginPercent = const Value.absent(),
                Value<int> syncStatus = const Value.absent(),
                Value<String> baseCurrencyCode = const Value.absent(),
                Value<double?> costExchangeRate = const Value.absent(),
                Value<double?> minPrice = const Value.absent(),
                Value<double?> sellingPrice = const Value.absent(),
                Value<double?> maxPrice = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => ProductsCompanion.insert(
                productUuid: productUuid,
                name: name,
                serialNumber: serialNumber,
                description: description,
                brand: brand,
                model: model,
                color: color,
                material: material,
                purchaseDate: purchaseDate,
                originalPrice: originalPrice,
                discountedPrice: discountedPrice,
                discountStartDate: discountStartDate,
                discountEndDate: discountEndDate,
                currentStock: currentStock,
                reorderPoint: reorderPoint,
                lastStockUpdate: lastStockUpdate,
                avgBuyPrice: avgBuyPrice,
                minMarginPercent: minMarginPercent,
                syncStatus: syncStatus,
                baseCurrencyCode: baseCurrencyCode,
                costExchangeRate: costExchangeRate,
                minPrice: minPrice,
                sellingPrice: sellingPrice,
                maxPrice: maxPrice,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ProductsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({salesItemsRefs = false, purchaseItemsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (salesItemsRefs) db.salesItems,
                    if (purchaseItemsRefs) db.purchaseItems,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (salesItemsRefs)
                        await $_getPrefetchedData<
                          Product,
                          $ProductsTable,
                          SalesItem
                        >(
                          currentTable: table,
                          referencedTable: $$ProductsTableReferences
                              ._salesItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProductsTableReferences(
                                db,
                                table,
                                p0,
                              ).salesItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.productUuid == item.productUuid,
                              ),
                          typedResults: items,
                        ),
                      if (purchaseItemsRefs)
                        await $_getPrefetchedData<
                          Product,
                          $ProductsTable,
                          PurchaseItem
                        >(
                          currentTable: table,
                          referencedTable: $$ProductsTableReferences
                              ._purchaseItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProductsTableReferences(
                                db,
                                table,
                                p0,
                              ).purchaseItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.productUuid == item.productUuid,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ProductsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProductsTable,
      Product,
      $$ProductsTableFilterComposer,
      $$ProductsTableOrderingComposer,
      $$ProductsTableAnnotationComposer,
      $$ProductsTableCreateCompanionBuilder,
      $$ProductsTableUpdateCompanionBuilder,
      (Product, $$ProductsTableReferences),
      Product,
      PrefetchHooks Function({bool salesItemsRefs, bool purchaseItemsRefs})
    >;
typedef $$UsersTableCreateCompanionBuilder =
    UsersCompanion Function({
      required String userUuid,
      required String username,
      required String password,
      required String role,
      required String nickname,
      Value<bool> isFirstLogin,
      Value<bool> loggedIn,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$UsersTableUpdateCompanionBuilder =
    UsersCompanion Function({
      Value<String> userUuid,
      Value<String> username,
      Value<String> password,
      Value<String> role,
      Value<String> nickname,
      Value<bool> isFirstLogin,
      Value<bool> loggedIn,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$UsersTableReferences
    extends BaseReferences<_$AppDatabase, $UsersTable, User> {
  $$UsersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$SalesInvoicesTable, List<SalesInvoice>>
  _salesInvoicesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.salesInvoices,
    aliasName: $_aliasNameGenerator(
      db.users.userUuid,
      db.salesInvoices.userUuid,
    ),
  );

  $$SalesInvoicesTableProcessedTableManager get salesInvoicesRefs {
    final manager = $$SalesInvoicesTableTableManager($_db, $_db.salesInvoices)
        .filter(
          (f) =>
              f.userUuid.userUuid.sqlEquals($_itemColumn<String>('user_uuid')!),
        );

    final cache = $_typedResult.readTableOrNull(_salesInvoicesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$UsersTableFilterComposer extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get userUuid => $composableBuilder(
    column: $table.userUuid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get password => $composableBuilder(
    column: $table.password,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nickname => $composableBuilder(
    column: $table.nickname,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFirstLogin => $composableBuilder(
    column: $table.isFirstLogin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get loggedIn => $composableBuilder(
    column: $table.loggedIn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> salesInvoicesRefs(
    Expression<bool> Function($$SalesInvoicesTableFilterComposer f) f,
  ) {
    final $$SalesInvoicesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userUuid,
      referencedTable: $db.salesInvoices,
      getReferencedColumn: (t) => t.userUuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SalesInvoicesTableFilterComposer(
            $db: $db,
            $table: $db.salesInvoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UsersTableOrderingComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get userUuid => $composableBuilder(
    column: $table.userUuid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get password => $composableBuilder(
    column: $table.password,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nickname => $composableBuilder(
    column: $table.nickname,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFirstLogin => $composableBuilder(
    column: $table.isFirstLogin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get loggedIn => $composableBuilder(
    column: $table.loggedIn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UsersTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get userUuid =>
      $composableBuilder(column: $table.userUuid, builder: (column) => column);

  GeneratedColumn<String> get username =>
      $composableBuilder(column: $table.username, builder: (column) => column);

  GeneratedColumn<String> get password =>
      $composableBuilder(column: $table.password, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<String> get nickname =>
      $composableBuilder(column: $table.nickname, builder: (column) => column);

  GeneratedColumn<bool> get isFirstLogin => $composableBuilder(
    column: $table.isFirstLogin,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get loggedIn =>
      $composableBuilder(column: $table.loggedIn, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> salesInvoicesRefs<T extends Object>(
    Expression<T> Function($$SalesInvoicesTableAnnotationComposer a) f,
  ) {
    final $$SalesInvoicesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userUuid,
      referencedTable: $db.salesInvoices,
      getReferencedColumn: (t) => t.userUuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SalesInvoicesTableAnnotationComposer(
            $db: $db,
            $table: $db.salesInvoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UsersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UsersTable,
          User,
          $$UsersTableFilterComposer,
          $$UsersTableOrderingComposer,
          $$UsersTableAnnotationComposer,
          $$UsersTableCreateCompanionBuilder,
          $$UsersTableUpdateCompanionBuilder,
          (User, $$UsersTableReferences),
          User,
          PrefetchHooks Function({bool salesInvoicesRefs})
        > {
  $$UsersTableTableManager(_$AppDatabase db, $UsersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> userUuid = const Value.absent(),
                Value<String> username = const Value.absent(),
                Value<String> password = const Value.absent(),
                Value<String> role = const Value.absent(),
                Value<String> nickname = const Value.absent(),
                Value<bool> isFirstLogin = const Value.absent(),
                Value<bool> loggedIn = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UsersCompanion(
                userUuid: userUuid,
                username: username,
                password: password,
                role: role,
                nickname: nickname,
                isFirstLogin: isFirstLogin,
                loggedIn: loggedIn,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String userUuid,
                required String username,
                required String password,
                required String role,
                required String nickname,
                Value<bool> isFirstLogin = const Value.absent(),
                Value<bool> loggedIn = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => UsersCompanion.insert(
                userUuid: userUuid,
                username: username,
                password: password,
                role: role,
                nickname: nickname,
                isFirstLogin: isFirstLogin,
                loggedIn: loggedIn,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$UsersTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({salesInvoicesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (salesInvoicesRefs) db.salesInvoices,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (salesInvoicesRefs)
                    await $_getPrefetchedData<User, $UsersTable, SalesInvoice>(
                      currentTable: table,
                      referencedTable: $$UsersTableReferences
                          ._salesInvoicesRefsTable(db),
                      managerFromTypedResult: (p0) => $$UsersTableReferences(
                        db,
                        table,
                        p0,
                      ).salesInvoicesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.userUuid == item.userUuid,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$UsersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UsersTable,
      User,
      $$UsersTableFilterComposer,
      $$UsersTableOrderingComposer,
      $$UsersTableAnnotationComposer,
      $$UsersTableCreateCompanionBuilder,
      $$UsersTableUpdateCompanionBuilder,
      (User, $$UsersTableReferences),
      User,
      PrefetchHooks Function({bool salesInvoicesRefs})
    >;
typedef $$ThemesTableCreateCompanionBuilder =
    ThemesCompanion Function({Value<int> id, required String themeType});
typedef $$ThemesTableUpdateCompanionBuilder =
    ThemesCompanion Function({Value<int> id, Value<String> themeType});

class $$ThemesTableFilterComposer
    extends Composer<_$AppDatabase, $ThemesTable> {
  $$ThemesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get themeType => $composableBuilder(
    column: $table.themeType,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ThemesTableOrderingComposer
    extends Composer<_$AppDatabase, $ThemesTable> {
  $$ThemesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get themeType => $composableBuilder(
    column: $table.themeType,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ThemesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ThemesTable> {
  $$ThemesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get themeType =>
      $composableBuilder(column: $table.themeType, builder: (column) => column);
}

class $$ThemesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ThemesTable,
          Theme,
          $$ThemesTableFilterComposer,
          $$ThemesTableOrderingComposer,
          $$ThemesTableAnnotationComposer,
          $$ThemesTableCreateCompanionBuilder,
          $$ThemesTableUpdateCompanionBuilder,
          (Theme, BaseReferences<_$AppDatabase, $ThemesTable, Theme>),
          Theme,
          PrefetchHooks Function()
        > {
  $$ThemesTableTableManager(_$AppDatabase db, $ThemesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ThemesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ThemesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ThemesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> themeType = const Value.absent(),
              }) => ThemesCompanion(id: id, themeType: themeType),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String themeType,
              }) => ThemesCompanion.insert(id: id, themeType: themeType),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ThemesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ThemesTable,
      Theme,
      $$ThemesTableFilterComposer,
      $$ThemesTableOrderingComposer,
      $$ThemesTableAnnotationComposer,
      $$ThemesTableCreateCompanionBuilder,
      $$ThemesTableUpdateCompanionBuilder,
      (Theme, BaseReferences<_$AppDatabase, $ThemesTable, Theme>),
      Theme,
      PrefetchHooks Function()
    >;
typedef $$LanguagesTableCreateCompanionBuilder =
    LanguagesCompanion Function({
      Value<int> id,
      required String code,
      required String name,
    });
typedef $$LanguagesTableUpdateCompanionBuilder =
    LanguagesCompanion Function({
      Value<int> id,
      Value<String> code,
      Value<String> name,
    });

class $$LanguagesTableFilterComposer
    extends Composer<_$AppDatabase, $LanguagesTable> {
  $$LanguagesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LanguagesTableOrderingComposer
    extends Composer<_$AppDatabase, $LanguagesTable> {
  $$LanguagesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LanguagesTableAnnotationComposer
    extends Composer<_$AppDatabase, $LanguagesTable> {
  $$LanguagesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);
}

class $$LanguagesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LanguagesTable,
          Language,
          $$LanguagesTableFilterComposer,
          $$LanguagesTableOrderingComposer,
          $$LanguagesTableAnnotationComposer,
          $$LanguagesTableCreateCompanionBuilder,
          $$LanguagesTableUpdateCompanionBuilder,
          (Language, BaseReferences<_$AppDatabase, $LanguagesTable, Language>),
          Language,
          PrefetchHooks Function()
        > {
  $$LanguagesTableTableManager(_$AppDatabase db, $LanguagesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LanguagesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LanguagesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LanguagesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> code = const Value.absent(),
                Value<String> name = const Value.absent(),
              }) => LanguagesCompanion(id: id, code: code, name: name),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String code,
                required String name,
              }) => LanguagesCompanion.insert(id: id, code: code, name: name),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LanguagesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LanguagesTable,
      Language,
      $$LanguagesTableFilterComposer,
      $$LanguagesTableOrderingComposer,
      $$LanguagesTableAnnotationComposer,
      $$LanguagesTableCreateCompanionBuilder,
      $$LanguagesTableUpdateCompanionBuilder,
      (Language, BaseReferences<_$AppDatabase, $LanguagesTable, Language>),
      Language,
      PrefetchHooks Function()
    >;
typedef $$SalesInvoicesTableCreateCompanionBuilder =
    SalesInvoicesCompanion Function({
      required String invoiceUuid,
      Value<String?> customerInfo,
      required DateTime invoiceDate,
      Value<double> totalAmount,
      Value<String> salesSource,
      Value<String> status,
      required String userUuid,
      Value<String?> notes,
      Value<int> syncStatus,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$SalesInvoicesTableUpdateCompanionBuilder =
    SalesInvoicesCompanion Function({
      Value<String> invoiceUuid,
      Value<String?> customerInfo,
      Value<DateTime> invoiceDate,
      Value<double> totalAmount,
      Value<String> salesSource,
      Value<String> status,
      Value<String> userUuid,
      Value<String?> notes,
      Value<int> syncStatus,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$SalesInvoicesTableReferences
    extends BaseReferences<_$AppDatabase, $SalesInvoicesTable, SalesInvoice> {
  $$SalesInvoicesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $UsersTable _userUuidTable(_$AppDatabase db) => db.users.createAlias(
    $_aliasNameGenerator(db.salesInvoices.userUuid, db.users.userUuid),
  );

  $$UsersTableProcessedTableManager get userUuid {
    final $_column = $_itemColumn<String>('user_uuid')!;

    final manager = $$UsersTableTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.userUuid.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userUuidTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$SalesItemsTable, List<SalesItem>>
  _salesItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.salesItems,
    aliasName: $_aliasNameGenerator(
      db.salesInvoices.invoiceUuid,
      db.salesItems.invoiceUuid,
    ),
  );

  $$SalesItemsTableProcessedTableManager get salesItemsRefs {
    final manager = $$SalesItemsTableTableManager($_db, $_db.salesItems).filter(
      (f) => f.invoiceUuid.invoiceUuid.sqlEquals(
        $_itemColumn<String>('invoice_uuid')!,
      ),
    );

    final cache = $_typedResult.readTableOrNull(_salesItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SalesInvoicesTableFilterComposer
    extends Composer<_$AppDatabase, $SalesInvoicesTable> {
  $$SalesInvoicesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get invoiceUuid => $composableBuilder(
    column: $table.invoiceUuid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customerInfo => $composableBuilder(
    column: $table.customerInfo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get invoiceDate => $composableBuilder(
    column: $table.invoiceDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get salesSource => $composableBuilder(
    column: $table.salesSource,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$UsersTableFilterComposer get userUuid {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userUuid,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.userUuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> salesItemsRefs(
    Expression<bool> Function($$SalesItemsTableFilterComposer f) f,
  ) {
    final $$SalesItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceUuid,
      referencedTable: $db.salesItems,
      getReferencedColumn: (t) => t.invoiceUuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SalesItemsTableFilterComposer(
            $db: $db,
            $table: $db.salesItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SalesInvoicesTableOrderingComposer
    extends Composer<_$AppDatabase, $SalesInvoicesTable> {
  $$SalesInvoicesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get invoiceUuid => $composableBuilder(
    column: $table.invoiceUuid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customerInfo => $composableBuilder(
    column: $table.customerInfo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get invoiceDate => $composableBuilder(
    column: $table.invoiceDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get salesSource => $composableBuilder(
    column: $table.salesSource,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$UsersTableOrderingComposer get userUuid {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userUuid,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.userUuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SalesInvoicesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SalesInvoicesTable> {
  $$SalesInvoicesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get invoiceUuid => $composableBuilder(
    column: $table.invoiceUuid,
    builder: (column) => column,
  );

  GeneratedColumn<String> get customerInfo => $composableBuilder(
    column: $table.customerInfo,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get invoiceDate => $composableBuilder(
    column: $table.invoiceDate,
    builder: (column) => column,
  );

  GeneratedColumn<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get salesSource => $composableBuilder(
    column: $table.salesSource,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<int> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$UsersTableAnnotationComposer get userUuid {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userUuid,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.userUuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> salesItemsRefs<T extends Object>(
    Expression<T> Function($$SalesItemsTableAnnotationComposer a) f,
  ) {
    final $$SalesItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceUuid,
      referencedTable: $db.salesItems,
      getReferencedColumn: (t) => t.invoiceUuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SalesItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.salesItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SalesInvoicesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SalesInvoicesTable,
          SalesInvoice,
          $$SalesInvoicesTableFilterComposer,
          $$SalesInvoicesTableOrderingComposer,
          $$SalesInvoicesTableAnnotationComposer,
          $$SalesInvoicesTableCreateCompanionBuilder,
          $$SalesInvoicesTableUpdateCompanionBuilder,
          (SalesInvoice, $$SalesInvoicesTableReferences),
          SalesInvoice,
          PrefetchHooks Function({bool userUuid, bool salesItemsRefs})
        > {
  $$SalesInvoicesTableTableManager(_$AppDatabase db, $SalesInvoicesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SalesInvoicesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SalesInvoicesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SalesInvoicesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> invoiceUuid = const Value.absent(),
                Value<String?> customerInfo = const Value.absent(),
                Value<DateTime> invoiceDate = const Value.absent(),
                Value<double> totalAmount = const Value.absent(),
                Value<String> salesSource = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> userUuid = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> syncStatus = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SalesInvoicesCompanion(
                invoiceUuid: invoiceUuid,
                customerInfo: customerInfo,
                invoiceDate: invoiceDate,
                totalAmount: totalAmount,
                salesSource: salesSource,
                status: status,
                userUuid: userUuid,
                notes: notes,
                syncStatus: syncStatus,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String invoiceUuid,
                Value<String?> customerInfo = const Value.absent(),
                required DateTime invoiceDate,
                Value<double> totalAmount = const Value.absent(),
                Value<String> salesSource = const Value.absent(),
                Value<String> status = const Value.absent(),
                required String userUuid,
                Value<String?> notes = const Value.absent(),
                Value<int> syncStatus = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => SalesInvoicesCompanion.insert(
                invoiceUuid: invoiceUuid,
                customerInfo: customerInfo,
                invoiceDate: invoiceDate,
                totalAmount: totalAmount,
                salesSource: salesSource,
                status: status,
                userUuid: userUuid,
                notes: notes,
                syncStatus: syncStatus,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SalesInvoicesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({userUuid = false, salesItemsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (salesItemsRefs) db.salesItems],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (userUuid) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.userUuid,
                                referencedTable: $$SalesInvoicesTableReferences
                                    ._userUuidTable(db),
                                referencedColumn: $$SalesInvoicesTableReferences
                                    ._userUuidTable(db)
                                    .userUuid,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (salesItemsRefs)
                    await $_getPrefetchedData<
                      SalesInvoice,
                      $SalesInvoicesTable,
                      SalesItem
                    >(
                      currentTable: table,
                      referencedTable: $$SalesInvoicesTableReferences
                          ._salesItemsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$SalesInvoicesTableReferences(
                            db,
                            table,
                            p0,
                          ).salesItemsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.invoiceUuid == item.invoiceUuid,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$SalesInvoicesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SalesInvoicesTable,
      SalesInvoice,
      $$SalesInvoicesTableFilterComposer,
      $$SalesInvoicesTableOrderingComposer,
      $$SalesInvoicesTableAnnotationComposer,
      $$SalesInvoicesTableCreateCompanionBuilder,
      $$SalesInvoicesTableUpdateCompanionBuilder,
      (SalesInvoice, $$SalesInvoicesTableReferences),
      SalesInvoice,
      PrefetchHooks Function({bool userUuid, bool salesItemsRefs})
    >;
typedef $$SalesItemsTableCreateCompanionBuilder =
    SalesItemsCompanion Function({
      required String itemUuid,
      required String invoiceUuid,
      required String productUuid,
      required int quantity,
      required double unitSellPrice,
      required double costAtSale,
      required double totalPrice,
      required double profit,
      Value<double?> exchangeRateAtSale,
      Value<double?> costExchangeRate,
      Value<double?> profitIrr,
      Value<int> rowid,
    });
typedef $$SalesItemsTableUpdateCompanionBuilder =
    SalesItemsCompanion Function({
      Value<String> itemUuid,
      Value<String> invoiceUuid,
      Value<String> productUuid,
      Value<int> quantity,
      Value<double> unitSellPrice,
      Value<double> costAtSale,
      Value<double> totalPrice,
      Value<double> profit,
      Value<double?> exchangeRateAtSale,
      Value<double?> costExchangeRate,
      Value<double?> profitIrr,
      Value<int> rowid,
    });

final class $$SalesItemsTableReferences
    extends BaseReferences<_$AppDatabase, $SalesItemsTable, SalesItem> {
  $$SalesItemsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $SalesInvoicesTable _invoiceUuidTable(_$AppDatabase db) =>
      db.salesInvoices.createAlias(
        $_aliasNameGenerator(
          db.salesItems.invoiceUuid,
          db.salesInvoices.invoiceUuid,
        ),
      );

  $$SalesInvoicesTableProcessedTableManager get invoiceUuid {
    final $_column = $_itemColumn<String>('invoice_uuid')!;

    final manager = $$SalesInvoicesTableTableManager(
      $_db,
      $_db.salesInvoices,
    ).filter((f) => f.invoiceUuid.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_invoiceUuidTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ProductsTable _productUuidTable(_$AppDatabase db) =>
      db.products.createAlias(
        $_aliasNameGenerator(
          db.salesItems.productUuid,
          db.products.productUuid,
        ),
      );

  $$ProductsTableProcessedTableManager get productUuid {
    final $_column = $_itemColumn<String>('product_uuid')!;

    final manager = $$ProductsTableTableManager(
      $_db,
      $_db.products,
    ).filter((f) => f.productUuid.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_productUuidTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SalesItemsTableFilterComposer
    extends Composer<_$AppDatabase, $SalesItemsTable> {
  $$SalesItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get itemUuid => $composableBuilder(
    column: $table.itemUuid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get unitSellPrice => $composableBuilder(
    column: $table.unitSellPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get costAtSale => $composableBuilder(
    column: $table.costAtSale,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalPrice => $composableBuilder(
    column: $table.totalPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get profit => $composableBuilder(
    column: $table.profit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get exchangeRateAtSale => $composableBuilder(
    column: $table.exchangeRateAtSale,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get costExchangeRate => $composableBuilder(
    column: $table.costExchangeRate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get profitIrr => $composableBuilder(
    column: $table.profitIrr,
    builder: (column) => ColumnFilters(column),
  );

  $$SalesInvoicesTableFilterComposer get invoiceUuid {
    final $$SalesInvoicesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceUuid,
      referencedTable: $db.salesInvoices,
      getReferencedColumn: (t) => t.invoiceUuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SalesInvoicesTableFilterComposer(
            $db: $db,
            $table: $db.salesInvoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductsTableFilterComposer get productUuid {
    final $$ProductsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productUuid,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.productUuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableFilterComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SalesItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $SalesItemsTable> {
  $$SalesItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get itemUuid => $composableBuilder(
    column: $table.itemUuid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get unitSellPrice => $composableBuilder(
    column: $table.unitSellPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get costAtSale => $composableBuilder(
    column: $table.costAtSale,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalPrice => $composableBuilder(
    column: $table.totalPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get profit => $composableBuilder(
    column: $table.profit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get exchangeRateAtSale => $composableBuilder(
    column: $table.exchangeRateAtSale,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get costExchangeRate => $composableBuilder(
    column: $table.costExchangeRate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get profitIrr => $composableBuilder(
    column: $table.profitIrr,
    builder: (column) => ColumnOrderings(column),
  );

  $$SalesInvoicesTableOrderingComposer get invoiceUuid {
    final $$SalesInvoicesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceUuid,
      referencedTable: $db.salesInvoices,
      getReferencedColumn: (t) => t.invoiceUuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SalesInvoicesTableOrderingComposer(
            $db: $db,
            $table: $db.salesInvoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductsTableOrderingComposer get productUuid {
    final $$ProductsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productUuid,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.productUuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableOrderingComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SalesItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SalesItemsTable> {
  $$SalesItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get itemUuid =>
      $composableBuilder(column: $table.itemUuid, builder: (column) => column);

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<double> get unitSellPrice => $composableBuilder(
    column: $table.unitSellPrice,
    builder: (column) => column,
  );

  GeneratedColumn<double> get costAtSale => $composableBuilder(
    column: $table.costAtSale,
    builder: (column) => column,
  );

  GeneratedColumn<double> get totalPrice => $composableBuilder(
    column: $table.totalPrice,
    builder: (column) => column,
  );

  GeneratedColumn<double> get profit =>
      $composableBuilder(column: $table.profit, builder: (column) => column);

  GeneratedColumn<double> get exchangeRateAtSale => $composableBuilder(
    column: $table.exchangeRateAtSale,
    builder: (column) => column,
  );

  GeneratedColumn<double> get costExchangeRate => $composableBuilder(
    column: $table.costExchangeRate,
    builder: (column) => column,
  );

  GeneratedColumn<double> get profitIrr =>
      $composableBuilder(column: $table.profitIrr, builder: (column) => column);

  $$SalesInvoicesTableAnnotationComposer get invoiceUuid {
    final $$SalesInvoicesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceUuid,
      referencedTable: $db.salesInvoices,
      getReferencedColumn: (t) => t.invoiceUuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SalesInvoicesTableAnnotationComposer(
            $db: $db,
            $table: $db.salesInvoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductsTableAnnotationComposer get productUuid {
    final $$ProductsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productUuid,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.productUuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableAnnotationComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SalesItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SalesItemsTable,
          SalesItem,
          $$SalesItemsTableFilterComposer,
          $$SalesItemsTableOrderingComposer,
          $$SalesItemsTableAnnotationComposer,
          $$SalesItemsTableCreateCompanionBuilder,
          $$SalesItemsTableUpdateCompanionBuilder,
          (SalesItem, $$SalesItemsTableReferences),
          SalesItem,
          PrefetchHooks Function({bool invoiceUuid, bool productUuid})
        > {
  $$SalesItemsTableTableManager(_$AppDatabase db, $SalesItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SalesItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SalesItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SalesItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> itemUuid = const Value.absent(),
                Value<String> invoiceUuid = const Value.absent(),
                Value<String> productUuid = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<double> unitSellPrice = const Value.absent(),
                Value<double> costAtSale = const Value.absent(),
                Value<double> totalPrice = const Value.absent(),
                Value<double> profit = const Value.absent(),
                Value<double?> exchangeRateAtSale = const Value.absent(),
                Value<double?> costExchangeRate = const Value.absent(),
                Value<double?> profitIrr = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SalesItemsCompanion(
                itemUuid: itemUuid,
                invoiceUuid: invoiceUuid,
                productUuid: productUuid,
                quantity: quantity,
                unitSellPrice: unitSellPrice,
                costAtSale: costAtSale,
                totalPrice: totalPrice,
                profit: profit,
                exchangeRateAtSale: exchangeRateAtSale,
                costExchangeRate: costExchangeRate,
                profitIrr: profitIrr,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String itemUuid,
                required String invoiceUuid,
                required String productUuid,
                required int quantity,
                required double unitSellPrice,
                required double costAtSale,
                required double totalPrice,
                required double profit,
                Value<double?> exchangeRateAtSale = const Value.absent(),
                Value<double?> costExchangeRate = const Value.absent(),
                Value<double?> profitIrr = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SalesItemsCompanion.insert(
                itemUuid: itemUuid,
                invoiceUuid: invoiceUuid,
                productUuid: productUuid,
                quantity: quantity,
                unitSellPrice: unitSellPrice,
                costAtSale: costAtSale,
                totalPrice: totalPrice,
                profit: profit,
                exchangeRateAtSale: exchangeRateAtSale,
                costExchangeRate: costExchangeRate,
                profitIrr: profitIrr,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SalesItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({invoiceUuid = false, productUuid = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (invoiceUuid) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.invoiceUuid,
                                referencedTable: $$SalesItemsTableReferences
                                    ._invoiceUuidTable(db),
                                referencedColumn: $$SalesItemsTableReferences
                                    ._invoiceUuidTable(db)
                                    .invoiceUuid,
                              )
                              as T;
                    }
                    if (productUuid) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.productUuid,
                                referencedTable: $$SalesItemsTableReferences
                                    ._productUuidTable(db),
                                referencedColumn: $$SalesItemsTableReferences
                                    ._productUuidTable(db)
                                    .productUuid,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$SalesItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SalesItemsTable,
      SalesItem,
      $$SalesItemsTableFilterComposer,
      $$SalesItemsTableOrderingComposer,
      $$SalesItemsTableAnnotationComposer,
      $$SalesItemsTableCreateCompanionBuilder,
      $$SalesItemsTableUpdateCompanionBuilder,
      (SalesItem, $$SalesItemsTableReferences),
      SalesItem,
      PrefetchHooks Function({bool invoiceUuid, bool productUuid})
    >;
typedef $$PurchaseInvoicesTableCreateCompanionBuilder =
    PurchaseInvoicesCompanion Function({
      required String purchaseUuid,
      Value<String?> supplierName,
      required DateTime purchaseDate,
      Value<double> totalCost,
      Value<double> additionalCosts,
      Value<double> finalTotal,
      Value<String?> notes,
      Value<int> syncStatus,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$PurchaseInvoicesTableUpdateCompanionBuilder =
    PurchaseInvoicesCompanion Function({
      Value<String> purchaseUuid,
      Value<String?> supplierName,
      Value<DateTime> purchaseDate,
      Value<double> totalCost,
      Value<double> additionalCosts,
      Value<double> finalTotal,
      Value<String?> notes,
      Value<int> syncStatus,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$PurchaseInvoicesTableReferences
    extends
        BaseReferences<_$AppDatabase, $PurchaseInvoicesTable, PurchaseInvoice> {
  $$PurchaseInvoicesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$PurchaseItemsTable, List<PurchaseItem>>
  _purchaseItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.purchaseItems,
    aliasName: $_aliasNameGenerator(
      db.purchaseInvoices.purchaseUuid,
      db.purchaseItems.purchaseUuid,
    ),
  );

  $$PurchaseItemsTableProcessedTableManager get purchaseItemsRefs {
    final manager = $$PurchaseItemsTableTableManager($_db, $_db.purchaseItems)
        .filter(
          (f) => f.purchaseUuid.purchaseUuid.sqlEquals(
            $_itemColumn<String>('purchase_uuid')!,
          ),
        );

    final cache = $_typedResult.readTableOrNull(_purchaseItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PurchaseInvoicesTableFilterComposer
    extends Composer<_$AppDatabase, $PurchaseInvoicesTable> {
  $$PurchaseInvoicesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get purchaseUuid => $composableBuilder(
    column: $table.purchaseUuid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get supplierName => $composableBuilder(
    column: $table.supplierName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get purchaseDate => $composableBuilder(
    column: $table.purchaseDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalCost => $composableBuilder(
    column: $table.totalCost,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get additionalCosts => $composableBuilder(
    column: $table.additionalCosts,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get finalTotal => $composableBuilder(
    column: $table.finalTotal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> purchaseItemsRefs(
    Expression<bool> Function($$PurchaseItemsTableFilterComposer f) f,
  ) {
    final $$PurchaseItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.purchaseUuid,
      referencedTable: $db.purchaseItems,
      getReferencedColumn: (t) => t.purchaseUuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchaseItemsTableFilterComposer(
            $db: $db,
            $table: $db.purchaseItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PurchaseInvoicesTableOrderingComposer
    extends Composer<_$AppDatabase, $PurchaseInvoicesTable> {
  $$PurchaseInvoicesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get purchaseUuid => $composableBuilder(
    column: $table.purchaseUuid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get supplierName => $composableBuilder(
    column: $table.supplierName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get purchaseDate => $composableBuilder(
    column: $table.purchaseDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalCost => $composableBuilder(
    column: $table.totalCost,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get additionalCosts => $composableBuilder(
    column: $table.additionalCosts,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get finalTotal => $composableBuilder(
    column: $table.finalTotal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PurchaseInvoicesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PurchaseInvoicesTable> {
  $$PurchaseInvoicesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get purchaseUuid => $composableBuilder(
    column: $table.purchaseUuid,
    builder: (column) => column,
  );

  GeneratedColumn<String> get supplierName => $composableBuilder(
    column: $table.supplierName,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get purchaseDate => $composableBuilder(
    column: $table.purchaseDate,
    builder: (column) => column,
  );

  GeneratedColumn<double> get totalCost =>
      $composableBuilder(column: $table.totalCost, builder: (column) => column);

  GeneratedColumn<double> get additionalCosts => $composableBuilder(
    column: $table.additionalCosts,
    builder: (column) => column,
  );

  GeneratedColumn<double> get finalTotal => $composableBuilder(
    column: $table.finalTotal,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<int> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> purchaseItemsRefs<T extends Object>(
    Expression<T> Function($$PurchaseItemsTableAnnotationComposer a) f,
  ) {
    final $$PurchaseItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.purchaseUuid,
      referencedTable: $db.purchaseItems,
      getReferencedColumn: (t) => t.purchaseUuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchaseItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.purchaseItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PurchaseInvoicesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PurchaseInvoicesTable,
          PurchaseInvoice,
          $$PurchaseInvoicesTableFilterComposer,
          $$PurchaseInvoicesTableOrderingComposer,
          $$PurchaseInvoicesTableAnnotationComposer,
          $$PurchaseInvoicesTableCreateCompanionBuilder,
          $$PurchaseInvoicesTableUpdateCompanionBuilder,
          (PurchaseInvoice, $$PurchaseInvoicesTableReferences),
          PurchaseInvoice,
          PrefetchHooks Function({bool purchaseItemsRefs})
        > {
  $$PurchaseInvoicesTableTableManager(
    _$AppDatabase db,
    $PurchaseInvoicesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PurchaseInvoicesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PurchaseInvoicesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PurchaseInvoicesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> purchaseUuid = const Value.absent(),
                Value<String?> supplierName = const Value.absent(),
                Value<DateTime> purchaseDate = const Value.absent(),
                Value<double> totalCost = const Value.absent(),
                Value<double> additionalCosts = const Value.absent(),
                Value<double> finalTotal = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> syncStatus = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PurchaseInvoicesCompanion(
                purchaseUuid: purchaseUuid,
                supplierName: supplierName,
                purchaseDate: purchaseDate,
                totalCost: totalCost,
                additionalCosts: additionalCosts,
                finalTotal: finalTotal,
                notes: notes,
                syncStatus: syncStatus,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String purchaseUuid,
                Value<String?> supplierName = const Value.absent(),
                required DateTime purchaseDate,
                Value<double> totalCost = const Value.absent(),
                Value<double> additionalCosts = const Value.absent(),
                Value<double> finalTotal = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> syncStatus = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => PurchaseInvoicesCompanion.insert(
                purchaseUuid: purchaseUuid,
                supplierName: supplierName,
                purchaseDate: purchaseDate,
                totalCost: totalCost,
                additionalCosts: additionalCosts,
                finalTotal: finalTotal,
                notes: notes,
                syncStatus: syncStatus,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PurchaseInvoicesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({purchaseItemsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (purchaseItemsRefs) db.purchaseItems,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (purchaseItemsRefs)
                    await $_getPrefetchedData<
                      PurchaseInvoice,
                      $PurchaseInvoicesTable,
                      PurchaseItem
                    >(
                      currentTable: table,
                      referencedTable: $$PurchaseInvoicesTableReferences
                          ._purchaseItemsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$PurchaseInvoicesTableReferences(
                            db,
                            table,
                            p0,
                          ).purchaseItemsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.purchaseUuid == item.purchaseUuid,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$PurchaseInvoicesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PurchaseInvoicesTable,
      PurchaseInvoice,
      $$PurchaseInvoicesTableFilterComposer,
      $$PurchaseInvoicesTableOrderingComposer,
      $$PurchaseInvoicesTableAnnotationComposer,
      $$PurchaseInvoicesTableCreateCompanionBuilder,
      $$PurchaseInvoicesTableUpdateCompanionBuilder,
      (PurchaseInvoice, $$PurchaseInvoicesTableReferences),
      PurchaseInvoice,
      PrefetchHooks Function({bool purchaseItemsRefs})
    >;
typedef $$PurchaseItemsTableCreateCompanionBuilder =
    PurchaseItemsCompanion Function({
      required String itemUuid,
      required String purchaseUuid,
      required String productUuid,
      required int quantity,
      required double unitBuyPrice,
      required double totalPrice,
      Value<String> currencyCode,
      Value<double?> exchangeRateAtPurchase,
      Value<double?> costInBaseCurrency,
      Value<int> rowid,
    });
typedef $$PurchaseItemsTableUpdateCompanionBuilder =
    PurchaseItemsCompanion Function({
      Value<String> itemUuid,
      Value<String> purchaseUuid,
      Value<String> productUuid,
      Value<int> quantity,
      Value<double> unitBuyPrice,
      Value<double> totalPrice,
      Value<String> currencyCode,
      Value<double?> exchangeRateAtPurchase,
      Value<double?> costInBaseCurrency,
      Value<int> rowid,
    });

final class $$PurchaseItemsTableReferences
    extends BaseReferences<_$AppDatabase, $PurchaseItemsTable, PurchaseItem> {
  $$PurchaseItemsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $PurchaseInvoicesTable _purchaseUuidTable(_$AppDatabase db) =>
      db.purchaseInvoices.createAlias(
        $_aliasNameGenerator(
          db.purchaseItems.purchaseUuid,
          db.purchaseInvoices.purchaseUuid,
        ),
      );

  $$PurchaseInvoicesTableProcessedTableManager get purchaseUuid {
    final $_column = $_itemColumn<String>('purchase_uuid')!;

    final manager = $$PurchaseInvoicesTableTableManager(
      $_db,
      $_db.purchaseInvoices,
    ).filter((f) => f.purchaseUuid.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_purchaseUuidTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ProductsTable _productUuidTable(_$AppDatabase db) =>
      db.products.createAlias(
        $_aliasNameGenerator(
          db.purchaseItems.productUuid,
          db.products.productUuid,
        ),
      );

  $$ProductsTableProcessedTableManager get productUuid {
    final $_column = $_itemColumn<String>('product_uuid')!;

    final manager = $$ProductsTableTableManager(
      $_db,
      $_db.products,
    ).filter((f) => f.productUuid.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_productUuidTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PurchaseItemsTableFilterComposer
    extends Composer<_$AppDatabase, $PurchaseItemsTable> {
  $$PurchaseItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get itemUuid => $composableBuilder(
    column: $table.itemUuid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get unitBuyPrice => $composableBuilder(
    column: $table.unitBuyPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalPrice => $composableBuilder(
    column: $table.totalPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get exchangeRateAtPurchase => $composableBuilder(
    column: $table.exchangeRateAtPurchase,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get costInBaseCurrency => $composableBuilder(
    column: $table.costInBaseCurrency,
    builder: (column) => ColumnFilters(column),
  );

  $$PurchaseInvoicesTableFilterComposer get purchaseUuid {
    final $$PurchaseInvoicesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.purchaseUuid,
      referencedTable: $db.purchaseInvoices,
      getReferencedColumn: (t) => t.purchaseUuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchaseInvoicesTableFilterComposer(
            $db: $db,
            $table: $db.purchaseInvoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductsTableFilterComposer get productUuid {
    final $$ProductsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productUuid,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.productUuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableFilterComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PurchaseItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $PurchaseItemsTable> {
  $$PurchaseItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get itemUuid => $composableBuilder(
    column: $table.itemUuid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get unitBuyPrice => $composableBuilder(
    column: $table.unitBuyPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalPrice => $composableBuilder(
    column: $table.totalPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get exchangeRateAtPurchase => $composableBuilder(
    column: $table.exchangeRateAtPurchase,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get costInBaseCurrency => $composableBuilder(
    column: $table.costInBaseCurrency,
    builder: (column) => ColumnOrderings(column),
  );

  $$PurchaseInvoicesTableOrderingComposer get purchaseUuid {
    final $$PurchaseInvoicesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.purchaseUuid,
      referencedTable: $db.purchaseInvoices,
      getReferencedColumn: (t) => t.purchaseUuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchaseInvoicesTableOrderingComposer(
            $db: $db,
            $table: $db.purchaseInvoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductsTableOrderingComposer get productUuid {
    final $$ProductsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productUuid,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.productUuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableOrderingComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PurchaseItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PurchaseItemsTable> {
  $$PurchaseItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get itemUuid =>
      $composableBuilder(column: $table.itemUuid, builder: (column) => column);

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<double> get unitBuyPrice => $composableBuilder(
    column: $table.unitBuyPrice,
    builder: (column) => column,
  );

  GeneratedColumn<double> get totalPrice => $composableBuilder(
    column: $table.totalPrice,
    builder: (column) => column,
  );

  GeneratedColumn<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => column,
  );

  GeneratedColumn<double> get exchangeRateAtPurchase => $composableBuilder(
    column: $table.exchangeRateAtPurchase,
    builder: (column) => column,
  );

  GeneratedColumn<double> get costInBaseCurrency => $composableBuilder(
    column: $table.costInBaseCurrency,
    builder: (column) => column,
  );

  $$PurchaseInvoicesTableAnnotationComposer get purchaseUuid {
    final $$PurchaseInvoicesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.purchaseUuid,
      referencedTable: $db.purchaseInvoices,
      getReferencedColumn: (t) => t.purchaseUuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchaseInvoicesTableAnnotationComposer(
            $db: $db,
            $table: $db.purchaseInvoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductsTableAnnotationComposer get productUuid {
    final $$ProductsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productUuid,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.productUuid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableAnnotationComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PurchaseItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PurchaseItemsTable,
          PurchaseItem,
          $$PurchaseItemsTableFilterComposer,
          $$PurchaseItemsTableOrderingComposer,
          $$PurchaseItemsTableAnnotationComposer,
          $$PurchaseItemsTableCreateCompanionBuilder,
          $$PurchaseItemsTableUpdateCompanionBuilder,
          (PurchaseItem, $$PurchaseItemsTableReferences),
          PurchaseItem,
          PrefetchHooks Function({bool purchaseUuid, bool productUuid})
        > {
  $$PurchaseItemsTableTableManager(_$AppDatabase db, $PurchaseItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PurchaseItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PurchaseItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PurchaseItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> itemUuid = const Value.absent(),
                Value<String> purchaseUuid = const Value.absent(),
                Value<String> productUuid = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<double> unitBuyPrice = const Value.absent(),
                Value<double> totalPrice = const Value.absent(),
                Value<String> currencyCode = const Value.absent(),
                Value<double?> exchangeRateAtPurchase = const Value.absent(),
                Value<double?> costInBaseCurrency = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PurchaseItemsCompanion(
                itemUuid: itemUuid,
                purchaseUuid: purchaseUuid,
                productUuid: productUuid,
                quantity: quantity,
                unitBuyPrice: unitBuyPrice,
                totalPrice: totalPrice,
                currencyCode: currencyCode,
                exchangeRateAtPurchase: exchangeRateAtPurchase,
                costInBaseCurrency: costInBaseCurrency,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String itemUuid,
                required String purchaseUuid,
                required String productUuid,
                required int quantity,
                required double unitBuyPrice,
                required double totalPrice,
                Value<String> currencyCode = const Value.absent(),
                Value<double?> exchangeRateAtPurchase = const Value.absent(),
                Value<double?> costInBaseCurrency = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PurchaseItemsCompanion.insert(
                itemUuid: itemUuid,
                purchaseUuid: purchaseUuid,
                productUuid: productUuid,
                quantity: quantity,
                unitBuyPrice: unitBuyPrice,
                totalPrice: totalPrice,
                currencyCode: currencyCode,
                exchangeRateAtPurchase: exchangeRateAtPurchase,
                costInBaseCurrency: costInBaseCurrency,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PurchaseItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({purchaseUuid = false, productUuid = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (purchaseUuid) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.purchaseUuid,
                                referencedTable: $$PurchaseItemsTableReferences
                                    ._purchaseUuidTable(db),
                                referencedColumn: $$PurchaseItemsTableReferences
                                    ._purchaseUuidTable(db)
                                    .purchaseUuid,
                              )
                              as T;
                    }
                    if (productUuid) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.productUuid,
                                referencedTable: $$PurchaseItemsTableReferences
                                    ._productUuidTable(db),
                                referencedColumn: $$PurchaseItemsTableReferences
                                    ._productUuidTable(db)
                                    .productUuid,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PurchaseItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PurchaseItemsTable,
      PurchaseItem,
      $$PurchaseItemsTableFilterComposer,
      $$PurchaseItemsTableOrderingComposer,
      $$PurchaseItemsTableAnnotationComposer,
      $$PurchaseItemsTableCreateCompanionBuilder,
      $$PurchaseItemsTableUpdateCompanionBuilder,
      (PurchaseItem, $$PurchaseItemsTableReferences),
      PurchaseItem,
      PrefetchHooks Function({bool purchaseUuid, bool productUuid})
    >;
typedef $$EventsTableCreateCompanionBuilder =
    EventsCompanion Function({
      required String eventId,
      required String eventType,
      required String entityType,
      required String entityId,
      required String payload,
      Value<String?> userUuid,
      required DateTime timestamp,
      Value<String?> metadata,
      Value<int> rowid,
    });
typedef $$EventsTableUpdateCompanionBuilder =
    EventsCompanion Function({
      Value<String> eventId,
      Value<String> eventType,
      Value<String> entityType,
      Value<String> entityId,
      Value<String> payload,
      Value<String?> userUuid,
      Value<DateTime> timestamp,
      Value<String?> metadata,
      Value<int> rowid,
    });

class $$EventsTableFilterComposer
    extends Composer<_$AppDatabase, $EventsTable> {
  $$EventsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get eventId => $composableBuilder(
    column: $table.eventId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get eventType => $composableBuilder(
    column: $table.eventType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userUuid => $composableBuilder(
    column: $table.userUuid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get metadata => $composableBuilder(
    column: $table.metadata,
    builder: (column) => ColumnFilters(column),
  );
}

class $$EventsTableOrderingComposer
    extends Composer<_$AppDatabase, $EventsTable> {
  $$EventsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get eventId => $composableBuilder(
    column: $table.eventId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get eventType => $composableBuilder(
    column: $table.eventType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userUuid => $composableBuilder(
    column: $table.userUuid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get metadata => $composableBuilder(
    column: $table.metadata,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$EventsTableAnnotationComposer
    extends Composer<_$AppDatabase, $EventsTable> {
  $$EventsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get eventId =>
      $composableBuilder(column: $table.eventId, builder: (column) => column);

  GeneratedColumn<String> get eventType =>
      $composableBuilder(column: $table.eventType, builder: (column) => column);

  GeneratedColumn<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get entityId =>
      $composableBuilder(column: $table.entityId, builder: (column) => column);

  GeneratedColumn<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);

  GeneratedColumn<String> get userUuid =>
      $composableBuilder(column: $table.userUuid, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<String> get metadata =>
      $composableBuilder(column: $table.metadata, builder: (column) => column);
}

class $$EventsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EventsTable,
          Event,
          $$EventsTableFilterComposer,
          $$EventsTableOrderingComposer,
          $$EventsTableAnnotationComposer,
          $$EventsTableCreateCompanionBuilder,
          $$EventsTableUpdateCompanionBuilder,
          (Event, BaseReferences<_$AppDatabase, $EventsTable, Event>),
          Event,
          PrefetchHooks Function()
        > {
  $$EventsTableTableManager(_$AppDatabase db, $EventsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EventsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EventsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EventsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> eventId = const Value.absent(),
                Value<String> eventType = const Value.absent(),
                Value<String> entityType = const Value.absent(),
                Value<String> entityId = const Value.absent(),
                Value<String> payload = const Value.absent(),
                Value<String?> userUuid = const Value.absent(),
                Value<DateTime> timestamp = const Value.absent(),
                Value<String?> metadata = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EventsCompanion(
                eventId: eventId,
                eventType: eventType,
                entityType: entityType,
                entityId: entityId,
                payload: payload,
                userUuid: userUuid,
                timestamp: timestamp,
                metadata: metadata,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String eventId,
                required String eventType,
                required String entityType,
                required String entityId,
                required String payload,
                Value<String?> userUuid = const Value.absent(),
                required DateTime timestamp,
                Value<String?> metadata = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EventsCompanion.insert(
                eventId: eventId,
                eventType: eventType,
                entityType: entityType,
                entityId: entityId,
                payload: payload,
                userUuid: userUuid,
                timestamp: timestamp,
                metadata: metadata,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$EventsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EventsTable,
      Event,
      $$EventsTableFilterComposer,
      $$EventsTableOrderingComposer,
      $$EventsTableAnnotationComposer,
      $$EventsTableCreateCompanionBuilder,
      $$EventsTableUpdateCompanionBuilder,
      (Event, BaseReferences<_$AppDatabase, $EventsTable, Event>),
      Event,
      PrefetchHooks Function()
    >;
typedef $$ExchangeRateEventsTableCreateCompanionBuilder =
    ExchangeRateEventsCompanion Function({
      Value<int> id,
      required String currencyCode,
      required double rate,
      required DateTime recordedAt,
      required String source,
      Value<double> confidence,
      Value<String?> notes,
      required String recordedBy,
    });
typedef $$ExchangeRateEventsTableUpdateCompanionBuilder =
    ExchangeRateEventsCompanion Function({
      Value<int> id,
      Value<String> currencyCode,
      Value<double> rate,
      Value<DateTime> recordedAt,
      Value<String> source,
      Value<double> confidence,
      Value<String?> notes,
      Value<String> recordedBy,
    });

class $$ExchangeRateEventsTableFilterComposer
    extends Composer<_$AppDatabase, $ExchangeRateEventsTable> {
  $$ExchangeRateEventsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get rate => $composableBuilder(
    column: $table.rate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get recordedAt => $composableBuilder(
    column: $table.recordedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get recordedBy => $composableBuilder(
    column: $table.recordedBy,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ExchangeRateEventsTableOrderingComposer
    extends Composer<_$AppDatabase, $ExchangeRateEventsTable> {
  $$ExchangeRateEventsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get rate => $composableBuilder(
    column: $table.rate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get recordedAt => $composableBuilder(
    column: $table.recordedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get recordedBy => $composableBuilder(
    column: $table.recordedBy,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ExchangeRateEventsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExchangeRateEventsTable> {
  $$ExchangeRateEventsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => column,
  );

  GeneratedColumn<double> get rate =>
      $composableBuilder(column: $table.rate, builder: (column) => column);

  GeneratedColumn<DateTime> get recordedAt => $composableBuilder(
    column: $table.recordedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get recordedBy => $composableBuilder(
    column: $table.recordedBy,
    builder: (column) => column,
  );
}

class $$ExchangeRateEventsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExchangeRateEventsTable,
          ExchangeRateEventData,
          $$ExchangeRateEventsTableFilterComposer,
          $$ExchangeRateEventsTableOrderingComposer,
          $$ExchangeRateEventsTableAnnotationComposer,
          $$ExchangeRateEventsTableCreateCompanionBuilder,
          $$ExchangeRateEventsTableUpdateCompanionBuilder,
          (
            ExchangeRateEventData,
            BaseReferences<
              _$AppDatabase,
              $ExchangeRateEventsTable,
              ExchangeRateEventData
            >,
          ),
          ExchangeRateEventData,
          PrefetchHooks Function()
        > {
  $$ExchangeRateEventsTableTableManager(
    _$AppDatabase db,
    $ExchangeRateEventsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExchangeRateEventsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExchangeRateEventsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExchangeRateEventsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> currencyCode = const Value.absent(),
                Value<double> rate = const Value.absent(),
                Value<DateTime> recordedAt = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<double> confidence = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String> recordedBy = const Value.absent(),
              }) => ExchangeRateEventsCompanion(
                id: id,
                currencyCode: currencyCode,
                rate: rate,
                recordedAt: recordedAt,
                source: source,
                confidence: confidence,
                notes: notes,
                recordedBy: recordedBy,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String currencyCode,
                required double rate,
                required DateTime recordedAt,
                required String source,
                Value<double> confidence = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                required String recordedBy,
              }) => ExchangeRateEventsCompanion.insert(
                id: id,
                currencyCode: currencyCode,
                rate: rate,
                recordedAt: recordedAt,
                source: source,
                confidence: confidence,
                notes: notes,
                recordedBy: recordedBy,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ExchangeRateEventsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExchangeRateEventsTable,
      ExchangeRateEventData,
      $$ExchangeRateEventsTableFilterComposer,
      $$ExchangeRateEventsTableOrderingComposer,
      $$ExchangeRateEventsTableAnnotationComposer,
      $$ExchangeRateEventsTableCreateCompanionBuilder,
      $$ExchangeRateEventsTableUpdateCompanionBuilder,
      (
        ExchangeRateEventData,
        BaseReferences<
          _$AppDatabase,
          $ExchangeRateEventsTable,
          ExchangeRateEventData
        >,
      ),
      ExchangeRateEventData,
      PrefetchHooks Function()
    >;
typedef $$PricingSettingsTableCreateCompanionBuilder =
    PricingSettingsCompanion Function({
      Value<int> id,
      Value<double> minProfitMargin,
      Value<double> defaultProfitMargin,
      Value<double> maxProfitMargin,
      Value<String> baseCurrency,
      Value<String> trackCurrencies,
      Value<int> roundingStep,
      Value<DateTime?> updatedAt,
      Value<String?> updatedBy,
    });
typedef $$PricingSettingsTableUpdateCompanionBuilder =
    PricingSettingsCompanion Function({
      Value<int> id,
      Value<double> minProfitMargin,
      Value<double> defaultProfitMargin,
      Value<double> maxProfitMargin,
      Value<String> baseCurrency,
      Value<String> trackCurrencies,
      Value<int> roundingStep,
      Value<DateTime?> updatedAt,
      Value<String?> updatedBy,
    });

class $$PricingSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $PricingSettingsTable> {
  $$PricingSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get minProfitMargin => $composableBuilder(
    column: $table.minProfitMargin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get defaultProfitMargin => $composableBuilder(
    column: $table.defaultProfitMargin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get maxProfitMargin => $composableBuilder(
    column: $table.maxProfitMargin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get baseCurrency => $composableBuilder(
    column: $table.baseCurrency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get trackCurrencies => $composableBuilder(
    column: $table.trackCurrencies,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get roundingStep => $composableBuilder(
    column: $table.roundingStep,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedBy => $composableBuilder(
    column: $table.updatedBy,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PricingSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $PricingSettingsTable> {
  $$PricingSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get minProfitMargin => $composableBuilder(
    column: $table.minProfitMargin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get defaultProfitMargin => $composableBuilder(
    column: $table.defaultProfitMargin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get maxProfitMargin => $composableBuilder(
    column: $table.maxProfitMargin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get baseCurrency => $composableBuilder(
    column: $table.baseCurrency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get trackCurrencies => $composableBuilder(
    column: $table.trackCurrencies,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get roundingStep => $composableBuilder(
    column: $table.roundingStep,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedBy => $composableBuilder(
    column: $table.updatedBy,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PricingSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PricingSettingsTable> {
  $$PricingSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get minProfitMargin => $composableBuilder(
    column: $table.minProfitMargin,
    builder: (column) => column,
  );

  GeneratedColumn<double> get defaultProfitMargin => $composableBuilder(
    column: $table.defaultProfitMargin,
    builder: (column) => column,
  );

  GeneratedColumn<double> get maxProfitMargin => $composableBuilder(
    column: $table.maxProfitMargin,
    builder: (column) => column,
  );

  GeneratedColumn<String> get baseCurrency => $composableBuilder(
    column: $table.baseCurrency,
    builder: (column) => column,
  );

  GeneratedColumn<String> get trackCurrencies => $composableBuilder(
    column: $table.trackCurrencies,
    builder: (column) => column,
  );

  GeneratedColumn<int> get roundingStep => $composableBuilder(
    column: $table.roundingStep,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get updatedBy =>
      $composableBuilder(column: $table.updatedBy, builder: (column) => column);
}

class $$PricingSettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PricingSettingsTable,
          PricingSettingsData,
          $$PricingSettingsTableFilterComposer,
          $$PricingSettingsTableOrderingComposer,
          $$PricingSettingsTableAnnotationComposer,
          $$PricingSettingsTableCreateCompanionBuilder,
          $$PricingSettingsTableUpdateCompanionBuilder,
          (
            PricingSettingsData,
            BaseReferences<
              _$AppDatabase,
              $PricingSettingsTable,
              PricingSettingsData
            >,
          ),
          PricingSettingsData,
          PrefetchHooks Function()
        > {
  $$PricingSettingsTableTableManager(
    _$AppDatabase db,
    $PricingSettingsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PricingSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PricingSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PricingSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<double> minProfitMargin = const Value.absent(),
                Value<double> defaultProfitMargin = const Value.absent(),
                Value<double> maxProfitMargin = const Value.absent(),
                Value<String> baseCurrency = const Value.absent(),
                Value<String> trackCurrencies = const Value.absent(),
                Value<int> roundingStep = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<String?> updatedBy = const Value.absent(),
              }) => PricingSettingsCompanion(
                id: id,
                minProfitMargin: minProfitMargin,
                defaultProfitMargin: defaultProfitMargin,
                maxProfitMargin: maxProfitMargin,
                baseCurrency: baseCurrency,
                trackCurrencies: trackCurrencies,
                roundingStep: roundingStep,
                updatedAt: updatedAt,
                updatedBy: updatedBy,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<double> minProfitMargin = const Value.absent(),
                Value<double> defaultProfitMargin = const Value.absent(),
                Value<double> maxProfitMargin = const Value.absent(),
                Value<String> baseCurrency = const Value.absent(),
                Value<String> trackCurrencies = const Value.absent(),
                Value<int> roundingStep = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<String?> updatedBy = const Value.absent(),
              }) => PricingSettingsCompanion.insert(
                id: id,
                minProfitMargin: minProfitMargin,
                defaultProfitMargin: defaultProfitMargin,
                maxProfitMargin: maxProfitMargin,
                baseCurrency: baseCurrency,
                trackCurrencies: trackCurrencies,
                roundingStep: roundingStep,
                updatedAt: updatedAt,
                updatedBy: updatedBy,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PricingSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PricingSettingsTable,
      PricingSettingsData,
      $$PricingSettingsTableFilterComposer,
      $$PricingSettingsTableOrderingComposer,
      $$PricingSettingsTableAnnotationComposer,
      $$PricingSettingsTableCreateCompanionBuilder,
      $$PricingSettingsTableUpdateCompanionBuilder,
      (
        PricingSettingsData,
        BaseReferences<
          _$AppDatabase,
          $PricingSettingsTable,
          PricingSettingsData
        >,
      ),
      PricingSettingsData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ProductsTableTableManager get products =>
      $$ProductsTableTableManager(_db, _db.products);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
  $$ThemesTableTableManager get themes =>
      $$ThemesTableTableManager(_db, _db.themes);
  $$LanguagesTableTableManager get languages =>
      $$LanguagesTableTableManager(_db, _db.languages);
  $$SalesInvoicesTableTableManager get salesInvoices =>
      $$SalesInvoicesTableTableManager(_db, _db.salesInvoices);
  $$SalesItemsTableTableManager get salesItems =>
      $$SalesItemsTableTableManager(_db, _db.salesItems);
  $$PurchaseInvoicesTableTableManager get purchaseInvoices =>
      $$PurchaseInvoicesTableTableManager(_db, _db.purchaseInvoices);
  $$PurchaseItemsTableTableManager get purchaseItems =>
      $$PurchaseItemsTableTableManager(_db, _db.purchaseItems);
  $$EventsTableTableManager get events =>
      $$EventsTableTableManager(_db, _db.events);
  $$ExchangeRateEventsTableTableManager get exchangeRateEvents =>
      $$ExchangeRateEventsTableTableManager(_db, _db.exchangeRateEvents);
  $$PricingSettingsTableTableManager get pricingSettings =>
      $$PricingSettingsTableTableManager(_db, _db.pricingSettings);
}
