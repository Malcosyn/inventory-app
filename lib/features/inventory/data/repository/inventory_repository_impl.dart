import 'package:fpdart/fpdart.dart';
import 'package:inventory_app/core/error/failures.dart';
import 'package:inventory_app/features/inventory/data/data_sources/inventory_supabase_data_source.dart';
import 'package:inventory_app/features/inventory/data/model/inventory_model.dart';
import 'package:inventory_app/features/inventory/domain/entity/inventory.dart';
import 'package:inventory_app/features/inventory/domain/repository/inventory_repository.dart';

class InventoryRepositoryImpl implements InventoryRepository {
  final InventorySupabaseDataSource inventorySupabaseDataSource;

  InventoryRepositoryImpl({required this.inventorySupabaseDataSource});

  @override
  Future<Either<Failures, List<Inventory>>> getInventoryByProductIds(
    List<String> productIds,
  ) async {
    try {
      final rows = await inventorySupabaseDataSource.getInventoryByProductIds(
        productIds,
      );
      return right(rows.map(InventoryModel.fromMap).toList());
    } catch (e) {
      return left(Failures(e.toString()));
    }
  }
}
