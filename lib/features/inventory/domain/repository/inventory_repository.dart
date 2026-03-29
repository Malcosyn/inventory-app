import 'package:fpdart/fpdart.dart';
import 'package:inventory_app/core/error/failures.dart';
import 'package:inventory_app/features/inventory/domain/entity/inventory.dart';

abstract interface class InventoryRepository {
  Future<Either<Failures, List<Inventory>>> getInventoryByProductIds(
    List<String> productIds,
  );
}
