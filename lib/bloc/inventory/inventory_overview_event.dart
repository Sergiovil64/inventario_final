import 'package:equatable/equatable.dart';
import 'package:inventario_final/models/entities.dart';


abstract class InventoryOverviewEvent extends Equatable {
  const InventoryOverviewEvent();

  @override
  List<Object?> get props => [];
}

class InventoryOverviewSubscriptionRequested extends InventoryOverviewEvent {
  const InventoryOverviewSubscriptionRequested();
}

class InventoryOverviewProductsUpdated extends InventoryOverviewEvent {
  const InventoryOverviewProductsUpdated(this.products);

  final List<ProductEntity> products;

  @override
  List<Object?> get props => [products];
}

class InventoryOverviewLocationsUpdated extends InventoryOverviewEvent {
  const InventoryOverviewLocationsUpdated(this.locations);

  final List<LocationEntity> locations;

  @override
  List<Object?> get props => [locations];
}

class InventoryOverviewSnapshotsUpdated extends InventoryOverviewEvent {
  const InventoryOverviewSnapshotsUpdated(this.snapshots);

  final List<InventorySnapshotEntity> snapshots;

  @override
  List<Object?> get props => [snapshots];
}

