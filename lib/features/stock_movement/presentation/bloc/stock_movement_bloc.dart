import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/features/stock_movement/domain/entity/stock_movement.dart';
import 'package:inventory_app/features/stock_movement/domain/usecases/get_stock_movements_usecase.dart';

part 'stock_movement_event.dart';
part 'stock_movement_state.dart';

class StockMovementBloc extends Bloc<StockMovementEvent, StockMovementState> {
  final GetStockMovementsUsecase getStockMovementsUsecase;

  StockMovementBloc({required this.getStockMovementsUsecase})
    : super(StockMovementInitial()) {
    on<LoadStockMovements>((event, emit) async {
      emit(StockMovementLoading());
      final result = await getStockMovementsUsecase(
        GetStockMovementsParams(productIds: event.productIds),
      );
      result.fold(
        (failure) => emit(StockMovementFailure(failure.message)),
        (rows) => emit(StockMovementLoaded(rows)),
      );
    });
  }
}
