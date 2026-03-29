import 'package:fpdart/fpdart.dart';
import 'package:inventory_app/core/error/failures.dart';
import 'package:inventory_app/features/stock_movement/domain/entity/stock_movement.dart';

abstract interface class StockMovementRepository {
  Future<Either<Failures, List<StockMovement>>> getByProductIds(
    List<String> productIds,
  );
}
