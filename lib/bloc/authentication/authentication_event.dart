import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object?> get props => [];
}

class AuthenticationStarted extends AuthenticationEvent {
  const AuthenticationStarted();
}

class AuthenticationLoginRequested extends AuthenticationEvent {
  const AuthenticationLoginRequested({required this.email, required this.password});

  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password];
}

class AuthenticationRegisterRequested extends AuthenticationEvent {
  const AuthenticationRegisterRequested({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.locationId,
  });

  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String locationId;

  @override
  List<Object?> get props => [email, password, firstName, lastName, locationId];
}

class AuthenticationLogoutRequested extends AuthenticationEvent {
  const AuthenticationLogoutRequested();
}

