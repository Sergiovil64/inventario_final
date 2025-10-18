import 'package:drift/drift.dart' show InsertMode, Value;
import './local_database.dart';
import './local_mappers.dart';
import '../../models/entities.dart';
import '../../models/enums.dart';

// Clase LocalInventoryDataSource que sirve para manejar la fuente de datos local
// Se encarga de manejar la fuente de datos local y de las acciones de sincronización
class LocalInventoryDataSource {
  LocalInventoryDataSource(this._db);

  final LocalDatabase _db;

  // Products
  // Método para observar los productos
  Stream<List<ProductEntity>> watchProducts() {
    return _db.select(_db.productRows).watch().map(
          (rows) => rows.map(mapProductRow).toList(),
        );
  }

  // Método para obtener los productos
  Future<List<ProductEntity>> getProducts() async {
    final rows = await _db.select(_db.productRows).get();
    return rows.map(mapProductRow).toList();
  }

  // Método para obtener un producto por su ID
  Future<ProductEntity?> getProductById(String id) async {
    final query = _db.select(_db.productRows)..where((tbl) => tbl.id.equals(id));
    final row = await query.getSingleOrNull();
    return row == null ? null : mapProductRow(row);
  }

  // Método para obtener los productos pendientes de sincronización
  Future<List<ProductEntity>> getPendingProducts() async {
    final query = _db.select(_db.productRows)
      ..where((tbl) => tbl.pendingSync.equals(true));
    final rows = await query.get();
    return rows.map(mapProductRow).toList();
  }

  // Método para upsertar un producto
  Future<void> upsertProduct(ProductEntity entity) {
    return _db.into(_db.productRows).insert(
          mapProductEntity(entity),
          mode: InsertMode.insertOrReplace,
        );
  }

  // Método para marcar los productos como sincronizados
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
  // Método para observar las ubicaciones
  Stream<List<LocationEntity>> watchLocations() {
    return _db.select(_db.locationRows).watch().map(
          (rows) => rows.map(mapLocationRow).toList(),
        );
  }

  // Método para obtener las ubicaciones
  Future<List<LocationEntity>> getLocations() async {
    final rows = await _db.select(_db.locationRows).get();
    return rows.map(mapLocationRow).toList();
  }

  // Método para obtener las ubicaciones pendientes de sincronización
  Future<List<LocationEntity>> getPendingLocations() async {
    final query = _db.select(_db.locationRows)
      ..where((tbl) => tbl.pendingSync.equals(true));
    final rows = await query.get();
    return rows.map(mapLocationRow).toList();
  }

  // Método para upsertar una ubicación
  Future<void> upsertLocation(LocationEntity entity) {
    return _db.into(_db.locationRows).insert(
          mapLocationEntity(entity),
          mode: InsertMode.insertOrReplace,
        );
  }

  // Método para marcar las ubicaciones como sincronizadas
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
  // Método para observar los empleados
  Stream<List<EmployeeEntity>> watchEmployees() {
    return _db.select(_db.employeeRows).watch().map(
          (rows) => rows.map(mapEmployeeRow).toList(),
        );
  }

  // Método para obtener los empleados
  Future<List<EmployeeEntity>> getEmployees() async {
    final rows = await _db.select(_db.employeeRows).get();
    return rows.map(mapEmployeeRow).toList();
  }

  // Método para obtener los empleados pendientes de sincronización
  Future<List<EmployeeEntity>> getPendingEmployees() async {
    final query = _db.select(_db.employeeRows)
      ..where((tbl) => tbl.pendingSync.equals(true));
    final rows = await query.get();
    return rows.map(mapEmployeeRow).toList();
  }

  // Método para upsertar un empleado
  Future<void> upsertEmployee(EmployeeEntity entity) {
    return _db.into(_db.employeeRows).insert(
          mapEmployeeEntity(entity),
          mode: InsertMode.insertOrReplace,
        );
  }

  // Método para marcar los empleados como sincronizados
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
  // Método para observar los snapshots
  Stream<List<InventorySnapshotEntity>> watchSnapshots() {
    return _db.select(_db.inventorySnapshotRows).watch().map(
          (rows) => rows.map(mapSnapshotRow).toList(),
        );
  }

  // Método para obtener los snapshots
  Future<List<InventorySnapshotEntity>> getSnapshots() async {
    final rows = await _db.select(_db.inventorySnapshotRows).get();
    return rows.map(mapSnapshotRow).toList();
  }

