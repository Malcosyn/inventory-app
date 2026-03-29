import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/features/store/domain/entity/store.dart';
import 'package:inventory_app/features/store/domain/usecases/get_stores_by_owner_usecase.dart';

part 'store_event.dart';
part 'store_state.dart';

class StoreBloc extends Bloc<StoreEvent, StoreState> {
  final GetStoresByOwnerUsecase getStoresByOwnerUsecase;

  StoreBloc({required this.getStoresByOwnerUsecase}) : super(StoreInitial()) {
    on<LoadStores>((event, emit) async {
      emit(StoreLoading());
      final result = await getStoresByOwnerUsecase(
        GetStoresByOwnerParams(ownerId: event.ownerId),
      );

      result.fold(
        (failure) => emit(StoreFailure(failure.message)),
        (stores) => emit(StoreLoaded(stores)),
      );
    });
  }
}
