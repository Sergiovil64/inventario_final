import 'package:equatable/equatable.dart';

enum SyncStatus { idle, inProgress, success, failure }

// Clase SyncState que sirve para manejar el estado de la sincronización
class SyncState extends Equatable {
  const SyncState({
    this.status = SyncStatus.idle,
    this.isOnline = true,
    this.message,
  });

  final SyncStatus status;
  final bool isOnline;
  final String? message;

  SyncState copyWith({
    SyncStatus? status,
    bool? isOnline,
    String? message,
  }) {
    return SyncState(
      status: status ?? this.status,
      isOnline: isOnline ?? this.isOnline,
      message: message,
    );
  }

  @override
  List<Object?> get props => [status, isOnline, message];
}

