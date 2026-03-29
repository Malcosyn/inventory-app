part of 'store_bloc.dart';

@immutable
sealed class StoreState {}

final class StoreInitial extends StoreState {}

final class StoreLoading extends StoreState {}

final class StoreLoaded extends StoreState {
  final List<Store> stores;

  StoreLoaded(this.stores);
}

final class StoreFailure extends StoreState {
  final String message;

  StoreFailure(this.message);
}
