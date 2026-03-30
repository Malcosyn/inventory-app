import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class ProductSupabaseDataSource {
  Future<List<Map<String, dynamic>>> getByStoreId(int storeId);
}

class ProductSupabaseDataSourceImpl implements ProductSupabaseDataSource {
  final SupabaseClient supabaseClient;

  ProductSupabaseDataSourceImpl({required this.supabaseClient});

  @override
  Future<List<Map<String, dynamic>>> getByStoreId(int storeId) async {
    final response = await supabaseClient
        .from('products')
        .select()
        .eq('warung_id', storeId)
        .order('created_at', ascending: false);

    return List<Map<String, dynamic>>.from(response);
  }
}
