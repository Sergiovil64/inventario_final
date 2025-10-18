import 'package:equatable/equatable.dart';
import 'package:inventario_final/models/entities.dart';

enum InventoryOverviewStatus { initial, loading, success, failure }

// Clase InventoryOverviewState que sirve para manejar el estado de inventario
class InventoryOverviewState extends Equatable {
  const InventoryOverviewState({
    this.status = InventoryOverviewStatus.initial,
    this.products = const [],
    this.snapshots = const [],
    this.locations = const [],
    this.inventoryTotals = const {},
    this.selectedLocationId,
    this.errorMessage,
  });

  final InventoryOverviewStatus status;
  final List<ProductEntity> products;
  final List<InventorySnapshotEntity> snapshots;
  final List<LocationEntity> locations;
  final Map<String, double> inventoryTotals;
  final String? selectedLocationId;
  final String? errorMessage;

  // Método para copiar el estado
  InventoryOverviewState copyWith({
    InventoryOverviewStatus? status,
    List<ProductEntity>? products,
    List<InventorySnapshotEntity>? snapshots,
    List<LocationEntity>? locations,
    Map<String, double>? inventoryTotals,
    String? selectedLocationId,
    String? errorMessage,
  }) {
    return InventoryOverviewState(
      status: status ?? this.status,
      products: products ?? this.products,
      snapshots: snapshots ?? this.snapshots,
      locations: locations ?? this.locations,
      inventoryTotals: inventoryTotals ?? this.inventoryTotals,
      selectedLocationId: selectedLocationId ?? this.selectedLocationId,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        products,
        snapshots,
        locations,
        inventoryTotals,
        selectedLocationId,
        errorMessage,
      ];
}

