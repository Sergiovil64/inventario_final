import 'package:drift/drift.dart' show InsertMode, Value;
import './local_database.dart';
import './local_mappers.dart';
import '../../models/entities.dart';
import '../../models/enums.dart';



class LocalInventoryDataSource {
  LocalInventoryDataSource(this._db);

  final LocalDatabase _db;

  // Products
  Stream<List<ProductEntity>> watchProducts() {
    return _db.select(_db.productRows).watch().map(
          (rows) => rows.map(mapProductRow).toList(),
        );
  }

  Future<List<ProductEntity>> getProducts() async {
    final rows = await _db.select(_db.productRows).get();
    return rows.map(mapProductRow).toList();
  }

  Future<ProductEntity?> getProductById(String id) async {
    final query = _db.select(_db.productRows)..where((tbl) => tbl.id.equals(id));
    final row = await query.getSingleOrNull();
    return row == null ? null : mapProductRow(row);
  }

  Future<List<ProductEntity>> getPendingProducts() async {
    final query = _db.select(_db.productRows)
      ..where((tbl) => tbl.pendingSync.equals(true));
    final rows = await query.get();
    return rows.map(mapProductRow).toList();
  }

  Future<void> upsertProduct(ProductEntity entity) {
    return _db.into(_db.productRows).insert(
          mapProductEntity(entity),
          mode: InsertMode.insertOrReplace,
        );
  }

  Future<void> markProductsSynced(
    Iterable<String> ids, {
    DateTime? updatedAt,
  }) async {
    if (ids.isEmpty) return;
    final update = _db.update(_db.productRows)
      ..where((tbl) => tbl.id.isIn(ids.toList()));
    await update.write(
      ProductRowsCompanion(
        updatedAt: updatedAt != null ? Value(updatedAt) : const Value.absent(),
        pendingSync: const Value(false),
      ),
    );
  }

  // Locations
  Stream<List<LocationEntity>> watchLocations() {
    return _db.select(_db.locationRows).watch().map(
          (rows) => rows.map(mapLocationRow).toList(),
        );
  }

  Future<List<LocationEntity>> getLocations() async {
    final rows = await _db.select(_db.locationRows).get();
    return rows.map(mapLocationRow).toList();
  }

  Future<List<LocationEntity>> getPendingLocations() async {
    final query = _db.select(_db.locationRows)
      ..where((tbl) => tbl.pendingSync.equals(true));
    final rows = await query.get();
    return rows.map(mapLocationRow).toList();
  }

  Future<void> upsertLocation(LocationEntity entity) {
    return _db.into(_db.locationRows).insert(
          mapLocationEntity(entity),
          mode: InsertMode.insertOrReplace,
        );
  }

  Future<void> markLocationsSynced(
    Iterable<String> ids, {
    DateTime? updatedAt,
  }) async {
    if (ids.isEmpty) return;
    final update = _db.update(_db.locationRows)
      ..where((tbl) => tbl.id.isIn(ids.toList()));
    await update.write(
      LocationRowsCompanion(
        updatedAt: updatedAt != null ? Value(updatedAt) : const Value.absent(),
        pendingSync: const Value(false),
      ),
    );
  }

  // Employees
  Stream<List<EmployeeEntity>> watchEmployees() {
    return _db.select(_db.employeeRows).watch().map(
          (rows) => rows.map(mapEmployeeRow).toList(),
        );
  }

  Future<List<EmployeeEntity>> getEmployees() async {
    final rows = await _db.select(_db.employeeRows).get();
    return rows.map(mapEmployeeRow).toList();
  }

  Future<List<EmployeeEntity>> getPendingEmployees() async {
    final query = _db.select(_db.employeeRows)
      ..where((tbl) => tbl.pendingSync.equals(true));
    final rows = await query.get();
    return rows.map(mapEmployeeRow).toList();
  }

  Future<void> upsertEmployee(EmployeeEntity entity) {
    return _db.into(_db.employeeRows).insert(
          mapEmployeeEntity(entity),
          mode: InsertMode.insertOrReplace,
        );
  }

  Future<void> markEmployeesSynced(
    Iterable<String> ids, {
    DateTime? updatedAt,
  }) async {
    if (ids.isEmpty) return;
    final update = _db.update(_db.employeeRows)
      ..where((tbl) => tbl.id.isIn(ids.toList()));
    await update.write(
      EmployeeRowsCompanion(
        updatedAt: updatedAt != null ? Value(updatedAt) : const Value.absent(),
        pendingSync: const Value(false),
      ),
    );
  }

  // Inventory snapshots
  Stream<List<InventorySnapshotEntity>> watchSnapshots() {
    return _db.select(_db.inventorySnapshotRows).watch().map(
          (rows) => rows.map(mapSnapshotRow).toList(),
        );
  }

  Future<List<InventorySnapshotEntity>> getSnapshots() async {
    final rows = await _db.select(_db.inventorySnapshotRows).get();
    return rows.map(mapSnapshotRow).toList();
  }

  Future<List<InventorySnapshotEntity>> getPendingSnapshots() async {
    final query = _db.select(_db.inventorySnapshotRows)
      ..where((tbl) => tbl.pendingSync.equals(true));
    final rows = await query.get();
    return rows.map(mapSnapshotRow).toList();
  }