  // Método para obtener los snapshots pendientes de sincronización
  Future<List<InventorySnapshotEntity>> getPendingSnapshots() async {
    final query = _db.select(_db.inventorySnapshotRows)
      ..where((tbl) => tbl.pendingSync.equals(true));
    final rows = await query.get();
    return rows.map(mapSnapshotRow).toList();
  }

  // Método para upsertar un snapshot
  Future<void> upsertSnapshot(InventorySnapshotEntity entity) {
    return _db.into(_db.inventorySnapshotRows).insert(
          mapSnapshotEntity(entity),
          mode: InsertMode.insertOrReplace,
        );
  }

  // Método para marcar los snapshots como sincronizados
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
  // Método para observar las transacciones
  Stream<List<InventoryTransactionEntity>> watchTransactions() {
    return _db.select(_db.inventoryTransactionRows).watch().map(
          (rows) => rows.map(mapTransactionRow).toList(),
        );
  }

  // Método para obtener las transacciones
  Future<List<InventoryTransactionEntity>> getTransactions() async {
    final rows = await _db.select(_db.inventoryTransactionRows).get();
    return rows.map(mapTransactionRow).toList();
  }

  // Método para obtener las transacciones por rango de fechas
  Future<List<InventoryTransactionEntity>> getTransactionsByDateRange({
    required DateTime startDate,
    required DateTime endDate,
    String? locationId,
  }) async {
    // Obtener todas las transacciones y filtrar en memoria
    // Esto es más simple y funciona mejor con Drift
    final allTransactions = await getTransactions();
    
    var filtered = allTransactions.where((t) => 
      t.occurredAt.isAfter(startDate.subtract(const Duration(seconds: 1))) &&
      t.occurredAt.isBefore(endDate.add(const Duration(days: 1)))
    ).toList();

    // Filtrar por ubicación si se especifica
    if (locationId != null) {
      filtered = filtered.where((t) =>
        t.sourceLocationId == locationId ||
        t.targetLocationId == locationId
      ).toList();
    }

    return filtered;
  }

  // Método para obtener las transacciones pendientes de sincronización
  Future<List<InventoryTransactionEntity>> getPendingTransactions() async {
    final query = _db.select(_db.inventoryTransactionRows)
      ..where((tbl) => tbl.pendingSync.equals(true));
    final rows = await query.get();
    return rows.map(mapTransactionRow).toList();
  }

  // Método para upsertar una transacción
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

  // Método para marcar las transacciones como sincronizadas
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

  // Método para obtener el estado de sincronización de un recurso
  Future<SyncStatusEntity?> getSyncStatus(SyncResource resource) async {
    final query = _db.select(_db.syncStatuses)
      ..where((tbl) => tbl.resource.equals(resource.value));
    final row = await query.getSingleOrNull();
    return row == null ? null : mapSyncStatusRow(row);
  }

  // Método para upsertar el estado de sincronización de un recurso
  Future<void> upsertSyncStatus(SyncStatusEntity entity) {
    return _db.into(_db.syncStatuses).insert(
          mapSyncStatusEntity(entity),
          mode: InsertMode.insertOrReplace,
        );
  }

  // Método para actualizar el snapshot para una transacción
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

  // Método para incrementar el stock de un producto en una ubicación
  Future<void> _incrementStock(String locationId, String productId, double delta) async {
    // Obtener el snapshot existente
    final query = _db.select(_db.inventorySnapshotRows)
      ..where((tbl) => tbl.locationId.equals(locationId))
      ..where((tbl) => tbl.productId.equals(productId));
    final existing = await query.getSingleOrNull();
    // Obtener la fecha y hora actual
    final now = DateTime.now().toUtc();
    if (existing == null) {
      // Crear un nuevo snapshot
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
      // Actualizar el snapshot existente
      final snapshot = mapSnapshotRow(existing).copyWith(
            quantity: existing.quantity + delta,
            updatedAt: now,
            sync: SyncMetadata(
              id: existing.id,
              updatedAt: now,
              pendingSync: true,
            ),
          );
      // Upsertar el snapshot actualizado
      await upsertSnapshot(snapshot);
    }
  }

  // Método para establecer el stock de un producto en una ubicación
  Future<void> _setStock(String locationId, String productId, double quantity) async {
    final now = DateTime.now().toUtc();
    // Crear un nuevo snapshot
    final snapshot = InventorySnapshotEntity(
      id: '${locationId}_$productId',
      productId: productId,
      locationId: locationId,
      quantity: quantity,
      updatedAt: now,
      sync: SyncMetadata(id: '${locationId}_$productId', updatedAt: now, pendingSync: true),
    );
    // Upsertar el snapshot creado
    await upsertSnapshot(snapshot);
  }
}

