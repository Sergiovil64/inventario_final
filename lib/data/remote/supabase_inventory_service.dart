import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:inventario_final/models/entities.dart';
import 'package:inventario_final/models/enums.dart';

class SupabaseInventoryService {
  SupabaseInventoryService({SupabaseClient? client})
      : _client = client ?? Supabase.instance.client;

  final SupabaseClient _client;

  Future<List<ProductEntity>> fetchProducts({DateTime? updatedAfter}) async {
    return _fetchEntities<ProductEntity>(
      table: 'products',
      mapper: _productFromMap,
      updatedAfter: updatedAfter,
    );
  }

  Future<List<ProductEntity>> upsertProducts(List<ProductEntity> entities) async {
    if (entities.isEmpty) return const [];
    final rows = entities.map(_productToMap).toList();
    return _upsertEntities<ProductEntity>(
      table: 'products',
      rows: rows,
      mapper: _productFromMap,
    );
  }

  Future<List<LocationEntity>> fetchLocations({DateTime? updatedAfter}) async {
    return _fetchEntities<LocationEntity>(
      table: 'locations',
      mapper: _locationFromMap,
      updatedAfter: updatedAfter,
    );
  }

  Future<List<LocationEntity>> upsertLocations(List<LocationEntity> entities) async {
    if (entities.isEmpty) return const [];
    final rows = entities.map(_locationToMap).toList();
    return _upsertEntities<LocationEntity>(
      table: 'locations',
      rows: rows,
      mapper: _locationFromMap,
    );
  }

  Future<List<EmployeeEntity>> fetchEmployees({DateTime? updatedAfter}) async {
    return _fetchEntities<EmployeeEntity>(
      table: 'employees',
      mapper: _employeeFromMap,
      updatedAfter: updatedAfter,
    );
  }

  Future<List<EmployeeEntity>> upsertEmployees(List<EmployeeEntity> entities) async {
    if (entities.isEmpty) return const [];
    final rows = entities.map(_employeeToMap).toList();
    return _upsertEntities<EmployeeEntity>(
      table: 'employees',
      rows: rows,
      mapper: _employeeFromMap,
    );
  }

  Future<List<InventorySnapshotEntity>> fetchSnapshots({DateTime? updatedAfter}) async {
    return _fetchEntities<InventorySnapshotEntity>(
      table: 'inventory_snapshots',
      mapper: _snapshotFromMap,
      updatedAfter: updatedAfter,
    );
  }

  Future<List<InventorySnapshotEntity>> upsertSnapshots(
    List<InventorySnapshotEntity> entities,
  ) async {
    if (entities.isEmpty) return const [];
    final rows = entities.map(_snapshotToMap).toList();
    return _upsertEntities<InventorySnapshotEntity>(
      table: 'inventory_snapshots',
      rows: rows,
      mapper: _snapshotFromMap,
    );
  }

  Future<List<InventoryTransactionEntity>> fetchTransactions({DateTime? updatedAfter}) async {
    return _fetchEntities<InventoryTransactionEntity>(
      table: 'inventory_transactions',
      mapper: _transactionFromMap,
      updatedAfter: updatedAfter,
    );
  }

  Future<List<InventoryTransactionEntity>> upsertTransactions(
    List<InventoryTransactionEntity> entities,
  ) async {
    if (entities.isEmpty) return const [];
    final rows = entities.map(_transactionToMap).toList();
    return _upsertEntities<InventoryTransactionEntity>(
      table: 'inventory_transactions',
      rows: rows,
      mapper: _transactionFromMap,
    );
  }

  Future<List<T>> _fetchEntities<T>({
    required String table,
    required T Function(Map<String, dynamic>) mapper,
    DateTime? updatedAfter,
  }) async {
    var query = _client.from(table).select();
    if (updatedAfter != null) {
      query = query.filter('updated_at', 'gt', updatedAfter.toUtc().toIso8601String());
    }
    final response = await query.order('updated_at');
    final data = (response as List<dynamic>).cast<Map<String, dynamic>>();
    return data.map(mapper).toList();
  }

  Future<List<T>> _upsertEntities<T>({
    required String table,
    required List<Map<String, dynamic>> rows,
    required T Function(Map<String, dynamic>) mapper,
  }) async {
    final response = await _client
        .from(table)
        .upsert(rows, onConflict: 'id')
        .select();
    final data = (response as List<dynamic>).cast<Map<String, dynamic>>();
    return data.map(mapper).toList();
  }

  static ProductEntity _productFromMap(Map<String, dynamic> row) {
    return ProductEntity(
      id: row['id'] as String,
      name: row['name'] as String,
      sku: row['sku'] as String,
      category: row['category'] as String,
      unit: row['unit'] as String,
      price: _toDouble(row['price']),
      active: row['active'] as bool? ?? true,
      sync: _syncMetadata(row['id'], row['updated_at']),
    );
  }

