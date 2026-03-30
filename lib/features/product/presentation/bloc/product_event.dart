part of 'product_bloc.dart';

@immutable
sealed class ProductEvent {}

final class LoadProducts extends ProductEvent {
  final int storeId;

  LoadProducts(this.storeId);
}
