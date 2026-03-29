import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class SupplierSupabaseDataSource {
  Future<List<Map<String, dynamic>>> getSuppliers();
}

class SupplierSupabaseDataSourceImpl implements SupplierSupabaseDataSource {
  final SupabaseClient supabaseClient;

  SupplierSupabaseDataSourceImpl({required this.supabaseClient});

  @override
  Future<List<Map<String, dynamic>>> getSuppliers() async {
    final response = await supabaseClient
        .from('suppliers')
        .select()
        .order('name');
    return List<Map<String, dynamic>>.from(response);
  }
}
