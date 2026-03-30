import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class StoreSupabaseDataSource {
  Future<List<Map<String, dynamic>>> getStoresByOwner(String ownerId);
}

class StoreSupabaseDataSourceImpl implements StoreSupabaseDataSource {
  final SupabaseClient supabaseClient;

  StoreSupabaseDataSourceImpl({required this.supabaseClient});

  @override
  Future<List<Map<String, dynamic>>> getStoresByOwner(String ownerId) async {
    final response = await supabaseClient
        .from('stores')
        .select()
        .eq('owner_id', ownerId)
        .order('created_at', ascending: false);

    return List<Map<String, dynamic>>.from(response);
  }
}
