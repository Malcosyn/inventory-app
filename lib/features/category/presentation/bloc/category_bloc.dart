import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/features/category/domain/entity/category.dart';
import 'package:inventory_app/features/category/domain/usecases/get_categories_usecase.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final GetCategoriesUsecase getCategoriesUsecase;

  CategoryBloc({required this.getCategoriesUsecase})
    : super(CategoryInitial()) {
    on<LoadCategories>((event, emit) async {
      emit(CategoryLoading());
      final result = await getCategoriesUsecase(
        GetCategoriesParams(storeId: event.storeId),
      );
      result.fold(
        (failure) => emit(CategoryFailure(failure.message)),
        (categories) => emit(CategoryLoaded(categories)),
      );
    });
  }
}
