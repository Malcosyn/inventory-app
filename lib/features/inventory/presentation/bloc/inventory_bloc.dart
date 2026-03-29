import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/features/inventory/domain/entity/inventory.dart';
import 'package:inventory_app/features/inventory/domain/usecases/get_inventory_usecase.dart';

part 'inventory_event.dart';
part 'inventory_state.dart';

class InventoryBloc extends Bloc<InventoryEvent, InventoryState> {
  final GetInventoryUsecase getInventoryUsecase;

  InventoryBloc({required this.getInventoryUsecase})
    : super(InventoryInitial()) {
    on<LoadInventory>((event, emit) async {
      emit(InventoryLoading());
      final result = await getInventoryUsecase(
        GetInventoryParams(productIds: event.productIds),
      );
      result.fold(
        (failure) => emit(InventoryFailure(failure.message)),
        (rows) => emit(InventoryLoaded(rows)),
      );
    });
  }
}
