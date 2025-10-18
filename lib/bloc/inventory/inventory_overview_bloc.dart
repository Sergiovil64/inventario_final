import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventario_final/bloc/inventory/inventory_overview_event.dart';
import 'package:inventario_final/bloc/inventory/inventory_overview_state.dart';
import 'package:inventario_final/data/repositories/inventory_repository.dart';
import 'package:inventario_final/models/entities.dart';

// Clase InventoryOverviewBloc que sirve para manejar el estado de inventario
// Se encarga de manejar el estado de inventario y de las acciones de sincronización
// También se encarga de manejar el estado de la aplicación y de las acciones de sincronización
class InventoryOverviewBloc
    extends Bloc<InventoryOverviewEvent, InventoryOverviewState> {
  InventoryOverviewBloc(this._repository) : super(const InventoryOverviewState()) {
    on<InventoryOverviewSubscriptionRequested>(_onSubscriptionRequested);
    on<InventoryOverviewProductsUpdated>(_onProductsUpdated);
    on<InventoryOverviewLocationsUpdated>(_onLocationsUpdated);
    on<InventoryOverviewSnapshotsUpdated>(_onSnapshotsUpdated);
    on<InventoryOverviewLocationChanged>(_onLocationChanged);
  }

  final InventoryRepository _repository;
  StreamSubscription<List<ProductEntity>>? _productSubscription;
  StreamSubscription<List<LocationEntity>>? _locationSubscription;
  StreamSubscription<List<InventorySnapshotEntity>>? _snapshotSubscription;

  // Método para manejar el evento de subscripción
  Future<void> _onSubscriptionRequested(
    InventoryOverviewSubscriptionRequested event,
    Emitter<InventoryOverviewState> emit,
  ) async {
    emit(state.copyWith(status: InventoryOverviewStatus.loading));

    await _productSubscription?.cancel();
    _productSubscription = _repository.watchProducts().listen((products) {
      add(InventoryOverviewProductsUpdated(products));
    });

    await _locationSubscription?.cancel();
    _locationSubscription = _repository.watchLocations().listen((locations) {
      add(InventoryOverviewLocationsUpdated(locations));
    });

    await _snapshotSubscription?.cancel();
    _snapshotSubscription = _repository.watchSnapshots().listen((snapshots) {
      add(InventoryOverviewSnapshotsUpdated(snapshots));
    });
  }

  @override
  Future<void> close() async {
    await _productSubscription?.cancel();
    await _locationSubscription?.cancel();
    await _snapshotSubscription?.cancel();
    return super.close();
  }

  // Método para manejar el evento de actualización de productos
  void _onProductsUpdated(
    InventoryOverviewProductsUpdated event,
    Emitter<InventoryOverviewState> emit,
  ) {
    emit(state.copyWith(products: event.products));
  }

  // Método para manejar el evento de actualización de ubicaciones
  void _onLocationsUpdated(
    InventoryOverviewLocationsUpdated event,
    Emitter<InventoryOverviewState> emit,
  ) {
    emit(state.copyWith(locations: event.locations));
  }

  // Método para manejar el evento de actualización de snapshots
  void _onSnapshotsUpdated(
    InventoryOverviewSnapshotsUpdated event,
    Emitter<InventoryOverviewState> emit,
  ) {
    _recalculateInventory(event.snapshots, emit);
  }

  // Método para manejar el evento de cambio de ubicación
  void _onLocationChanged(
    InventoryOverviewLocationChanged event,
    Emitter<InventoryOverviewState> emit,
  ) {
    emit(state.copyWith(selectedLocationId: event.locationId));
    _recalculateInventory(state.snapshots, emit);
  }

  // Método para recalcular el inventario
  void _recalculateInventory(
    List<InventorySnapshotEntity> snapshots,
    Emitter<InventoryOverviewState> emit,
  ) {
    // Filtrar snapshots por ubicación si hay una seleccionada
    final filteredSnapshots = state.selectedLocationId == null
        ? snapshots
        : snapshots.where((s) => s.locationId == state.selectedLocationId).toList();

    final inventory = filteredSnapshots.fold<Map<String, double>>({}, (acc, snapshot) {
      acc[snapshot.productId] = (acc[snapshot.productId] ?? 0) + snapshot.quantity;
      return acc;
    });

    emit(state.copyWith(
      status: InventoryOverviewStatus.success,
      snapshots: snapshots, // Guardamos todos los snapshots
      inventoryTotals: inventory, // Pero calculamos totales filtrados
    ));
  }
}

