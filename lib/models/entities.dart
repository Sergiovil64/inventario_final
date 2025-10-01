import 'package:equatable/equatable.dart';
import 'package:inventario_final/models/enums.dart';

class SyncMetadata extends Equatable {
  const SyncMetadata({
    required this.id,
    required this.updatedAt,
    required this.pendingSync,
  });

  final String id;
  final DateTime updatedAt;
  final bool pendingSync;

  SyncMetadata copyWith({
    String? id,
    DateTime? updatedAt,
    bool? pendingSync,
  }) {
    return SyncMetadata(
      id: id ?? this.id,
      updatedAt: updatedAt ?? this.updatedAt,
      pendingSync: pendingSync ?? this.pendingSync,
    );
  }

  @override
  List<Object> get props => [id, updatedAt, pendingSync];
}

class SyncStatusEntity extends Equatable {
  const SyncStatusEntity({
    required this.resource,
    required this.lastSyncedAt,
  });

  final SyncResource resource;
  final DateTime? lastSyncedAt;

  SyncStatusEntity copyWith({
    SyncResource? resource,
    DateTime? lastSyncedAt,
  }) {
    return SyncStatusEntity(
      resource: resource ?? this.resource,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
    );
  }

  @override
  List<Object?> get props => [resource, lastSyncedAt];
}

class ProductEntity extends Equatable {
  const ProductEntity({
    required this.id,
    required this.name,
    required this.sku,
    required this.category,
    required this.unit,
    required this.price,
    required this.active,
    required this.sync,
  });

  final String id;
  final String name;
  final String sku;
  final String category;
  final String unit;
  final double price;
  final bool active;
  final SyncMetadata sync;

  ProductEntity copyWith({
    String? id,
    String? name,
    String? sku,
    String? category,
    String? unit,
    double? price,
    bool? active,
    SyncMetadata? sync,
  }) {
    return ProductEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      sku: sku ?? this.sku,
      category: category ?? this.category,
      unit: unit ?? this.unit,
      price: price ?? this.price,
      active: active ?? this.active,
      sync: sync ?? this.sync,
    );
  }

  @override
  List<Object> get props => [id, name, sku, category, unit, price, active, sync];
}

class LocationEntity extends Equatable {
  const LocationEntity({
    required this.id,
    required this.name,
    required this.type,
    required this.address,
    required this.sync,
  });

  final String id;
  final String name;
  final LocationType type;
  final String address;
  final SyncMetadata sync;

  LocationEntity copyWith({
    String? id,
    String? name,
    LocationType? type,
    String? address,
    SyncMetadata? sync,
  }) {
    return LocationEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      address: address ?? this.address,
      sync: sync ?? this.sync,
    );
  }

  @override
  List<Object> get props => [id, name, type, address, sync];
}

class EmployeeEntity extends Equatable {
  const EmployeeEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.active,
    required this.locationId,
    required this.sync,
  });

  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final bool active;
  final String locationId;
  final SyncMetadata sync;

  EmployeeEntity copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    bool? active,
    String? locationId,
    SyncMetadata? sync,
  }) {
    return EmployeeEntity(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      active: active ?? this.active,
      locationId: locationId ?? this.locationId,
      sync: sync ?? this.sync,
    );
  }

  @override
  List<Object> get props => [id, firstName, lastName, email, active, locationId, sync];
}

class InventorySnapshotEntity extends Equatable {
  const InventorySnapshotEntity({
    required this.id,
    required this.productId,
    required this.locationId,
    required this.quantity,
    required this.updatedAt,
    required this.sync,
  });

  final String id;
  final String productId;
  final String locationId;
  final double quantity;
  final DateTime updatedAt;
  final SyncMetadata sync;

  InventorySnapshotEntity copyWith({
    String? id,
    String? productId,
    String? locationId,
    double? quantity,
    DateTime? updatedAt,
    SyncMetadata? sync,
  }) {
    return InventorySnapshotEntity(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      locationId: locationId ?? this.locationId,
      quantity: quantity ?? this.quantity,
      updatedAt: updatedAt ?? this.updatedAt,
      sync: sync ?? this.sync,
    );
  }

  @override
  List<Object> get props => [id, productId, locationId, quantity, updatedAt, sync];
}

class InventoryTransactionEntity extends Equatable {
  const InventoryTransactionEntity({
    required this.id,
    required this.productId,
    required this.sourceLocationId,
    required this.targetLocationId,
    required this.quantity,
    required this.transactionType,
    required this.reference,
    required this.note,
    required this.employeeId,
    required this.occurredAt,
    required this.sync,
  });

  final String id;
  final String productId;
  final String? sourceLocationId;
  final String? targetLocationId;
  final double quantity;
  final TransactionType transactionType;
  final String reference;
  final String? note;
  final String employeeId;
  final DateTime occurredAt;
  final SyncMetadata sync;

  InventoryTransactionEntity copyWith({
    String? id,
    String? productId,
    String? sourceLocationId,
    String? targetLocationId,
    double? quantity,
    TransactionType? transactionType,
    String? reference,
    String? note,
    String? employeeId,
    DateTime? occurredAt,
    SyncMetadata? sync,
  }) {
    return InventoryTransactionEntity(
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
      sync: sync ?? this.sync,
    );
  }

  @override
  List<Object?> get props => [
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
        sync,
      ];
}

