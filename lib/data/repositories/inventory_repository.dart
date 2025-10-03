import 'dart:async';
import 'package:inventario_final/data/local/local_data_source.dart';
import 'package:inventario_final/data/remote/supabase_inventory_service.dart';
import 'package:inventario_final/models/entities.dart';
import 'package:inventario_final/models/enums.dart';


typedef ConnectionChecker = Future<bool> Function();

class InventoryRepository {
  InventoryRepository({
    required LocalInventoryDataSource localDataSource,
    SupabaseInventoryService? remoteService,
    ConnectionChecker? connectionChecker,
  })  : _local = localDataSource,
        _remote = remoteService ?? SupabaseInventoryService(),
        _connectionChecker = connectionChecker ?? _defaultConnectionChecker;

  final LocalInventoryDataSource _local;
  final SupabaseInventoryService _remote;
  final ConnectionChecker _connectionChecker;

  // Streams
  Stream<List<ProductEntity>> watchProducts() => _local.watchProducts();

  Stream<List<LocationEntity>> watchLocations() => _local.watchLocations();

  Stream<List<EmployeeEntity>> watchEmployees() => _local.watchEmployees();

  Stream<List<InventorySnapshotEntity>> watchSnapshots() => _local.watchSnapshots();

  Stream<List<InventoryTransactionEntity>> watchTransactions() => _local.watchTransactions();

  // Local mutations (mark as pending before calling)
  Future<void> upsertProduct(ProductEntity entity) => _local.upsertProduct(entity);

  Future<void> upsertLocation(LocationEntity entity) => _local.upsertLocation(entity);

  Future<void> upsertEmployee(EmployeeEntity entity) => _local.upsertEmployee(entity);

  Future<void> upsertSnapshot(InventorySnapshotEntity entity) => _local.upsertSnapshot(entity);

  Future<void> upsertTransaction(InventoryTransactionEntity entity) =>
      _local.upsertTransaction(entity);


