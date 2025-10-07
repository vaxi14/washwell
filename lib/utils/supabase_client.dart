import 'package:flutter/material.dart';
import 'package:washwell/constants/app_constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseClient {
  static Future<void> intialize()async {
    Supabase.initialize(
      url: AppConstants.supabaseurl,
      anonKey: AppConstants.supabaseAnonKey
      );

  }
  static SupabaseClient get instance => SupabaseClient();
}