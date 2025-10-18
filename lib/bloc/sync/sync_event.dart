import 'package:equatable/equatable.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

// Clase SyncEvent que sirve para manejar los eventos de la sincronización
abstract class SyncEvent extends Equatable {
  const SyncEvent();

  @override
  List<Object?> get props => [];
}

class SyncRequested extends SyncEvent {
  const SyncRequested({this.force = false});

  final bool force;

  @override
  List<Object?> get props => [force];
}

class SyncConnectivityChanged extends SyncEvent {
  const SyncConnectivityChanged(this.result);

  final ConnectivityResult result;

  @override
  List<Object?> get props => [result];
}

class SyncStatusResetRequested extends SyncEvent {
  const SyncStatusResetRequested();
}

