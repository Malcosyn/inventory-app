import 'package:fpdart/fpdart.dart' hide Order;
import 'package:inventory_app/core/error/failures.dart';
import 'package:inventory_app/features/order/domain/entity/order.dart';

abstract interface class OrderRepository {
  Future<Either<Failures, List<Order>>> getOrdersByProductIds(
    List<String> productIds,
  );
}
