part of 'sync_bloc.dart';

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

