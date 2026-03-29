part of 'category_bloc.dart';

@immutable
sealed class CategoryEvent {}

final class LoadCategories extends CategoryEvent {
  final int storeId;

  LoadCategories(this.storeId);
}
