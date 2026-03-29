import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class StockMovementSupabaseDataSource {
  Future<List<Map<String, dynamic>>> getByProductIds(List<String> productIds);
}

class StockMovementSupabaseDataSourceImpl
    implements StockMovementSupabaseDataSource {
  final SupabaseClient supabaseClient;

  StockMovementSupabaseDataSourceImpl({required this.supabaseClient});

  @override
  Future<List<Map<String, dynamic>>> getByProductIds(
    List<String> productIds,
  ) async {
    if (productIds.isEmpty) return [];

    final response = await supabaseClient
        .from('stock_movement')
        .select()
        .inFilter('product_id', productIds)
        .order('created_at', ascending: false);

    return List<Map<String, dynamic>>.from(response);
  }
}
