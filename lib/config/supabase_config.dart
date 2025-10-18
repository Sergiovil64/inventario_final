import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SupabaseConfig {
  const SupabaseConfig._();
  static String get supabaseUrl => (dotenv.env['SUPABASE_URL'] ?? '').trim();
  static String get supabaseAnonKey => (dotenv.env['SUPABASE_ANON_KEY'] ?? '').trim();

  static Future<void> initialize() async {
    if (supabaseUrl.isEmpty || supabaseAnonKey.isEmpty) {
      throw Exception('Las credenciales de Supabase están vacías. Verifica el archivo .env');
    }
    
    await Supabase.initialize(url: supabaseUrl, anonKey: supabaseAnonKey);
  }
}

