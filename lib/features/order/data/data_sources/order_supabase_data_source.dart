import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class OrderSupabaseDataSource {
  Future<List<Map<String, dynamic>>> getOrdersByProductIds(
    List<String> productIds,
  );
}

class OrderSupabaseDataSourceImpl implements OrderSupabaseDataSource {
  final SupabaseClient supabaseClient;

  OrderSupabaseDataSourceImpl({required this.supabaseClient});

  @override
  Future<List<Map<String, dynamic>>> getOrdersByProductIds(
    List<String> productIds,
  ) async {
    if (productIds.isEmpty) return [];

    final response = await supabaseClient
        .from('orders')
        .select()
        .inFilter('product_id', productIds);

    return List<Map<String, dynamic>>.from(response);
  }
}
