import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class InventorySupabaseDataSource {
  Future<List<Map<String, dynamic>>> getInventoryByProductIds(
    List<String> productIds,
  );
}

class InventorySupabaseDataSourceImpl implements InventorySupabaseDataSource {
  final SupabaseClient supabaseClient;

  InventorySupabaseDataSourceImpl({required this.supabaseClient});

  @override
  Future<List<Map<String, dynamic>>> getInventoryByProductIds(
    List<String> productIds,
  ) async {
    if (productIds.isEmpty) return [];

    final response = await supabaseClient
        .from('inventories')
        .select()
        .inFilter('product_id', productIds);

    return List<Map<String, dynamic>>.from(response);
  }
}
