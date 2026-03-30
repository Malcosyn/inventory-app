import 'package:fpdart/fpdart.dart';
import 'package:inventory_app/core/error/failures.dart';
import 'package:inventory_app/core/usecases/usecase.dart';
import 'package:inventory_app/features/inventory/domain/entity/inventory.dart';
import 'package:inventory_app/features/inventory/domain/repository/inventory_repository.dart';

class GetInventoryUsecase
    implements Usecase<List<Inventory>, GetInventoryParams> {
  final InventoryRepository inventoryRepository;

  GetInventoryUsecase({required this.inventoryRepository});

  @override
  Future<Either<Failures, List<Inventory>>> call(GetInventoryParams param) {
    return inventoryRepository.getInventoryByProductIds(param.productIds);
  }
}

class GetInventoryParams {
  final List<String> productIds;

  GetInventoryParams({required this.productIds});
}
