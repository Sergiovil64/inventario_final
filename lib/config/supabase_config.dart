import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfig {
  const SupabaseConfig._();

  static const String supabaseUrl = 'https://itrvavlxjhiuxyomdssj.supabase.co';
  static const String supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml0cnZhdmx4amhpdXh5b21kc3NqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTkxODg0OTYsImV4cCI6MjA3NDc2NDQ5Nn0.xOaCkNwwLh2UU2-yc4x-OiGomvErw_ro-Su_9PAom2k';

  static Future<void> initialize() async {
    await Supabase.initialize(url: supabaseUrl, anonKey: supabaseAnonKey);
  }
}

