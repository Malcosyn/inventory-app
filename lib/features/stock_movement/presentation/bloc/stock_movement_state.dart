part of 'stock_movement_bloc.dart';

@immutable
sealed class StockMovementState {}

final class StockMovementInitial extends StockMovementState {}

final class StockMovementLoading extends StockMovementState {}

final class StockMovementLoaded extends StockMovementState {
  final List<StockMovement> rows;

  StockMovementLoaded(this.rows);
}

final class StockMovementFailure extends StockMovementState {
  final String message;

  StockMovementFailure(this.message);
}