  Future<void> loadLocations() async {
    try {
      final locations = await _remote.fetchLocations();
      for (final location in locations) {
        await _local.upsertLocation(location);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> syncAll({bool force = false}) async {
    if (!await _connectionChecker()) {
      throw const InventorySyncException('No hay conexión a internet');
    }

    await _syncProducts(force: force);
    await _syncLocations(force: force);
    await _syncEmployees(force: force);
    await _syncTransactions(force: force);
    await _syncSnapshots(force: force);
  }

  Future<void> _syncProducts({required bool force}) async {
    final status = await _local.getSyncStatus(SyncResource.products);
    final updatedAfter = force ? null : status?.lastSyncedAt;

    final remoteUpdates = await _remote.fetchProducts(updatedAfter: updatedAfter);
    for (final product in remoteUpdates) {
      await _local.upsertProduct(product);
    }

    final pending = await _local.getPendingProducts();
    List<ProductEntity> synced = const [];
    if (pending.isNotEmpty) {
      synced = await _remote.upsertProducts(pending);
      for (final product in synced) {
        await _local.upsertProduct(product);
      }
    }

    await _persistSyncStatus(
      resource: SyncResource.products,
      previous: status,
      metadatas: [...remoteUpdates, ...synced].map((entity) => entity.sync),
    );
    if (synced.isNotEmpty) {
      await _local.markProductsSynced(
        synced.map((e) => e.id),
        updatedAt: synced.last.sync.updatedAt,
      );
    }
  }

  Future<void> _syncLocations({required bool force}) async {
    final status = await _local.getSyncStatus(SyncResource.locations);
    final updatedAfter = force ? null : status?.lastSyncedAt;

    final remoteUpdates = await _remote.fetchLocations(updatedAfter: updatedAfter);
    for (final location in remoteUpdates) {
      await _local.upsertLocation(location);
    }

    final pending = await _local.getPendingLocations();
    List<LocationEntity> synced = const [];
    if (pending.isNotEmpty) {
      synced = await _remote.upsertLocations(pending);
      for (final location in synced) {
        await _local.upsertLocation(location);
      }
    }

    await _persistSyncStatus(
      resource: SyncResource.locations,
      previous: status,
      metadatas: [...remoteUpdates, ...synced].map((entity) => entity.sync),
    );
    if (synced.isNotEmpty) {
      await _local.markLocationsSynced(
        synced.map((e) => e.id),
        updatedAt: synced.last.sync.updatedAt,
      );
    }
  }

  Future<void> _syncEmployees({required bool force}) async {
    final status = await _local.getSyncStatus(SyncResource.employees);
    final updatedAfter = force ? null : status?.lastSyncedAt;

    final remoteUpdates = await _remote.fetchEmployees(updatedAfter: updatedAfter);
    for (final employee in remoteUpdates) {
      await _local.upsertEmployee(employee);
    }

    final pending = await _local.getPendingEmployees();
    List<EmployeeEntity> synced = const [];
    if (pending.isNotEmpty) {
      synced = await _remote.upsertEmployees(pending);
      for (final employee in synced) {
        await _local.upsertEmployee(employee);
      }
    }

    await _persistSyncStatus(
      resource: SyncResource.employees,
      previous: status,
      metadatas: [...remoteUpdates, ...synced].map((entity) => entity.sync),
    );
    if (synced.isNotEmpty) {
      await _local.markEmployeesSynced(
        synced.map((e) => e.id),
        updatedAt: synced.last.sync.updatedAt,
      );
    }
  }

  Future<void> _syncSnapshots({required bool force}) async {
    final status = await _local.getSyncStatus(SyncResource.inventorySnapshots);
    final updatedAfter = force ? null : status?.lastSyncedAt;

    final remoteUpdates = await _remote.fetchSnapshots(updatedAfter: updatedAfter);
    for (final snapshot in remoteUpdates) {
      await _local.upsertSnapshot(snapshot);
    }

    final pending = await _local.getPendingSnapshots();
    List<InventorySnapshotEntity> synced = const [];
    if (pending.isNotEmpty) {
      synced = await _remote.upsertSnapshots(pending);
      for (final snapshot in synced) {
        await _local.upsertSnapshot(snapshot);
      }
    }

    await _persistSyncStatus(
      resource: SyncResource.inventorySnapshots,
      previous: status,
      metadatas: [...remoteUpdates, ...synced].map((entity) => entity.sync),
    );
    if (synced.isNotEmpty) {
      await _local.markSnapshotsSynced(
        synced.map((e) => e.id),
        updatedAt: synced.last.sync.updatedAt,
      );
    }
  }

  Future<void> _syncTransactions({required bool force}) async {
    final status = await _local.getSyncStatus(SyncResource.inventoryTransactions);
    final updatedAfter = force ? null : status?.lastSyncedAt;

    final remoteUpdates = await _remote.fetchTransactions(updatedAfter: updatedAfter);
    for (final transaction in remoteUpdates) {
      await _local.upsertTransaction(transaction, updateSnapshots: false);
    }

    final pending = await _local.getPendingTransactions();
    List<InventoryTransactionEntity> synced = const [];
    if (pending.isNotEmpty) {
      synced = await _remote.upsertTransactions(pending);
      for (final transaction in synced) {
        await _local.upsertTransaction(transaction, updateSnapshots: false);
      }
    }

    await _persistSyncStatus(
      resource: SyncResource.inventoryTransactions,
      previous: status,
      metadatas: [...remoteUpdates, ...synced].map((entity) => entity.sync),
    );
    if (synced.isNotEmpty) {
      await _local.markTransactionsSynced(
        synced.map((e) => e.id),
        updatedAt: synced.last.sync.updatedAt,
      );
    }
  }

  Future<void> _persistSyncStatus({
    required SyncResource resource,
    required SyncStatusEntity? previous,
    required Iterable<SyncMetadata> metadatas,
  }) async {
    final timestamps = metadatas.map((meta) => meta.updatedAt).toList();
    final lastSyncedAt = timestamps.isEmpty
        ? (previous?.lastSyncedAt ?? DateTime.now().toUtc())
        : timestamps.reduce((value, element) => value.isAfter(element) ? value : element);

    await _local.upsertSyncStatus(
      SyncStatusEntity(resource: resource, lastSyncedAt: lastSyncedAt),
    );
  }

  static Future<bool> _defaultConnectionChecker() async => true;
}

class InventorySyncException implements Exception {
  const InventorySyncException(this.message);
  final String message;

  @override
  String toString() => 'InventorySyncException: $message';
}


