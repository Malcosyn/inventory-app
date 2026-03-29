import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class CategorySupabaseDataSource {
  Future<List<Map<String, dynamic>>> getByStoreId(int storeId);
}

class CategorySupabaseDataSourceImpl implements CategorySupabaseDataSource {
  final SupabaseClient supabaseClient;

  CategorySupabaseDataSourceImpl({required this.supabaseClient});

  @override
  Future<List<Map<String, dynamic>>> getByStoreId(int storeId) async {
    final response = await supabaseClient
        .from('categories')
        .select()
        .eq('warung_id', storeId)
        .order('name');

    return List<Map<String, dynamic>>.from(response);
  }
}
