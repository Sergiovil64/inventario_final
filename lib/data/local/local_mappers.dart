import 'package:drift/drift.dart';

import '../../models/entities.dart';
import '../../models/enums.dart';
import 'local_database.dart';

SyncMetadata _toSyncMetadata(String id, DateTime updatedAt, bool pendingSync) {
  return SyncMetadata(id: id, updatedAt: updatedAt, pendingSync: pendingSync);
}

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

LocationEntity mapLocationRow(LocationRow row) {
  return LocationEntity(
    id: row.id,
    name: row.name,
    type: LocationTypeX.fromValue(row.type),
    address: row.address,
    sync: _toSyncMetadata(row.id, row.updatedAt, row.pendingSync),
  );
}

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

SyncStatusEntity mapSyncStatusRow(SyncStatusRow row) {
  return SyncStatusEntity(
    resource: SyncResourceX.fromValue(row.resource),
    lastSyncedAt: row.lastSyncedAt,
  );
}

SyncStatusesCompanion mapSyncStatusEntity(SyncStatusEntity entity) {
  return SyncStatusesCompanion(
    resource: Value(entity.resource.value),
    lastSyncedAt: Value(entity.lastSyncedAt),
  );
}

