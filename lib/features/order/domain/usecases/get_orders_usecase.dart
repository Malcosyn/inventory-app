import 'package:fpdart/fpdart.dart' hide Order;
import 'package:inventory_app/core/error/failures.dart';
import 'package:inventory_app/core/usecases/usecase.dart';
import 'package:inventory_app/features/order/domain/entity/order.dart';
import 'package:inventory_app/features/order/domain/repository/order_repository.dart';

class GetOrdersUsecase implements Usecase<List<Order>, GetOrdersParams> {
  final OrderRepository orderRepository;

  GetOrdersUsecase({required this.orderRepository});

  @override
  Future<Either<Failures, List<Order>>> call(GetOrdersParams param) {
    return orderRepository.getOrdersByProductIds(param.productIds);
  }
}

class GetOrdersParams {
  final List<String> productIds;

  GetOrdersParams({required this.productIds});
}
