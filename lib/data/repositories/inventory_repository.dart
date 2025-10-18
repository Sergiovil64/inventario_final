import 'dart:async';
import 'package:inventario_final/data/local/local_data_source.dart';
import 'package:inventario_final/data/remote/supabase_inventory_service.dart';
import 'package:inventario_final/models/entities.dart';
import 'package:inventario_final/models/enums.dart';


typedef ConnectionChecker = Future<bool> Function();

// Clase InventoryRepository que sirve para manejar el repositorio de inventario
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
  // Método para observar los productos
  Stream<List<ProductEntity>> watchProducts() => _local.watchProducts();

  // Método para observar las ubicaciones
  Stream<List<LocationEntity>> watchLocations() => _local.watchLocations();

  // Método para observar los empleados
  Stream<List<EmployeeEntity>> watchEmployees() => _local.watchEmployees();

  // Método para observar los snapshots
  Stream<List<InventorySnapshotEntity>> watchSnapshots() => _local.watchSnapshots();

  // Método para observar las transacciones
  Stream<List<InventoryTransactionEntity>> watchTransactions() => _local.watchTransactions();

  // Local mutations (mark as pending before calling)
  // Método para upsertar un producto
  Future<void> upsertProduct(ProductEntity entity) => _local.upsertProduct(entity);

  // Método para upsertar una ubicación
  Future<void> upsertLocation(LocationEntity entity) => _local.upsertLocation(entity);

  // Método para upsertar un empleado
  Future<void> upsertEmployee(EmployeeEntity entity) => _local.upsertEmployee(entity);

  // Método para upsertar un snapshot
  Future<void> upsertSnapshot(InventorySnapshotEntity entity) => _local.upsertSnapshot(entity);

  // Método para upsertar una transacción
  Future<void> upsertTransaction(InventoryTransactionEntity entity) =>
      _local.upsertTransaction(entity);


  // Método para cargar las ubicaciones
  Future<void> loadLocations() async {
    final locations = await _remote.fetchLocations();
    for (final location in locations) {
      await _local.upsertLocation(location);
    }
  }

  // Método para sincronizar todos los datos
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

  // Método para sincronizar los productos
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

  // Método para sincronizar las ubicaciones
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

  // Método para sincronizar los empleados
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

  // Método para sincronizar los snapshots
  Future<void> _syncSnapshots({required bool force}) async {
    final status = await _local.getSyncStatus(SyncResource.inventorySnapshots);
    final updatedAfter = force ? null : status?.lastSyncedAt;

    // Primero enviar los snapshots pendientes locales al servidor
    final pending = await _local.getPendingSnapshots();
    List<InventorySnapshotEntity> synced = const [];
    if (pending.isNotEmpty) {
      synced = await _remote.upsertSnapshots(pending);
      for (final snapshot in synced) {
        await _local.upsertSnapshot(snapshot);
      }
    }

    // Luego obtener actualizaciones remotas (solo si no hay conflictos)
    final remoteUpdates = await _remote.fetchSnapshots(updatedAfter: updatedAfter);
    final localSnapshots = await _local.getSnapshots();
    
    // Crear un mapa de snapshots locales por ID para comparación rápida
    final localSnapshotsMap = {
      for (var snapshot in localSnapshots) snapshot.id: snapshot
    };

    for (final remoteSnapshot in remoteUpdates) {
      final localSnapshot = localSnapshotsMap[remoteSnapshot.id];
      
      // Solo actualizar si:
      // 1. No existe localmente, O
      // 2. El remoto es más reciente que el local
      if (localSnapshot == null || 
          remoteSnapshot.sync.updatedAt.isAfter(localSnapshot.sync.updatedAt)) {
        await _local.upsertSnapshot(remoteSnapshot);
      }
      // Si el local es más reciente, no sobrescribir
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

  // Método para sincronizar las transacciones
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

  // Método para persistir el estado de sincronización
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

  // Método para verificar la conexión
  static Future<bool> _defaultConnectionChecker() async => true;

  // Additional query methods
  // Método para obtener todas las ubicaciones
  Future<List<LocationEntity>> getAllLocations() => _local.getLocations();

  // Método para obtener todos los productos
  Future<List<ProductEntity>> getProducts() => _local.getProducts();

  // Método para obtener un producto por su ID
  Future<ProductEntity?> getProductById(String id) => _local.getProductById(id);

  // Método para guardar un producto
  Future<void> saveProduct(ProductEntity product) => _local.upsertProduct(product);

  // Método para guardar un snapshot
  Future<void> saveSnapshot(InventorySnapshotEntity snapshot) => _local.upsertSnapshot(snapshot);

  // Método para guardar una transacción
  Future<void> saveTransaction(InventoryTransactionEntity transaction) => 
      _local.upsertTransaction(transaction);

  Future<List<InventoryTransactionEntity>> getTransactionsByDateRange({
    required DateTime startDate,
    required DateTime endDate,
    String? locationId,
  }) =>
      _local.getTransactionsByDateRange(
        startDate: startDate,
        endDate: endDate,
        locationId: locationId,
      );
}

// Clase InventorySyncException que sirve para manejar las excepciones de sincronización
class InventorySyncException implements Exception {
  const InventorySyncException(this.message);
  final String message;

  @override
  String toString() => 'InventorySyncException: $message';
}


