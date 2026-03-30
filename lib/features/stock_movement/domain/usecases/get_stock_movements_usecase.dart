import 'package:fpdart/fpdart.dart';
import 'package:inventory_app/core/error/failures.dart';
import 'package:inventory_app/core/usecases/usecase.dart';
import 'package:inventory_app/features/stock_movement/domain/entity/stock_movement.dart';
import 'package:inventory_app/features/stock_movement/domain/repository/stock_movement_repository.dart';

class GetStockMovementsUsecase
    implements Usecase<List<StockMovement>, GetStockMovementsParams> {
  final StockMovementRepository stockMovementRepository;

  GetStockMovementsUsecase({required this.stockMovementRepository});

  @override
  Future<Either<Failures, List<StockMovement>>> call(
    GetStockMovementsParams param,
  ) {
    return stockMovementRepository.getByProductIds(param.productIds);
  }
}

class GetStockMovementsParams {
  final List<String> productIds;

  GetStockMovementsParams({required this.productIds});
}
