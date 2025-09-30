// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_database.dart';

// ignore_for_file: type=lint
class $ProductRowsTable extends ProductRows
    with TableInfo<$ProductRowsTable, ProductRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductRowsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
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
  static const VerificationMeta _skuMeta = const VerificationMeta('sku');
  @override
  late final GeneratedColumn<String> sku = GeneratedColumn<String>(
    'sku',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
    'unit',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<double> price = GeneratedColumn<double>(
    'price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _activeMeta = const VerificationMeta('active');
  @override
  late final GeneratedColumn<bool> active = GeneratedColumn<bool>(
    'active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
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
  static const VerificationMeta _pendingSyncMeta = const VerificationMeta(
    'pendingSync',
  );
  @override
  late final GeneratedColumn<bool> pendingSync = GeneratedColumn<bool>(
    'pending_sync',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("pending_sync" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    sku,
    category,
    unit,
    price,
    active,
    updatedAt,
    pendingSync,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'product_rows';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProductRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('sku')) {
      context.handle(
        _skuMeta,
        sku.isAcceptableOrUnknown(data['sku']!, _skuMeta),
      );
    } else if (isInserting) {
      context.missing(_skuMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('unit')) {
      context.handle(
        _unitMeta,
        unit.isAcceptableOrUnknown(data['unit']!, _unitMeta),
      );
    } else if (isInserting) {
      context.missing(_unitMeta);
    }
    if (data.containsKey('price')) {
      context.handle(
        _priceMeta,
        price.isAcceptableOrUnknown(data['price']!, _priceMeta),
      );
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    if (data.containsKey('active')) {
      context.handle(
        _activeMeta,
        active.isAcceptableOrUnknown(data['active']!, _activeMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('pending_sync')) {
      context.handle(
        _pendingSyncMeta,
        pendingSync.isAcceptableOrUnknown(
          data['pending_sync']!,
          _pendingSyncMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProductRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductRow(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}id'],
          )!,
      name:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}name'],
          )!,
      sku:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}sku'],
          )!,
      category:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}category'],
          )!,
      unit:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}unit'],
          )!,
      price:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}price'],
          )!,
      active:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}active'],
          )!,
      updatedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}updated_at'],
          )!,
      pendingSync:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}pending_sync'],
          )!,
    );
  }

  @override
  $ProductRowsTable createAlias(String alias) {
    return $ProductRowsTable(attachedDatabase, alias);
  }
}

class ProductRow extends DataClass implements Insertable<ProductRow> {
  final String id;
  final String name;
  final String sku;
  final String category;
  final String unit;
  final double price;
  final bool active;
  final DateTime updatedAt;
  final bool pendingSync;
  const ProductRow({
    required this.id,
    required this.name,
    required this.sku,
    required this.category,
    required this.unit,
    required this.price,
    required this.active,
    required this.updatedAt,
    required this.pendingSync,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['sku'] = Variable<String>(sku);
    map['category'] = Variable<String>(category);
    map['unit'] = Variable<String>(unit);
    map['price'] = Variable<double>(price);
    map['active'] = Variable<bool>(active);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['pending_sync'] = Variable<bool>(pendingSync);
    return map;
  }

  ProductRowsCompanion toCompanion(bool nullToAbsent) {
    return ProductRowsCompanion(
      id: Value(id),
      name: Value(name),
      sku: Value(sku),
      category: Value(category),
      unit: Value(unit),
      price: Value(price),
      active: Value(active),
      updatedAt: Value(updatedAt),
      pendingSync: Value(pendingSync),
    );
  }

  factory ProductRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductRow(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      sku: serializer.fromJson<String>(json['sku']),
      category: serializer.fromJson<String>(json['category']),
      unit: serializer.fromJson<String>(json['unit']),
      price: serializer.fromJson<double>(json['price']),
      active: serializer.fromJson<bool>(json['active']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      pendingSync: serializer.fromJson<bool>(json['pendingSync']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'sku': serializer.toJson<String>(sku),
      'category': serializer.toJson<String>(category),
      'unit': serializer.toJson<String>(unit),
      'price': serializer.toJson<double>(price),
      'active': serializer.toJson<bool>(active),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'pendingSync': serializer.toJson<bool>(pendingSync),
    };
  }

  ProductRow copyWith({
    String? id,
    String? name,
    String? sku,
    String? category,
    String? unit,
    double? price,
    bool? active,
    DateTime? updatedAt,
    bool? pendingSync,
  }) => ProductRow(
    id: id ?? this.id,
    name: name ?? this.name,
    sku: sku ?? this.sku,
    category: category ?? this.category,
    unit: unit ?? this.unit,
    price: price ?? this.price,
    active: active ?? this.active,
    updatedAt: updatedAt ?? this.updatedAt,
    pendingSync: pendingSync ?? this.pendingSync,
  );
  ProductRow copyWithCompanion(ProductRowsCompanion data) {
    return ProductRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      sku: data.sku.present ? data.sku.value : this.sku,
      category: data.category.present ? data.category.value : this.category,
      unit: data.unit.present ? data.unit.value : this.unit,
      price: data.price.present ? data.price.value : this.price,
      active: data.active.present ? data.active.value : this.active,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      pendingSync:
          data.pendingSync.present ? data.pendingSync.value : this.pendingSync,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProductRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('sku: $sku, ')
          ..write('category: $category, ')
          ..write('unit: $unit, ')
          ..write('price: $price, ')
          ..write('active: $active, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('pendingSync: $pendingSync')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    sku,
    category,
    unit,
    price,
    active,
    updatedAt,
    pendingSync,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.sku == this.sku &&
          other.category == this.category &&
          other.unit == this.unit &&
          other.price == this.price &&
          other.active == this.active &&
          other.updatedAt == this.updatedAt &&
          other.pendingSync == this.pendingSync);
}

class ProductRowsCompanion extends UpdateCompanion<ProductRow> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> sku;
  final Value<String> category;
  final Value<String> unit;
  final Value<double> price;
  final Value<bool> active;
  final Value<DateTime> updatedAt;
  final Value<bool> pendingSync;
  final Value<int> rowid;
  const ProductRowsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.sku = const Value.absent(),
    this.category = const Value.absent(),
    this.unit = const Value.absent(),
    this.price = const Value.absent(),
    this.active = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.pendingSync = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProductRowsCompanion.insert({
    required String id,
    required String name,
    required String sku,
    required String category,
    required String unit,
    required double price,
    this.active = const Value.absent(),
    required DateTime updatedAt,
    this.pendingSync = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       sku = Value(sku),
       category = Value(category),
       unit = Value(unit),
       price = Value(price),
       updatedAt = Value(updatedAt);
  static Insertable<ProductRow> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? sku,
    Expression<String>? category,
    Expression<String>? unit,
    Expression<double>? price,
    Expression<bool>? active,
    Expression<DateTime>? updatedAt,
    Expression<bool>? pendingSync,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (sku != null) 'sku': sku,
      if (category != null) 'category': category,
      if (unit != null) 'unit': unit,
      if (price != null) 'price': price,
      if (active != null) 'active': active,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (pendingSync != null) 'pending_sync': pendingSync,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProductRowsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? sku,
    Value<String>? category,
    Value<String>? unit,
    Value<double>? price,
    Value<bool>? active,
    Value<DateTime>? updatedAt,
    Value<bool>? pendingSync,
    Value<int>? rowid,
  }) {
    return ProductRowsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      sku: sku ?? this.sku,
      category: category ?? this.category,
      unit: unit ?? this.unit,
      price: price ?? this.price,
      active: active ?? this.active,
      updatedAt: updatedAt ?? this.updatedAt,
      pendingSync: pendingSync ?? this.pendingSync,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (sku.present) {
      map['sku'] = Variable<String>(sku.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    if (active.present) {
      map['active'] = Variable<bool>(active.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (pendingSync.present) {
      map['pending_sync'] = Variable<bool>(pendingSync.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductRowsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('sku: $sku, ')
          ..write('category: $category, ')
          ..write('unit: $unit, ')
          ..write('price: $price, ')
          ..write('active: $active, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('pendingSync: $pendingSync, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocationRowsTable extends LocationRows
    with TableInfo<$LocationRowsTable, LocationRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocationRowsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
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
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    false,
    type: DriftSqlType.string,
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
  static const VerificationMeta _pendingSyncMeta = const VerificationMeta(
    'pendingSync',
  );
  @override
  late final GeneratedColumn<bool> pendingSync = GeneratedColumn<bool>(
    'pending_sync',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("pending_sync" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    type,
    address,
    updatedAt,
    pendingSync,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'location_rows';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocationRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    } else if (isInserting) {
      context.missing(_addressMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('pending_sync')) {
      context.handle(
        _pendingSyncMeta,
        pendingSync.isAcceptableOrUnknown(
          data['pending_sync']!,
          _pendingSyncMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocationRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocationRow(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}id'],
          )!,
      name:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}name'],
          )!,
      type:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}type'],
          )!,
      address:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}address'],
          )!,
      updatedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}updated_at'],
          )!,
      pendingSync:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}pending_sync'],
          )!,
    );
  }

  @override
  $LocationRowsTable createAlias(String alias) {
    return $LocationRowsTable(attachedDatabase, alias);
  }
}

class LocationRow extends DataClass implements Insertable<LocationRow> {
  final String id;
  final String name;
  final String type;
  final String address;
  final DateTime updatedAt;
  final bool pendingSync;
  const LocationRow({
    required this.id,
    required this.name,
    required this.type,
    required this.address,
    required this.updatedAt,
    required this.pendingSync,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['type'] = Variable<String>(type);
    map['address'] = Variable<String>(address);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['pending_sync'] = Variable<bool>(pendingSync);
    return map;
  }

  LocationRowsCompanion toCompanion(bool nullToAbsent) {
    return LocationRowsCompanion(
      id: Value(id),
      name: Value(name),
      type: Value(type),
      address: Value(address),
      updatedAt: Value(updatedAt),
      pendingSync: Value(pendingSync),
    );
  }

  factory LocationRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocationRow(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      type: serializer.fromJson<String>(json['type']),
      address: serializer.fromJson<String>(json['address']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      pendingSync: serializer.fromJson<bool>(json['pendingSync']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'type': serializer.toJson<String>(type),
      'address': serializer.toJson<String>(address),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'pendingSync': serializer.toJson<bool>(pendingSync),
    };
  }

  LocationRow copyWith({
    String? id,
    String? name,
    String? type,
    String? address,
    DateTime? updatedAt,
    bool? pendingSync,
  }) => LocationRow(
    id: id ?? this.id,
    name: name ?? this.name,
    type: type ?? this.type,
    address: address ?? this.address,
    updatedAt: updatedAt ?? this.updatedAt,
    pendingSync: pendingSync ?? this.pendingSync,
  );
  LocationRow copyWithCompanion(LocationRowsCompanion data) {
    return LocationRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      type: data.type.present ? data.type.value : this.type,
      address: data.address.present ? data.address.value : this.address,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      pendingSync:
          data.pendingSync.present ? data.pendingSync.value : this.pendingSync,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocationRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('address: $address, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('pendingSync: $pendingSync')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, type, address, updatedAt, pendingSync);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocationRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.type == this.type &&
          other.address == this.address &&
          other.updatedAt == this.updatedAt &&
          other.pendingSync == this.pendingSync);
}

class LocationRowsCompanion extends UpdateCompanion<LocationRow> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> type;
  final Value<String> address;
  final Value<DateTime> updatedAt;
  final Value<bool> pendingSync;
  final Value<int> rowid;
  const LocationRowsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
    this.address = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.pendingSync = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocationRowsCompanion.insert({
    required String id,
    required String name,
    required String type,
    required String address,
    required DateTime updatedAt,
    this.pendingSync = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       type = Value(type),
       address = Value(address),
       updatedAt = Value(updatedAt);
  static Insertable<LocationRow> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? type,
    Expression<String>? address,
    Expression<DateTime>? updatedAt,
    Expression<bool>? pendingSync,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
      if (address != null) 'address': address,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (pendingSync != null) 'pending_sync': pendingSync,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocationRowsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? type,
    Value<String>? address,
    Value<DateTime>? updatedAt,
    Value<bool>? pendingSync,
    Value<int>? rowid,
  }) {
    return LocationRowsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      address: address ?? this.address,
      updatedAt: updatedAt ?? this.updatedAt,
      pendingSync: pendingSync ?? this.pendingSync,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (pendingSync.present) {
      map['pending_sync'] = Variable<bool>(pendingSync.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocationRowsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('address: $address, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('pendingSync: $pendingSync, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $EmployeeRowsTable extends EmployeeRows
    with TableInfo<$EmployeeRowsTable, EmployeeRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EmployeeRowsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _firstNameMeta = const VerificationMeta(
    'firstName',
  );
  @override
  late final GeneratedColumn<String> firstName = GeneratedColumn<String>(
    'first_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastNameMeta = const VerificationMeta(
    'lastName',
  );
  @override
  late final GeneratedColumn<String> lastName = GeneratedColumn<String>(
    'last_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _activeMeta = const VerificationMeta('active');
  @override
  late final GeneratedColumn<bool> active = GeneratedColumn<bool>(
    'active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _locationIdMeta = const VerificationMeta(
    'locationId',
  );
  @override
  late final GeneratedColumn<String> locationId = GeneratedColumn<String>(
    'location_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES location_rows (id)',
    ),
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
  static const VerificationMeta _pendingSyncMeta = const VerificationMeta(
    'pendingSync',
  );
  @override
  late final GeneratedColumn<bool> pendingSync = GeneratedColumn<bool>(
    'pending_sync',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("pending_sync" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    firstName,
    lastName,
    email,
    active,
    locationId,
    updatedAt,
    pendingSync,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'employee_rows';
  @override
  VerificationContext validateIntegrity(
    Insertable<EmployeeRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('first_name')) {
      context.handle(
        _firstNameMeta,
        firstName.isAcceptableOrUnknown(data['first_name']!, _firstNameMeta),
      );
    } else if (isInserting) {
      context.missing(_firstNameMeta);
    }
    if (data.containsKey('last_name')) {
      context.handle(
        _lastNameMeta,
        lastName.isAcceptableOrUnknown(data['last_name']!, _lastNameMeta),
      );
    } else if (isInserting) {
      context.missing(_lastNameMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('active')) {
      context.handle(
        _activeMeta,
        active.isAcceptableOrUnknown(data['active']!, _activeMeta),
      );
    }
    if (data.containsKey('location_id')) {
      context.handle(
        _locationIdMeta,
        locationId.isAcceptableOrUnknown(data['location_id']!, _locationIdMeta),
      );
    } else if (isInserting) {
      context.missing(_locationIdMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('pending_sync')) {
      context.handle(
        _pendingSyncMeta,
        pendingSync.isAcceptableOrUnknown(
          data['pending_sync']!,
          _pendingSyncMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EmployeeRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EmployeeRow(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}id'],
          )!,
      firstName:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}first_name'],
          )!,
      lastName:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}last_name'],
          )!,
      email:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}email'],
          )!,
      active:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}active'],
          )!,
      locationId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}location_id'],
          )!,
      updatedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}updated_at'],
          )!,
      pendingSync:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}pending_sync'],
          )!,
    );
  }

  @override
  $EmployeeRowsTable createAlias(String alias) {
    return $EmployeeRowsTable(attachedDatabase, alias);
  }
}

