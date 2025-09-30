import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/entities.dart';
import '../../data/repositories/inventory_repository.dart';

part 'inventory_overview_event.dart';
part 'inventory_overview_state.dart';

class InventoryOverviewBloc
    extends Bloc<InventoryOverviewEvent, InventoryOverviewState> {
  InventoryOverviewBloc(this._repository) : super(const InventoryOverviewState()) {
    on<InventoryOverviewSubscriptionRequested>(_onSubscriptionRequested);
    on<InventoryOverviewProductsUpdated>(_onProductsUpdated);
    on<InventoryOverviewSnapshotsUpdated>(_onSnapshotsUpdated);
  }

  final InventoryRepository _repository;
  StreamSubscription<List<ProductEntity>>? _productSubscription;
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

    await _snapshotSubscription?.cancel();
    _snapshotSubscription = _repository.watchSnapshots().listen((snapshots) {
      add(InventoryOverviewSnapshotsUpdated(snapshots));
    });
  }

  @override
  Future<void> close() async {
    await _productSubscription?.cancel();
    await _snapshotSubscription?.cancel();
    return super.close();
  }

  void _onProductsUpdated(
    InventoryOverviewProductsUpdated event,
    Emitter<InventoryOverviewState> emit,
  ) {
    emit(state.copyWith(products: event.products));
  }

  void _onSnapshotsUpdated(
    InventoryOverviewSnapshotsUpdated event,
    Emitter<InventoryOverviewState> emit,
  ) {
    final inventory = event.snapshots
        .fold<Map<String, double>>({}, (acc, snapshot) {
      acc[snapshot.productId] =
          (acc[snapshot.productId] ?? 0) + snapshot.quantity;
      return acc;
    });

    emit(state.copyWith(
      status: InventoryOverviewStatus.success,
      snapshots: event.snapshots,
      inventoryTotals: inventory,
    ));
  }
}

