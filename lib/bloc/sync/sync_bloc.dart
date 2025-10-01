import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventario_final/bloc/sync/sync_event.dart';
import 'package:inventario_final/bloc/sync/sync_state.dart';
import 'package:inventario_final/data/repositories/inventory_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SyncBloc extends Bloc<SyncEvent, SyncState> {
  SyncBloc({
    required InventoryRepository repository,
    Connectivity? connectivity,
  })  : _repository = repository,
        _connectivity = connectivity ?? Connectivity(),
        super(const SyncState()) {
    on<SyncRequested>(_onSyncRequested);
    on<SyncConnectivityChanged>(_onConnectivityChanged);
    on<SyncStatusResetRequested>(_onStatusReset);

    _connectivitySubscription = _connectivity.onConnectivityChanged.listen((events) {
      final result = events.isNotEmpty ? events.first : ConnectivityResult.none;
      add(SyncConnectivityChanged(result));
    });
  }

  final InventoryRepository _repository;
  final Connectivity _connectivity;
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;

  Future<void> _onSyncRequested(SyncRequested event, Emitter<SyncState> emit) async {
    if (state.status == SyncStatus.inProgress) return;
    emit(state.copyWith(status: SyncStatus.inProgress, message: 'Sincronizando...'));
    try {
      final session = Supabase.instance.client.auth.currentSession;
      if (session == null) {
        emit(state.copyWith(
          status: SyncStatus.failure,
          message: 'Inicia sesión para sincronizar.',
        ));
        return;
      }
      await _repository.syncAll(force: event.force);
      emit(state.copyWith(status: SyncStatus.success, message: 'Sincronización completa'));
    } on InventorySyncException catch (error) {
      emit(state.copyWith(status: SyncStatus.failure, message: error.message));
    } catch (error) {
      emit(state.copyWith(status: SyncStatus.failure, message: error.toString()));
    }
  }

  void _onConnectivityChanged(
    SyncConnectivityChanged event,
    Emitter<SyncState> emit,
  ) {
    final hasConnection = event.result != ConnectivityResult.none;
    emit(state.copyWith(isOnline: hasConnection));
    if (hasConnection && state.status != SyncStatus.inProgress) {
      add(const SyncRequested());
    }
  }

  void _onStatusReset(SyncStatusResetRequested event, Emitter<SyncState> emit) {
    emit(state.copyWith(status: SyncStatus.idle, message: null));
  }

  @override
  Future<void> close() {
    _connectivitySubscription?.cancel();
    return super.close();
  }
}