class EmployeeRow extends DataClass implements Insertable<EmployeeRow> {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final bool active;
  final String locationId;
  final DateTime updatedAt;
  final bool pendingSync;
  const EmployeeRow({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.active,
    required this.locationId,
    required this.updatedAt,
    required this.pendingSync,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['first_name'] = Variable<String>(firstName);
    map['last_name'] = Variable<String>(lastName);
    map['email'] = Variable<String>(email);
    map['active'] = Variable<bool>(active);
    map['location_id'] = Variable<String>(locationId);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['pending_sync'] = Variable<bool>(pendingSync);
    return map;
  }

  EmployeeRowsCompanion toCompanion(bool nullToAbsent) {
    return EmployeeRowsCompanion(
      id: Value(id),
      firstName: Value(firstName),
      lastName: Value(lastName),
      email: Value(email),
      active: Value(active),
      locationId: Value(locationId),
      updatedAt: Value(updatedAt),
      pendingSync: Value(pendingSync),
    );
  }

  factory EmployeeRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EmployeeRow(
      id: serializer.fromJson<String>(json['id']),
      firstName: serializer.fromJson<String>(json['firstName']),
      lastName: serializer.fromJson<String>(json['lastName']),
      email: serializer.fromJson<String>(json['email']),
      active: serializer.fromJson<bool>(json['active']),
      locationId: serializer.fromJson<String>(json['locationId']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      pendingSync: serializer.fromJson<bool>(json['pendingSync']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'firstName': serializer.toJson<String>(firstName),
      'lastName': serializer.toJson<String>(lastName),
      'email': serializer.toJson<String>(email),
      'active': serializer.toJson<bool>(active),
      'locationId': serializer.toJson<String>(locationId),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'pendingSync': serializer.toJson<bool>(pendingSync),
    };
  }

  EmployeeRow copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    bool? active,
    String? locationId,
    DateTime? updatedAt,
    bool? pendingSync,
  }) => EmployeeRow(
    id: id ?? this.id,
    firstName: firstName ?? this.firstName,
    lastName: lastName ?? this.lastName,
    email: email ?? this.email,
    active: active ?? this.active,
    locationId: locationId ?? this.locationId,
    updatedAt: updatedAt ?? this.updatedAt,
    pendingSync: pendingSync ?? this.pendingSync,
  );
  EmployeeRow copyWithCompanion(EmployeeRowsCompanion data) {
    return EmployeeRow(
      id: data.id.present ? data.id.value : this.id,
      firstName: data.firstName.present ? data.firstName.value : this.firstName,
      lastName: data.lastName.present ? data.lastName.value : this.lastName,
      email: data.email.present ? data.email.value : this.email,
      active: data.active.present ? data.active.value : this.active,
      locationId:
          data.locationId.present ? data.locationId.value : this.locationId,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      pendingSync:
          data.pendingSync.present ? data.pendingSync.value : this.pendingSync,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EmployeeRow(')
          ..write('id: $id, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('email: $email, ')
          ..write('active: $active, ')
          ..write('locationId: $locationId, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('pendingSync: $pendingSync')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    firstName,
    lastName,
    email,
    active,
    locationId,
    updatedAt,
    pendingSync,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EmployeeRow &&
          other.id == this.id &&
          other.firstName == this.firstName &&
          other.lastName == this.lastName &&
          other.email == this.email &&
          other.active == this.active &&
          other.locationId == this.locationId &&
          other.updatedAt == this.updatedAt &&
          other.pendingSync == this.pendingSync);
}

class EmployeeRowsCompanion extends UpdateCompanion<EmployeeRow> {
  final Value<String> id;
  final Value<String> firstName;
  final Value<String> lastName;
  final Value<String> email;
  final Value<bool> active;
  final Value<String> locationId;
  final Value<DateTime> updatedAt;
  final Value<bool> pendingSync;
  final Value<int> rowid;
  const EmployeeRowsCompanion({
    this.id = const Value.absent(),
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.email = const Value.absent(),
    this.active = const Value.absent(),
    this.locationId = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.pendingSync = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EmployeeRowsCompanion.insert({
    required String id,
    required String firstName,
    required String lastName,
    required String email,
    this.active = const Value.absent(),
    required String locationId,
    required DateTime updatedAt,
    this.pendingSync = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       firstName = Value(firstName),
       lastName = Value(lastName),
       email = Value(email),
       locationId = Value(locationId),
       updatedAt = Value(updatedAt);
  static Insertable<EmployeeRow> custom({
    Expression<String>? id,
    Expression<String>? firstName,
    Expression<String>? lastName,
    Expression<String>? email,
    Expression<bool>? active,
    Expression<String>? locationId,
    Expression<DateTime>? updatedAt,
    Expression<bool>? pendingSync,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (firstName != null) 'first_name': firstName,
      if (lastName != null) 'last_name': lastName,
      if (email != null) 'email': email,
      if (active != null) 'active': active,
      if (locationId != null) 'location_id': locationId,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (pendingSync != null) 'pending_sync': pendingSync,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EmployeeRowsCompanion copyWith({
    Value<String>? id,
    Value<String>? firstName,
    Value<String>? lastName,
    Value<String>? email,
    Value<bool>? active,
    Value<String>? locationId,
    Value<DateTime>? updatedAt,
    Value<bool>? pendingSync,
    Value<int>? rowid,
  }) {
    return EmployeeRowsCompanion(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      active: active ?? this.active,
      locationId: locationId ?? this.locationId,
      updatedAt: updatedAt ?? this.updatedAt,
      pendingSync: pendingSync ?? this.pendingSync,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (firstName.present) {
      map['first_name'] = Variable<String>(firstName.value);
    }
    if (lastName.present) {
      map['last_name'] = Variable<String>(lastName.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (active.present) {
      map['active'] = Variable<bool>(active.value);
    }
    if (locationId.present) {
      map['location_id'] = Variable<String>(locationId.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (pendingSync.present) {
      map['pending_sync'] = Variable<bool>(pendingSync.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EmployeeRowsCompanion(')
          ..write('id: $id, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('email: $email, ')
          ..write('active: $active, ')
          ..write('locationId: $locationId, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('pendingSync: $pendingSync, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $InventorySnapshotRowsTable extends InventorySnapshotRows
    with TableInfo<$InventorySnapshotRowsTable, InventorySnapshotRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InventorySnapshotRowsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<String> productId = GeneratedColumn<String>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES product_rows (id)',
    ),
  );
  static const VerificationMeta _locationIdMeta = const VerificationMeta(
    'locationId',
  );
  @override
  late final GeneratedColumn<String> locationId = GeneratedColumn<String>(
    'location_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES location_rows (id)',
    ),
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<double> quantity = GeneratedColumn<double>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.double,
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
  static const VerificationMeta _pendingSyncMeta = const VerificationMeta(
    'pendingSync',
  );
  @override
  late final GeneratedColumn<bool> pendingSync = GeneratedColumn<bool>(
    'pending_sync',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("pending_sync" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    productId,
    locationId,
    quantity,
    updatedAt,
    pendingSync,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'inventory_snapshot_rows';
  @override
  VerificationContext validateIntegrity(
    Insertable<InventorySnapshotRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('location_id')) {
      context.handle(
        _locationIdMeta,
        locationId.isAcceptableOrUnknown(data['location_id']!, _locationIdMeta),
      );
    } else if (isInserting) {
      context.missing(_locationIdMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('pending_sync')) {
      context.handle(
        _pendingSyncMeta,
        pendingSync.isAcceptableOrUnknown(
          data['pending_sync']!,
          _pendingSyncMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InventorySnapshotRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InventorySnapshotRow(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}id'],
          )!,
      productId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}product_id'],
          )!,
      locationId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}location_id'],
          )!,
      quantity:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}quantity'],
          )!,
      updatedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}updated_at'],
          )!,
      pendingSync:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}pending_sync'],
          )!,
    );
  }

  @override
  $InventorySnapshotRowsTable createAlias(String alias) {
    return $InventorySnapshotRowsTable(attachedDatabase, alias);
  }
}

class InventorySnapshotRow extends DataClass
    implements Insertable<InventorySnapshotRow> {
  final String id;
  final String productId;
  final String locationId;
  final double quantity;
  final DateTime updatedAt;
  final bool pendingSync;
  const InventorySnapshotRow({
    required this.id,
    required this.productId,
    required this.locationId,
    required this.quantity,
    required this.updatedAt,
    required this.pendingSync,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['product_id'] = Variable<String>(productId);
    map['location_id'] = Variable<String>(locationId);
    map['quantity'] = Variable<double>(quantity);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['pending_sync'] = Variable<bool>(pendingSync);
    return map;
  }

  InventorySnapshotRowsCompanion toCompanion(bool nullToAbsent) {
    return InventorySnapshotRowsCompanion(
      id: Value(id),
      productId: Value(productId),
      locationId: Value(locationId),
      quantity: Value(quantity),
      updatedAt: Value(updatedAt),
      pendingSync: Value(pendingSync),
    );
  }

  factory InventorySnapshotRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InventorySnapshotRow(
      id: serializer.fromJson<String>(json['id']),
      productId: serializer.fromJson<String>(json['productId']),
      locationId: serializer.fromJson<String>(json['locationId']),
      quantity: serializer.fromJson<double>(json['quantity']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      pendingSync: serializer.fromJson<bool>(json['pendingSync']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'productId': serializer.toJson<String>(productId),
      'locationId': serializer.toJson<String>(locationId),
      'quantity': serializer.toJson<double>(quantity),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'pendingSync': serializer.toJson<bool>(pendingSync),
    };
  }

  InventorySnapshotRow copyWith({
    String? id,
    String? productId,
    String? locationId,
    double? quantity,
    DateTime? updatedAt,
    bool? pendingSync,
  }) => InventorySnapshotRow(
    id: id ?? this.id,
    productId: productId ?? this.productId,
    locationId: locationId ?? this.locationId,
    quantity: quantity ?? this.quantity,
    updatedAt: updatedAt ?? this.updatedAt,
    pendingSync: pendingSync ?? this.pendingSync,
  );
  InventorySnapshotRow copyWithCompanion(InventorySnapshotRowsCompanion data) {
    return InventorySnapshotRow(
      id: data.id.present ? data.id.value : this.id,
      productId: data.productId.present ? data.productId.value : this.productId,
      locationId:
          data.locationId.present ? data.locationId.value : this.locationId,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      pendingSync:
          data.pendingSync.present ? data.pendingSync.value : this.pendingSync,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InventorySnapshotRow(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('locationId: $locationId, ')
          ..write('quantity: $quantity, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('pendingSync: $pendingSync')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, productId, locationId, quantity, updatedAt, pendingSync);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InventorySnapshotRow &&
          other.id == this.id &&
          other.productId == this.productId &&
          other.locationId == this.locationId &&
          other.quantity == this.quantity &&
          other.updatedAt == this.updatedAt &&
          other.pendingSync == this.pendingSync);
}

class InventorySnapshotRowsCompanion
    extends UpdateCompanion<InventorySnapshotRow> {
  final Value<String> id;
  final Value<String> productId;
  final Value<String> locationId;
  final Value<double> quantity;
  final Value<DateTime> updatedAt;
  final Value<bool> pendingSync;
  final Value<int> rowid;
  const InventorySnapshotRowsCompanion({
    this.id = const Value.absent(),
    this.productId = const Value.absent(),
    this.locationId = const Value.absent(),
    this.quantity = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.pendingSync = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  InventorySnapshotRowsCompanion.insert({
    required String id,
    required String productId,
    required String locationId,
    required double quantity,
    required DateTime updatedAt,
    this.pendingSync = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       productId = Value(productId),
       locationId = Value(locationId),
       quantity = Value(quantity),
       updatedAt = Value(updatedAt);
  static Insertable<InventorySnapshotRow> custom({
    Expression<String>? id,
    Expression<String>? productId,
    Expression<String>? locationId,
    Expression<double>? quantity,
    Expression<DateTime>? updatedAt,
    Expression<bool>? pendingSync,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (productId != null) 'product_id': productId,
      if (locationId != null) 'location_id': locationId,
      if (quantity != null) 'quantity': quantity,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (pendingSync != null) 'pending_sync': pendingSync,
      if (rowid != null) 'rowid': rowid,
    });
  }

  InventorySnapshotRowsCompanion copyWith({
    Value<String>? id,
    Value<String>? productId,
    Value<String>? locationId,
    Value<double>? quantity,
    Value<DateTime>? updatedAt,
    Value<bool>? pendingSync,
    Value<int>? rowid,
  }) {
    return InventorySnapshotRowsCompanion(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      locationId: locationId ?? this.locationId,
      quantity: quantity ?? this.quantity,
      updatedAt: updatedAt ?? this.updatedAt,
      pendingSync: pendingSync ?? this.pendingSync,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<String>(productId.value);
    }
    if (locationId.present) {
      map['location_id'] = Variable<String>(locationId.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<double>(quantity.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (pendingSync.present) {
      map['pending_sync'] = Variable<bool>(pendingSync.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InventorySnapshotRowsCompanion(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('locationId: $locationId, ')
          ..write('quantity: $quantity, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('pendingSync: $pendingSync, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $InventoryTransactionRowsTable extends InventoryTransactionRows
    with TableInfo<$InventoryTransactionRowsTable, InventoryTransactionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InventoryTransactionRowsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<String> productId = GeneratedColumn<String>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES product_rows (id)',
    ),
  );
  static const VerificationMeta _sourceLocationIdMeta = const VerificationMeta(
    'sourceLocationId',
  );
  @override
  late final GeneratedColumn<String> sourceLocationId = GeneratedColumn<String>(
    'source_location_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES location_rows (id)',
    ),
  );
  static const VerificationMeta _targetLocationIdMeta = const VerificationMeta(
    'targetLocationId',
  );
  @override
  late final GeneratedColumn<String> targetLocationId = GeneratedColumn<String>(
    'target_location_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES location_rows (id)',
    ),
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<double> quantity = GeneratedColumn<double>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _transactionTypeMeta = const VerificationMeta(
    'transactionType',
  );
  @override
  late final GeneratedColumn<String> transactionType = GeneratedColumn<String>(
    'transaction_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _referenceMeta = const VerificationMeta(
    'reference',
  );
  @override
  late final GeneratedColumn<String> reference = GeneratedColumn<String>(
    'reference',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _employeeIdMeta = const VerificationMeta(
    'employeeId',
  );
  @override
  late final GeneratedColumn<String> employeeId = GeneratedColumn<String>(
    'employee_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES employee_rows (id)',
    ),
  );
  static const VerificationMeta _occurredAtMeta = const VerificationMeta(
    'occurredAt',
  );
  @override
  late final GeneratedColumn<DateTime> occurredAt = GeneratedColumn<DateTime>(
    'occurred_at',
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
  static const VerificationMeta _pendingSyncMeta = const VerificationMeta(
    'pendingSync',
  );
  @override
  late final GeneratedColumn<bool> pendingSync = GeneratedColumn<bool>(
    'pending_sync',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("pending_sync" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    productId,
    sourceLocationId,
    targetLocationId,
    quantity,
    transactionType,
    reference,
    note,
    employeeId,
    occurredAt,
    updatedAt,
    pendingSync,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'inventory_transaction_rows';
  @override
  VerificationContext validateIntegrity(
    Insertable<InventoryTransactionRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('source_location_id')) {
      context.handle(
        _sourceLocationIdMeta,
        sourceLocationId.isAcceptableOrUnknown(
          data['source_location_id']!,
          _sourceLocationIdMeta,
        ),
      );
    }
    if (data.containsKey('target_location_id')) {
      context.handle(
        _targetLocationIdMeta,
        targetLocationId.isAcceptableOrUnknown(
          data['target_location_id']!,
          _targetLocationIdMeta,
        ),
      );
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('transaction_type')) {
      context.handle(
        _transactionTypeMeta,
        transactionType.isAcceptableOrUnknown(
          data['transaction_type']!,
          _transactionTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_transactionTypeMeta);
    }
    if (data.containsKey('reference')) {
      context.handle(
        _referenceMeta,
        reference.isAcceptableOrUnknown(data['reference']!, _referenceMeta),
      );
    } else if (isInserting) {
      context.missing(_referenceMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('employee_id')) {
      context.handle(
        _employeeIdMeta,
        employeeId.isAcceptableOrUnknown(data['employee_id']!, _employeeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_employeeIdMeta);
    }
    if (data.containsKey('occurred_at')) {
      context.handle(
        _occurredAtMeta,
        occurredAt.isAcceptableOrUnknown(data['occurred_at']!, _occurredAtMeta),
      );
    } else if (isInserting) {
      context.missing(_occurredAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('pending_sync')) {
      context.handle(
        _pendingSyncMeta,
        pendingSync.isAcceptableOrUnknown(
          data['pending_sync']!,
          _pendingSyncMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InventoryTransactionRow map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InventoryTransactionRow(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}id'],
          )!,
      productId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}product_id'],
          )!,
      sourceLocationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_location_id'],
      ),
      targetLocationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}target_location_id'],
      ),
      quantity:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}quantity'],
          )!,
      transactionType:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}transaction_type'],
          )!,
      reference:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}reference'],
          )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      employeeId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}employee_id'],
          )!,
      occurredAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}occurred_at'],
          )!,
      updatedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}updated_at'],
          )!,
      pendingSync:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}pending_sync'],
          )!,
    );
  }

  @override
  $InventoryTransactionRowsTable createAlias(String alias) {
    return $InventoryTransactionRowsTable(attachedDatabase, alias);
  }
}

class InventoryTransactionRow extends DataClass
    implements Insertable<InventoryTransactionRow> {
  final String id;
  final String productId;
  final String? sourceLocationId;
  final String? targetLocationId;
  final double quantity;
  final String transactionType;
  final String reference;
  final String? note;
  final String employeeId;
  final DateTime occurredAt;
  final DateTime updatedAt;
  final bool pendingSync;
  const InventoryTransactionRow({
    required this.id,
    required this.productId,
    this.sourceLocationId,
    this.targetLocationId,
    required this.quantity,
    required this.transactionType,
    required this.reference,
    this.note,
    required this.employeeId,
    required this.occurredAt,
    required this.updatedAt,
    required this.pendingSync,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['product_id'] = Variable<String>(productId);
    if (!nullToAbsent || sourceLocationId != null) {
      map['source_location_id'] = Variable<String>(sourceLocationId);
    }
    if (!nullToAbsent || targetLocationId != null) {
      map['target_location_id'] = Variable<String>(targetLocationId);
    }
    map['quantity'] = Variable<double>(quantity);
    map['transaction_type'] = Variable<String>(transactionType);
    map['reference'] = Variable<String>(reference);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['employee_id'] = Variable<String>(employeeId);
    map['occurred_at'] = Variable<DateTime>(occurredAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['pending_sync'] = Variable<bool>(pendingSync);
    return map;
  }

  InventoryTransactionRowsCompanion toCompanion(bool nullToAbsent) {
    return InventoryTransactionRowsCompanion(
      id: Value(id),
      productId: Value(productId),
      sourceLocationId:
          sourceLocationId == null && nullToAbsent
              ? const Value.absent()
              : Value(sourceLocationId),
      targetLocationId:
          targetLocationId == null && nullToAbsent
              ? const Value.absent()
              : Value(targetLocationId),
      quantity: Value(quantity),
      transactionType: Value(transactionType),
      reference: Value(reference),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      employeeId: Value(employeeId),
      occurredAt: Value(occurredAt),
      updatedAt: Value(updatedAt),
      pendingSync: Value(pendingSync),
    );
  }

  factory InventoryTransactionRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InventoryTransactionRow(
      id: serializer.fromJson<String>(json['id']),
      productId: serializer.fromJson<String>(json['productId']),
      sourceLocationId: serializer.fromJson<String?>(json['sourceLocationId']),
      targetLocationId: serializer.fromJson<String?>(json['targetLocationId']),
      quantity: serializer.fromJson<double>(json['quantity']),
      transactionType: serializer.fromJson<String>(json['transactionType']),
      reference: serializer.fromJson<String>(json['reference']),
      note: serializer.fromJson<String?>(json['note']),
      employeeId: serializer.fromJson<String>(json['employeeId']),
      occurredAt: serializer.fromJson<DateTime>(json['occurredAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      pendingSync: serializer.fromJson<bool>(json['pendingSync']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'productId': serializer.toJson<String>(productId),
      'sourceLocationId': serializer.toJson<String?>(sourceLocationId),
      'targetLocationId': serializer.toJson<String?>(targetLocationId),
      'quantity': serializer.toJson<double>(quantity),
      'transactionType': serializer.toJson<String>(transactionType),
      'reference': serializer.toJson<String>(reference),
      'note': serializer.toJson<String?>(note),
      'employeeId': serializer.toJson<String>(employeeId),
      'occurredAt': serializer.toJson<DateTime>(occurredAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'pendingSync': serializer.toJson<bool>(pendingSync),
    };
  }

  InventoryTransactionRow copyWith({
    String? id,
    String? productId,
    Value<String?> sourceLocationId = const Value.absent(),
    Value<String?> targetLocationId = const Value.absent(),
    double? quantity,
    String? transactionType,
    String? reference,
    Value<String?> note = const Value.absent(),
    String? employeeId,
    DateTime? occurredAt,
    DateTime? updatedAt,
    bool? pendingSync,
  }) => InventoryTransactionRow(
    id: id ?? this.id,
    productId: productId ?? this.productId,
    sourceLocationId:
        sourceLocationId.present
            ? sourceLocationId.value
            : this.sourceLocationId,
    targetLocationId:
        targetLocationId.present
            ? targetLocationId.value
            : this.targetLocationId,
    quantity: quantity ?? this.quantity,
    transactionType: transactionType ?? this.transactionType,
    reference: reference ?? this.reference,
    note: note.present ? note.value : this.note,
    employeeId: employeeId ?? this.employeeId,
    occurredAt: occurredAt ?? this.occurredAt,
    updatedAt: updatedAt ?? this.updatedAt,
    pendingSync: pendingSync ?? this.pendingSync,
  );
  InventoryTransactionRow copyWithCompanion(
    InventoryTransactionRowsCompanion data,
  ) {
    return InventoryTransactionRow(
      id: data.id.present ? data.id.value : this.id,
      productId: data.productId.present ? data.productId.value : this.productId,
      sourceLocationId:
          data.sourceLocationId.present
              ? data.sourceLocationId.value
              : this.sourceLocationId,
      targetLocationId:
          data.targetLocationId.present
              ? data.targetLocationId.value
              : this.targetLocationId,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      transactionType:
          data.transactionType.present
              ? data.transactionType.value
              : this.transactionType,
      reference: data.reference.present ? data.reference.value : this.reference,
      note: data.note.present ? data.note.value : this.note,
      employeeId:
          data.employeeId.present ? data.employeeId.value : this.employeeId,
      occurredAt:
          data.occurredAt.present ? data.occurredAt.value : this.occurredAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      pendingSync:
          data.pendingSync.present ? data.pendingSync.value : this.pendingSync,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InventoryTransactionRow(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('sourceLocationId: $sourceLocationId, ')
          ..write('targetLocationId: $targetLocationId, ')
          ..write('quantity: $quantity, ')
          ..write('transactionType: $transactionType, ')
          ..write('reference: $reference, ')
          ..write('note: $note, ')
          ..write('employeeId: $employeeId, ')
          ..write('occurredAt: $occurredAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('pendingSync: $pendingSync')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    productId,
    sourceLocationId,
    targetLocationId,
    quantity,
    transactionType,
    reference,
    note,
    employeeId,
    occurredAt,
    updatedAt,
    pendingSync,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InventoryTransactionRow &&
          other.id == this.id &&
          other.productId == this.productId &&
          other.sourceLocationId == this.sourceLocationId &&
          other.targetLocationId == this.targetLocationId &&
          other.quantity == this.quantity &&
          other.transactionType == this.transactionType &&
          other.reference == this.reference &&
          other.note == this.note &&
          other.employeeId == this.employeeId &&
          other.occurredAt == this.occurredAt &&
          other.updatedAt == this.updatedAt &&
          other.pendingSync == this.pendingSync);
}

class InventoryTransactionRowsCompanion
    extends UpdateCompanion<InventoryTransactionRow> {
  final Value<String> id;
  final Value<String> productId;
  final Value<String?> sourceLocationId;
  final Value<String?> targetLocationId;
  final Value<double> quantity;
  final Value<String> transactionType;
  final Value<String> reference;
  final Value<String?> note;
  final Value<String> employeeId;
  final Value<DateTime> occurredAt;
  final Value<DateTime> updatedAt;
  final Value<bool> pendingSync;
  final Value<int> rowid;
  const InventoryTransactionRowsCompanion({
    this.id = const Value.absent(),
    this.productId = const Value.absent(),
    this.sourceLocationId = const Value.absent(),
    this.targetLocationId = const Value.absent(),
    this.quantity = const Value.absent(),
    this.transactionType = const Value.absent(),
    this.reference = const Value.absent(),
    this.note = const Value.absent(),
    this.employeeId = const Value.absent(),
    this.occurredAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.pendingSync = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  InventoryTransactionRowsCompanion.insert({
    required String id,
    required String productId,
    this.sourceLocationId = const Value.absent(),
    this.targetLocationId = const Value.absent(),
    required double quantity,
    required String transactionType,
    required String reference,
    this.note = const Value.absent(),
    required String employeeId,
    required DateTime occurredAt,
    required DateTime updatedAt,
    this.pendingSync = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       productId = Value(productId),
       quantity = Value(quantity),
       transactionType = Value(transactionType),
       reference = Value(reference),
       employeeId = Value(employeeId),
       occurredAt = Value(occurredAt),
       updatedAt = Value(updatedAt);
  static Insertable<InventoryTransactionRow> custom({
    Expression<String>? id,
    Expression<String>? productId,
    Expression<String>? sourceLocationId,
    Expression<String>? targetLocationId,
    Expression<double>? quantity,
    Expression<String>? transactionType,
    Expression<String>? reference,
    Expression<String>? note,
    Expression<String>? employeeId,
    Expression<DateTime>? occurredAt,
    Expression<DateTime>? updatedAt,
    Expression<bool>? pendingSync,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (productId != null) 'product_id': productId,
      if (sourceLocationId != null) 'source_location_id': sourceLocationId,
      if (targetLocationId != null) 'target_location_id': targetLocationId,
      if (quantity != null) 'quantity': quantity,
      if (transactionType != null) 'transaction_type': transactionType,
      if (reference != null) 'reference': reference,
      if (note != null) 'note': note,
      if (employeeId != null) 'employee_id': employeeId,
      if (occurredAt != null) 'occurred_at': occurredAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (pendingSync != null) 'pending_sync': pendingSync,
      if (rowid != null) 'rowid': rowid,
    });
  }

  InventoryTransactionRowsCompanion copyWith({
    Value<String>? id,
    Value<String>? productId,
    Value<String?>? sourceLocationId,
    Value<String?>? targetLocationId,
    Value<double>? quantity,
    Value<String>? transactionType,
    Value<String>? reference,
    Value<String?>? note,
    Value<String>? employeeId,
    Value<DateTime>? occurredAt,
    Value<DateTime>? updatedAt,
    Value<bool>? pendingSync,
    Value<int>? rowid,
  }) {
    return InventoryTransactionRowsCompanion(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      sourceLocationId: sourceLocationId ?? this.sourceLocationId,
      targetLocationId: targetLocationId ?? this.targetLocationId,
      quantity: quantity ?? this.quantity,
      transactionType: transactionType ?? this.transactionType,
      reference: reference ?? this.reference,
      note: note ?? this.note,
      employeeId: employeeId ?? this.employeeId,
      occurredAt: occurredAt ?? this.occurredAt,
      updatedAt: updatedAt ?? this.updatedAt,
      pendingSync: pendingSync ?? this.pendingSync,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<String>(productId.value);
    }
    if (sourceLocationId.present) {
      map['source_location_id'] = Variable<String>(sourceLocationId.value);
    }
    if (targetLocationId.present) {
      map['target_location_id'] = Variable<String>(targetLocationId.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<double>(quantity.value);
    }
    if (transactionType.present) {
      map['transaction_type'] = Variable<String>(transactionType.value);
    }
    if (reference.present) {
      map['reference'] = Variable<String>(reference.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (employeeId.present) {
      map['employee_id'] = Variable<String>(employeeId.value);
    }
    if (occurredAt.present) {
      map['occurred_at'] = Variable<DateTime>(occurredAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (pendingSync.present) {
      map['pending_sync'] = Variable<bool>(pendingSync.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InventoryTransactionRowsCompanion(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('sourceLocationId: $sourceLocationId, ')
          ..write('targetLocationId: $targetLocationId, ')
          ..write('quantity: $quantity, ')
          ..write('transactionType: $transactionType, ')
          ..write('reference: $reference, ')
          ..write('note: $note, ')
          ..write('employeeId: $employeeId, ')
          ..write('occurredAt: $occurredAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('pendingSync: $pendingSync, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyncStatusesTable extends SyncStatuses
    with TableInfo<$SyncStatusesTable, SyncStatuse> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncStatusesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _resourceMeta = const VerificationMeta(
    'resource',
  );
  @override
  late final GeneratedColumn<String> resource = GeneratedColumn<String>(
    'resource',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastSyncedAtMeta = const VerificationMeta(
    'lastSyncedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastSyncedAt = GeneratedColumn<DateTime>(
    'last_synced_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [resource, lastSyncedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_statuses';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncStatuse> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('resource')) {
      context.handle(
        _resourceMeta,
        resource.isAcceptableOrUnknown(data['resource']!, _resourceMeta),
      );
    } else if (isInserting) {
      context.missing(_resourceMeta);
    }
    if (data.containsKey('last_synced_at')) {
      context.handle(
        _lastSyncedAtMeta,
        lastSyncedAt.isAcceptableOrUnknown(
          data['last_synced_at']!,
          _lastSyncedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {resource};
  @override
  SyncStatuse map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncStatuse(
      resource:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}resource'],
          )!,
      lastSyncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_synced_at'],
      ),
    );
  }

  @override
  $SyncStatusesTable createAlias(String alias) {
    return $SyncStatusesTable(attachedDatabase, alias);
  }
}

class SyncStatuse extends DataClass implements Insertable<SyncStatuse> {
  final String resource;
  final DateTime? lastSyncedAt;
  const SyncStatuse({required this.resource, this.lastSyncedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['resource'] = Variable<String>(resource);
    if (!nullToAbsent || lastSyncedAt != null) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt);
    }
    return map;
  }

  SyncStatusesCompanion toCompanion(bool nullToAbsent) {
    return SyncStatusesCompanion(
      resource: Value(resource),
      lastSyncedAt:
          lastSyncedAt == null && nullToAbsent
              ? const Value.absent()
              : Value(lastSyncedAt),
    );
  }

  factory SyncStatuse.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncStatuse(
      resource: serializer.fromJson<String>(json['resource']),
      lastSyncedAt: serializer.fromJson<DateTime?>(json['lastSyncedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'resource': serializer.toJson<String>(resource),
      'lastSyncedAt': serializer.toJson<DateTime?>(lastSyncedAt),
    };
  }

  SyncStatuse copyWith({
    String? resource,
    Value<DateTime?> lastSyncedAt = const Value.absent(),
  }) => SyncStatuse(
    resource: resource ?? this.resource,
    lastSyncedAt: lastSyncedAt.present ? lastSyncedAt.value : this.lastSyncedAt,
  );
  SyncStatuse copyWithCompanion(SyncStatusesCompanion data) {
    return SyncStatuse(
      resource: data.resource.present ? data.resource.value : this.resource,
      lastSyncedAt:
          data.lastSyncedAt.present
              ? data.lastSyncedAt.value
              : this.lastSyncedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncStatuse(')
          ..write('resource: $resource, ')
          ..write('lastSyncedAt: $lastSyncedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(resource, lastSyncedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncStatuse &&
          other.resource == this.resource &&
          other.lastSyncedAt == this.lastSyncedAt);
}

class SyncStatusesCompanion extends UpdateCompanion<SyncStatuse> {
  final Value<String> resource;
  final Value<DateTime?> lastSyncedAt;
  final Value<int> rowid;
  const SyncStatusesCompanion({
    this.resource = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncStatusesCompanion.insert({
    required String resource,
    this.lastSyncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : resource = Value(resource);
  static Insertable<SyncStatuse> custom({
    Expression<String>? resource,
    Expression<DateTime>? lastSyncedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (resource != null) 'resource': resource,
      if (lastSyncedAt != null) 'last_synced_at': lastSyncedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncStatusesCompanion copyWith({
    Value<String>? resource,
    Value<DateTime?>? lastSyncedAt,
    Value<int>? rowid,
  }) {
    return SyncStatusesCompanion(
      resource: resource ?? this.resource,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (resource.present) {
      map['resource'] = Variable<String>(resource.value);
    }
    if (lastSyncedAt.present) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncStatusesCompanion(')
          ..write('resource: $resource, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$LocalDatabase extends GeneratedDatabase {
  _$LocalDatabase(QueryExecutor e) : super(e);
  $LocalDatabaseManager get managers => $LocalDatabaseManager(this);
  late final $ProductRowsTable productRows = $ProductRowsTable(this);
  late final $LocationRowsTable locationRows = $LocationRowsTable(this);
  late final $EmployeeRowsTable employeeRows = $EmployeeRowsTable(this);
  late final $InventorySnapshotRowsTable inventorySnapshotRows =
      $InventorySnapshotRowsTable(this);
  late final $InventoryTransactionRowsTable inventoryTransactionRows =
      $InventoryTransactionRowsTable(this);
  late final $SyncStatusesTable syncStatuses = $SyncStatusesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    productRows,
    locationRows,
    employeeRows,
    inventorySnapshotRows,
    inventoryTransactionRows,
    syncStatuses,
  ];
}

typedef $$ProductRowsTableCreateCompanionBuilder =
    ProductRowsCompanion Function({
      required String id,
      required String name,
      required String sku,
      required String category,
      required String unit,
      required double price,
      Value<bool> active,
      required DateTime updatedAt,
      Value<bool> pendingSync,
      Value<int> rowid,
    });
typedef $$ProductRowsTableUpdateCompanionBuilder =
    ProductRowsCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> sku,
      Value<String> category,
      Value<String> unit,
      Value<double> price,
      Value<bool> active,
      Value<DateTime> updatedAt,
      Value<bool> pendingSync,
      Value<int> rowid,
    });

final class $$ProductRowsTableReferences
    extends BaseReferences<_$LocalDatabase, $ProductRowsTable, ProductRow> {
  $$ProductRowsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<
    $InventorySnapshotRowsTable,
    List<InventorySnapshotRow>
  >
  _inventorySnapshotRowsRefsTable(_$LocalDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.inventorySnapshotRows,
        aliasName: $_aliasNameGenerator(
          db.productRows.id,
          db.inventorySnapshotRows.productId,
        ),
      );

  $$InventorySnapshotRowsTableProcessedTableManager
  get inventorySnapshotRowsRefs {
    final manager = $$InventorySnapshotRowsTableTableManager(
      $_db,
      $_db.inventorySnapshotRows,
    ).filter((f) => f.productId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _inventorySnapshotRowsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $InventoryTransactionRowsTable,
    List<InventoryTransactionRow>
  >
  _inventoryTransactionRowsRefsTable(_$LocalDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.inventoryTransactionRows,
        aliasName: $_aliasNameGenerator(
          db.productRows.id,
          db.inventoryTransactionRows.productId,
        ),
      );

  $$InventoryTransactionRowsTableProcessedTableManager
  get inventoryTransactionRowsRefs {
    final manager = $$InventoryTransactionRowsTableTableManager(
      $_db,
      $_db.inventoryTransactionRows,
    ).filter((f) => f.productId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _inventoryTransactionRowsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ProductRowsTableFilterComposer
    extends Composer<_$LocalDatabase, $ProductRowsTable> {
  $$ProductRowsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sku => $composableBuilder(
    column: $table.sku,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get active => $composableBuilder(
    column: $table.active,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get pendingSync => $composableBuilder(
    column: $table.pendingSync,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> inventorySnapshotRowsRefs(
    Expression<bool> Function($$InventorySnapshotRowsTableFilterComposer f) f,
  ) {
    final $$InventorySnapshotRowsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.inventorySnapshotRows,
          getReferencedColumn: (t) => t.productId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$InventorySnapshotRowsTableFilterComposer(
                $db: $db,
                $table: $db.inventorySnapshotRows,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> inventoryTransactionRowsRefs(
    Expression<bool> Function($$InventoryTransactionRowsTableFilterComposer f)
    f,
  ) {
    final $$InventoryTransactionRowsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.inventoryTransactionRows,
          getReferencedColumn: (t) => t.productId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$InventoryTransactionRowsTableFilterComposer(
                $db: $db,
                $table: $db.inventoryTransactionRows,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$ProductRowsTableOrderingComposer
    extends Composer<_$LocalDatabase, $ProductRowsTable> {
  $$ProductRowsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sku => $composableBuilder(
    column: $table.sku,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get active => $composableBuilder(
    column: $table.active,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get pendingSync => $composableBuilder(
    column: $table.pendingSync,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProductRowsTableAnnotationComposer
    extends Composer<_$LocalDatabase, $ProductRowsTable> {
  $$ProductRowsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get sku =>
      $composableBuilder(column: $table.sku, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<double> get price =>
      $composableBuilder(column: $table.price, builder: (column) => column);

  GeneratedColumn<bool> get active =>
      $composableBuilder(column: $table.active, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get pendingSync => $composableBuilder(
    column: $table.pendingSync,
    builder: (column) => column,
  );

  Expression<T> inventorySnapshotRowsRefs<T extends Object>(
    Expression<T> Function($$InventorySnapshotRowsTableAnnotationComposer a) f,
  ) {
    final $$InventorySnapshotRowsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.inventorySnapshotRows,
          getReferencedColumn: (t) => t.productId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$InventorySnapshotRowsTableAnnotationComposer(
                $db: $db,
                $table: $db.inventorySnapshotRows,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> inventoryTransactionRowsRefs<T extends Object>(
    Expression<T> Function($$InventoryTransactionRowsTableAnnotationComposer a)
    f,
  ) {
    final $$InventoryTransactionRowsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.inventoryTransactionRows,
          getReferencedColumn: (t) => t.productId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$InventoryTransactionRowsTableAnnotationComposer(
                $db: $db,
                $table: $db.inventoryTransactionRows,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$ProductRowsTableTableManager
    extends
        RootTableManager<
          _$LocalDatabase,
          $ProductRowsTable,
          ProductRow,
          $$ProductRowsTableFilterComposer,
          $$ProductRowsTableOrderingComposer,
          $$ProductRowsTableAnnotationComposer,
          $$ProductRowsTableCreateCompanionBuilder,
          $$ProductRowsTableUpdateCompanionBuilder,
          (ProductRow, $$ProductRowsTableReferences),
          ProductRow,
          PrefetchHooks Function({
            bool inventorySnapshotRowsRefs,
            bool inventoryTransactionRowsRefs,
          })
        > {
  $$ProductRowsTableTableManager(_$LocalDatabase db, $ProductRowsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$ProductRowsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$ProductRowsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () =>
                  $$ProductRowsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> sku = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<String> unit = const Value.absent(),
                Value<double> price = const Value.absent(),
                Value<bool> active = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> pendingSync = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProductRowsCompanion(
                id: id,
                name: name,
                sku: sku,
                category: category,
                unit: unit,
                price: price,
                active: active,
                updatedAt: updatedAt,
                pendingSync: pendingSync,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String sku,
                required String category,
                required String unit,
                required double price,
                Value<bool> active = const Value.absent(),
                required DateTime updatedAt,
                Value<bool> pendingSync = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProductRowsCompanion.insert(
                id: id,
                name: name,
                sku: sku,
                category: category,
                unit: unit,
                price: price,
                active: active,
                updatedAt: updatedAt,
                pendingSync: pendingSync,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$ProductRowsTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({
            inventorySnapshotRowsRefs = false,
            inventoryTransactionRowsRefs = false,
          }) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (inventorySnapshotRowsRefs) db.inventorySnapshotRows,
                if (inventoryTransactionRowsRefs) db.inventoryTransactionRows,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (inventorySnapshotRowsRefs)
                    await $_getPrefetchedData<
                      ProductRow,
                      $ProductRowsTable,
                      InventorySnapshotRow
                    >(
                      currentTable: table,
                      referencedTable: $$ProductRowsTableReferences
                          ._inventorySnapshotRowsRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$ProductRowsTableReferences(
                                db,
                                table,
                                p0,
                              ).inventorySnapshotRowsRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.productId == item.id,
                          ),
                      typedResults: items,
                    ),
                  if (inventoryTransactionRowsRefs)
                    await $_getPrefetchedData<
                      ProductRow,
                      $ProductRowsTable,
                      InventoryTransactionRow
                    >(
                      currentTable: table,
                      referencedTable: $$ProductRowsTableReferences
                          ._inventoryTransactionRowsRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$ProductRowsTableReferences(
                                db,
                                table,
                                p0,
                              ).inventoryTransactionRowsRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.productId == item.id,
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

typedef $$ProductRowsTableProcessedTableManager =
    ProcessedTableManager<
      _$LocalDatabase,
      $ProductRowsTable,
      ProductRow,
      $$ProductRowsTableFilterComposer,
      $$ProductRowsTableOrderingComposer,
      $$ProductRowsTableAnnotationComposer,
      $$ProductRowsTableCreateCompanionBuilder,
      $$ProductRowsTableUpdateCompanionBuilder,
      (ProductRow, $$ProductRowsTableReferences),
      ProductRow,
      PrefetchHooks Function({
        bool inventorySnapshotRowsRefs,
        bool inventoryTransactionRowsRefs,
      })
    >;
typedef $$LocationRowsTableCreateCompanionBuilder =
    LocationRowsCompanion Function({
      required String id,
      required String name,
      required String type,
      required String address,
      required DateTime updatedAt,
      Value<bool> pendingSync,
      Value<int> rowid,
    });
typedef $$LocationRowsTableUpdateCompanionBuilder =
    LocationRowsCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> type,
      Value<String> address,
      Value<DateTime> updatedAt,
      Value<bool> pendingSync,
      Value<int> rowid,
    });

final class $$LocationRowsTableReferences
    extends BaseReferences<_$LocalDatabase, $LocationRowsTable, LocationRow> {
  $$LocationRowsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$EmployeeRowsTable, List<EmployeeRow>>
  _employeeRowsRefsTable(_$LocalDatabase db) => MultiTypedResultKey.fromTable(
    db.employeeRows,
    aliasName: $_aliasNameGenerator(
      db.locationRows.id,
      db.employeeRows.locationId,
    ),
  );

  $$EmployeeRowsTableProcessedTableManager get employeeRowsRefs {
    final manager = $$EmployeeRowsTableTableManager(
      $_db,
      $_db.employeeRows,
    ).filter((f) => f.locationId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_employeeRowsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $InventorySnapshotRowsTable,
    List<InventorySnapshotRow>
  >
  _inventorySnapshotRowsRefsTable(_$LocalDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.inventorySnapshotRows,
        aliasName: $_aliasNameGenerator(
          db.locationRows.id,
          db.inventorySnapshotRows.locationId,
        ),
      );

  $$InventorySnapshotRowsTableProcessedTableManager
  get inventorySnapshotRowsRefs {
    final manager = $$InventorySnapshotRowsTableTableManager(
      $_db,
      $_db.inventorySnapshotRows,
    ).filter((f) => f.locationId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _inventorySnapshotRowsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $InventoryTransactionRowsTable,
    List<InventoryTransactionRow>
  >
  _sourceTransactionsTable(_$LocalDatabase db) => MultiTypedResultKey.fromTable(
    db.inventoryTransactionRows,
    aliasName: $_aliasNameGenerator(
      db.locationRows.id,
      db.inventoryTransactionRows.sourceLocationId,
    ),
  );

  $$InventoryTransactionRowsTableProcessedTableManager get sourceTransactions {
    final manager = $$InventoryTransactionRowsTableTableManager(
      $_db,
      $_db.inventoryTransactionRows,
    ).filter(
      (f) => f.sourceLocationId.id.sqlEquals($_itemColumn<String>('id')!),
    );

    final cache = $_typedResult.readTableOrNull(_sourceTransactionsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $InventoryTransactionRowsTable,
    List<InventoryTransactionRow>
  >
  _targetTransactionsTable(_$LocalDatabase db) => MultiTypedResultKey.fromTable(
    db.inventoryTransactionRows,
    aliasName: $_aliasNameGenerator(
      db.locationRows.id,
      db.inventoryTransactionRows.targetLocationId,
    ),
  );

  $$InventoryTransactionRowsTableProcessedTableManager get targetTransactions {
    final manager = $$InventoryTransactionRowsTableTableManager(
      $_db,
      $_db.inventoryTransactionRows,
    ).filter(
      (f) => f.targetLocationId.id.sqlEquals($_itemColumn<String>('id')!),
    );

    final cache = $_typedResult.readTableOrNull(_targetTransactionsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$LocationRowsTableFilterComposer
    extends Composer<_$LocalDatabase, $LocationRowsTable> {
  $$LocationRowsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get pendingSync => $composableBuilder(
    column: $table.pendingSync,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> employeeRowsRefs(
    Expression<bool> Function($$EmployeeRowsTableFilterComposer f) f,
  ) {
    final $$EmployeeRowsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.employeeRows,
      getReferencedColumn: (t) => t.locationId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EmployeeRowsTableFilterComposer(
            $db: $db,
            $table: $db.employeeRows,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> inventorySnapshotRowsRefs(
    Expression<bool> Function($$InventorySnapshotRowsTableFilterComposer f) f,
  ) {
    final $$InventorySnapshotRowsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.inventorySnapshotRows,
          getReferencedColumn: (t) => t.locationId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$InventorySnapshotRowsTableFilterComposer(
                $db: $db,
                $table: $db.inventorySnapshotRows,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> sourceTransactions(
    Expression<bool> Function($$InventoryTransactionRowsTableFilterComposer f)
    f,
  ) {
    final $$InventoryTransactionRowsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.inventoryTransactionRows,
          getReferencedColumn: (t) => t.sourceLocationId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$InventoryTransactionRowsTableFilterComposer(
                $db: $db,
                $table: $db.inventoryTransactionRows,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> targetTransactions(
    Expression<bool> Function($$InventoryTransactionRowsTableFilterComposer f)
    f,
  ) {
    final $$InventoryTransactionRowsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.inventoryTransactionRows,
          getReferencedColumn: (t) => t.targetLocationId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$InventoryTransactionRowsTableFilterComposer(
                $db: $db,
                $table: $db.inventoryTransactionRows,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$LocationRowsTableOrderingComposer
    extends Composer<_$LocalDatabase, $LocationRowsTable> {
  $$LocationRowsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get pendingSync => $composableBuilder(
    column: $table.pendingSync,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocationRowsTableAnnotationComposer
    extends Composer<_$LocalDatabase, $LocationRowsTable> {
  $$LocationRowsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get pendingSync => $composableBuilder(
    column: $table.pendingSync,
    builder: (column) => column,
  );

  Expression<T> employeeRowsRefs<T extends Object>(
    Expression<T> Function($$EmployeeRowsTableAnnotationComposer a) f,
  ) {
    final $$EmployeeRowsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.employeeRows,
      getReferencedColumn: (t) => t.locationId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EmployeeRowsTableAnnotationComposer(
            $db: $db,
            $table: $db.employeeRows,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> inventorySnapshotRowsRefs<T extends Object>(
    Expression<T> Function($$InventorySnapshotRowsTableAnnotationComposer a) f,
  ) {
    final $$InventorySnapshotRowsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.inventorySnapshotRows,
          getReferencedColumn: (t) => t.locationId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$InventorySnapshotRowsTableAnnotationComposer(
                $db: $db,
                $table: $db.inventorySnapshotRows,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> sourceTransactions<T extends Object>(
    Expression<T> Function($$InventoryTransactionRowsTableAnnotationComposer a)
    f,
  ) {
    final $$InventoryTransactionRowsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.inventoryTransactionRows,
          getReferencedColumn: (t) => t.sourceLocationId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$InventoryTransactionRowsTableAnnotationComposer(
                $db: $db,
                $table: $db.inventoryTransactionRows,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> targetTransactions<T extends Object>(
    Expression<T> Function($$InventoryTransactionRowsTableAnnotationComposer a)
    f,
  ) {
    final $$InventoryTransactionRowsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.inventoryTransactionRows,
          getReferencedColumn: (t) => t.targetLocationId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$InventoryTransactionRowsTableAnnotationComposer(
                $db: $db,
                $table: $db.inventoryTransactionRows,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$LocationRowsTableTableManager
    extends
        RootTableManager<
          _$LocalDatabase,
          $LocationRowsTable,
          LocationRow,
          $$LocationRowsTableFilterComposer,
          $$LocationRowsTableOrderingComposer,
          $$LocationRowsTableAnnotationComposer,
          $$LocationRowsTableCreateCompanionBuilder,
          $$LocationRowsTableUpdateCompanionBuilder,
          (LocationRow, $$LocationRowsTableReferences),
          LocationRow,
          PrefetchHooks Function({
            bool employeeRowsRefs,
            bool inventorySnapshotRowsRefs,
            bool sourceTransactions,
            bool targetTransactions,
          })
        > {
  $$LocationRowsTableTableManager(_$LocalDatabase db, $LocationRowsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$LocationRowsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$LocationRowsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () =>
                  $$LocationRowsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> address = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> pendingSync = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocationRowsCompanion(
                id: id,
                name: name,
                type: type,
                address: address,
                updatedAt: updatedAt,
                pendingSync: pendingSync,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String type,
                required String address,
                required DateTime updatedAt,
                Value<bool> pendingSync = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocationRowsCompanion.insert(
                id: id,
                name: name,
                type: type,
                address: address,
                updatedAt: updatedAt,
                pendingSync: pendingSync,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$LocationRowsTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({
            employeeRowsRefs = false,
            inventorySnapshotRowsRefs = false,
            sourceTransactions = false,
            targetTransactions = false,
          }) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (employeeRowsRefs) db.employeeRows,
                if (inventorySnapshotRowsRefs) db.inventorySnapshotRows,
                if (sourceTransactions) db.inventoryTransactionRows,
                if (targetTransactions) db.inventoryTransactionRows,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (employeeRowsRefs)
                    await $_getPrefetchedData<
                      LocationRow,
                      $LocationRowsTable,
                      EmployeeRow
                    >(
                      currentTable: table,
                      referencedTable: $$LocationRowsTableReferences
                          ._employeeRowsRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$LocationRowsTableReferences(
                                db,
                                table,
                                p0,
                              ).employeeRowsRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.locationId == item.id,
                          ),
                      typedResults: items,
                    ),
                  if (inventorySnapshotRowsRefs)
                    await $_getPrefetchedData<
                      LocationRow,
                      $LocationRowsTable,
                      InventorySnapshotRow
                    >(
                      currentTable: table,
                      referencedTable: $$LocationRowsTableReferences
                          ._inventorySnapshotRowsRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$LocationRowsTableReferences(
                                db,
                                table,
                                p0,
                              ).inventorySnapshotRowsRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.locationId == item.id,
                          ),
                      typedResults: items,
                    ),
                  if (sourceTransactions)
                    await $_getPrefetchedData<
                      LocationRow,
                      $LocationRowsTable,
                      InventoryTransactionRow
                    >(
                      currentTable: table,
                      referencedTable: $$LocationRowsTableReferences
                          ._sourceTransactionsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$LocationRowsTableReferences(
                                db,
                                table,
                                p0,
                              ).sourceTransactions,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.sourceLocationId == item.id,
                          ),
                      typedResults: items,
                    ),
                  if (targetTransactions)
                    await $_getPrefetchedData<
                      LocationRow,
                      $LocationRowsTable,
                      InventoryTransactionRow
                    >(
                      currentTable: table,
                      referencedTable: $$LocationRowsTableReferences
                          ._targetTransactionsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$LocationRowsTableReferences(
                                db,
                                table,
                                p0,
                              ).targetTransactions,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.targetLocationId == item.id,
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

typedef $$LocationRowsTableProcessedTableManager =
    ProcessedTableManager<
      _$LocalDatabase,
      $LocationRowsTable,
      LocationRow,
      $$LocationRowsTableFilterComposer,
      $$LocationRowsTableOrderingComposer,
      $$LocationRowsTableAnnotationComposer,
      $$LocationRowsTableCreateCompanionBuilder,
      $$LocationRowsTableUpdateCompanionBuilder,
      (LocationRow, $$LocationRowsTableReferences),
      LocationRow,
      PrefetchHooks Function({
        bool employeeRowsRefs,
        bool inventorySnapshotRowsRefs,
        bool sourceTransactions,
        bool targetTransactions,
      })
    >;
typedef $$EmployeeRowsTableCreateCompanionBuilder =
    EmployeeRowsCompanion Function({
      required String id,
      required String firstName,
      required String lastName,
      required String email,
      Value<bool> active,
      required String locationId,
      required DateTime updatedAt,
      Value<bool> pendingSync,
      Value<int> rowid,
    });
typedef $$EmployeeRowsTableUpdateCompanionBuilder =
    EmployeeRowsCompanion Function({
      Value<String> id,
      Value<String> firstName,
      Value<String> lastName,
      Value<String> email,
      Value<bool> active,
      Value<String> locationId,
      Value<DateTime> updatedAt,
      Value<bool> pendingSync,
      Value<int> rowid,
    });

final class $$EmployeeRowsTableReferences
    extends BaseReferences<_$LocalDatabase, $EmployeeRowsTable, EmployeeRow> {
  $$EmployeeRowsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $LocationRowsTable _locationIdTable(_$LocalDatabase db) =>
      db.locationRows.createAlias(
        $_aliasNameGenerator(db.employeeRows.locationId, db.locationRows.id),
      );

  $$LocationRowsTableProcessedTableManager get locationId {
    final $_column = $_itemColumn<String>('location_id')!;

    final manager = $$LocationRowsTableTableManager(
      $_db,
      $_db.locationRows,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_locationIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<
    $InventoryTransactionRowsTable,
    List<InventoryTransactionRow>
  >
  _inventoryTransactionRowsRefsTable(_$LocalDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.inventoryTransactionRows,
        aliasName: $_aliasNameGenerator(
          db.employeeRows.id,
          db.inventoryTransactionRows.employeeId,
        ),
      );

  $$InventoryTransactionRowsTableProcessedTableManager
  get inventoryTransactionRowsRefs {
    final manager = $$InventoryTransactionRowsTableTableManager(
      $_db,
      $_db.inventoryTransactionRows,
    ).filter((f) => f.employeeId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _inventoryTransactionRowsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$EmployeeRowsTableFilterComposer
    extends Composer<_$LocalDatabase, $EmployeeRowsTable> {
  $$EmployeeRowsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get firstName => $composableBuilder(
    column: $table.firstName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastName => $composableBuilder(
    column: $table.lastName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get active => $composableBuilder(
    column: $table.active,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get pendingSync => $composableBuilder(
    column: $table.pendingSync,
    builder: (column) => ColumnFilters(column),
  );

  $$LocationRowsTableFilterComposer get locationId {
    final $$LocationRowsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.locationId,
      referencedTable: $db.locationRows,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocationRowsTableFilterComposer(
            $db: $db,
            $table: $db.locationRows,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> inventoryTransactionRowsRefs(
    Expression<bool> Function($$InventoryTransactionRowsTableFilterComposer f)
    f,
  ) {
    final $$InventoryTransactionRowsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.inventoryTransactionRows,
          getReferencedColumn: (t) => t.employeeId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$InventoryTransactionRowsTableFilterComposer(
                $db: $db,
                $table: $db.inventoryTransactionRows,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$EmployeeRowsTableOrderingComposer
    extends Composer<_$LocalDatabase, $EmployeeRowsTable> {
  $$EmployeeRowsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get firstName => $composableBuilder(
    column: $table.firstName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastName => $composableBuilder(
    column: $table.lastName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get active => $composableBuilder(
    column: $table.active,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get pendingSync => $composableBuilder(
    column: $table.pendingSync,
    builder: (column) => ColumnOrderings(column),
  );

  $$LocationRowsTableOrderingComposer get locationId {
    final $$LocationRowsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.locationId,
      referencedTable: $db.locationRows,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocationRowsTableOrderingComposer(
            $db: $db,
            $table: $db.locationRows,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EmployeeRowsTableAnnotationComposer
    extends Composer<_$LocalDatabase, $EmployeeRowsTable> {
  $$EmployeeRowsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get firstName =>
      $composableBuilder(column: $table.firstName, builder: (column) => column);

  GeneratedColumn<String> get lastName =>
      $composableBuilder(column: $table.lastName, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<bool> get active =>
      $composableBuilder(column: $table.active, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get pendingSync => $composableBuilder(
    column: $table.pendingSync,
    builder: (column) => column,
  );

  $$LocationRowsTableAnnotationComposer get locationId {
    final $$LocationRowsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.locationId,
      referencedTable: $db.locationRows,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocationRowsTableAnnotationComposer(
            $db: $db,
            $table: $db.locationRows,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> inventoryTransactionRowsRefs<T extends Object>(
    Expression<T> Function($$InventoryTransactionRowsTableAnnotationComposer a)
    f,
  ) {
    final $$InventoryTransactionRowsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.inventoryTransactionRows,
          getReferencedColumn: (t) => t.employeeId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$InventoryTransactionRowsTableAnnotationComposer(
                $db: $db,
                $table: $db.inventoryTransactionRows,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$EmployeeRowsTableTableManager
    extends
        RootTableManager<
          _$LocalDatabase,
          $EmployeeRowsTable,
          EmployeeRow,
          $$EmployeeRowsTableFilterComposer,
          $$EmployeeRowsTableOrderingComposer,
          $$EmployeeRowsTableAnnotationComposer,
          $$EmployeeRowsTableCreateCompanionBuilder,
          $$EmployeeRowsTableUpdateCompanionBuilder,
          (EmployeeRow, $$EmployeeRowsTableReferences),
          EmployeeRow,
          PrefetchHooks Function({
            bool locationId,
            bool inventoryTransactionRowsRefs,
          })
        > {
  $$EmployeeRowsTableTableManager(_$LocalDatabase db, $EmployeeRowsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$EmployeeRowsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$EmployeeRowsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () =>
                  $$EmployeeRowsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> firstName = const Value.absent(),
                Value<String> lastName = const Value.absent(),
                Value<String> email = const Value.absent(),
                Value<bool> active = const Value.absent(),
                Value<String> locationId = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> pendingSync = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EmployeeRowsCompanion(
                id: id,
                firstName: firstName,
                lastName: lastName,
                email: email,
                active: active,
                locationId: locationId,
                updatedAt: updatedAt,
                pendingSync: pendingSync,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String firstName,
                required String lastName,
                required String email,
                Value<bool> active = const Value.absent(),
                required String locationId,
                required DateTime updatedAt,
                Value<bool> pendingSync = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EmployeeRowsCompanion.insert(
                id: id,
                firstName: firstName,
                lastName: lastName,
                email: email,
                active: active,
                locationId: locationId,
                updatedAt: updatedAt,
                pendingSync: pendingSync,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$EmployeeRowsTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({
            locationId = false,
            inventoryTransactionRowsRefs = false,
          }) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (inventoryTransactionRowsRefs) db.inventoryTransactionRows,
              ],
              addJoins: <
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
                if (locationId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.locationId,
                            referencedTable: $$EmployeeRowsTableReferences
                                ._locationIdTable(db),
                            referencedColumn:
                                $$EmployeeRowsTableReferences
                                    ._locationIdTable(db)
                                    .id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (inventoryTransactionRowsRefs)
                    await $_getPrefetchedData<
                      EmployeeRow,
                      $EmployeeRowsTable,
                      InventoryTransactionRow
                    >(
                      currentTable: table,
                      referencedTable: $$EmployeeRowsTableReferences
                          ._inventoryTransactionRowsRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$EmployeeRowsTableReferences(
                                db,
                                table,
                                p0,
                              ).inventoryTransactionRowsRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.employeeId == item.id,
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

typedef $$EmployeeRowsTableProcessedTableManager =
    ProcessedTableManager<
      _$LocalDatabase,
      $EmployeeRowsTable,
      EmployeeRow,
      $$EmployeeRowsTableFilterComposer,
      $$EmployeeRowsTableOrderingComposer,
      $$EmployeeRowsTableAnnotationComposer,
      $$EmployeeRowsTableCreateCompanionBuilder,
      $$EmployeeRowsTableUpdateCompanionBuilder,
      (EmployeeRow, $$EmployeeRowsTableReferences),
      EmployeeRow,
      PrefetchHooks Function({
        bool locationId,
        bool inventoryTransactionRowsRefs,
      })
    >;
typedef $$InventorySnapshotRowsTableCreateCompanionBuilder =
    InventorySnapshotRowsCompanion Function({
      required String id,
      required String productId,
      required String locationId,
      required double quantity,
      required DateTime updatedAt,
      Value<bool> pendingSync,
      Value<int> rowid,
    });
typedef $$InventorySnapshotRowsTableUpdateCompanionBuilder =
    InventorySnapshotRowsCompanion Function({
      Value<String> id,
      Value<String> productId,
      Value<String> locationId,
      Value<double> quantity,
      Value<DateTime> updatedAt,
      Value<bool> pendingSync,
      Value<int> rowid,
    });

final class $$InventorySnapshotRowsTableReferences
    extends
        BaseReferences<
          _$LocalDatabase,
          $InventorySnapshotRowsTable,
          InventorySnapshotRow
        > {
  $$InventorySnapshotRowsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ProductRowsTable _productIdTable(_$LocalDatabase db) =>
      db.productRows.createAlias(
        $_aliasNameGenerator(
          db.inventorySnapshotRows.productId,
          db.productRows.id,
        ),
      );

  $$ProductRowsTableProcessedTableManager get productId {
    final $_column = $_itemColumn<String>('product_id')!;

    final manager = $$ProductRowsTableTableManager(
      $_db,
      $_db.productRows,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_productIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $LocationRowsTable _locationIdTable(_$LocalDatabase db) =>
      db.locationRows.createAlias(
        $_aliasNameGenerator(
          db.inventorySnapshotRows.locationId,
          db.locationRows.id,
        ),
      );

  $$LocationRowsTableProcessedTableManager get locationId {
    final $_column = $_itemColumn<String>('location_id')!;

    final manager = $$LocationRowsTableTableManager(
      $_db,
      $_db.locationRows,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_locationIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$InventorySnapshotRowsTableFilterComposer
    extends Composer<_$LocalDatabase, $InventorySnapshotRowsTable> {
  $$InventorySnapshotRowsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get pendingSync => $composableBuilder(
    column: $table.pendingSync,
    builder: (column) => ColumnFilters(column),
  );

  $$ProductRowsTableFilterComposer get productId {
    final $$ProductRowsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.productRows,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductRowsTableFilterComposer(
            $db: $db,
            $table: $db.productRows,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LocationRowsTableFilterComposer get locationId {
    final $$LocationRowsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.locationId,
      referencedTable: $db.locationRows,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocationRowsTableFilterComposer(
            $db: $db,
            $table: $db.locationRows,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InventorySnapshotRowsTableOrderingComposer
    extends Composer<_$LocalDatabase, $InventorySnapshotRowsTable> {
  $$InventorySnapshotRowsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get pendingSync => $composableBuilder(
    column: $table.pendingSync,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProductRowsTableOrderingComposer get productId {
    final $$ProductRowsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.productRows,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductRowsTableOrderingComposer(
            $db: $db,
            $table: $db.productRows,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LocationRowsTableOrderingComposer get locationId {
    final $$LocationRowsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.locationId,
      referencedTable: $db.locationRows,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocationRowsTableOrderingComposer(
            $db: $db,
            $table: $db.locationRows,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InventorySnapshotRowsTableAnnotationComposer
    extends Composer<_$LocalDatabase, $InventorySnapshotRowsTable> {
  $$InventorySnapshotRowsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get pendingSync => $composableBuilder(
    column: $table.pendingSync,
    builder: (column) => column,
  );

  $$ProductRowsTableAnnotationComposer get productId {
    final $$ProductRowsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.productRows,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductRowsTableAnnotationComposer(
            $db: $db,
            $table: $db.productRows,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LocationRowsTableAnnotationComposer get locationId {
    final $$LocationRowsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.locationId,
      referencedTable: $db.locationRows,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocationRowsTableAnnotationComposer(
            $db: $db,
            $table: $db.locationRows,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InventorySnapshotRowsTableTableManager
    extends
        RootTableManager<
          _$LocalDatabase,
          $InventorySnapshotRowsTable,
          InventorySnapshotRow,
          $$InventorySnapshotRowsTableFilterComposer,
          $$InventorySnapshotRowsTableOrderingComposer,
          $$InventorySnapshotRowsTableAnnotationComposer,
          $$InventorySnapshotRowsTableCreateCompanionBuilder,
          $$InventorySnapshotRowsTableUpdateCompanionBuilder,
          (InventorySnapshotRow, $$InventorySnapshotRowsTableReferences),
          InventorySnapshotRow,
          PrefetchHooks Function({bool productId, bool locationId})
        > {
  $$InventorySnapshotRowsTableTableManager(
    _$LocalDatabase db,
    $InventorySnapshotRowsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$InventorySnapshotRowsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer:
              () => $$InventorySnapshotRowsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$InventorySnapshotRowsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> productId = const Value.absent(),
                Value<String> locationId = const Value.absent(),
                Value<double> quantity = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> pendingSync = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InventorySnapshotRowsCompanion(
                id: id,
                productId: productId,
                locationId: locationId,
                quantity: quantity,
                updatedAt: updatedAt,
                pendingSync: pendingSync,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String productId,
                required String locationId,
                required double quantity,
                required DateTime updatedAt,
                Value<bool> pendingSync = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InventorySnapshotRowsCompanion.insert(
                id: id,
                productId: productId,
                locationId: locationId,
                quantity: quantity,
                updatedAt: updatedAt,
                pendingSync: pendingSync,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$InventorySnapshotRowsTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({productId = false, locationId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                if (productId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.productId,
                            referencedTable:
                                $$InventorySnapshotRowsTableReferences
                                    ._productIdTable(db),
                            referencedColumn:
                                $$InventorySnapshotRowsTableReferences
                                    ._productIdTable(db)
                                    .id,
                          )
                          as T;
                }
                if (locationId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.locationId,
                            referencedTable:
                                $$InventorySnapshotRowsTableReferences
                                    ._locationIdTable(db),
                            referencedColumn:
                                $$InventorySnapshotRowsTableReferences
                                    ._locationIdTable(db)
                                    .id,
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

typedef $$InventorySnapshotRowsTableProcessedTableManager =
    ProcessedTableManager<
      _$LocalDatabase,
      $InventorySnapshotRowsTable,
      InventorySnapshotRow,
      $$InventorySnapshotRowsTableFilterComposer,
      $$InventorySnapshotRowsTableOrderingComposer,
      $$InventorySnapshotRowsTableAnnotationComposer,
      $$InventorySnapshotRowsTableCreateCompanionBuilder,
      $$InventorySnapshotRowsTableUpdateCompanionBuilder,
      (InventorySnapshotRow, $$InventorySnapshotRowsTableReferences),
      InventorySnapshotRow,
      PrefetchHooks Function({bool productId, bool locationId})
    >;
typedef $$InventoryTransactionRowsTableCreateCompanionBuilder =
    InventoryTransactionRowsCompanion Function({
      required String id,
      required String productId,
      Value<String?> sourceLocationId,
      Value<String?> targetLocationId,
      required double quantity,
      required String transactionType,
      required String reference,
      Value<String?> note,
      required String employeeId,
      required DateTime occurredAt,
      required DateTime updatedAt,
      Value<bool> pendingSync,
      Value<int> rowid,
    });
typedef $$InventoryTransactionRowsTableUpdateCompanionBuilder =
    InventoryTransactionRowsCompanion Function({
      Value<String> id,
      Value<String> productId,
      Value<String?> sourceLocationId,
      Value<String?> targetLocationId,
      Value<double> quantity,
      Value<String> transactionType,
      Value<String> reference,
      Value<String?> note,
      Value<String> employeeId,
      Value<DateTime> occurredAt,
      Value<DateTime> updatedAt,
      Value<bool> pendingSync,
      Value<int> rowid,
    });

final class $$InventoryTransactionRowsTableReferences
    extends
        BaseReferences<
          _$LocalDatabase,
          $InventoryTransactionRowsTable,
          InventoryTransactionRow
        > {
  $$InventoryTransactionRowsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ProductRowsTable _productIdTable(_$LocalDatabase db) =>
      db.productRows.createAlias(
        $_aliasNameGenerator(
          db.inventoryTransactionRows.productId,
          db.productRows.id,
        ),
      );

  $$ProductRowsTableProcessedTableManager get productId {
    final $_column = $_itemColumn<String>('product_id')!;

    final manager = $$ProductRowsTableTableManager(
      $_db,
      $_db.productRows,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_productIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $LocationRowsTable _sourceLocationIdTable(_$LocalDatabase db) =>
      db.locationRows.createAlias(
        $_aliasNameGenerator(
          db.inventoryTransactionRows.sourceLocationId,
          db.locationRows.id,
        ),
      );

  $$LocationRowsTableProcessedTableManager? get sourceLocationId {
    final $_column = $_itemColumn<String>('source_location_id');
    if ($_column == null) return null;
    final manager = $$LocationRowsTableTableManager(
      $_db,
      $_db.locationRows,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sourceLocationIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $LocationRowsTable _targetLocationIdTable(_$LocalDatabase db) =>
      db.locationRows.createAlias(
        $_aliasNameGenerator(
          db.inventoryTransactionRows.targetLocationId,
          db.locationRows.id,
        ),
      );

  $$LocationRowsTableProcessedTableManager? get targetLocationId {
    final $_column = $_itemColumn<String>('target_location_id');
    if ($_column == null) return null;
    final manager = $$LocationRowsTableTableManager(
      $_db,
      $_db.locationRows,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_targetLocationIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $EmployeeRowsTable _employeeIdTable(_$LocalDatabase db) =>
      db.employeeRows.createAlias(
        $_aliasNameGenerator(
          db.inventoryTransactionRows.employeeId,
          db.employeeRows.id,
        ),
      );

  $$EmployeeRowsTableProcessedTableManager get employeeId {
    final $_column = $_itemColumn<String>('employee_id')!;

    final manager = $$EmployeeRowsTableTableManager(
      $_db,
      $_db.employeeRows,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_employeeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$InventoryTransactionRowsTableFilterComposer
    extends Composer<_$LocalDatabase, $InventoryTransactionRowsTable> {
  $$InventoryTransactionRowsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get transactionType => $composableBuilder(
    column: $table.transactionType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reference => $composableBuilder(
    column: $table.reference,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get pendingSync => $composableBuilder(
    column: $table.pendingSync,
    builder: (column) => ColumnFilters(column),
  );

  $$ProductRowsTableFilterComposer get productId {
    final $$ProductRowsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.productRows,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductRowsTableFilterComposer(
            $db: $db,
            $table: $db.productRows,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LocationRowsTableFilterComposer get sourceLocationId {
    final $$LocationRowsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sourceLocationId,
      referencedTable: $db.locationRows,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocationRowsTableFilterComposer(
            $db: $db,
            $table: $db.locationRows,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LocationRowsTableFilterComposer get targetLocationId {
    final $$LocationRowsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.targetLocationId,
      referencedTable: $db.locationRows,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocationRowsTableFilterComposer(
            $db: $db,
            $table: $db.locationRows,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$EmployeeRowsTableFilterComposer get employeeId {
    final $$EmployeeRowsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.employeeId,
      referencedTable: $db.employeeRows,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EmployeeRowsTableFilterComposer(
            $db: $db,
            $table: $db.employeeRows,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InventoryTransactionRowsTableOrderingComposer
    extends Composer<_$LocalDatabase, $InventoryTransactionRowsTable> {
  $$InventoryTransactionRowsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get transactionType => $composableBuilder(
    column: $table.transactionType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reference => $composableBuilder(
    column: $table.reference,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get pendingSync => $composableBuilder(
    column: $table.pendingSync,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProductRowsTableOrderingComposer get productId {
    final $$ProductRowsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.productRows,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductRowsTableOrderingComposer(
            $db: $db,
            $table: $db.productRows,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LocationRowsTableOrderingComposer get sourceLocationId {
    final $$LocationRowsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sourceLocationId,
      referencedTable: $db.locationRows,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocationRowsTableOrderingComposer(
            $db: $db,
            $table: $db.locationRows,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LocationRowsTableOrderingComposer get targetLocationId {
    final $$LocationRowsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.targetLocationId,
      referencedTable: $db.locationRows,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocationRowsTableOrderingComposer(
            $db: $db,
            $table: $db.locationRows,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$EmployeeRowsTableOrderingComposer get employeeId {
    final $$EmployeeRowsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.employeeId,
      referencedTable: $db.employeeRows,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EmployeeRowsTableOrderingComposer(
            $db: $db,
            $table: $db.employeeRows,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InventoryTransactionRowsTableAnnotationComposer
    extends Composer<_$LocalDatabase, $InventoryTransactionRowsTable> {
  $$InventoryTransactionRowsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<String> get transactionType => $composableBuilder(
    column: $table.transactionType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get reference =>
      $composableBuilder(column: $table.reference, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get pendingSync => $composableBuilder(
    column: $table.pendingSync,
    builder: (column) => column,
  );

  $$ProductRowsTableAnnotationComposer get productId {
    final $$ProductRowsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.productRows,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductRowsTableAnnotationComposer(
            $db: $db,
            $table: $db.productRows,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LocationRowsTableAnnotationComposer get sourceLocationId {
    final $$LocationRowsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sourceLocationId,
      referencedTable: $db.locationRows,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocationRowsTableAnnotationComposer(
            $db: $db,
            $table: $db.locationRows,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LocationRowsTableAnnotationComposer get targetLocationId {
    final $$LocationRowsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.targetLocationId,
      referencedTable: $db.locationRows,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocationRowsTableAnnotationComposer(
            $db: $db,
            $table: $db.locationRows,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$EmployeeRowsTableAnnotationComposer get employeeId {
    final $$EmployeeRowsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.employeeId,
      referencedTable: $db.employeeRows,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EmployeeRowsTableAnnotationComposer(
            $db: $db,
            $table: $db.employeeRows,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InventoryTransactionRowsTableTableManager
    extends
        RootTableManager<
          _$LocalDatabase,
          $InventoryTransactionRowsTable,
          InventoryTransactionRow,
          $$InventoryTransactionRowsTableFilterComposer,
          $$InventoryTransactionRowsTableOrderingComposer,
          $$InventoryTransactionRowsTableAnnotationComposer,
          $$InventoryTransactionRowsTableCreateCompanionBuilder,
          $$InventoryTransactionRowsTableUpdateCompanionBuilder,
          (InventoryTransactionRow, $$InventoryTransactionRowsTableReferences),
          InventoryTransactionRow,
          PrefetchHooks Function({
            bool productId,
            bool sourceLocationId,
            bool targetLocationId,
            bool employeeId,
          })
        > {
  $$InventoryTransactionRowsTableTableManager(
    _$LocalDatabase db,
    $InventoryTransactionRowsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$InventoryTransactionRowsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer:
              () => $$InventoryTransactionRowsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$InventoryTransactionRowsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> productId = const Value.absent(),
                Value<String?> sourceLocationId = const Value.absent(),
                Value<String?> targetLocationId = const Value.absent(),
                Value<double> quantity = const Value.absent(),
                Value<String> transactionType = const Value.absent(),
                Value<String> reference = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<String> employeeId = const Value.absent(),
                Value<DateTime> occurredAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> pendingSync = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InventoryTransactionRowsCompanion(
                id: id,
                productId: productId,
                sourceLocationId: sourceLocationId,
                targetLocationId: targetLocationId,
                quantity: quantity,
                transactionType: transactionType,
                reference: reference,
                note: note,
                employeeId: employeeId,
                occurredAt: occurredAt,
                updatedAt: updatedAt,
                pendingSync: pendingSync,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String productId,
                Value<String?> sourceLocationId = const Value.absent(),
                Value<String?> targetLocationId = const Value.absent(),
                required double quantity,
                required String transactionType,
                required String reference,
                Value<String?> note = const Value.absent(),
                required String employeeId,
                required DateTime occurredAt,
                required DateTime updatedAt,
                Value<bool> pendingSync = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InventoryTransactionRowsCompanion.insert(
                id: id,
                productId: productId,
                sourceLocationId: sourceLocationId,
                targetLocationId: targetLocationId,
                quantity: quantity,
                transactionType: transactionType,
                reference: reference,
                note: note,
                employeeId: employeeId,
                occurredAt: occurredAt,
                updatedAt: updatedAt,
                pendingSync: pendingSync,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$InventoryTransactionRowsTableReferences(
                            db,
                            table,
                            e,
                          ),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({
            productId = false,
            sourceLocationId = false,
            targetLocationId = false,
            employeeId = false,
          }) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                if (productId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.productId,
                            referencedTable:
                                $$InventoryTransactionRowsTableReferences
                                    ._productIdTable(db),
                            referencedColumn:
                                $$InventoryTransactionRowsTableReferences
                                    ._productIdTable(db)
                                    .id,
                          )
                          as T;
                }
                if (sourceLocationId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.sourceLocationId,
                            referencedTable:
                                $$InventoryTransactionRowsTableReferences
                                    ._sourceLocationIdTable(db),
                            referencedColumn:
                                $$InventoryTransactionRowsTableReferences
                                    ._sourceLocationIdTable(db)
                                    .id,
                          )
                          as T;
                }
                if (targetLocationId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.targetLocationId,
                            referencedTable:
                                $$InventoryTransactionRowsTableReferences
                                    ._targetLocationIdTable(db),
                            referencedColumn:
                                $$InventoryTransactionRowsTableReferences
                                    ._targetLocationIdTable(db)
                                    .id,
                          )
                          as T;
                }
                if (employeeId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.employeeId,
                            referencedTable:
                                $$InventoryTransactionRowsTableReferences
                                    ._employeeIdTable(db),
                            referencedColumn:
                                $$InventoryTransactionRowsTableReferences
                                    ._employeeIdTable(db)
                                    .id,
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

typedef $$InventoryTransactionRowsTableProcessedTableManager =
    ProcessedTableManager<
      _$LocalDatabase,
      $InventoryTransactionRowsTable,
      InventoryTransactionRow,
      $$InventoryTransactionRowsTableFilterComposer,
      $$InventoryTransactionRowsTableOrderingComposer,
      $$InventoryTransactionRowsTableAnnotationComposer,
      $$InventoryTransactionRowsTableCreateCompanionBuilder,
      $$InventoryTransactionRowsTableUpdateCompanionBuilder,
      (InventoryTransactionRow, $$InventoryTransactionRowsTableReferences),
      InventoryTransactionRow,
      PrefetchHooks Function({
        bool productId,
        bool sourceLocationId,
        bool targetLocationId,
        bool employeeId,
      })
    >;
typedef $$SyncStatusesTableCreateCompanionBuilder =
    SyncStatusesCompanion Function({
      required String resource,
      Value<DateTime?> lastSyncedAt,
      Value<int> rowid,
    });
typedef $$SyncStatusesTableUpdateCompanionBuilder =
    SyncStatusesCompanion Function({
      Value<String> resource,
      Value<DateTime?> lastSyncedAt,
      Value<int> rowid,
    });

class $$SyncStatusesTableFilterComposer
    extends Composer<_$LocalDatabase, $SyncStatusesTable> {
  $$SyncStatusesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get resource => $composableBuilder(
    column: $table.resource,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncStatusesTableOrderingComposer
    extends Composer<_$LocalDatabase, $SyncStatusesTable> {
  $$SyncStatusesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get resource => $composableBuilder(
    column: $table.resource,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncStatusesTableAnnotationComposer
    extends Composer<_$LocalDatabase, $SyncStatusesTable> {
  $$SyncStatusesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get resource =>
      $composableBuilder(column: $table.resource, builder: (column) => column);

  GeneratedColumn<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => column,
  );
}

class $$SyncStatusesTableTableManager
    extends
        RootTableManager<
          _$LocalDatabase,
          $SyncStatusesTable,
          SyncStatuse,
          $$SyncStatusesTableFilterComposer,
          $$SyncStatusesTableOrderingComposer,
          $$SyncStatusesTableAnnotationComposer,
          $$SyncStatusesTableCreateCompanionBuilder,
          $$SyncStatusesTableUpdateCompanionBuilder,
          (
            SyncStatuse,
            BaseReferences<_$LocalDatabase, $SyncStatusesTable, SyncStatuse>,
          ),
          SyncStatuse,
          PrefetchHooks Function()
        > {
  $$SyncStatusesTableTableManager(_$LocalDatabase db, $SyncStatusesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$SyncStatusesTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$SyncStatusesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () =>
                  $$SyncStatusesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> resource = const Value.absent(),
                Value<DateTime?> lastSyncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncStatusesCompanion(
                resource: resource,
                lastSyncedAt: lastSyncedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String resource,
                Value<DateTime?> lastSyncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncStatusesCompanion.insert(
                resource: resource,
                lastSyncedAt: lastSyncedAt,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncStatusesTableProcessedTableManager =
    ProcessedTableManager<
      _$LocalDatabase,
      $SyncStatusesTable,
      SyncStatuse,
      $$SyncStatusesTableFilterComposer,
      $$SyncStatusesTableOrderingComposer,
      $$SyncStatusesTableAnnotationComposer,
      $$SyncStatusesTableCreateCompanionBuilder,
      $$SyncStatusesTableUpdateCompanionBuilder,
      (
        SyncStatuse,
        BaseReferences<_$LocalDatabase, $SyncStatusesTable, SyncStatuse>,
      ),
      SyncStatuse,
      PrefetchHooks Function()
    >;

class $LocalDatabaseManager {
  final _$LocalDatabase _db;
  $LocalDatabaseManager(this._db);
  $$ProductRowsTableTableManager get productRows =>
      $$ProductRowsTableTableManager(_db, _db.productRows);
  $$LocationRowsTableTableManager get locationRows =>
      $$LocationRowsTableTableManager(_db, _db.locationRows);
  $$EmployeeRowsTableTableManager get employeeRows =>
      $$EmployeeRowsTableTableManager(_db, _db.employeeRows);
  $$InventorySnapshotRowsTableTableManager get inventorySnapshotRows =>
      $$InventorySnapshotRowsTableTableManager(_db, _db.inventorySnapshotRows);
  $$InventoryTransactionRowsTableTableManager get inventoryTransactionRows =>
      $$InventoryTransactionRowsTableTableManager(
        _db,
        _db.inventoryTransactionRows,
      );
  $$SyncStatusesTableTableManager get syncStatuses =>
      $$SyncStatusesTableTableManager(_db, _db.syncStatuses);
}
