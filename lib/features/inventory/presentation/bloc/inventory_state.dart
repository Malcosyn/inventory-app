part of 'inventory_bloc.dart';

@immutable
sealed class InventoryState {}

final class InventoryInitial extends InventoryState {}

final class InventoryLoading extends InventoryState {}

final class InventoryLoaded extends InventoryState {
  final List<Inventory> rows;

  InventoryLoaded(this.rows);
}

final class InventoryFailure extends InventoryState {
  final String message;

  InventoryFailure(this.message);
}
