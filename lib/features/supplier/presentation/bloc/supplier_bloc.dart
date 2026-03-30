import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/features/supplier/domain/entity/supplier.dart';
import 'package:inventory_app/features/supplier/domain/usecases/get_suppliers_usecase.dart';

part 'supplier_event.dart';
part 'supplier_state.dart';

class SupplierBloc extends Bloc<SupplierEvent, SupplierState> {
  final GetSuppliersUsecase getSuppliersUsecase;

  SupplierBloc({required this.getSuppliersUsecase}) : super(SupplierInitial()) {
    on<LoadSuppliers>((event, emit) async {
      emit(SupplierLoading());
      final result = await getSuppliersUsecase(NoSupplierParams());
      result.fold(
        (failure) => emit(SupplierFailure(failure.message)),
        (suppliers) => emit(SupplierLoaded(suppliers)),
      );
    });
  }
}
