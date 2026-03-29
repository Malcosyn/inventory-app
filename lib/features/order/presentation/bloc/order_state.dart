part of 'order_bloc.dart';

@immutable
sealed class OrderState {}

final class OrderInitial extends OrderState {}

final class OrderLoading extends OrderState {}

final class OrderLoaded extends OrderState {
  final List<Order> orders;

  OrderLoaded(this.orders);
}

final class OrderFailure extends OrderState {
  final String message;

  OrderFailure(this.message);
}
