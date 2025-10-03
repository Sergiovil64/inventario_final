import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventario_final/bloc/inventory/inventory_overview_event.dart';
import 'package:inventario_final/bloc/inventory/inventory_overview_state.dart';
import 'package:inventario_final/data/repositories/inventory_repository.dart';
import 'package:inventario_final/models/entities.dart';


class InventoryOverviewBloc
    extends Bloc<InventoryOverviewEvent, InventoryOverviewState> {
  InventoryOverviewBloc(this._repository) : super(const InventoryOverviewState()) {
    on<InventoryOverviewSubscriptionRequested>(_onSubscriptionRequested);
    on<InventoryOverviewProductsUpdated>(_onProductsUpdated);
    on<InventoryOverviewLocationsUpdated>(_onLocationsUpdated);
    on<InventoryOverviewSnapshotsUpdated>(_onSnapshotsUpdated);
  }

  final InventoryRepository _repository;
  StreamSubscription<List<ProductEntity>>? _productSubscription;
  StreamSubscription<List<LocationEntity>>? _locationSubscription;
  StreamSubscription<List<InventorySnapshotEntity>>? _snapshotSubscription;

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

  void _onProductsUpdated(
    InventoryOverviewProductsUpdated event,
    Emitter<InventoryOverviewState> emit,
  ) {
    emit(state.copyWith(products: event.products));
  }

  void _onLocationsUpdated(
    InventoryOverviewLocationsUpdated event,
    Emitter<InventoryOverviewState> emit,
  ) {
    emit(state.copyWith(locations: event.locations));
  }

  void _onSnapshotsUpdated(
    InventoryOverviewSnapshotsUpdated event,
    Emitter<InventoryOverviewState> emit,
  ) {
    final inventory = event.snapshots.fold<Map<String, double>>({}, (acc, snapshot) {
      acc[snapshot.productId] = (acc[snapshot.productId] ?? 0) + snapshot.quantity;
      return acc;
    });

    emit(state.copyWith(
      status: InventoryOverviewStatus.success,
      snapshots: event.snapshots,
      inventoryTotals: inventory,
    ));
  }
}

