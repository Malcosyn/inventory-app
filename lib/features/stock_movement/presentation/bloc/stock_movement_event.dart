part of 'stock_movement_bloc.dart';

@immutable
sealed class StockMovementEvent {}

final class LoadStockMovements extends StockMovementEvent {
  final List<String> productIds;

  LoadStockMovements(this.productIds);
}
