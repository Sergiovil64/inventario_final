import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventario_final/bloc/authentication/authentication_event.dart';
import 'package:inventario_final/bloc/authentication/authentication_state.dart';
import 'package:inventario_final/data/repositories/auth_repository.dart';

// Clase AuthenticationBloc que sirve para manejar el estado de autenticación del usuario
// Se encarga de manejar el estado de autenticación del usuario y de las acciones de login, register, logout y cambio de ubicación
// También se encarga de manejar el estado de la aplicación y de las acciones de sincronización
class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({required AuthRepository repository})
      : _repository = repository,
        super(const AuthenticationState.unknown()) {
    on<AuthenticationStarted>(_onStarted);
    on<AuthenticationLoginRequested>(_onLoginRequested);
    on<AuthenticationRegisterRequested>(_onRegisterRequested);
    on<AuthenticationLogoutRequested>(_onLogoutRequested);
    on<AuthenticationLocationChanged>(_onLocationChanged);
  }

  final AuthRepository _repository;

  // Método para manejar el evento de inicio de la aplicación
  Future<void> _onStarted(
    AuthenticationStarted event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(const AuthenticationState.loading());
    final currentUser = await _repository.currentUser();
    if (currentUser != null) {
      emit(AuthenticationState.authenticated(currentUser));
    } else {
      emit(const AuthenticationState.unauthenticated());
    }
  }

  // Método para manejar el evento de login
  Future<void> _onLoginRequested(
    AuthenticationLoginRequested event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(const AuthenticationState.loading());
    try {
      final user = await _repository.signIn(event.email, event.password);
      emit(AuthenticationState.authenticated(user));
    } catch (error) {
      emit(AuthenticationState.failure(error.toString()));
    }
  }

  // Método para manejar el evento de registro
  Future<void> _onRegisterRequested(
    AuthenticationRegisterRequested event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(const AuthenticationState.loading());
    try {
      final user = await _repository.signUp(
        email: event.email,
        password: event.password,
        firstName: event.firstName,
        lastName: event.lastName,
        locationId: event.locationId,
      );
      emit(AuthenticationState.authenticated(user));
    } catch (error) {
      emit(AuthenticationState.failure(error.toString()));
    }
  }

  // Método para manejar el evento de logout
  Future<void> _onLogoutRequested(
    AuthenticationLogoutRequested event,
    Emitter<AuthenticationState> emit,
  ) async {
    await _repository.signOut();
    emit(const AuthenticationState.unauthenticated());
  }

  // Método para manejar el evento de cambio de ubicación
  Future<void> _onLocationChanged(
    AuthenticationLocationChanged event,
    Emitter<AuthenticationState> emit,
  ) async {
    if (state.user == null) return;
    
    try {
      final updatedUser = await _repository.updateEmployeeLocation(
        state.user!.id,
        event.newLocationId,
      );
      emit(AuthenticationState.authenticated(updatedUser));
    } catch (error) {
      emit(AuthenticationState.failure(error.toString()));
    }
  }
}