  Future<void> upsertSnapshot(InventorySnapshotEntity entity) {
    return _db.into(_db.inventorySnapshotRows).insert(
          mapSnapshotEntity(entity),
          mode: InsertMode.insertOrReplace,
        );
  }

  Future<void> markSnapshotsSynced(
    Iterable<String> ids, {
    DateTime? updatedAt,
  }) async {
    if (ids.isEmpty) return;
    final update = _db.update(_db.inventorySnapshotRows)
      ..where((tbl) => tbl.id.isIn(ids.toList()));
    await update.write(
      InventorySnapshotRowsCompanion(
        updatedAt: updatedAt != null ? Value(updatedAt) : const Value.absent(),
        pendingSync: const Value(false),
      ),
    );
  }

  // Inventory transactions
  Stream<List<InventoryTransactionEntity>> watchTransactions() {
    return _db.select(_db.inventoryTransactionRows).watch().map(
          (rows) => rows.map(mapTransactionRow).toList(),
        );
  }

  Future<List<InventoryTransactionEntity>> getTransactions() async {
    final rows = await _db.select(_db.inventoryTransactionRows).get();
    return rows.map(mapTransactionRow).toList();
  }

  Future<List<InventoryTransactionEntity>> getPendingTransactions() async {
    final query = _db.select(_db.inventoryTransactionRows)
      ..where((tbl) => tbl.pendingSync.equals(true));
    final rows = await query.get();
    return rows.map(mapTransactionRow).toList();
  }

  Future<void> upsertTransaction(
    InventoryTransactionEntity entity, {
    bool updateSnapshots = true,
  }) async {
    await _db.into(_db.inventoryTransactionRows).insert(
          mapTransactionEntity(entity),
          mode: InsertMode.insertOrReplace,
        );
    if (updateSnapshots) {
      await _updateSnapshotForTransaction(entity);
    }
  }

  Future<void> markTransactionsSynced(
    Iterable<String> ids, {
    DateTime? updatedAt,
  }) async {
    if (ids.isEmpty) return;
    final update = _db.update(_db.inventoryTransactionRows)
      ..where((tbl) => tbl.id.isIn(ids.toList()));
    await update.write(
      InventoryTransactionRowsCompanion(
        updatedAt: updatedAt != null ? Value(updatedAt) : const Value.absent(),
        pendingSync: const Value(false),
      ),
    );
  }

  Future<SyncStatusEntity?> getSyncStatus(SyncResource resource) async {
    final query = _db.select(_db.syncStatuses)
      ..where((tbl) => tbl.resource.equals(resource.value));
    final row = await query.getSingleOrNull();
    return row == null ? null : mapSyncStatusRow(row);
  }

  Future<void> upsertSyncStatus(SyncStatusEntity entity) {
    return _db.into(_db.syncStatuses).insert(
          mapSyncStatusEntity(entity),
          mode: InsertMode.insertOrReplace,
        );
  }

  Future<void> _updateSnapshotForTransaction(InventoryTransactionEntity entity) async {
    switch (entity.transactionType) {
      case TransactionType.purchase:
        if (entity.targetLocationId == null) return;
        await _incrementStock(entity.targetLocationId!, entity.productId, entity.quantity);
        break;
      case TransactionType.sale:
        if (entity.sourceLocationId == null) return;
        await _incrementStock(entity.sourceLocationId!, entity.productId, -entity.quantity);
        break;
      case TransactionType.transfer:
        if (entity.sourceLocationId != null) {
          await _incrementStock(entity.sourceLocationId!, entity.productId, -entity.quantity);
        }
        if (entity.targetLocationId != null) {
          await _incrementStock(entity.targetLocationId!, entity.productId, entity.quantity);
        }
        break;
      case TransactionType.adjustment:
        if (entity.targetLocationId == null) return;
        await _setStock(entity.targetLocationId!, entity.productId, entity.quantity);
        break;
    }
  }

  Future<void> _incrementStock(String locationId, String productId, double delta) async {
    final query = _db.select(_db.inventorySnapshotRows)
      ..where((tbl) => tbl.locationId.equals(locationId))
      ..where((tbl) => tbl.productId.equals(productId));
    final existing = await query.getSingleOrNull();
    final now = DateTime.now().toUtc();
    if (existing == null) {
      final snapshot = InventorySnapshotEntity(
        id: '${locationId}_$productId',
        productId: productId,
        locationId: locationId,
        quantity: delta,
        updatedAt: now,
        sync: SyncMetadata(id: '${locationId}_$productId', updatedAt: now, pendingSync: true),
      );
      await upsertSnapshot(snapshot);
    } else {
      final snapshot = mapSnapshotRow(existing).copyWith(
            quantity: existing.quantity + delta,
            updatedAt: now,
            sync: SyncMetadata(
              id: existing.id,
              updatedAt: now,
              pendingSync: true,
            ),
          );
      await upsertSnapshot(snapshot);
    }
  }

  Future<void> _setStock(String locationId, String productId, double quantity) async {
    final now = DateTime.now().toUtc();
    final snapshot = InventorySnapshotEntity(
      id: '${locationId}_$productId',
      productId: productId,
      locationId: locationId,
      quantity: quantity,
      updatedAt: now,
      sync: SyncMetadata(id: '${locationId}_$productId', updatedAt: now, pendingSync: true),
    );
    await upsertSnapshot(snapshot);
  }
}

