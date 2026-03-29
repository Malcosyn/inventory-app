part of 'store_bloc.dart';

@immutable
sealed class StoreEvent {}

final class LoadStores extends StoreEvent {
  final String ownerId;

  LoadStores(this.ownerId);
}
