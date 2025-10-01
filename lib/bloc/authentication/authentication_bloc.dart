import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventario_final/bloc/authentication/authentication_event.dart';
import 'package:inventario_final/bloc/authentication/authentication_state.dart';
import 'package:inventario_final/data/repositories/auth_repository.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({required AuthRepository repository})
      : _repository = repository,
        super(const AuthenticationState.unknown()) {
    on<AuthenticationStarted>(_onStarted);
    on<AuthenticationLoginRequested>(_onLoginRequested);
    on<AuthenticationLogoutRequested>(_onLogoutRequested);
  }

  final AuthRepository _repository;

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

  Future<void> _onLogoutRequested(
    AuthenticationLogoutRequested event,
    Emitter<AuthenticationState> emit,
  ) async {
    await _repository.signOut();
    emit(const AuthenticationState.unauthenticated());
  }
}

