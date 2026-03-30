import 'package:fpdart/fpdart.dart' hide Order;
import 'package:inventory_app/core/error/failures.dart';
import 'package:inventory_app/features/order/data/data_sources/order_supabase_data_source.dart';
import 'package:inventory_app/features/order/data/model/order_model.dart';
import 'package:inventory_app/features/order/domain/entity/order.dart';
import 'package:inventory_app/features/order/domain/repository/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderSupabaseDataSource orderSupabaseDataSource;

  OrderRepositoryImpl({required this.orderSupabaseDataSource});

  @override
  Future<Either<Failures, List<Order>>> getOrdersByProductIds(
    List<String> productIds,
  ) async {
    try {
      final rows = await orderSupabaseDataSource.getOrdersByProductIds(
        productIds,
      );
      return right(rows.map(OrderModel.fromMap).toList());
    } catch (e) {
      return left(Failures(e.toString()));
    }
  }
}
