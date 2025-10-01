import 'package:equatable/equatable.dart';
import 'package:inventario_final/models/entities.dart';

enum AuthenticationStatus { unknown, loading, authenticated, unauthenticated, failure }

class AuthenticationState extends Equatable {
  const AuthenticationState._({
    required this.status,
    this.user,
    this.error,
  });

  const AuthenticationState.unknown() : this._(status: AuthenticationStatus.unknown);

  const AuthenticationState.loading() : this._(status: AuthenticationStatus.loading);

  const AuthenticationState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);

  const AuthenticationState.failure(String error)
      : this._(status: AuthenticationStatus.failure, error: error);

  factory AuthenticationState.authenticated(EmployeeEntity user) {
    return AuthenticationState._(status: AuthenticationStatus.authenticated, user: user);
  }

  final AuthenticationStatus status;
  final EmployeeEntity? user;
  final String? error;

  @override
  List<Object?> get props => [status, user, error];
}

