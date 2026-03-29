part of 'inventory_bloc.dart';

@immutable
sealed class InventoryEvent {}

final class LoadInventory extends InventoryEvent {
  final List<String> productIds;

  LoadInventory(this.productIds);
}
