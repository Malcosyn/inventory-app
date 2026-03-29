part of 'order_bloc.dart';

@immutable
sealed class OrderEvent {}

final class LoadOrders extends OrderEvent {
  final List<String> productIds;

  LoadOrders(this.productIds);
}
