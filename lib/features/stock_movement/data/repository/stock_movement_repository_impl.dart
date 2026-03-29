import 'package:fpdart/fpdart.dart';
import 'package:inventory_app/core/error/failures.dart';
import 'package:inventory_app/features/stock_movement/data/data_sources/stock_movement_supabase_data_source.dart';
import 'package:inventory_app/features/stock_movement/data/model/stock_movement_model.dart';
import 'package:inventory_app/features/stock_movement/domain/entity/stock_movement.dart';
import 'package:inventory_app/features/stock_movement/domain/repository/stock_movement_repository.dart';

class StockMovementRepositoryImpl implements StockMovementRepository {
  final StockMovementSupabaseDataSource stockMovementSupabaseDataSource;

  StockMovementRepositoryImpl({required this.stockMovementSupabaseDataSource});

  @override
  Future<Either<Failures, List<StockMovement>>> getByProductIds(
    List<String> productIds,
  ) async {
    try {
      final rows = await stockMovementSupabaseDataSource.getByProductIds(
        productIds,
      );
      return right(rows.map(StockMovementModel.fromMap).toList());
    } catch (e) {
      return left(Failures(e.toString()));
    }
  }
}