  static Map<String, dynamic> _productToMap(ProductEntity entity) {
    return {
      'id': entity.id,
      'name': entity.name,
      'sku': entity.sku,
      'category': entity.category,
      'unit': entity.unit,
      'price': entity.price,
      'active': entity.active,
      'updated_at': _dateToString(entity.sync.updatedAt),
    };
  }

  static LocationEntity _locationFromMap(Map<String, dynamic> row) {
    return LocationEntity(
      id: row['id'] as String,
      name: row['name'] as String,
      type: LocationTypeX.fromValue(row['type'] as String),
      address: row['address'] as String,
      sync: _syncMetadata(row['id'], row['updated_at']),
    );
  }

  static Map<String, dynamic> _locationToMap(LocationEntity entity) {
    return {
      'id': entity.id,
      'name': entity.name,
      'type': entity.type.value,
      'address': entity.address,
      'updated_at': _dateToString(entity.sync.updatedAt),
    };
  }

  static EmployeeEntity _employeeFromMap(Map<String, dynamic> row) {
    return EmployeeEntity(
      id: row['id'] as String,
      firstName: row['first_name'] as String,
      lastName: row['last_name'] as String,
      email: row['email'] as String,
      active: row['active'] as bool? ?? true,
      locationId: row['location_id'] as String,
      sync: _syncMetadata(row['id'], row['updated_at']),
    );
  }

  static Map<String, dynamic> _employeeToMap(EmployeeEntity entity) {
    return {
      'id': entity.id,
      'first_name': entity.firstName,
      'last_name': entity.lastName,
      'email': entity.email,
      'active': entity.active,
      'location_id': entity.locationId,
      'updated_at': _dateToString(entity.sync.updatedAt),
    };
  }

  static InventorySnapshotEntity _snapshotFromMap(Map<String, dynamic> row) {
    return InventorySnapshotEntity(
      id: row['id'] as String,
      productId: row['product_id'] as String,
      locationId: row['location_id'] as String,
      quantity: _toDouble(row['quantity']),
      updatedAt: _parseDateTime(row['updated_at']),
      sync: _syncMetadata(row['id'], row['updated_at']),
    );
  }

  static Map<String, dynamic> _snapshotToMap(InventorySnapshotEntity entity) {
    return {
      'id': entity.id,
      'product_id': entity.productId,
      'location_id': entity.locationId,
      'quantity': entity.quantity,
      'updated_at': _dateToString(entity.updatedAt),
    };
  }

  static InventoryTransactionEntity _transactionFromMap(Map<String, dynamic> row) {
    return InventoryTransactionEntity(
      id: row['id'] as String,
      productId: row['product_id'] as String,
      sourceLocationId: row['source_location_id'] as String?,
      targetLocationId: row['target_location_id'] as String?,
      quantity: _toDouble(row['quantity']),
      transactionType: TransactionTypeX.fromValue(row['transaction_type'] as String),
      reference: row['reference'] as String,
      note: row['note'] as String?,
      employeeId: row['employee_id'] as String,
      occurredAt: _parseDateTime(row['occurred_at']),
      sync: _syncMetadata(row['id'], row['updated_at']),
    );
  }

  static Map<String, dynamic> _transactionToMap(InventoryTransactionEntity entity) {
    return {
      'id': entity.id,
      'product_id': entity.productId,
      'source_location_id': entity.sourceLocationId,
      'target_location_id': entity.targetLocationId,
      'quantity': entity.quantity,
      'transaction_type': entity.transactionType.value,
      'reference': entity.reference,
      'note': entity.note,
      'employee_id': entity.employeeId,
      'occurred_at': _dateToString(entity.occurredAt),
      'updated_at': _dateToString(entity.sync.updatedAt),
    };
  }

  static SyncMetadata _syncMetadata(String id, dynamic updatedAt) {
    return SyncMetadata(
      id: id,
      updatedAt: _parseDateTime(updatedAt),
      pendingSync: false,
    );
  }

  static DateTime _parseDateTime(dynamic value) {
    if (value == null) {
      return DateTime.fromMillisecondsSinceEpoch(0, isUtc: true);
    }
    if (value is DateTime) {
      return value.toUtc();
    }
    if (value is String) {
      return DateTime.parse(value).toUtc();
    }
    throw ArgumentError('Unsupported DateTime value: $value');
  }

  static String _dateToString(DateTime dateTime) => dateTime.toUtc().toIso8601String();

  static double _toDouble(dynamic value) {
    if (value == null) return 0;
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0;
    throw ArgumentError('Unsupported numeric value: $value');
  }
}

