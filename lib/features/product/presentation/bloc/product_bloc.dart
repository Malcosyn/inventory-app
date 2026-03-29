import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/features/product/domain/entity/product.dart';
import 'package:inventory_app/features/product/domain/usecases/get_products_usecase.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProductsUsecase getProductsUsecase;

  ProductBloc({required this.getProductsUsecase}) : super(ProductInitial()) {
    on<LoadProducts>((event, emit) async {
      emit(ProductLoading());
      final result = await getProductsUsecase(
        GetProductsParams(storeId: event.storeId),
      );
      result.fold(
        (failure) => emit(ProductFailure(failure.message)),
        (products) => emit(ProductLoaded(products)),
      );
    });
  }
}
