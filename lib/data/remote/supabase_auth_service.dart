import 'package:supabase_flutter/supabase_flutter.dart';

// Clase SupabaseAuthService que sirve para manejar el servicio de autenticación de Supabase
class SupabaseAuthService {
  SupabaseAuthService({SupabaseClient? client})
      : _client = client ?? Supabase.instance.client;

  final SupabaseClient _client;

  // Método para obtener la sesión actual
  Session? currentSession() => _client.auth.currentSession;

  // Método para iniciar sesión
  Future<AuthResponse> signIn(String email, String password) {
    return _client.auth.signInWithPassword(email: email, password: password);
  }

  // Método para registrar un nuevo usuario
  Future<AuthResponse> signUp({
    required String email,
    required String password,
    Map<String, dynamic>? data,
  }) {
    return _client.auth.signUp(
      email: email,
      password: password,
      data: data,
    );
  }

  // Método para cerrar sesión
  Future<void> signOut() => _client.auth.signOut();
}

