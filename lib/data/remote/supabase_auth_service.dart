import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAuthService {
  SupabaseAuthService({SupabaseClient? client})
      : _client = client ?? Supabase.instance.client;

  final SupabaseClient _client;

  Session? currentSession() => _client.auth.currentSession;

  Future<AuthResponse> signIn(String email, String password) {
    return _client.auth.signInWithPassword(email: email, password: password);
  }

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

  Future<void> signOut() => _client.auth.signOut();
}

