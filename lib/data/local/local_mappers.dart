import 'package:drift/drift.dart';
import 'package:inventario_final/models/entities.dart';
import 'package:inventario_final/models/enums.dart';
import 'package:inventario_final/data/local/local_database.dart';

// Método para convertir los datos de la fila a la entidad
SyncMetadata _toSyncMetadata(String id, DateTime updatedAt, bool pendingSync) {
  return SyncMetadata(id: id, updatedAt: updatedAt, pendingSync: pendingSync);
}

// Método para convertir los datos de la fila de productos a la entidad
ProductEntity mapProductRow(ProductRow row) {
  return ProductEntity(
    id: row.id,
    name: row.name,
    sku: row.sku,
    category: row.category,
    unit: row.unit,
    price: row.price,
    active: row.active,
    sync: _toSyncMetadata(row.id, row.updatedAt, row.pendingSync),
  );
}

// Método para convertir la entidad de productos a la fila
ProductRowsCompanion mapProductEntity(ProductEntity entity) {
  return ProductRowsCompanion(
    id: Value(entity.id),
    name: Value(entity.name),
    sku: Value(entity.sku),
    category: Value(entity.category),
    unit: Value(entity.unit),
    price: Value(entity.price),
    active: Value(entity.active),
    updatedAt: Value(entity.sync.updatedAt),
    pendingSync: Value(entity.sync.pendingSync),
  );
}

// Método para convertir los datos de la fila de ubicaciones a la entidad
LocationEntity mapLocationRow(LocationRow row) {
  return LocationEntity(
    id: row.id,
    name: row.name,
    type: LocationTypeX.fromValue(row.type),
    address: row.address,
    sync: _toSyncMetadata(row.id, row.updatedAt, row.pendingSync),
  );
}

// Método para convertir la entidad de ubicaciones a la fila
LocationRowsCompanion mapLocationEntity(LocationEntity entity) {
  return LocationRowsCompanion(
    id: Value(entity.id),
    name: Value(entity.name),
    type: Value(entity.type.value),
    address: Value(entity.address),
    updatedAt: Value(entity.sync.updatedAt),
    pendingSync: Value(entity.sync.pendingSync),
  );
}

// Método para convertir los datos de la fila de empleados a la entidad
EmployeeEntity mapEmployeeRow(EmployeeRow row) {
  return EmployeeEntity(
    id: row.id,
    firstName: row.firstName,
    lastName: row.lastName,
    email: row.email,
    active: row.active,
    locationId: row.locationId,
    sync: _toSyncMetadata(row.id, row.updatedAt, row.pendingSync),
  );
}

// Método para convertir la entidad de empleados a la fila
EmployeeRowsCompanion mapEmployeeEntity(EmployeeEntity entity) {
  return EmployeeRowsCompanion(
    id: Value(entity.id),
    firstName: Value(entity.firstName),
    lastName: Value(entity.lastName),
    email: Value(entity.email),
    active: Value(entity.active),
    locationId: Value(entity.locationId),
    updatedAt: Value(entity.sync.updatedAt),
    pendingSync: Value(entity.sync.pendingSync),
  );
}

// Método para convertir los datos de la fila de snapshots a la entidad
InventorySnapshotEntity mapSnapshotRow(InventorySnapshotRow row) {
  return InventorySnapshotEntity(
    id: row.id,
    productId: row.productId,
    locationId: row.locationId,
    quantity: row.quantity,
    updatedAt: row.updatedAt,
    sync: _toSyncMetadata(row.id, row.updatedAt, row.pendingSync),
  );
}

// Método para convertir la entidad de snapshots a la fila
InventorySnapshotRowsCompanion mapSnapshotEntity(InventorySnapshotEntity entity) {
  return InventorySnapshotRowsCompanion(
    id: Value(entity.id),
    productId: Value(entity.productId),
    locationId: Value(entity.locationId),
    quantity: Value(entity.quantity),
    updatedAt: Value(entity.updatedAt),
    pendingSync: Value(entity.sync.pendingSync),
  );
}

// Método para convertir los datos de la fila de transacciones a la entidad
InventoryTransactionEntity mapTransactionRow(InventoryTransactionRow row) {
  return InventoryTransactionEntity(
    id: row.id,
    productId: row.productId,
    sourceLocationId: row.sourceLocationId,
    targetLocationId: row.targetLocationId,
    quantity: row.quantity,
    transactionType: TransactionTypeX.fromValue(row.transactionType),
    reference: row.reference,
    note: row.note,
    employeeId: row.employeeId,
    occurredAt: row.occurredAt,
    sync: _toSyncMetadata(row.id, row.updatedAt, row.pendingSync),
  );
}

// Método para convertir la entidad de transacciones a la fila
InventoryTransactionRowsCompanion mapTransactionEntity(InventoryTransactionEntity entity) {
  return InventoryTransactionRowsCompanion(
    id: Value(entity.id),
    productId: Value(entity.productId),
    sourceLocationId: Value(entity.sourceLocationId),
    targetLocationId: Value(entity.targetLocationId),
    quantity: Value(entity.quantity),
    transactionType: Value(entity.transactionType.value),
    reference: Value(entity.reference),
    note: Value(entity.note),
    employeeId: Value(entity.employeeId),
    occurredAt: Value(entity.occurredAt),
    updatedAt: Value(entity.sync.updatedAt),
    pendingSync: Value(entity.sync.pendingSync),
  );
}

// Método para convertir los datos de la fila de estado de sincronización a la entidad
SyncStatusEntity mapSyncStatusRow(SyncStatusRow row) {
  return SyncStatusEntity(
    resource: SyncResourceX.fromValue(row.resource),
    lastSyncedAt: row.lastSyncedAt,
  );
}

// Método para convertir la entidad de estado de sincronización a la fila
SyncStatusesCompanion mapSyncStatusEntity(SyncStatusEntity entity) {
  return SyncStatusesCompanion(
    resource: Value(entity.resource.value),
    lastSyncedAt: Value(entity.lastSyncedAt),
  );
}

