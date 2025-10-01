import 'package:equatable/equatable.dart';
import 'package:inventario_final/models/entities.dart';

enum InventoryOverviewStatus { initial, loading, success, failure }

class InventoryOverviewState extends Equatable {
  const InventoryOverviewState({
    this.status = InventoryOverviewStatus.initial,
    this.products = const [],
    this.snapshots = const [],
    this.inventoryTotals = const {},
    this.errorMessage,
  });

  final InventoryOverviewStatus status;
  final List<ProductEntity> products;
  final List<InventorySnapshotEntity> snapshots;
  final Map<String, double> inventoryTotals;
  final String? errorMessage;

  InventoryOverviewState copyWith({
    InventoryOverviewStatus? status,
    List<ProductEntity>? products,
    List<InventorySnapshotEntity>? snapshots,
    Map<String, double>? inventoryTotals,
    String? errorMessage,
  }) {
    return InventoryOverviewState(
      status: status ?? this.status,
      products: products ?? this.products,
      snapshots: snapshots ?? this.snapshots,
      inventoryTotals: inventoryTotals ?? this.inventoryTotals,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        products,
        snapshots,
        inventoryTotals,
        errorMessage,
      ];
}

