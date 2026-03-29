import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/features/order/domain/entity/order.dart';
import 'package:inventory_app/features/order/domain/usecases/get_orders_usecase.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final GetOrdersUsecase getOrdersUsecase;

  OrderBloc({required this.getOrdersUsecase}) : super(OrderInitial()) {
    on<LoadOrders>((event, emit) async {
      emit(OrderLoading());
      final result = await getOrdersUsecase(
        GetOrdersParams(productIds: event.productIds),
      );
      result.fold(
        (failure) => emit(OrderFailure(failure.message)),
        (orders) => emit(OrderLoaded(orders)),
      );
    });
  }
}
